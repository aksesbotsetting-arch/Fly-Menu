-- Fly & NoClip System by NazamOfficial

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Wait for character
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

-- Variables
local NoClipEnabled = false
local FlyEnabled = false
local FlySpeed = 1
local Connections = {}
local ctrl = {f = 0, b = 0, l = 0, r = 0}
local lastctrl = {f = 0, b = 0, l = 0, r = 0}
local maxspeed = 50
local speed = 0
local bg, bv

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FlyNoClipGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 320, 0, 280)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -140)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = MainFrame

-- Gradient Background
local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 30)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 15))
}
Gradient.Rotation = 45
Gradient.Parent = MainFrame

-- Border Glow
local BorderGlow = Instance.new("UIStroke")
BorderGlow.Color = Color3.fromRGB(0, 170, 255)
BorderGlow.Thickness = 2
BorderGlow.Transparency = 0.3
BorderGlow.Parent = MainFrame

-- Header Frame
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 60)
Header.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 15)
HeaderCorner.Parent = Header

local HeaderFix = Instance.new("Frame")
HeaderFix.Size = UDim2.new(1, 0, 0, 15)
HeaderFix.Position = UDim2.new(0, 0, 1, -15)
HeaderFix.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
HeaderFix.BorderSizePixel = 0
HeaderFix.Parent = Header

-- Title with Icon
local TitleIcon = Instance.new("TextLabel")
TitleIcon.Size = UDim2.new(0, 45, 0, 45)
TitleIcon.Position = UDim2.new(0, 10, 0, 8)
TitleIcon.BackgroundTransparency = 1
TitleIcon.Text = "⚡"
TitleIcon.TextColor3 = Color3.fromRGB(0, 170, 255)
TitleIcon.TextSize = 32
TitleIcon.Font = Enum.Font.GothamBold
TitleIcon.Parent = Header

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -140, 1, 0)
Title.Position = UDim2.new(0, 60, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "FLY & NOCLIP"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, -140, 0, 20)
Subtitle.Position = UDim2.new(0, 60, 0, 30)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "by @NazamOfficial"
Subtitle.TextColor3 = Color3.fromRGB(150, 150, 150)
Subtitle.TextSize = 12
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = Header

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -50, 0, 10)
CloseButton.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseButton.TextSize = 22
CloseButton.Font = Enum.Font.GothamBold
CloseButton.BorderSizePixel = 0
CloseButton.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 10)
CloseCorner.Parent = CloseButton

local CloseStroke = Instance.new("UIStroke")
CloseStroke.Color = Color3.fromRGB(255, 80, 80)
CloseStroke.Thickness = 1.5
CloseStroke.Transparency = 0.5
CloseStroke.Parent = CloseButton

-- Notification Frame
local NotificationFrame = Instance.new("Frame")
NotificationFrame.Name = "NotificationFrame"
NotificationFrame.Size = UDim2.new(1, -30, 0, 45)
NotificationFrame.Position = UDim2.new(0, 15, 0, 70)
NotificationFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
NotificationFrame.BorderSizePixel = 0
NotificationFrame.Parent = MainFrame

local NotifCorner = Instance.new("UICorner")
NotifCorner.CornerRadius = UDim.new(0, 10)
NotifCorner.Parent = NotificationFrame

local NotificationLabel = Instance.new("TextLabel")
NotificationLabel.Size = UDim2.new(1, -20, 1, 0)
NotificationLabel.Position = UDim2.new(0, 10, 0, 0)
NotificationLabel.BackgroundTransparency = 1
NotificationLabel.Text = "Ready to use!"
NotificationLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
NotificationLabel.TextSize = 14
NotificationLabel.Font = Enum.Font.GothamSemibold
NotificationLabel.TextXAlignment = Enum.TextXAlignment.Center
NotificationLabel.Parent = NotificationFrame

-- Show Notification
local function ShowNotification(text, color)
    NotificationLabel.Text = text
    NotificationLabel.TextColor3 = color or Color3.fromRGB(100, 255, 100)
    NotificationLabel.TextTransparency = 0
    TweenService:Create(NotificationFrame, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(35, 35, 45)}):Play()
    task.wait(2)
    TweenService:Create(NotificationLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(NotificationFrame, TweenInfo.new(0.5), {BackgroundColor3 = Color3.fromRGB(25, 25, 35)}):Play()
end

-- Button Creator
local function CreateButton(name, text, icon, position, parent)
    local buttonFrame = Instance.new("Frame")
    buttonFrame.Name = name.."Frame"
    buttonFrame.Size = UDim2.new(1, -30, 0, 70)
    buttonFrame.Position = position
    buttonFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    buttonFrame.BorderSizePixel = 0
    buttonFrame.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = buttonFrame
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(50, 50, 60)
    stroke.Thickness = 1.5
    stroke.Transparency = 0.7
    stroke.Parent = buttonFrame
    
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(0, 50, 0, 50)
    iconLabel.Position = UDim2.new(0, 10, 0.5, -25)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = icon
    iconLabel.TextColor3 = Color3.fromRGB(0, 170, 255)
    iconLabel.TextSize = 32
    iconLabel.Font = Enum.Font.GothamBold
    iconLabel.Parent = buttonFrame
    
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(1, -70, 1, 0)
    button.Position = UDim2.new(0, 70, 0, 0)
    button.BackgroundTransparency = 1
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 18
    button.Font = Enum.Font.GothamBold
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.Parent = buttonFrame
    
    button.MouseEnter:Connect(function()
        TweenService:Create(buttonFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 50)}):Play()
        TweenService:Create(stroke, TweenInfo.new(0.2), {Transparency = 0.3, Color = Color3.fromRGB(0, 170, 255)}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(buttonFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 25, 35)}):Play()
        TweenService:Create(stroke, TweenInfo.new(0.2), {Transparency = 0.7, Color = Color3.fromRGB(50, 50, 60)}):Play()
    end)
    
    return button, buttonFrame, iconLabel
end

-- Create Buttons
local FlyButton = CreateButton("FlyButton", "FLY: OFF", "✈️", UDim2.new(0, 15, 0, 125), MainFrame)
local NoClipButton = CreateButton("NoClipButton", "NOCLIP: OFF", "👻", UDim2.new(0, 15, 0, 205), MainFrame)

-- Mini Icon
local MiniIcon = Instance.new("Frame")
MiniIcon.Name = "MiniIcon"
MiniIcon.Size = UDim2.new(0, 70, 0, 70)
MiniIcon.Position = UDim2.new(0, 20, 0, 20)
MiniIcon.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MiniIcon.BorderSizePixel = 0
MiniIcon.Visible = false
MiniIcon.Active = true
MiniIcon.Draggable = true
MiniIcon.Parent = ScreenGui

local MiniCorner = Instance.new("UICorner")
MiniCorner.CornerRadius = UDim.new(0, 15)
MiniCorner.Parent = MiniIcon

local MiniStroke = Instance.new("UIStroke")
MiniStroke.Color = Color3.fromRGB(0, 170, 255)
MiniStroke.Thickness = 2
MiniStroke.Transparency = 0.3
MiniStroke.Parent = MiniIcon

local MiniButton = Instance.new("TextButton")
MiniButton.Size = UDim2.new(1, 0, 1, 0)
MiniButton.BackgroundTransparency = 1
MiniButton.Text = "⚡"
MiniButton.TextColor3 = Color3.fromRGB(0, 170, 255)
MiniButton.TextSize = 36
MiniButton.Font = Enum.Font.GothamBold
MiniButton.Parent = MiniIcon

-- Toggle GUI
local function ToggleGUI()
    if MainFrame.Visible then
        MainFrame.Visible = false
        MiniIcon.Visible = true
    else
        MainFrame.Visible = true
        MiniIcon.Visible = false
    end
end

CloseButton.MouseButton1Click:Connect(ToggleGUI)
MiniButton.MouseButton1Click:Connect(ToggleGUI)

-- NoClip System
local function EnableNoClip()
    if Connections.NoClip then Connections.NoClip:Disconnect() end
    
    Connections.NoClip = RunService.Stepped:Connect(function()
        if NoClipEnabled and Character then
            for _, part in pairs(Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end

NoClipButton.MouseButton1Click:Connect(function()
    NoClipEnabled = not NoClipEnabled
    
    if NoClipEnabled then
        NoClipButton.Text = "NOCLIP: ON"
        EnableNoClip()
        ShowNotification("✓ NoClip Enabled! Walk through walls!", Color3.fromRGB(100, 255, 100))
    else
        NoClipButton.Text = "NOCLIP: OFF"
        if Connections.NoClip then Connections.NoClip:Disconnect() end
        if Character then
            for _, part in pairs(Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
        ShowNotification("✗ NoClip Disabled!", Color3.fromRGB(255, 150, 100))
    end
end)

-- Fly System
local function EnableFly()
    if not Character or not HumanoidRootPart then return end
    
    Humanoid.PlatformStand = true
    
    bg = Instance.new("BodyGyro", HumanoidRootPart)
    bg.P = 9e4
    bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    bg.cframe = HumanoidRootPart.CFrame
    
    bv = Instance.new("BodyVelocity", HumanoidRootPart)
    bv.velocity = Vector3.new(0, 0.1, 0)
    bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
    
    if Connections.Fly then Connections.Fly:Disconnect() end
    
    Connections.Fly = RunService.RenderStepped:Connect(function()
        if FlyEnabled and Character and HumanoidRootPart and Humanoid.Health > 0 then
            if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
                speed = speed + 0.5 + (speed / maxspeed)
                if speed > maxspeed then speed = maxspeed end
            elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
                speed = speed - 1
                if speed < 0 then speed = 0 end
            end
            
            if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
                bv.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f + ctrl.b)) + 
                    ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l + ctrl.r, (ctrl.f + ctrl.b) * 0.2, 0).p) - 
                    workspace.CurrentCamera.CoordinateFrame.p)) * speed * FlySpeed
                lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
            elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
                bv.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f + lastctrl.b)) + 
                    ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l + lastctrl.r, (lastctrl.f + lastctrl.b) * 0.2, 0).p) - 
                    workspace.CurrentCamera.CoordinateFrame.p)) * speed * FlySpeed
            else
                bv.velocity = Vector3.new(0, 0, 0)
            end
            
            bg.cframe = workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f + ctrl.b) * 50 * speed / maxspeed), 0, 0)
        end
    end)
end

local function DisableFly()
    if Connections.Fly then
        Connections.Fly:Disconnect()
        Connections.Fly = nil
    end
    
    if bg then bg:Destroy() bg = nil end
    if bv then bv:Destroy() bv = nil end
    
    ctrl = {f = 0, b = 0, l = 0, r = 0}
    lastctrl = {f = 0, b = 0, l = 0, r = 0}
    speed = 0
    
    if Character and Humanoid then
        Humanoid.PlatformStand = false
    end
end

FlyButton.MouseButton1Click:Connect(function()
    FlyEnabled = not FlyEnabled
    
    if FlyEnabled then
        FlyButton.Text = "FLY: ON"
        EnableFly()
        ShowNotification("✓ Fly Enabled! Use WASD to fly!", Color3.fromRGB(100, 255, 100))
    else
        FlyButton.Text = "FLY: OFF"
        DisableFly()
        ShowNotification("✗ Fly Disabled!", Color3.fromRGB(255, 150, 100))
    end
end)

-- Keyboard Controls for Fly
UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed or not FlyEnabled then return end
    
    if input.KeyCode == Enum.KeyCode.W then
        ctrl.f = 1
    elseif input.KeyCode == Enum.KeyCode.S then
        ctrl.b = -1
    elseif input.KeyCode == Enum.KeyCode.A then
        ctrl.l = -1
    elseif input.KeyCode == Enum.KeyCode.D then
        ctrl.r = 1
    end
end)

UIS.InputEnded:Connect(function(input, gameProcessed)
    if not FlyEnabled then return end
    
    if input.KeyCode == Enum.KeyCode.W then
        ctrl.f = 0
    elseif input.KeyCode == Enum.KeyCode.S then
        ctrl.b = 0
    elseif input.KeyCode == Enum.KeyCode.A then
        ctrl.l = 0
    elseif input.KeyCode == Enum.KeyCode.D then
        ctrl.r = 0
    end
end)

-- Character Respawn Handler
LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    Character = newCharacter
    HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    Humanoid = Character:WaitForChild("Humanoid")
    
    if FlyEnabled then
        task.wait(0.5)
        DisableFly()
        FlyEnabled = false
        FlyButton.Text = "FLY: OFF"
    end
    
    if NoClipEnabled then
        task.wait(0.5)
        EnableNoClip()
    end
end)

-- Cleanup
ScreenGui.AncestryChanged:Connect(function(_, parent)
    if not parent then
        DisableFly()
        if Connections.NoClip then Connections.NoClip:Disconnect() end
        for _, connection in pairs(Connections) do
            if connection then connection:Disconnect() end
        end
    end
end)

-- Initial Notification
ShowNotification("Script Loaded! Press buttons to activate", Color3.fromRGB(100, 200, 255))
