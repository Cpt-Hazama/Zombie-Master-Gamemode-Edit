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

	if !IsValid(ply.ZM_Enemy) then
		local tDist = 999999999
		for _,v in ipairs(ents.GetAll()) do
			if v:IsNPC() && v:Visible(ply) && v:GetPos():Distance(ply:GetPos()) < tDist then
				tDist = v:GetPos():Distance(ply:GetPos())
				ply.ZM_Enemy = v
				for _,v in ipairs(ply:GetWeapons()) do
					if v:Clip1() > 0 then
						cmd:SelectWeapon(v)
					end
				end
			end
		end
	end
	-- if !IsValid(ply.ZM_Follow) then
		local tDist = 999999999
		for _,v in ipairs(player.GetAll()) do
			if v:Alive() && !v:IsBot() && v != ply && v:IsSurvivor() && v:GetPos():Distance(ply:GetPos()) < tDist then
				tDist = v:GetPos():Distance(ply:GetPos())
				ply.ZM_Follow = v
			end
		end
	-- end
	local fEnt = ply.ZM_Follow
	if IsValid(fEnt) then
		if !fEnt:Alive() or IsValid(fEnt) && !fEnt:IsSurvivor() then
			ply.ZM_Follow = NULL
			return
		end
		local dist = fEnt:GetPos():Distance(ply:GetPos())
		if dist > 220 then
			cmd:SetForwardMove(ply:GetWalkSpeed())
			cmd:SetViewAngles((fEnt:GetPos() -ply:GetShootPos()):GetNormalized():Angle())
			ply:SetAngles((fEnt:GetPos() -ply:GetShootPos()):GetNormalized():Angle())
			ply.NextJumpT = ply.NextJumpT or CurTime()
			if math.random(1,50) == 1 && ply:OnGround() && CurTime() > ply.NextJumpT then
				cmd:SetButtons(IN_JUMP)
				ply.NextJumpT = CurTime() +1
			end
		end
	else
		if !IsValid(ply.ZM_Enemy) then
			cmd:SetForwardMove(ply:GetWalkSpeed())
			cmd:SetViewAngles(ply:GetAngles() +Angle(0,2,0))
			ply:SetAngles(ply:GetAngles() +Angle(0,2,0))
			ply.NextJumpT = ply.NextJumpT or CurTime()
			if math.random(1,50) == 1 && ply:OnGround() && CurTime() > ply.NextJumpT then
				cmd:SetButtons(IN_JUMP)
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
			if dist > targDist && ((!IsValid(ply.ZM_Follow) && wep.IsMelee) or true) then
				cmd:SetForwardMove(ply:GetWalkSpeed())
				cmd:SetViewAngles(((enemy:GetPos() +enemy:OBBCenter()) -ply:GetShootPos()):GetNormalized():Angle())
			end
			if dist <= 1500 then
				if IsValid(wep) then
					cmd:SetButtons((wep:Clip1() <= 0 && wep:Clip1() != wep.Primary.DefaultClip) && IN_RELOAD or IN_ATTACK)
				end
			end
		end

		if !IsValid(enemy) or enemy:Health() <= 0 then
			ply.ZM_Enemy = NULL
		end
	end
end)