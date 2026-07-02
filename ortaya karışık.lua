-- Xeno Başlatıcı Kontrolü
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Karakterin tamamen yüklendiğinden emin ol
if not player.Character then 
    player.CharacterAdded:Wait() 
end

-- Kodunu buranın altına ekle...
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui", player.PlayerGui)
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0.5, -100, 0.5, -50)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

local btnNoclip = Instance.new("TextButton", frame)
btnNoclip.Size = UDim2.new(0.9, 0, 0.4, 0)
btnNoclip.Position = UDim2.new(0.05, 0, 0.05, 0)
btnNoclip.Text = "NOCLIP (KAPALI)"

local btnFly = Instance.new("TextButton", frame)
btnFly.Size = UDim2.new(0.9, 0, 0.4, 0)
btnFly.Position = UDim2.new(0.05, 0, 0.55, 0)
btnFly.Text = "UÇUŞ (KAPALI)"

local noclip, fly = false, false

btnNoclip.MouseButton1Click:Connect(function()
    noclip = not noclip
    btnNoclip.Text = noclip and "NOCLIP (AÇIK)" or "NOCLIP (KAPALI)"
end)

btnFly.MouseButton1Click:Connect(function()
    fly = not fly
    btnFly.Text = fly and "UÇUŞ (AÇIK)" or "UÇUŞ (KAPALI)"
end)

RunService.Stepped:Connect(function()
    local char = player.Character
    if not char then return end
    
    -- Noclip Mantığı
    if noclip then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
    
    -- Uçuş Mantığı
    if fly then
        local root = char:FindFirstChild("HumanoidRootPart")
        if root then
            root.Velocity = Vector3.new(0, 0, 0) -- Hızı sıfırla
            if not root:FindFirstChild("BodyVelocity") then
                local bv = Instance.new("BodyVelocity", root)
                bv.Name = "FlyBV"
                bv.MaxForce = Vector3.new(1, 1, 1) * 100000
                bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * 50
            end
        end
    else
        if char:FindFirstChild("HumanoidRootPart") and char.HumanoidRootPart:FindFirstChild("FlyBV") then
            char.HumanoidRootPart.FlyBV:Destroy()
        end
    end
end)
