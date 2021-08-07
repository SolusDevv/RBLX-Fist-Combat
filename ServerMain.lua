--【Ａｄｉ_Ｄｅｖｖ】
--𝐒𝐎𝐂𝐈𝐀𝐋𝐒
--https://twitter.com/Adi_Devv
--https://github.com/Adi-Devv
--CallMeAdi#0196

local SS = game:GetService("ServerStorage")
local Debris = game:GetService("Debris")
local Remote = script.Parent.Remote

local Combo = 1
local DoingCombo = 0
local Debounce = false
local BlockingDebounce = false
local CanDoAnything = true
local isBlocking = false

Remote.OnServerEvent:Connect(function(Plr, Action, Bool)
	local Char = Plr.Character
	local Hum = Char:WaitForChild("Humanoid")
	local HumRP = Char:WaitForChild("HumanoidRootPart")
	if Hum.Jump == false then
		
		local InsertDisabled = function(Target,Time)
			local Disabled = Instance.new("BoolValue", Target)
			Disabled.Name = "Disabled"
			Debris:AddItem(Disabled, Time)
		end
		
		local StopAnims = function()
			local AnimationTracks = Hum:GetPlayingAnimationTracks()
			for i,track in pairs (AnimationTracks) do
				track:Stop()
			end
		end
		
		local StopTargetAnim = function(Target)
			local AnimationTracks = Target.Humanoid:GetPlayingAnimationTracks()
			for i,track in pairs (AnimationTracks) do
				track:Stop()
			end
		end
		
		local InsertRagdoll = function(Target,Time)
			if Target:FindFirstChild("Effects") then
				local Ragdoll = SS.Assets.Ragdoll:Clone()
				Ragdoll.Parent = Target.Effects
				Debris:AddItem(Ragdoll, Time)
			end
		end
		
		local InsertStun = function(Target,Time)
			InsertDisabled(Target,Time)
			StopTargetAnim(Target)
			--Play Stun Loop Animation
			
			delay(Time,function()
				--Stop Stun animation
				
			end)
		end
		
		
		local PunchDetection = function(Char)
			local DamageAmount = 2.5
			local HeavyDamageAmount = 10
			
			local Hitbox = script.Hitboxes.PunchHitbox:Clone()
			Hitbox.Parent = workspace
			Hitbox.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(0,0,-2.5)
			if DoingCombo ~= 5 then
				for i,v in pairs(Hitbox:GetTouchingParts()) do
					if v.Parent ~= Char then
						if v.Parent:FindFirstChild("Humanoid") ~= nil and v.Name =="Torso" then
							if v.Parent:FindFirstChild("Blocking") then
								warn("Blocked")
							else
								
								--/Knockback
								local Speed = 40
								local Force = 80000
								local TotalForce = Force

								local KnockBack = Instance.new("BodyVelocity")
								KnockBack.Parent = v.Parent:FindFirstChild("HumanoidRootPart")

								KnockBack.MaxForce = Vector3.new(TotalForce,TotalForce,TotalForce)
								KnockBack.Velocity = HumRP.CFrame.LookVector * 40 -- make the player travel up and back
								Debris:AddItem(KnockBack, 0.025)
								
								v.Parent.Humanoid:TakeDamage(DamageAmount)
								InsertDisabled(v.Parent,1)
							end			
							Hitbox:Destroy()
						end
					end
				end
			else
				for i,v in pairs(Hitbox:GetTouchingParts()) do
					if v.Parent ~= Char then
						if v.Parent:FindFirstChild("Humanoid") ~= nil and v.Name =="Torso" then
							if v.Parent:FindFirstChild("Blocking") then
								if v.Parent:FindFirstChild("Parry") then
									warn("Pary")
								else
									warn("Block Break")
								end
							else
								
								--/Knockback
								local Speed = 40
								local Force = 80000
								local TotalForce = Force

								local KnockBack = Instance.new("BodyVelocity")
								KnockBack.Parent = v.Parent:FindFirstChild("HumanoidRootPart")

								KnockBack.MaxForce = Vector3.new(TotalForce,TotalForce,TotalForce)
								KnockBack.Velocity = HumRP.CFrame.LookVector * 40 -- make the player travel up and back
								Debris:AddItem(KnockBack, 0.25)
								
								v.Parent.Humanoid:TakeDamage(HeavyDamageAmount)
								InsertDisabled(v.Parent,1.85)
							end
						end
					end
				end
			end
			Hitbox:Destroy()
		end
		--Animations
		local Animations = script.Animations
		
		local Punch1 = Hum:LoadAnimation(Animations.Punch1)
		local Punch2 = Hum:LoadAnimation(Animations.Punch2)
		local Punch3 = Hum:LoadAnimation(Animations.Punch3)
		local Punch4 = Hum:LoadAnimation(Animations.Punch4)
		local Punch5 = Hum:LoadAnimation(Animations.Punch5)
		local Block = Hum:LoadAnimation(Animations.Block)
		
		
		if Action == "Punch" then
			if Debounce == false and Char:FindFirstChild("Disabled") == nil and CanDoAnything == true and Char:FindFirstChild("Blocking") == nil then
				CanDoAnything = false
				Debounce = true
				delay(0.4,function()
					if DoingCombo == 5 then
						delay(1,function() --How long will the Punch CD be
							Debounce = false
							CanDoAnything = true
						end)
					else
						CanDoAnything = true
						Debounce = false
					end
				end)

				if Combo == 1 then
					Combo = 2
					DoingCombo = 1
					delay(1,function()
						if Combo == 2 then
							Combo = 1
						end
					end)
				Punch1:Play()

				elseif Combo == 2 then
					Combo = 3
					DoingCombo = 2
					delay(1,function()
						if Combo == 3 then
							Combo = 1
						end
					end)
					
					Punch2:Play()
					
				elseif Combo == 3 then
					Combo = 4
					DoingCombo = 3
					delay(1,function()
						if Combo == 4 then
							Combo = 1
						end
					end)
					
					Punch3:Play()

				elseif Combo == 4 then
					Combo = 5
					DoingCombo = 4
					delay(1,function()
						if Combo == 5 then
							Combo = 1
						end
					end)
					
					Punch4:Play()

				elseif Combo == 5 then
					Combo = 1
					DoingCombo = 5
					delay(0.6,function()
						DoingCombo = 0
					end)
					
					Punch5:Play()
					
				end		
				
				--/Knockback
				local Speed = 40
				local Force = 80000
				local TotalForce = Force

				local KnockBack = Instance.new("BodyVelocity")
				KnockBack.Parent = HumRP

				KnockBack.MaxForce = Vector3.new(TotalForce,TotalForce,TotalForce)
				KnockBack.Velocity = HumRP.CFrame.LookVector * 40 -- make the player travel up and back
				Debris:AddItem(KnockBack, 0.028)

				
				Hum.WalkSpeed = 0
				Hum.JumpPower = 0
				
				delay(0.25,function()
					PunchDetection(Char)
					delay(0.15,function()
						if Char:FindFirstChild("Disabled") == nil and CanDoAnything == true then
							Hum.WalkSpeed = 16
							Hum.JumpPower = 50
						else
							delay(0.45,function()
								Hum.WalkSpeed = 16
								Hum.JumpPower = 50
							end)
						end
	
						
					end)
				end)
				
				
				
			end	
		elseif Action == "Block" then
			if Bool == false and isBlocking == true then
				--UnBlock
				BlockingDebounce = true
				delay(1,function() --Block CD
					BlockingDebounce = false
				end)
				
				delay(0.4,function()
					CanDoAnything = true
				end)
				
				isBlocking = false
				
				local AnimationTracks = Hum:GetPlayingAnimationTracks()
				for i, track in pairs(AnimationTracks) do
					if track.Name == "Block" then
						track:Stop()
					end
				end
				
				Hum.JumpPower = 50
				Hum.WalkSpeed = 16
				
				local Value = Char:FindFirstChild("Blocking")
				if Value then
					Value:Destroy()
				end
			elseif Char:FindFirstChild("Disabled") == nil and CanDoAnything == true and Bool == true and BlockingDebounce == false and isBlocking == false then
				isBlocking = true
				CanDoAnything = false
				
				Hum.JumpPower = 0
				Hum.WalkSpeed = 0 --If you want the Character to be able to move while blocking change this to be greater than 0
				
				Block:Play()
				
				local Val = Instance.new("BoolValue",Char)
				Val.Name = "Parry"
				game.Debris:AddItem(Val,0.45)
				
				local Value = Instance.new("BoolValue", Char)
				Value.Name = "Blocking"
				
			end
		end
		
		
		--END
	end
end)
