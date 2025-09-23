local main = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local up = Instance.new("TextButton")
local down = Instance.new("TextButton")
local onof = Instance.new("TextButton")
local plus = Instance.new("TextButton")
local speed = Instance.new("TextLabel")
local mine = Instance.new("TextButton")
local closebutton = Instance.new("TextButton")
local mini = Instance.new("TextButton")
local mini2 = Instance.new("TextButton")

-- Parent GUI
main.Name = "main"
main.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
main.ResetOnSpawn = false

-- Frame utama (tema hitam-putih)
Frame.Parent = main
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20) -- hitam abu gelap
Frame.BorderSizePixel = 2
Frame.BorderColor3 = Color3.fromRGB(255, 255, 255) -- putih
Frame.Position = UDim2.new(0.1, 0, 0.3, 0)
Frame.Size = UDim2.new(0, 230, 0, 160)
Frame.Active = true
Frame.Draggable = true

-- Title
Title.Parent = Frame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "Fly | @NazamOfficial"
Title.TextColor3 = Color3.fromRGB(255, 255, 255) -- putih
Title.TextSize = 22
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Position = UDim2.new(0, 8, 0, 0)

-- Close button
closebutton.Name = "Close"
closebutton.Parent = Frame
closebutton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closebutton.Font = Enum.Font.SourceSansBold
closebutton.Size = UDim2.new(0, 30, 0, 30)
closebutton.Text = "X"
closebutton.TextColor3 = Color3.fromRGB(255,255,255)
closebutton.TextSize = 20
closebutton.Position = UDim2.new(1, -35, 0, 0)

-- Tombol naik
up.Name = "up"
up.Parent = Frame
up.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- putih
up.Size = UDim2.new(0, 100, 0, 30)
up.Position = UDim2.new(0, 10, 0, 40)
up.Font = Enum.Font.SourceSansBold
up.Text = "NAIK"
up.TextColor3 = Color3.fromRGB(0,0,0) -- biar kebaca, teks hitam
up.TextSize = 18

-- Tombol turun
down.Name = "down"
down.Parent = Frame
down.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- putih
down.Size = UDim2.new(0, 100, 0, 30)
down.Position = UDim2.new(0, 10, 0, 80)
down.Font = Enum.Font.SourceSansBold
down.Text = "TURUN"
down.TextColor3 = Color3.fromRGB(0,0,0)
down.TextSize = 18

-- Tombol terbang
onof.Name = "onof"
onof.Parent = Frame
onof.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- putih
onof.Size = UDim2.new(0, 100, 0, 30)
onof.Position = UDim2.new(0, 120, 0, 40)
onof.Font = Enum.Font.SourceSansBold
onof.Text = "TERBANG"
onof.TextColor3 = Color3.fromRGB(0,0,0)
onof.TextSize = 18

-- Speed label
speed.Name = "speed"
speed.Parent = Frame
speed.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
speed.BorderColor3 = Color3.fromRGB(255, 255, 255) -- putih
speed.BorderSizePixel = 1
speed.Size = UDim2.new(0, 100, 0, 30)
speed.Position = UDim2.new(0, 120, 0, 80)
speed.Font = Enum.Font.SourceSansBold
speed.Text = "1"
speed.TextColor3 = Color3.fromRGB(255, 255, 255) -- putih
speed.TextSize = 18

-- Tombol plus
plus.Name = "plus"
plus.Parent = Frame
plus.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- putih
plus.Size = UDim2.new(0, 45, 0, 30)
plus.Position = UDim2.new(0, 10, 0, 120)
plus.Font = Enum.Font.SourceSansBold
plus.Text = "+"
plus.TextColor3 = Color3.fromRGB(0,0,0)
plus.TextSize = 20

-- Tombol minus
mine.Name = "mine"
mine.Parent = Frame
mine.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- putih
mine.Size = UDim2.new(0, 45, 0, 30)
mine.Position = UDim2.new(0, 65, 0, 120)
mine.Font = Enum.Font.SourceSansBold
mine.Text = "-"
mine.TextColor3 = Color3.fromRGB(0,0,0)
mine.TextSize = 20

-- Tombol Fly kecil (muncul setelah X ditekan)
local FlyBtn = Instance.new("TextButton")
FlyBtn.Name = "FlyBtn"
FlyBtn.Parent = main
FlyBtn.Size = UDim2.new(0, 45, 0, 45)
FlyBtn.Position = UDim2.new(0.5, -35, 0, 20)
FlyBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
FlyBtn.Text = "Fly"
FlyBtn.TextScaled = true
FlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255) -- putih
FlyBtn.Font = Enum.Font.SourceSansBold
FlyBtn.Visible = false
FlyBtn.Active = true
FlyBtn.Draggable = true

-- bikin bulat
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1, 0)
corner.Parent = FlyBtn
