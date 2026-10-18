package
{
   import Audio.GameSound;
   
   public class Sounds
   {
      
      public static var shoot_embed:Class = Sounds_shoot_embed;
      
      public static var shoot:GameSound = GameSound.forEmbed(shoot_embed,0.600000024,0);
      
      public static var explosion_1_embed:Class = Sounds_explosion_1_embed;
      
      public static var explosion_2_embed:Class = Sounds_explosion_2_embed;
      
      public static var explosion_3_embed:Class = Sounds_explosion_3_embed;
      
      public static var explosion_embed:Array = [explosion_1_embed,explosion_2_embed,explosion_3_embed];
      
      public static var explosion:GameSound = GameSound.forEmbedArray(explosion_embed,0.400000036,0);
      
      public static var droneBig_embed:Class = Sounds_droneBig_embed;
      
      public static var droneBig:GameSound = GameSound.forEmbed(droneBig_embed,0.400000006,0);
      
      public static var laserShoot_embed:Class = Sounds_laserShoot_embed;
      
      public static var laserShoot:GameSound = GameSound.forEmbed(laserShoot_embed,0.5,0);
      
      public static var grenadeShoot_embed:Class = Sounds_grenadeShoot_embed;
      
      public static var grenadeShoot:GameSound = GameSound.forEmbed(grenadeShoot_embed,0.300000012,0);
      
      public static var shotgunShoot_embed:Class = Sounds_shotgunShoot_embed;
      
      public static var shotgunShoot:GameSound = GameSound.forEmbed(shotgunShoot_embed,0.400000006,0);
      
      public static var pickup_embed:Class = Sounds_pickup_embed;
      
      public static var pickup:GameSound = GameSound.forEmbed(pickup_embed,0.5,0);
      
      public static var pickupWeapon_embed:Class = Sounds_pickupWeapon_embed;
      
      public static var pickupWeapon:GameSound = GameSound.forEmbed(pickupWeapon_embed,0.300000012,0);
      
      public static var wallHit_1_embed:Class = Sounds_wallHit_1_embed;
      
      public static var wallHit_2_embed:Class = Sounds_wallHit_2_embed;
      
      public static var wallHit_3_embed:Class = Sounds_wallHit_3_embed;
      
      public static var wallHit_embed:Array = [wallHit_1_embed,wallHit_2_embed,wallHit_3_embed];
      
      public static var wallHit:GameSound = GameSound.forEmbedArray(wallHit_embed,0.100000016,0);
      
      public static var objectHit_1_embed:Class = Sounds_objectHit_1_embed;
      
      public static var objectHit_2_embed:Class = Sounds_objectHit_2_embed;
      
      public static var objectHit_3_embed:Class = Sounds_objectHit_3_embed;
      
      public static var objectHit_embed:Array = [objectHit_1_embed,objectHit_2_embed,objectHit_3_embed];
      
      public static var objectHit:GameSound = GameSound.forEmbedArray(objectHit_embed,0.200000003,0);
      
      public static var doorOpen_embed:Class = Sounds_doorOpen_embed;
      
      public static var doorOpen:GameSound = GameSound.forEmbed(doorOpen_embed,0.599999964,200);
      
      public static var doorClose_embed:Class = Sounds_doorClose_embed;
      
      public static var doorClose:GameSound = GameSound.forEmbed(doorClose_embed,0.400000036,200);
      
      public static var pickupKey_embed:Class = Sounds_pickupKey_embed;
      
      public static var pickupKey:GameSound = GameSound.forEmbed(pickupKey_embed,1,0);
      
      public static var rocketShoot_embed:Class = Sounds_rocketShoot_embed;
      
      public static var rocketShoot:GameSound = GameSound.forEmbed(rocketShoot_embed,0.5,0);
      
      public static var rocketHit_1_embed:Class = Sounds_rocketHit_1_embed;
      
      public static var rocketHit_2_embed:Class = Sounds_rocketHit_2_embed;
      
      public static var rocketHit_3_embed:Class = Sounds_rocketHit_3_embed;
      
      public static var rocketHit_embed:Array = [rocketHit_1_embed,rocketHit_2_embed,rocketHit_3_embed];
      
      public static var rocketHit:GameSound = GameSound.forEmbedArray(rocketHit_embed,0.449999988,0);
      
      public static var enemyShoot_embed:Class = Sounds_enemyShoot_embed;
      
      public static var enemyShoot:GameSound = GameSound.forEmbed(enemyShoot_embed,0.200000018,0);
      
      public static var Quest_1_embed:Class = Sounds_Quest_1_embed;
      
      public static var Quest_2_embed:Class = Sounds_Quest_2_embed;
      
      public static var Quest_3_embed:Class = Sounds_Quest_3_embed;
      
      public static var Quest_4_embed:Class = Sounds_Quest_4_embed;
      
      public static var Quest_5_embed:Class = Sounds_Quest_5_embed;
      
      public static var Quest_6_embed:Class = Sounds_Quest_6_embed;
      
      public static var Quest_7_embed:Class = Sounds_Quest_7_embed;
      
      public static var Quest_8_embed:Class = Sounds_Quest_8_embed;
      
      public static var Quest_9_embed:Class = Sounds_Quest_9_embed;
      
      public static var Quest_10_embed:Class = Sounds_Quest_10_embed;
      
      public static var Quest_11_embed:Class = Sounds_Quest_11_embed;
      
      public static var Quest_12_embed:Class = Sounds_Quest_12_embed;
      
      public static var Quest_embed:Array = [Quest_1_embed,Quest_2_embed,Quest_3_embed,Quest_4_embed,Quest_5_embed,Quest_6_embed,Quest_7_embed,Quest_8_embed,Quest_9_embed,Quest_10_embed,Quest_11_embed,Quest_12_embed];
      
      public static var Quest:GameSound = GameSound.forEmbedArray(Quest_embed,1,0);
      
      public static var levelUp_embed:Class = Sounds_levelUp_embed;
      
      public static var levelUp:GameSound = GameSound.forEmbed(levelUp_embed,1,0);
      
      public static var missionComplete_embed:Class = Sounds_missionComplete_embed;
      
      public static var missionComplete:GameSound = GameSound.forEmbed(missionComplete_embed,1,0);
      
      public static var shieldPickup_embed:Class = Sounds_shieldPickup_embed;
      
      public static var shieldPickup:GameSound = GameSound.forEmbed(shieldPickup_embed,1,0);
      
      public static var treasureOpen_embed:Class = Sounds_treasureOpen_embed;
      
      public static var treasureOpen:GameSound = GameSound.forEmbed(treasureOpen_embed,1,0);
      
      public static var trap_embed:Class = Sounds_trap_embed;
      
      public static var trap:GameSound = GameSound.forEmbed(trap_embed,1,0);
      
      public static var flameTurretFire_embed:Class = Sounds_flameTurretFire_embed;
      
      public static var flameTurretFire:GameSound = GameSound.forEmbed(flameTurretFire_embed,1,250);
      
      public static var propSounds_6_embed:Class = Sounds_propSounds_6_embed;
      
      public static var propSounds_10_embed:Class = Sounds_propSounds_10_embed;
      
      public static var propSounds_14_embed:Class = Sounds_propSounds_14_embed;
      
      public static var propSounds_15_embed:Class = Sounds_propSounds_15_embed;
      
      public static var propSounds_19_embed:Class = Sounds_propSounds_19_embed;
      
      public static var propSounds_23_embed:Class = Sounds_propSounds_23_embed;
      
      public static var propSounds_sparse:* = [null,null,null,null,null,GameSound.forEmbed(propSounds_6_embed,0.600000024,500),null,null,null,GameSound.forEmbed(propSounds_10_embed,0.600000024,500),null,null,null,GameSound.forEmbed(propSounds_14_embed,0.600000024,500),GameSound.forEmbed(propSounds_15_embed,0.600000024,500),null,null,null,GameSound.forEmbed(propSounds_19_embed,0.600000024,500),null,null,null,GameSound.forEmbed(propSounds_23_embed,0.600000024,500)];
      
      public static var propSounds_embed:Array = [null,null,null,null,null,propSounds_6_embed,null,null,null,propSounds_10_embed,null,null,null,propSounds_14_embed,propSounds_15_embed,null,null,null,propSounds_19_embed,null,null,null,propSounds_23_embed];
      
      public static var propSounds:GameSound = GameSound.forEmbedArray(propSounds_embed,0.600000024,500);
      
      public static var cavern_embed:Class = Sounds_cavern_embed;
      
      public static var cavern:GameSound = GameSound.forEmbed(cavern_embed,1,0);
      
      public static var textPrint_embed:Class = Sounds_textPrint_embed;
      
      public static var textPrint:GameSound = GameSound.forEmbed(textPrint_embed,0.600000024,0);
      
      public static var teleport_embed:Class = Sounds_teleport_embed;
      
      public static var teleport:GameSound = GameSound.forEmbed(teleport_embed,1,100);
      
      public static var turretFire_embed:Class = Sounds_turretFire_embed;
      
      public static var turretFire:GameSound = GameSound.forEmbed(turretFire_embed,1,0);
      
      public static var hulkFire_embed:Class = Sounds_hulkFire_embed;
      
      public static var hulkFire:GameSound = GameSound.forEmbed(hulkFire_embed,1,0);
      
      public static var hoverFire_embed:Class = Sounds_hoverFire_embed;
      
      public static var hoverFire:GameSound = GameSound.forEmbed(hoverFire_embed,0.100000009,0);
      
      public static var spiderGunnerFire_embed:Class = Sounds_spiderGunnerFire_embed;
      
      public static var spiderGunnerFire:GameSound = GameSound.forEmbed(spiderGunnerFire_embed,0.5,0);
      
      public static var hunterFire_embed:Class = Sounds_hunterFire_embed;
      
      public static var hunterFire:GameSound = GameSound.forEmbed(hunterFire_embed,0.5,0);
      
      public static var bigTurretFire_embed:Class = Sounds_bigTurretFire_embed;
      
      public static var bigTurretFire:GameSound = GameSound.forEmbed(bigTurretFire_embed,0.5,0);
      
      public static var shooteyGruntFire_embed:Class = Sounds_shooteyGruntFire_embed;
      
      public static var shooteyGruntFire:GameSound = GameSound.forEmbed(shooteyGruntFire_embed,1,0);
      
      public static var bigHoverFire_embed:Class = Sounds_bigHoverFire_embed;
      
      public static var bigHoverFire:GameSound = GameSound.forEmbed(bigHoverFire_embed,1,0);
      
      public static var laserEnemyFire_embed:Class = Sounds_laserEnemyFire_embed;
      
      public static var laserEnemyFire:GameSound = GameSound.forEmbed(laserEnemyFire_embed,0.5,0);
      
      public static var sleeperFire_embed:Class = Sounds_sleeperFire_embed;
      
      public static var sleeperFire:GameSound = GameSound.forEmbed(sleeperFire_embed,1,0);
      
      public static var shieldGunnerFire_embed:Class = Sounds_shieldGunnerFire_embed;
      
      public static var shieldGunnerFire:GameSound = GameSound.forEmbed(shieldGunnerFire_embed,1,0);
      
      public static var gasTankDestroy_embed:Class = Sounds_gasTankDestroy_embed;
      
      public static var gasTankDestroy:GameSound = GameSound.forEmbed(gasTankDestroy_embed,0.400000006,0);
      
      public static var shieldsLow_embed:Class = Sounds_shieldsLow_embed;
      
      public static var shieldsLow:GameSound = GameSound.forEmbed(shieldsLow_embed,1,0);
      
      public static var shieldsCritical_embed:Class = Sounds_shieldsCritical_embed;
      
      public static var shieldsCritical:GameSound = GameSound.forEmbed(shieldsCritical_embed,1,0);
      
      public static var laserBeam_embed:Class = Sounds_laserBeam_embed;
      
      public static var laserBeam:GameSound = GameSound.forEmbed(laserBeam_embed,0.699999988,100);
      
      public static var playerLaserHit_embed:Class = Sounds_playerLaserHit_embed;
      
      public static var playerLaserHit:GameSound = GameSound.forEmbed(playerLaserHit_embed,0.600000024,0);
      
      public static var invPickup_embed:Class = Sounds_invPickup_embed;
      
      public static var invPickup:GameSound = GameSound.forEmbed(invPickup_embed,1,0);
      
      public static var invPlace_embed:Class = Sounds_invPlace_embed;
      
      public static var invPlace:GameSound = GameSound.forEmbed(invPlace_embed,0.699999988,0);
      
      public static var slide_embed:Class = Sounds_slide_embed;
      
      public static var slide:GameSound = GameSound.forEmbed(slide_embed,0.600000024,0);
      
      public static var experienceTick_embed:Class = Sounds_experienceTick_embed;
      
      public static var experienceTick:GameSound = GameSound.forEmbed(experienceTick_embed,0.600000024,0);
      
      public static var pickupItem_embed:Class = Sounds_pickupItem_embed;
      
      public static var pickupItem:GameSound = GameSound.forEmbed(pickupItem_embed,1,0);
      
      public static var medkit_embed:Class = Sounds_medkit_embed;
      
      public static var medkit:GameSound = GameSound.forEmbed(medkit_embed,1,0);
      
      public static var enemySpawn_embed:Class = Sounds_enemySpawn_embed;
      
      public static var enemySpawn:GameSound = GameSound.forEmbed(enemySpawn_embed,1,0);
      
      public static var introTrack_embed:Class = Sounds_introTrack_embed;
      
      public static var introTrack:GameSound = GameSound.forEmbed(introTrack_embed,1,0);
      
      public static var menuTrack_embed:Class = Sounds_menuTrack_embed;
      
      public static var menuTrack:GameSound = GameSound.forEmbed(menuTrack_embed,1,0);
      
      public static var alienTalk_1_embed:Class = Sounds_alienTalk_1_embed;
      
      public static var alienTalk_2_embed:Class = Sounds_alienTalk_2_embed;
      
      public static var alienTalk_3_embed:Class = Sounds_alienTalk_3_embed;
      
      public static var alienTalk_4_embed:Class = Sounds_alienTalk_4_embed;
      
      public static var alienTalk_embed:Array = [alienTalk_1_embed,alienTalk_2_embed,alienTalk_3_embed,alienTalk_4_embed];
      
      public static var alienTalk:GameSound = GameSound.forEmbedArray(alienTalk_embed,1,0);
      
      public static var pulseShoot_embed:Class = Sounds_pulseShoot_embed;
      
      public static var pulseShoot:GameSound = GameSound.forEmbed(pulseShoot_embed,0.200000018,0);
      
      public static var alienMediumDie_1_embed:Class = Sounds_alienMediumDie_1_embed;
      
      public static var alienMediumDie_2_embed:Class = Sounds_alienMediumDie_2_embed;
      
      public static var alienMediumDie_3_embed:Class = Sounds_alienMediumDie_3_embed;
      
      public static var alienMediumDie_embed:Array = [alienMediumDie_1_embed,alienMediumDie_2_embed,alienMediumDie_3_embed];
      
      public static var alienMediumDie:GameSound = GameSound.forEmbedArray(alienMediumDie_embed,1,0);
      
      public static var alienMediumGrowl_1_embed:Class = Sounds_alienMediumGrowl_1_embed;
      
      public static var alienMediumGrowl_2_embed:Class = Sounds_alienMediumGrowl_2_embed;
      
      public static var alienMediumGrowl_3_embed:Class = Sounds_alienMediumGrowl_3_embed;
      
      public static var alienMediumGrowl_embed:Array = [alienMediumGrowl_1_embed,alienMediumGrowl_2_embed,alienMediumGrowl_3_embed];
      
      public static var alienMediumGrowl:GameSound = GameSound.forEmbedArray(alienMediumGrowl_embed,1,0);
      
      public static var alienSmallDie_1_embed:Class = Sounds_alienSmallDie_1_embed;
      
      public static var alienSmallDie_2_embed:Class = Sounds_alienSmallDie_2_embed;
      
      public static var alienSmallDie_3_embed:Class = Sounds_alienSmallDie_3_embed;
      
      public static var alienSmallDie_embed:Array = [alienSmallDie_1_embed,alienSmallDie_2_embed,alienSmallDie_3_embed];
      
      public static var alienSmallDie:GameSound = GameSound.forEmbedArray(alienSmallDie_embed,1,0);
      
      public static var alienSmallGrowl_1_embed:Class = Sounds_alienSmallGrowl_1_embed;
      
      public static var alienSmallGrowl_2_embed:Class = Sounds_alienSmallGrowl_2_embed;
      
      public static var alienSmallGrowl_embed:Array = [alienSmallGrowl_1_embed,alienSmallGrowl_2_embed];
      
      public static var alienSmallGrowl:GameSound = GameSound.forEmbedArray(alienSmallGrowl_embed,1,0);
      
      public static var alienBigDie_1_embed:Class = Sounds_alienBigDie_1_embed;
      
      public static var alienBigDie_2_embed:Class = Sounds_alienBigDie_2_embed;
      
      public static var alienBigDie_3_embed:Class = Sounds_alienBigDie_3_embed;
      
      public static var alienBigDie_embed:Array = [alienBigDie_1_embed,alienBigDie_2_embed,alienBigDie_3_embed];
      
      public static var alienBigDie:GameSound = GameSound.forEmbedArray(alienBigDie_embed,1,0);
      
      public static var alienBigGrowl_1_embed:Class = Sounds_alienBigGrowl_1_embed;
      
      public static var alienBigGrowl_2_embed:Class = Sounds_alienBigGrowl_2_embed;
      
      public static var alienBigGrowl_3_embed:Class = Sounds_alienBigGrowl_3_embed;
      
      public static var alienBigGrowl_embed:Array = [alienBigGrowl_1_embed,alienBigGrowl_2_embed,alienBigGrowl_3_embed];
      
      public static var alienBigGrowl:GameSound = GameSound.forEmbedArray(alienBigGrowl_embed,1,0);
      
      public static var trooperDie_1_embed:Class = Sounds_trooperDie_1_embed;
      
      public static var trooperDie_2_embed:Class = Sounds_trooperDie_2_embed;
      
      public static var trooperDie_embed:Array = [trooperDie_1_embed,trooperDie_2_embed];
      
      public static var trooperDie:GameSound = GameSound.forEmbedArray(trooperDie_embed,1,0);
      
      public static var trooperGrowl_1_embed:Class = Sounds_trooperGrowl_1_embed;
      
      public static var trooperGrowl_2_embed:Class = Sounds_trooperGrowl_2_embed;
      
      public static var trooperGrowl_3_embed:Class = Sounds_trooperGrowl_3_embed;
      
      public static var trooperGrowl_embed:Array = [trooperGrowl_1_embed,trooperGrowl_2_embed,trooperGrowl_3_embed];
      
      public static var trooperGrowl:GameSound = GameSound.forEmbedArray(trooperGrowl_embed,1,0);
      
      public static var nestDie_1_embed:Class = Sounds_nestDie_1_embed;
      
      public static var nestDie_2_embed:Class = Sounds_nestDie_2_embed;
      
      public static var nestDie_embed:Array = [nestDie_1_embed,nestDie_2_embed];
      
      public static var nestDie:GameSound = GameSound.forEmbedArray(nestDie_embed,1,0);
      
      public static var crumble_1_embed:Class = Sounds_crumble_1_embed;
      
      public static var crumble_embed:Array = [crumble_1_embed];
      
      public static var crumble:GameSound = GameSound.forEmbedArray(crumble_embed,1,100);
      
      public static var doorUnlock_embed:Class = Sounds_doorUnlock_embed;
      
      public static var doorUnlock:GameSound = GameSound.forEmbed(doorUnlock_embed,1,0);
      
      public static var brutePowerthirst_embed:Class = Sounds_brutePowerthirst_embed;
      
      public static var brutePowerthirst:GameSound = GameSound.forEmbed(brutePowerthirst_embed,1,0);
      
      public static var fleshHit_1_embed:Class = Sounds_fleshHit_1_embed;
      
      public static var fleshHit_2_embed:Class = Sounds_fleshHit_2_embed;
      
      public static var fleshHit_3_embed:Class = Sounds_fleshHit_3_embed;
      
      public static var fleshHit_embed:Array = [fleshHit_1_embed,fleshHit_2_embed,fleshHit_3_embed];
      
      public static var fleshHit:GameSound = GameSound.forEmbedArray(fleshHit_embed,1,0);
      
      public static var tileFall_embed:Class = Sounds_tileFall_embed;
      
      public static var tileFall:GameSound = GameSound.forEmbed(tileFall_embed,1,0);
      
      public static var droneBig2_embed:Class = Sounds_droneBig2_embed;
      
      public static var droneBig2:GameSound = GameSound.forEmbed(droneBig2_embed,0.400000006,0);
      
      public static var droneBig3_embed:Class = Sounds_droneBig3_embed;
      
      public static var droneBig3:GameSound = GameSound.forEmbed(droneBig3_embed,0.400000006,0);
      
      public static var elevatorOpen_embed:Class = Sounds_elevatorOpen_embed;
      
      public static var elevatorOpen:GameSound = GameSound.forEmbed(elevatorOpen_embed,1,0);
      
      public static var elevatorUse_embed:Class = Sounds_elevatorUse_embed;
      
      public static var elevatorUse:GameSound = GameSound.forEmbed(elevatorUse_embed,1,0);
      
      public static var bruteMinigunFire_embed:Class = Sounds_bruteMinigunFire_embed;
      
      public static var bruteMinigunFire:GameSound = GameSound.forEmbed(bruteMinigunFire_embed,1,0);
      
      public static var terranPissed_embed:Class = Sounds_terranPissed_embed;
      
      public static var terranPissed:GameSound = GameSound.forEmbed(terranPissed_embed,1,0);
      
      public static var splatter_1_embed:Class = Sounds_splatter_1_embed;
      
      public static var splatter_embed:Array = [splatter_1_embed];
      
      public static var splatter:GameSound = GameSound.forEmbedArray(splatter_embed,1,0);
      
      public static var shockwave_embed:Class = Sounds_shockwave_embed;
      
      public static var shockwave:GameSound = GameSound.forEmbed(shockwave_embed,1,0);
      
      public static var useItem_embed:Class = Sounds_useItem_embed;
      
      public static var useItem:GameSound = GameSound.forEmbed(useItem_embed,1,0);
      
      public static var grenadeWarning_embed:Class = Sounds_grenadeWarning_embed;
      
      public static var grenadeWarning:GameSound = GameSound.forEmbed(grenadeWarning_embed,1,0);
      
      public static var chargeLaser_embed:Class = Sounds_chargeLaser_embed;
      
      public static var chargeLaser:GameSound = GameSound.forEmbed(chargeLaser_embed,1,0);
      
      public static var chargeGrenade_embed:Class = Sounds_chargeGrenade_embed;
      
      public static var chargeGrenade:GameSound = GameSound.forEmbed(chargeGrenade_embed,1,0);
      
      public static var chargeMissiles_embed:Class = Sounds_chargeMissiles_embed;
      
      public static var chargeMissiles:GameSound = GameSound.forEmbed(chargeMissiles_embed,1,0);
      
      public static var radio_embed:Class = Sounds_radio_embed;
      
      public static var radio:GameSound = GameSound.forEmbed(radio_embed,1,0);
      
      public static var shredderFire_embed:Class = Sounds_shredderFire_embed;
      
      public static var shredderFire:GameSound = GameSound.forEmbed(shredderFire_embed,1,0);
      
      public static var plasmaShotgunFire_embed:Class = Sounds_plasmaShotgunFire_embed;
      
      public static var plasmaShotgunFire:GameSound = GameSound.forEmbed(plasmaShotgunFire_embed,1,0);
      
      public function Sounds()
      {
         super();
      }
   }
}

