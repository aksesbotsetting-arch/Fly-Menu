-- AUTO WALK RUNNER - RUN SYSTEM 
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- Hapus GUI lama jika ada
if player.PlayerGui:FindFirstChild("RunGUI") then
    player.PlayerGui:FindFirstChild("RunGUI"):Destroy()
end

-- Variabel system
local IsPlaying = false
local IsPaused = false
local PlaybackConnection = nil
local CurrentRecording = nil
local CurrentAnimationPack = nil
local CurrentAnimTrack = nil

-- 15 PACK ANIMATION (1 ID = 1 PACK LENGKAP)
local ANIMATION_PACKS = {
    ["Adidas Pack"] = "rbxassetid://1234567890",  -- Ganti dengan ID pack Adidas
    ["Nike Pack"] = "rbxassetid://2345678901",    -- Ganti dengan ID pack Nike  
    ["Sport Pack"] = "rbxassetid://3456789012",   -- Ganti dengan ID pack Sport
    ["Elegant Pack"] = "rbxassetid://4567890123",
    ["Casual Pack"] = "rbxassetid://5678901234",
    ["Fantasy Pack"] = "rbxassetid://6789012345",
    ["Robot Pack"] = "rbxassetid://7890123456",
    ["Zombie Pack"] = "rbxassetid://8901234567",
    ["Superhero Pack"] = "rbxassetid://9012345678",
    ["Cartoon Pack"] = "rbxassetid://0123456789",
    ["Military Pack"] = "rbxassetid://1122334455", 
    ["Dance Pack"] = "rbxassetid://2233445566",
    ["Horror Pack"] = "rbxassetid://3344556677",
    ["Cyber Pack"] = "rbxassetid://4455667788",
    ["Default Pack"] = "rbxassetid://5566778899"
}

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RunGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player.PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 250)
MainFrame.Position = UDim2.new(0.5, -150, 0, 20)
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🚀 AUTO WALK RUNNER"
Title.TextColor3 = Color3.fromRGB(255, 255, 0)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

-- Select Animation Button
local AnimButton = Instance.new("TextButton")
AnimButton.Size = UDim2.new(0.8, 0, 0, 35)
AnimButton.Position = UDim2.new(0.1, 0, 0, 35)
AnimButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
AnimButton.BorderSizePixel = 0
AnimButton.Text = "🎭 SELECT ANIMATION PACK"
AnimButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AnimButton.TextSize = 14
AnimButton.Font = Enum.Font.GothamBold
AnimButton.Parent = MainFrame

local AnimCorner = Instance.new("UICorner")
AnimCorner.CornerRadius = UDim.new(0, 6)
AnimCorner.Parent = AnimButton

-- Animation Pack List (akan muncul saat klik)
local AnimListFrame = Instance.new("Frame")
AnimListFrame.Size = UDim2.new(0.9, 0, 0, 200)
AnimListFrame.Position = UDim2.new(0.05, 0, 0, 75)
AnimListFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
AnimListFrame.BorderSizePixel = 0
AnimListFrame.Visible = false
AnimListFrame.Parent = MainFrame

local AnimListCorner = Instance.new("UICorner")
AnimListCorner.CornerRadius = UDim.new(0, 6)
AnimListCorner.Parent = AnimListFrame

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.ScrollBarThickness = 4
ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 0)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingFrame.Parent = AnimListFrame

local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0, 5)
ListLayout.Parent = ScrollingFrame

ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y)
end)

-- Run Button
local RunButton = Instance.new("TextButton")
RunButton.Size = UDim2.new(0.8, 0, 0, 35)
RunButton.Position = UDim2.new(0.1, 0, 0, 75)
RunButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
RunButton.BorderSizePixel = 0
RunButton.Text = "▶️ RUN"
RunButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RunButton.TextSize = 14
RunButton.Font = Enum.Font.GothamBold
RunButton.Parent = MainFrame

local RunCorner = Instance.new("UICorner")
RunCorner.CornerRadius = UDim.new(0, 6)
RunCorner.Parent = RunButton

-- Pause Button
local PauseButton = Instance.new("TextButton")
PauseButton.Size = UDim2.new(0.8, 0, 0, 35)
PauseButton.Position = UDim2.new(0.1, 0, 0, 115)
PauseButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
PauseButton.BorderSizePixel = 0
PauseButton.Text = "⏸️ PAUSE"
PauseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
PauseButton.TextSize = 14
PauseButton.Font = Enum.Font.GothamBold
PauseButton.Parent = MainFrame

local PauseCorner = Instance.new("UICorner")
PauseCorner.CornerRadius = UDim.new(0, 6)
PauseCorner.Parent = PauseButton

-- Status Label
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 20)
StatusLabel.Position = UDim2.new(0, 0, 0, 225)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Status: Ready - Paste JSON data"
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.TextSize = 11
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Parent = MainFrame

-- Fungsi load animation pack
local function LoadAnimationPack(packName)
    if not ANIMATION_PACKS[packName] then return end
    
    CurrentAnimationPack = packName
    
    -- Stop animasi lama
    if CurrentAnimTrack then
        CurrentAnimTrack:Stop()
        CurrentAnimTrack = nil
    end
    
    -- Load animation pack baru (1 ID untuk semua gerakan)
    local animation = Instance.new("Animation")
    animation.AnimationId = ANIMATION_PACKS[packName]
    CurrentAnimTrack = humanoid:LoadAnimation(animation)
    
    -- Mainkan animasi
    if CurrentAnimTrack then
        CurrentAnimTrack:Play()
    end
    
    StatusLabel.Text = "Animation: " .. packName
    AnimListFrame.Visible = false
end

-- Fungsi show animation list
local function ShowAnimationList()
    -- Clear existing buttons
    for _, child in pairs(ScrollingFrame:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    -- Create buttons for each pack
    for packName, packId in pairs(ANIMATION_PACKS) do
        local PackButton = Instance.new("TextButton")
        PackButton.Size = UDim2.new(0.9, 0, 0, 30)
        PackButton.Position = UDim2.new(0.05, 0, 0, 0)
        PackButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        PackButton.BorderSizePixel = 0
        PackButton.Text = "🎭 " .. packName
        PackButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        PackButton.TextSize = 12
        PackButton.Font = Enum.Font.Gotham
        PackButton.Parent = ScrollingFrame
        
        local PackCorner = Instance.new("UICorner")
        PackCorner.CornerRadius = UDim.new(0, 4)
        PackCorner.Parent = PackButton
        
        PackButton.MouseButton1Click:Connect(function()
            LoadAnimationPack(packName)
        end)
        
        PackButton.MouseEnter:Connect(function()
            PackButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        end)
        
        PackButton.MouseLeave:Connect(function()
            PackButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        end)
    end
    
    AnimListFrame.Visible = not AnimListFrame.Visible
end

-- Fungsi find nearest point
local function FindNearestPoint(currentPos, recordingData)
    if not recordingData then return 1 end
    
    local nearestIndex = 1
    local nearestDistance = math.huge
    
    for i, posData in ipairs(recordingData.positions) do
        local pos = Vector3.new(posData.X, posData.Y, posData.Z)
        local distance = (currentPos - pos).Magnitude
        
        if distance < nearestDistance then
            nearestDistance = distance
            nearestIndex = i
        end
    end
    
    return math.max(1, nearestIndex - 1) -- Mulai dari sedikit sebelum titik terdekat
end

-- Fungsi stop playback
local function StopPlayback()
    IsPlaying = false
    IsPaused = false
    
    if PlaybackConnection then
        PlaybackConnection:Disconnect()
        PlaybackConnection = nil
    end
    
    -- Hapus physics
    if rootPart then
        local velocity = rootPart:FindFirstChild("WalkVelocity")
        local gyro = rootPart:FindFirstChild("WalkGyro")
        if velocity then velocity:Destroy() end
        if gyro then gyro:Destroy() end
    end
    
    RunButton.Text = "▶️ RUN"
    RunButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    PauseButton.Text = "⏸️ PAUSE"
    PauseButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
end

-- Fungsi play recording
local function PlayRecording()
    if not CurrentRecording or IsPlaying then return end
    
    IsPlaying = true
    IsPaused = false
    
    local startPlaybackTime = tick()
    local currentIndex = FindNearestPoint(rootPart.Position, CurrentRecording.data)
    
    StatusLabel.Text = "Status: 🚀 Running from point " .. currentIndex
    RunButton.Text = "⏹️ STOP"
    RunButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    
    PlaybackConnection = RunService.Heartbeat:Connect(function(deltaTime)
        if not IsPlaying or not rootPart then
            StopPlayback()
            return
        end
        
        if IsPaused then return end
        
        local currentTime = tick() - startPlaybackTime
        
        -- Cari posisi target berdasarkan timestamp
        while currentIndex < #CurrentRecording.data.timestamps and 
              CurrentRecording.data.timestamps[currentIndex + 1] <= currentTime do
            currentIndex = currentIndex + 1
        end
        
        if currentIndex >= #CurrentRecording.data.positions then
            StopPlayback()
            StatusLabel.Text = "Status: ✅ Playback Complete"
            return
        end
        
        -- Dapatkan target position
        local targetPosData = CurrentRecording.data.positions[currentIndex]
        local targetPos = Vector3.new(targetPosData.X, targetPosData.Y, targetPosData.Z)
        
        -- Gerakkan karakter
        local direction = (targetPos - rootPart.Position)
        local distance = direction.Magnitude
        
        if distance > 1 then
            -- Hapus velocity lama
            local oldVelocity = rootPart:FindFirstChild("WalkVelocity")
            local oldGyro = rootPart:FindFirstChild("WalkGyro")
            if oldVelocity then oldVelocity:Destroy() end
            if oldGyro then oldGyro:Destroy() end
            
            -- Buat velocity baru
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.Name = "WalkVelocity"
            bodyVelocity.Velocity = direction.Unit * 16
            bodyVelocity.MaxForce = Vector3.new(4000, 0, 4000)
            bodyVelocity.P = 1000
            bodyVelocity.Parent = rootPart
            
            -- Buat gyro untuk orientasi
            local bodyGyro = Instance.new("BodyGyro")
            bodyGyro.Name = "WalkGyro"
            bodyGyro.MaxTorque = Vector3.new(4000, 4000, 4000)
            bodyGyro.CFrame = CFrame.lookAt(rootPart.Position, rootPart.Position + direction)
            bodyGyro.P = 500
            bodyGyro.Parent = rootPart
            
            -- Update animasi
            if CurrentAnimTrack and not CurrentAnimTrack.IsPlaying then
                CurrentAnimTrack:Play()
            end
            
        else
            -- Hentikan velocity jika sudah dekat
            local velocity = rootPart:FindFirstChild("WalkVelocity")
            if velocity then
                velocity.Velocity = Vector3.new(0, 0, 0)
            end
        end
        
        StatusLabel.Text = string.format("Status: Running %d/%d (%.1fm)", 
            currentIndex, #CurrentRecording.data.positions, distance)
    end)
end

-- Fungsi pause/resume
local function TogglePause()
    if not IsPlaying then return end
    
    IsPaused = not IsPaused
    
    if IsPaused then
        PauseButton.Text = "▶️ RESUME"
        PauseButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        StatusLabel.Text = "Status: ⏸️ Paused"
        
        -- Hentikan velocity saat pause
        local velocity = rootPart:FindFirstChild("WalkVelocity")
        if velocity then
            velocity.Velocity = Vector3.new(0, 0, 0)
        end
    else
        PauseButton.Text = "⏸️ PAUSE"
        PauseButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        StatusLabel.Text = "Status: 🚀 Resumed"
    end
end

-- Fungsi load JSON data
local function LoadRecordingData(jsonString)
    local success, data = pcall(function()
        return HttpService:JSONDecode(jsonString)
    end)
    
    if success and data then
        CurrentRecording = data
        StatusLabel.Text = string.format("Status: ✅ Loaded %d points", data.points)
        return true
    else
        StatusLabel.Text = "Status: ❌ Invalid JSON data"
        return false
    end
end

-- Event handlers
AnimButton.MouseButton1Click:Connect(ShowAnimationList)

RunButton.MouseButton1Click:Connect(function()
    if not IsPlaying then
        if CurrentRecording then
            PlayRecording()
        else
            StatusLabel.Text = "Status: ❌ No recording data loaded!"
        end
    else
        StopPlayback()
        StatusLabel.Text = "Status: Stopped"
    end
end)

PauseButton.MouseButton1Click:Connect(TogglePause)

-- Input JSON data (via console atau file)
print("=== AUTO WALK RUNNER ===")
print("1. Paste your JSON recording data below:")
print("2. Click SELECT ANIMATION PACK to choose animation")
print("3. Click RUN to start playback")

-- Auto load dari file jika ada
spawn(function()
    wait(2)
    if readfile and isfile("AutoWalk_Recording.json") then
        local jsonData = readfile("AutoWalk_Recording.json")
        if LoadRecordingData(jsonData) then
            print("✅ Auto-loaded recording from file!")
        end
    end
end)

-- Handle character change
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = newChar:WaitForChild("Humanoid")
    rootPart = newChar:WaitForChild("HumanoidRootPart")
    
    StopPlayback()
    
    -- Reload animasi pack jika ada
    if CurrentAnimationPack then
        LoadAnimationPack(CurrentAnimationPack)
    end
end)

print("🚀 AUTO WALK RUNNER READY!")
