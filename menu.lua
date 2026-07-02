-- Admin Kontrol Paneli (Uçuş ve Noclip)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- RemoteEvent Kontrolü (Uçuş için Server'a sinyal gönderir)
local flightEvent = ReplicatedStorage:FindFirstChild("UcusEvent") or Instance.new("RemoteEvent", ReplicatedStorage)
flightEvent.Name = "UcusEvent"

-- GUI Oluşturma
local screenGui = Instance.new("ScreenGui", player.PlayerGui)
local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 220, 0, 150)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local title = Instance.new("TextLabel", frame)
title.Text = "KONTROL PANELİ"
title.Size = UDim2.new(1, 0, 0, 30)
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1

local function createButton(text, pos)
	local btn = Instance.new("TextButton", frame)
	btn.Text = text
	btn.Size = UDim2.new(0.9, 0, 0, 40)
	btn.Position = pos
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	btn.TextColor3 = Color3.new(1, 1, 1)
	return btn
end

local noclipBtn = createButton("NOCLIP: KAPALI", UDim2.new(0.05, 0, 0.25, 0))
local flightBtn = createButton("UÇUŞ: KAPALI", UDim2.new(0.05, 0, 0.6, 0))

-- Mantık
local noclip, flying = false, false

noclipBtn.MouseButton1Click:Connect(function()
	noclip = not noclip
	noclipBtn.Text = noclip and "NOCLIP: AÇIK" or "NOCLIP: KAPALI"
	noclipBtn.BackgroundColor3 = noclip and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(50, 50, 50)
end)

flightBtn.MouseButton1Click:Connect(function()
	flying = not flying
	flightBtn.Text = flying and "UÇUŞ: AÇIK" or "UÇUŞ: KAPALI"
	flightBtn.BackgroundColor3 = flying and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(50, 50, 50)
end)

-- Döngü (Fizik Güncelleme)
RunService.Stepped:Connect(function()
	local char = player.Character
	if not char then return end
	
	-- Noclip
	if noclip then
		for _, v in pairs(char:GetDescendants()) do
			if v:IsA("BasePart") then v.CanCollide = false end
		end
	end
	
	-- Uçuş (Sunucu ile senkronizasyon)
	if flying then
		local root = char:FindFirstChild("HumanoidRootPart")
		if root then
			local direction = workspace.CurrentCamera.CFrame.LookVector
			flightEvent:FireServer(true, direction)
		end
	else
		flightEvent:FireServer(false, Vector3.zero)
	end
end)
