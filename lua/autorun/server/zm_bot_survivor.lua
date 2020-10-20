if (CLIENT) then return end

hook.Add("PlayerInitialSpawn","ZombieMaster_SurviorSpawn",function(ply)
	if gmod.GetGamemode().Name != "Zombie Master" then return end
	if ply:IsBot() then return end

	-- if SERVER then
		-- timer.Simple(15,function()
			-- player.CreateNextBot("Bob")
		-- end)
	-- end
end)

hook.Add("StartCommand","ZombieMaster_SurviorAI",function(ply,cmd)
	if gmod.GetGamemode().Name != "Zombie Master" then return end
	if !ply:IsSurvivor() then return end
	if !ply:IsBot() then return end
	if !ply:Alive() then return end
	if ply:IsFlagSet(FL_FROZEN) then return end

	cmd:ClearMovement()
	cmd:ClearButtons()
	
	ply.ZM_Dir = ply.ZM_Dir or 1
	ply.ZM_NextChangeDirT = ply.ZM_NextChangeDirT or 0
	
	local function gDist(ent)
		return ent:GetPos():Distance(ply:GetPos())
	end
	
	local function Jump()
		if math.random(1,2) == 1 then
			cmd:SetButtons(bit.bor(IN_JUMP,IN_DUCK))
		else
			cmd:SetButtons(IN_JUMP)
		end
	end
	
	if !IsValid(ply.ZM_Enemy) then
		local tDist = 999999999
		for _,v in pairs(ents.GetAll()) do
			if v:IsNPC() && v:Visible(ply) && v:GetPos():Distance(ply:GetPos()) < tDist then
				tDist = v:GetPos():Distance(ply:GetPos())
				ply.ZM_Enemy = v
				for _,v in pairs(ply:GetWeapons()) do
					if v:Clip1() > 0 then
						cmd:SelectWeapon(v)
					end
				end
			end
		end
	end
	local tDist = 999999999
	for _,v in pairs(player.GetAll()) do
		if v:Alive() && !v:IsBot() && v != ply && v:IsSurvivor() && v:GetPos():Distance(ply:GetPos()) < tDist then
			tDist = v:GetPos():Distance(ply:GetPos())
			ply.ZM_Follow = v
		end
	end
	local fEnt = ply.ZM_Follow
	local enemy = ply.ZM_Enemy
	if IsValid(enemy) && enemy:Visible(ply) && !ply.ZM_ChasingPlayer then
		ply:SetEyeAngles(((enemy:GetPos() +enemy:OBBCenter()) -ply:GetShootPos()):GetNormalized():Angle())
	end

	if IsValid(fEnt) then
		if !fEnt:Alive() or IsValid(fEnt) && !fEnt:IsSurvivor() then
			ply.ZM_Follow = NULL
			return
		end
		local dist = fEnt:GetPos():Distance(ply:GetPos())
		if dist > 220 then
			ply.ZM_ChasingPlayer = true
			cmd:SetForwardMove(ply:GetWalkSpeed())
			ply:SetEyeAngles((fEnt:GetPos() -ply:GetShootPos()):GetNormalized():Angle())
			ply.NextJumpT = ply.NextJumpT or CurTime()
			if math.random(1,50) == 1 && ply:OnGround() && CurTime() > ply.NextJumpT then
				Jump()
				ply.NextJumpT = CurTime() +1
			end
		else
			ply.ZM_ChasingPlayer = false
		end
	else
		if !IsValid(ply.ZM_Enemy) then
			cmd:SetForwardMove(ply:GetWalkSpeed())
			ply:SetEyeAngles(ply:GetAngles() +Angle(0,math.random(0,4) *ply.ZM_Dir,0))
			if math.random(1,50) == 1 && CurTime() > ply.ZM_NextChangeDirT then
				ply.ZM_Dir = ply.ZM_Dir *-1
				ply.ZM_NextChangeDirT = CurTime() +math.Rand(5,30)
			end
			ply.NextJumpT = ply.NextJumpT or CurTime()
			if math.random(1,50) == 1 && ply:OnGround() && CurTime() > ply.NextJumpT then
				Jump()
				ply.NextJumpT = CurTime() +1
			end
		end
	end

	if IsValid(ply.ZM_Enemy) then
		local enemy = ply.ZM_Enemy
		local dist = enemy:GetPos():Distance(ply:GetPos())
		if enemy:Visible(ply) then
			local targDist = 600
			local wep = ply:GetActiveWeapon()
			if IsValid(wep) then
				targDist = wep.IsMelee && wep.Primary.Reach or 600
			end
			if dist <= 1500 && !ply.ZM_ChasingPlayer then
				if IsValid(wep) && CurTime() > wep:GetNextPrimaryFire() then
					if wep:Clip1() <= 0 && ply:GetAmmoCount(wep.Primary.Ammo) <= 0 then
						for _,v in pairs(ply:GetWeapons()) do
							if v:Clip1() > 0 then
								cmd:SelectWeapon(v)
								break
							end
						end
						return
					end
					cmd:SetButtons(((wep:Clip1() <= 0 && wep:Clip1() < wep.Primary.DefaultClip) && IN_RELOAD) or IN_ATTACK)
				end
			end
		end

		if !IsValid(enemy) or enemy:Health() <= 0 then
			ply.ZM_Enemy = NULL
		end
	end
end)