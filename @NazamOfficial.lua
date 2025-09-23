-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local chr, hum

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "FlyGui"
gui.Parent = game:GetService("CoreGui")
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 280, 0, 300)
Main.Position = UDim2.new(0.5, -140, 0.5, -150)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = gui

local UICorner = Instance.new("UICorner", Main)
UICorner.CornerRadius = UDim.new(0, 10)

-- Title Bar
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(120, 0, 200)
Title.Text = "Fly Menu | Speed: 1"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.BorderSizePixel = 0
Title.Parent = Main
local UICorner2 = Instance.new("UICorner", Title)
UICorner2.CornerRadius = UDim.new(0,10)

-- Container untuk tombol
local Holder = Instance.new("Frame")
Holder.Size = UDim2.new(1, -20, 1, -60)
Holder.Position = UDim2.new(0, 10, 0, 50)
Holder.BackgroundTransparency = 1
Holder.Parent = Main

local UIListLayout = Instance.new("UIListLayout", Holder)
UIListLayout.Padding = UDim.new(0,8)

-- Fungsi buat bikin tombol
local function createButton(text, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    btn.Parent = Holder
    local round = Instance.new("UICorner", btn)
    round.CornerRadius = UDim.new(0,8)
    return btn
end

-- Tombol2
local FlyBtn   = createButton("Terbang: OFF", Color3.fromRGB(0,120,215))
local UpBtn    = createButton("Naik", Color3.fromRGB(0,180,100))
local DownBtn  = createButton("Turun", Color3.fromRGB(200,100,0))
local SpeedUp  = createButton("Speed +", Color3.fromRGB(120,0,200))
local SpeedDown= createButton("Speed -", Color3.fromRGB(70,0,120))
local CloseBtn = createButton("Tutup Menu", Color3.fromRGB(180,0,0))

-- Core Variables
local flying = false
local speed = 1

-- Functions
local function updateTitle()
    Title.Text = "Fly Menu | Speed: "..speed
end

local function toggleFly()
    chr = player.Character
    hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
    if not hum then return end

    flying = not flying
    if flying then
        FlyBtn.Text = "Terbang: ON"
        FlyBtn.BackgroundColor3 = Color3.fromRGB(0,180,0)
        hum:ChangeState(Enum.HumanoidStateType.Physics)
        task.spawn(function()
            while flying and task.wait() do
                if hum.MoveDirection.Magnitude > 0 then
                    chr:TranslateBy(hum.MoveDirection * speed)
                end
            end
        end)
    else
        FlyBtn.Text = "Terbang: OFF"
        FlyBtn.BackgroundColor3 = Color3.fromRGB(0,120,215)
    end
end

local function goUp()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame *= CFrame.new(0,2,0)
    end
end

local function goDown()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame *= CFrame.new(0,-2,0)
    end
end

local function addSpeed()
    speed += 1
    updateTitle()
end

local function minusSpeed()
    if speed > 1 then
        speed -= 1
        updateTitle()
    end
end

local function closeGui()
    gui:Destroy()
end

-- Connect Buttons
FlyBtn.MouseButton1Click:Connect(toggleFly)
UpBtn.MouseButton1Click:Connect(goUp)
DownBtn.MouseButton1Click:Connect(goDown)
SpeedUp.MouseButton1Click:Connect(addSpeed)
SpeedDown.MouseButton1Click:Connect(minusSpeed)
CloseBtn.MouseButton1Click:Connect(closeGui)

-- Shortcut untuk hide/show
local visible = true
UserInputService.InputBegan:Connect(function(input,gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.RightControl then
        visible = not visible
        Main.Visible = visible
    end
end)
