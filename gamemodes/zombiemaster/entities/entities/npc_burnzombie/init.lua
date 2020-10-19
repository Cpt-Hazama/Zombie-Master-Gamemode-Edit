AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

DEFINE_BASECLASS("zm_npc_base")

ENT.AttackDamage = 8
ENT.CanSwatPhysicsObjects = false
ENT.FootStepTime = 0.3
ENT.DamageType   = DMG_BURN

ENT.AttackSounds = "NPC_BurnZombie.Scream"
ENT.DeathSounds  = "NPC_BurnZombie.Die"
ENT.PainSounds   = "NPC_BurnZombie.Pain"
ENT.MoanSounds   = "NPC_BurnZombie.Idle"
ENT.AlertSounds	 = "NPC_BurnZombie.Alert"

function ENT:Initialize()
	BaseClass.Initialize(self)
	self:CapabilitiesAdd(bit.bor(CAP_MOVE_GROUND, CAP_INNATE_MELEE_ATTACK1, CAP_SQUAD))
end

function ENT:CustomThink()
	if self:WaterLevel() >= 2 then
		self:TakeDamage(self:Health(), self, self)
		return
	end
	
	if self.OnFire and self:GetMovementActivity() ~= ACT_WALK_ON_FIRE then
		self:SetMovementActivity(ACT_WALK_ON_FIRE)
	end
	
	local enemy = self:GetEnemy()
 	if IsValid(enemy) and not self.OnFire and enemy:GetPos():Distance(self:GetPos()) < 250 and enemy:IsPlayer() then
		for i = 1, 2 do
			local fire = ents.Create("env_fire")
			fire:SetParent(self)
			fire:SetPos(self:GetPos())
			fire:SetKeyValue("health", 100)
			fire:SetKeyValue("firesize", "60")
			fire:SetKeyValue("fireattack", "2")
			fire:SetKeyValue("damagescale", "4.0")
			fire:SetKeyValue("StartDisabled", "0")
			fire:SetKeyValue("firetype", "0" )
			fire:SetKeyValue("spawnflags", "132")
			fire:Spawn()
			fire:Fire("StartFire", "", 0)
			fire.OwnerTeam = TEAM_ZOMBIEMASTER
		end
		
		timer.Simple(5, function()
			if not IsValid(self) then return end
			
			self:EmitSound("PropaneTank.Burst")
			
			local dmginfo = DamageInfo()
				dmginfo:SetAttacker(enemy)
				dmginfo:SetInflictor(self)
				dmginfo:SetDamage(math.random(10, 20))
				dmginfo:SetDamagePosition(self:GetPos())
				dmginfo:SetDamageType(DMG_BURN)
			util.BlastDamageInfo(dmginfo, self:GetPos(), 128)
			
			local effect = EffectData()
				effect:SetOrigin(self:GetPos())
				effect:SetScale(2)
			util.Effect("Explosion", effect, true, true)
		
			self:TakeDamage(self:Health(), self, self)
		end)

		self:PlayVoiceSound(self.AttackSounds)
		self.OnFire = true
	end
end

function ENT:OnRemove()
	if self:WaterLevel() >= 2 then return end
	
	for i = 1, 5 do
		local fire = ents.Create("env_fire")
		fire:SetPos(self:GetPos() + Vector(math.random(-40, 40), math.random(-40, 40), 0))
		fire:SetKeyValue("health", 25)
		fire:SetKeyValue("firesize", "60")
		fire:SetKeyValue("fireattack", "8")
		fire:SetKeyValue("damagescale", "1.0")
		fire:SetKeyValue("StartDisabled", "0")
		fire:SetKeyValue("firetype", "0" )
		fire:SetKeyValue("spawnflags", "132")
		fire:Spawn()
		fire:Fire("StartFire", "", 0)
		fire.OwnerTeam = TEAM_ZOMBIEMASTER
	end
end

function ENT:OnTakeDamage(dmginfo)
	local attacker, inflictor = dmginfo:GetAttacker(), dmginfo:GetInflictor()
	if not IsValid(attacker) then
		attacker = self
	end
	
	if not IsValid(inflictor) then
		inflictor = self
	end
	
	local attackowner = attacker:GetOwner()
	if IsValid(attacker) and attacker:GetClass() == "env_fire" and IsValid(attackowner) and attackowner:GetClass() == self:GetClass() then
		dmginfo:SetDamage(0)
		dmginfo:ScaleDamage(0)
		return
	end
	
	BaseClass.OnTakeDamage(self, dmginfo)
end