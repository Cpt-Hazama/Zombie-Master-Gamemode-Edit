ZM_PHYSEXP_DAMAGE = 17500
ZM_PHYSEXP_RADIUS = 222
ZM_PHYSEXP_DELAY = 7.4

SCROLL_THRESHOLD = 8

FL_SPAWN_SHAMBLER_ALLOWED = 1
FL_SPAWN_BANSHEE_ALLOWED = 2
FL_SPAWN_HULK_ALLOWED = 4
FL_SPAWN_DRIFTER_ALLOWED = 8
FL_SPAWN_IMMOLATOR_ALLOWED = 16

SF_PHYSEXPLOSION_NODAMAGE = 1
SF_PHYSEXPLOSION_PUSH_PLAYER = 2
SF_PHYSEXPLOSION_PUSH_RADIALLY = 4
SF_PHYSEXPLOSION_TESTLOS = 8
SF_PHYSEXPLOSION_DISORIENT_PLAYER = 16

SF_ZOMBIE_WANDER_ON_IDLE = 32

ZOMBIE_BUCKSHOT_TRIPLE_DAMAGE_DIST = 96

VECTOR_CONE_1DEGREES = Vector( 0.00873, 0.00873, 0.00873 )
VECTOR_CONE_2DEGREES = Vector( 0.01745, 0.01745, 0.01745 )
VECTOR_CONE_3DEGREES = Vector( 0.02618, 0.02618, 0.02618 )
VECTOR_CONE_4DEGREES = Vector( 0.03490, 0.03490, 0.03490 )
VECTOR_CONE_5DEGREES = Vector( 0.04362, 0.04362, 0.04362 )
VECTOR_CONE_6DEGREES = Vector( 0.05234, 0.05234, 0.05234 )
VECTOR_CONE_7DEGREES = Vector( 0.06105, 0.06105, 0.06105 )
VECTOR_CONE_8DEGREES = Vector( 0.06976, 0.06976, 0.06976 )
VECTOR_CONE_9DEGREES = Vector( 0.07846, 0.07846, 0.07846 )
VECTOR_CONE_10DEGREES = Vector( 0.08716, 0.08716, 0.08716 )
VECTOR_CONE_15DEGREES = Vector( 0.13053, 0.13053, 0.13053 )
VECTOR_CONE_20DEGREES = Vector( 0.17365, 0.17365, 0.17365 )

COND_NONE = 0
COND_IN_PVS = 1
COND_IDLE_INTERRUPT = 2
COND_LOW_PRIMARY_AMMO = 3
COND_NO_PRIMARY_AMMO = 4
COND_NO_SECONDARY_AMMO = 5
COND_NO_WEAPON = 6
COND_SEE_HATE = 7
COND_SEE_FEAR = 8
COND_SEE_DISLIKE = 9
COND_SEE_ENEMY = 10
COND_LOST_ENEMY = 11
COND_ENEMY_WENT_NULL = 12
COND_ENEMY_OCCLUDED = 13
COND_TARGET_OCCLUDED = 14
COND_HAVE_ENEMY_LOS = 15
COND_HAVE_TARGET_LOS = 16
COND_LIGHT_DAMAGE = 17
COND_HEAVY_DAMAGE = 18
COND_PHYSICS_DAMAGE = 19
COND_REPEATED_DAMAGE = 20
COND_CAN_RANGE_ATTACK1 = 21
COND_CAN_RANGE_ATTACK2 = 22
COND_CAN_MELEE_ATTACK1 = 23
COND_CAN_MELEE_ATTACK2 = 24
COND_PROVOKED = 25
COND_NEW_ENEMY = 26
COND_ENEMY_TOO_FAR = 27
COND_ENEMY_FACING_ME = 28
COND_BEHIND_ENEMY = 29
COND_ENEMY_DEAD = 30
COND_ENEMY_UNREACHABLE = 31
COND_SEE_PLAYER = 32
COND_LOST_PLAYER = 33
COND_SEE_NEMESIS = 34
COND_TASK_FAILED = 35
COND_SCHEDULE_DONE = 36
COND_SMELL = 37
COND_TOO_CLOSE_TO_ATTACK = 38
COND_TOO_FAR_TO_ATTACK = 39
COND_NOT_FACING_ATTACK = 40
COND_WEAPON_HAS_LOS = 41
COND_WEAPON_BLOCKED_BY_FRIEND = 42
COND_WEAPON_PLAYER_IN_SPREAD = 43
COND_WEAPON_PLAYER_NEAR_TARGET = 44
COND_WEAPON_SIGHT_OCCLUDED = 45
COND_BETTER_WEAPON_AVAILABLE = 46
COND_HEALTH_ITEM_AVAILABLE = 47
COND_GIVE_WAY = 48
COND_WAY_CLEAR = 49
COND_HEAR_DANGER = 50
COND_HEAR_THUMPER = 51
COND_HEAR_BUGBAIT = 52
COND_HEAR_COMBAT = 53
COND_HEAR_WORLD = 54
COND_HEAR_PLAYER = 55
COND_HEAR_BULLET_IMPACT = 56
COND_HEAR_PHYSICS_DANGER = 57
COND_HEAR_MOVE_AWAY = 58
COND_HEAR_SPOOKY = 59
COND_NO_HEAR_DANGER = 60
COND_FLOATING_OFF_GROUND = 61
COND_MOBBED_BY_ENEMIES = 62
COND_RECEIVED_ORDERS = 63
COND_PLAYER_ADDED_TO_SQUAD = 64
COND_PLAYER_REMOVED_FROM_SQUAD = 65
COND_PLAYER_PUSHING = 66
COND_NPC_FREEZE = 67
COND_NPC_UNFREEZE = 68
COND_TALKER_RESPOND_TO_QUESTION = 69
COND_NO_CUSTOM_INTERRUPTS = 70

HUMAN_WIN_SCORE = 50
HUMAN_LOSS_SCORE = 50

GM.AmmoClass = {}
GM.AmmoClass["item_ammo_357"] = "357"
GM.AmmoClass["item_ammo_357_large"] = "357_large"
GM.AmmoClass["item_ammo_pistol"] = "pistol"
GM.AmmoClass["item_ammo_pistol_large"] = "pistol_large"
GM.AmmoClass["item_ammo_ar2"] = "ar2"
GM.AmmoClass["item_ammo_ar2_large"] = "ar2_large"
GM.AmmoClass["item_ammo_smg1"] = "smg1"
GM.AmmoClass["item_ammo_smg1_large"] = "smg1_large"
GM.AmmoClass["item_box_buckshot"] = "buckshot"
GM.AmmoClass["item_ammo_revolver"] = "revolver"
GM.AmmoClass["weapon_zm_molotov"] = "molotov"

GM.AmmoCache = {}
GM.AmmoCache["pistol"] = 20
GM.AmmoCache["pistol_large"] = 100
GM.AmmoCache["smg1"] = 30
GM.AmmoCache["smg1_large"] = 180
GM.AmmoCache["ar2"] = 20
GM.AmmoCache["ar2_large"] = 100
GM.AmmoCache["357"] = 11
GM.AmmoCache["357_large"] = 20
GM.AmmoCache["buckshot"] = 20
GM.AmmoCache["revolver"] = 6
GM.AmmoCache["molotov"] = 1

GM.AmmoModels = {}
GM.AmmoModels["item_ammo_revolver"] = "models/Items/revolverammo.mdl"
GM.AmmoModels["item_ammo_smg1"] = "models/items/boxmrounds.mdl"
GM.AmmoModels["item_ammo_smg1_large"] = "models/items/boxmrounds.mdl"
GM.AmmoModels["item_ammo_357"] = "models/items/357ammo.mdl"
GM.AmmoModels["item_ammo_357_large"] = "models/items/357ammo.mdl"
GM.AmmoModels["item_ammo_pistol"] = "models/items/boxsrounds.mdl"
GM.AmmoModels["item_ammo_pistol_large"] = "models/items/boxsrounds.mdl"
GM.AmmoModels["item_box_buckshot"] = "models/items/boxbuckshot.mdl"

CARRY_MASS = 40

GM.HumanGibs = {
	Model("models/gibs/HGIBS.mdl"),
	Model("models/gibs/HGIBS_spine.mdl"),

	Model("models/gibs/HGIBS_rib.mdl"),
	Model("models/gibs/HGIBS_scapula.mdl"),
	Model("models/gibs/antlion_gib_medium_2.mdl"),
	Model("models/gibs/Antlion_gib_Large_1.mdl"),
	Model("models/gibs/Strider_Gib4.mdl")
}