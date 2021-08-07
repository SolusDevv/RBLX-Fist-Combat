--【Ａｄｉ_Ｄｅｖｖ】
--𝐒𝐎𝐂𝐈𝐀𝐋𝐒
--https://twitter.com/Adi_Devv
--https://github.com/Adi-Devv
--CallMeAdi#0196

local UIS = game:GetService("UserInputService")
local Remote = script.Remote

local Plr = game.Players.LocalPlayer
local Char = Plr.Character or Plr.CharacterAdded:Wait()
while Char.Parent == nil do
	Char.AncestryChanged:Wait()
end
local HumRP = Char:WaitForChild("HumanoidRootPart")
local Hum = Char:WaitForChild("Humanoid")
local CanDoAnything = true
local Blocking = false

UIS.InputBegan:Connect(function(input,isTyping)
	if isTyping then return end
	
	if CanDoAnything == true then
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			Remote:FireServer("Punch")
		end
	end
	
end)

local RunService = game:GetService("RunService")
RunService.RenderStepped:Connect(function()
	local Plr = game.Players.LocalPlayer
	local Char = Plr.Character
	local Hum = Char:FindFirstChild("Humanoid")
	
	if UIS:IsKeyDown(Enum.KeyCode.F) then
		if CanDoAnything == true then
			if Blocking == false then
				Blocking = true
				Remote:FireServer("Block", true)
			end
		end
	else
		if Blocking == true then
			Blocking = false
			Remote:FireServer("Block", false)
		end
	end
end)
