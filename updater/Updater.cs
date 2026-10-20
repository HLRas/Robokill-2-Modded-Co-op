// Robokill 2 co-op mod updater.
//
// The game can only start programs in the "fscommand" folder next to it, and can't pass arguments, so the
// channel comes from this exe's own name: fscommand\updaterelease.exe installs the latest build from the
// main branch, fscommand\updatebeta.exe the latest from the working-tree branch. (Flash won't start a file
// whose name has a hyphen.)
//
// It waits for the game to close, downloads the exe (and version.txt) from GitHub, swaps it in, records the
// channel in channel.txt and starts the game again. Built by build\build.ps1 with the C# compiler in Windows.
using System;
using System.Diagnostics;
using System.IO;
using System.Net;
using System.Threading;

class Updater
{
    const string Repo = "https://raw.githubusercontent.com/HLRas/Robokill-2-Modded-Co-op/";
    const string GameExe = "Robokill 2 (Co-op).exe";

    static int Main()
    {
        string self = Process.GetCurrentProcess().MainModule.FileName;
        string channel = Path.GetFileNameWithoutExtension(self).ToLowerInvariant().EndsWith("beta") ? "beta" : "release";
        string branch = channel == "beta" ? "working-tree" : "main";
        string gameDir = Directory.GetParent(Path.GetDirectoryName(self)).FullName;
        string gamePath = Path.Combine(gameDir, GameExe);
        // For testing: fscommand\source.txt can point at another base URL (ending in "/").
        string baseUrl = Repo + branch + "/";
        string sourceFile = Path.Combine(Path.GetDirectoryName(self), "source.txt");
        if (File.Exists(sourceFile))
        {
            baseUrl = File.ReadAllText(sourceFile).Trim();
        }

        Console.Title = "Robokill 2 co-op updater";
        Console.WriteLine("Installing the latest " + (channel == "beta" ? "BETA" : "RELEASE") + " version...");
        Console.WriteLine();
        WaitForGameToClose(gamePath);

        string tmp = gamePath + ".download";
        string old = gamePath + ".old";
        try
        {
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
            string stamp = "?t=" + DateTime.UtcNow.Ticks;
            using (var web = new WebClient())
            {
                web.Headers["User-Agent"] = "Robokill2-Coop-Updater";
                string version = web.DownloadString(baseUrl + "version.txt" + stamp).Trim();
                Console.WriteLine("Latest version: V" + version);
                bool done = false;
                Exception error = null;
                web.DownloadProgressChanged += (s, e) =>
                    Console.Write("\rDownloading... " + e.ProgressPercentage + "%   ");
                web.DownloadFileCompleted += (s, e) => { error = e.Error; done = true; };
                web.DownloadFileAsync(new Uri(baseUrl + Uri.EscapeDataString(GameExe) + stamp), tmp);
                while (!done)
                {
                    Thread.Sleep(50);
                }
                Console.WriteLine();
                if (error != null)
                {
                    throw error;
                }
            }
            if (new FileInfo(tmp).Length < 1000000)
            {
                throw new Exception("the download is too small to be the game");
            }
            if (File.Exists(old))
            {
                File.Delete(old);
            }
            if (File.Exists(gamePath))
            {
                File.Move(gamePath, old);
            }
            File.Move(tmp, gamePath);
            File.WriteAllText(Path.Combine(gameDir, "channel.txt"), channel);
            try
            {
                File.Delete(old);
            }
            catch
            {
                // Still locked; it's replaced next time.
            }
            Console.WriteLine("Done. Starting the game...");
        }
        catch (Exception e)
        {
            Console.WriteLine();
            Console.WriteLine("Update failed: " + e.Message);
            Console.WriteLine("Starting the version you already have.");
            try
            {
                if (File.Exists(tmp))
                {
                    File.Delete(tmp);
                }
                if (!File.Exists(gamePath) && File.Exists(old))
                {
                    File.Move(old, gamePath);
                }
            }
            catch
            {
            }
            Thread.Sleep(4000);
        }
        Process.Start(new ProcessStartInfo(gamePath) { WorkingDirectory = gameDir, UseShellExecute = true });
        return 0;
    }

    static void WaitForGameToClose(string gamePath)
    {
        for (int i = 0; i < 300; i++)
        {
            bool running = false;
            foreach (var p in Process.GetProcessesByName(Path.GetFileNameWithoutExtension(gamePath)))
            {
                try
                {
                    if (string.Equals(p.MainModule.FileName, gamePath, StringComparison.OrdinalIgnoreCase))
                    {
                        running = true;
                    }
                }
                catch
                {
                    running = true;
                }
            }
            if (!running)
            {
                return;
            }
            Thread.Sleep(100);
        }
    }
}
