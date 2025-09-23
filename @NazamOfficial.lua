-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "FlyGui"
gui.Parent = game:GetService("CoreGui")
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 320, 0, 220)
Main.Position = UDim2.new(0.5, -160, 0.5, -110)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = gui

local UICorner = Instance.new("UICorner", Main)
UICorner.CornerRadius = UDim.new(0, 8)

-- Title Bar
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
Title.BorderSizePixel = 0
Title.Text = "Fly Menu | @Nazam Official"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.Parent = Main

local UICorner2 = Instance.new("UICorner", Title)
UICorner2.CornerRadius = UDim.new(0,8)

-- Buttons
local function createButton(name, text, posY, color)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(0.85, 0, 0, 40)
    btn.Position = UDim2.new(0.075, 0, 0, posY)
    btn.BackgroundColor3 = color
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    btn.Parent = Main
    local round = Instance.new("UICorner", btn)
    round.CornerRadius = UDim.new(0,6)
    return btn
end

local FlyBtn   = createButton("FlyBtn","Terbang | OFF",0.25,Color3.fromRGB(0,120,215))
local UpBtn    = createButton("UpBtn","Naik",0.45,Color3.fromRGB(0,180,100))
local DownBtn  = createButton("DownBtn","Turun",0.65,Color3.fromRGB(200,100,0))
local SpeedBtn = createButton("SpeedBtn","Speed: 1",0.85,Color3.fromRGB(120,0,200))

-- Core Variables
local flying = false
local speed = 1
local chr, hum

-- Functions
local function toggleFly()
    chr = player.Character
    hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
    if not hum then return end

    flying = not flying
    if flying then
        FlyBtn.Text = "Terbang | ON"
        FlyBtn.BackgroundColor3 = Color3.fromRGB(0,180,0)
        -- masukin logic terbang dari script pertama
        hum:ChangeState(Enum.HumanoidStateType.Physics)
        spawn(function()
            while flying and task.wait() do
                if hum.MoveDirection.Magnitude > 0 then
                    chr:TranslateBy(hum.MoveDirection * speed)
                end
            end
        end)
    else
        FlyBtn.Text = "Terbang | OFF"
        FlyBtn.BackgroundColor3 = Color3.fromRGB(0,120,215)
    end
end

local function goUp()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame *= CFrame.new(0,1,0)
    end
end

local function goDown()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame *= CFrame.new(0,-1,0)
    end
end

local function addSpeed()
    speed += 1
    SpeedBtn.Text = "Speed: "..speed
end

-- Button Events
FlyBtn.MouseButton1Click:Connect(toggleFly)
UpBtn.MouseButton1Click:Connect(goUp)
DownBtn.MouseButton1Click:Connect(goDown)
SpeedBtn.MouseButton1Click:Connect(addSpeed)

-- Toggle GUI with RightControl
local visible = true
UserInputService.InputBegan:Connect(function(input,gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.RightControl then
        visible = not visible
        Main.Visible = visible
    end
end)
