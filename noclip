-- Tek Parça Noclip (Duvarlardan Geçme) Scripti
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local noclip = false

-- N tuşuna basıldığında modu aç/kapa
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.N then
		noclip = not noclip
		print("Noclip Modu: " .. (noclip and "AÇIK" or "KAPALI"))
	end
end)

-- Her karede çalışarak fizik motorunun çarpışmasını engelle
RunService.Stepped:Connect(function()
	if noclip then
		local character = player.Character
		if character then
			for _, part in pairs(character:GetDescendants()) do
				if part:IsA("BasePart") and part.CanCollide == true then
					part.CanCollide = false
				end
			end
		end
	end
end)
