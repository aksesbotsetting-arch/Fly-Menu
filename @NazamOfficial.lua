-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- GUI
local main = Instance.new("ScreenGui")
main.Name = "FlyGui"
main.Parent = player:WaitForChild("PlayerGui")
main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
main.ResetOnSpawn = false

-- Fungsi draggable
local function makeDraggable(frame)
	local dragToggle, dragStart, startPos
	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragToggle = true
			dragStart = input.Position
			startPos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragToggle = false
				end
			end)
		end
	end)
	frame.InputChanged:Connect(function(input)
		if dragToggle and (input.UserInputType == Enum.UserInputType.MouseMovement) then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

-- Frame utama
local Frame = Instance.new("Frame")
Frame.Parent = main
Frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
Frame.BorderSizePixel = 2
Frame.BorderColor3 = Color3.fromRGB(255,255,255)
Frame.Position = UDim2.new(0.1,0,0.3,0)
Frame.Size = UDim2.new(0,230,0,160)
makeDraggable(Frame)

-- Title
local Title = Instance.new("TextLabel")
Title.Parent = Frame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1,0,0,30)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "Fly | @NazamOfficial"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.TextSize = 20
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Position = UDim2.new(0,8,0,0)

-- Tombol Close
local closebutton = Instance.new("TextButton")
closebutton.Parent = Frame
closebutton.BackgroundColor3 = Color3.fromRGB(255,50,50)
closebutton.Size = UDim2.new(0,30,0,30)
closebutton.Position = UDim2.new(1,-35,0,0)
closebutton.Text = "X"
closebutton.TextColor3 = Color3.new(1,1,1)
closebutton.Font = Enum.Font.SourceSansBold
closebutton.TextSize = 18

-- Tombol Fly kecil
local FlyBtn = Instance.new("TextButton")
FlyBtn.Parent = main
FlyBtn.Size = UDim2.new(0,45,0,45)
FlyBtn.Position = UDim2.new(0.5,-35,0,20)
FlyBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
FlyBtn.Text = "Fly"
FlyBtn.TextColor3 = Color3.new(1,1,1)
FlyBtn.Font = Enum.Font.SourceSansBold
FlyBtn.Visible = false
makeDraggable(FlyBtn)
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1,0)
corner.Parent = FlyBtn

-- Tombol
local up = Instance.new("TextButton", Frame)
up.Size = UDim2.new(0,100,0,30)
up.Position = UDim2.new(0,10,0,40)
up.Text = "NAIK"

local down = Instance.new("TextButton", Frame)
down.Size = UDim2.new(0,100,0,30)
down.Position = UDim2.new(0,10,0,80)
down.Text = "TURUN"

local onof = Instance.new("TextButton", Frame)
onof.Size = UDim2.new(0,100,0,30)
onof.Position = UDim2.new(0,120,0,40)
onof.Text = "TERBANG"

local speedLabel = Instance.new("TextLabel", Frame)
speedLabel.Size = UDim2.new(0,100,0,30)
speedLabel.Position = UDim2.new(0,120,0,80)
speedLabel.Text = "1"
speedLabel.TextColor3 = Color3.new(1,1,1)
speedLabel.BackgroundColor3 = Color3.fromRGB(40,40,40)

local plus = Instance.new("TextButton", Frame)
plus.Size = UDim2.new(0,45,0,30)
plus.Position = UDim2.new(0,10,0,120)
plus.Text = "+"

local minus = Instance.new("TextButton", Frame)
minus.Size = UDim2.new(0,45,0,30)
minus.Position = UDim2.new(0,65,0,120)
minus.Text = "-"

-- ====== LOGIC FLY ======
local flying = false
local speed = 1
local moveY = 0

local bv, bg

local function startFly()
	if flying then return end
	flying = true
	bv = Instance.new("BodyVelocity")
	bv.MaxForce = Vector3.new(1e5,1e5,1e5)
	bv.Velocity = Vector3.zero
	bv.Parent = hrp

	bg = Instance.new("BodyGyro")
	bg.MaxTorque = Vector3.new(1e5,1e5,1e5)
	bg.P = 9e4
	bg.CFrame = hrp.CFrame
	bg.Parent = hrp

	RunService.RenderStepped:Connect(function()
		if flying and hrp and bv then
			local camCF = workspace.CurrentCamera.CFrame
			local moveVec = Vector3.new(0,moveY,0)
			bv.Velocity = (camCF.LookVector * speed) + moveVec
			bg.CFrame = camCF
		end
	end)
end

local function stopFly()
	flying = false
	if bv then bv:Destroy() bv = nil end
	if bg then bg:Destroy() bg = nil end
end

-- Tombol event
onof.MouseButton1Click:Connect(function()
	if flying then
		stopFly()
		onof.Text = "TERBANG"
	else
		startFly()
		onof.Text = "STOP"
	end
end)

up.MouseButton1Click:Connect(function() moveY = speed end)
down.MouseButton1Click:Connect(function() moveY = -speed end)
plus.MouseButton1Click:Connect(function()
	speed += 1
	speedLabel.Text = tostring(speed)
end)
minus.MouseButton1Click:Connect(function()
	if speed > 1 then
		speed -= 1
		speedLabel.Text = tostring(speed)
	end
end)

closebutton.MouseButton1Click:Connect(function()
	Frame.Visible = false
	FlyBtn.Visible = true
end)

FlyBtn.MouseButton1Click:Connect(function()
	Frame.Visible = true
	FlyBtn.Visible = false
end)
