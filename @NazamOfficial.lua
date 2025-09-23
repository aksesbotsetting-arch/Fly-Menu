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

main.Name = "main"
main.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
main.ResetOnSpawn = false

-- Frame utama
Frame.Parent = main
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20) -- hitam abu gelap
Frame.BorderSizePixel = 2
Frame.BorderColor3 = Color3.fromRGB(0, 170, 255) -- biru neon
Frame.Position = UDim2.new(0.1, 0, 0.3, 0)
Frame.Size = UDim2.new(0, 230, 0, 160)
Frame.Active = true
Frame.Draggable = true

-- Title
Title.Parent = Frame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "TERBANG ID"
Title.TextColor3 = Color3.fromRGB(0, 170, 255)
Title.TextSize = 22

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

-- Minimize
mini.Name = "minimize"
mini.Parent = Frame
mini.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
mini.Font = Enum.Font.SourceSansBold
mini.Size = UDim2.new(0, 30, 0, 30)
mini.Text = "-"
mini.TextColor3 = Color3.fromRGB(255,255,255)
mini.TextSize = 22
mini.Position = UDim2.new(1, -70, 0, 0)

-- Restore button
mini2.Name = "minimize2"
mini2.Parent = Frame
mini2.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
mini2.Font = Enum.Font.SourceSansBold
mini2.Size = UDim2.new(0, 30, 0, 30)
mini2.Text = "+"
mini2.TextColor3 = Color3.fromRGB(255,255,255)
mini2.TextSize = 22
mini2.Position = UDim2.new(1, -70, 0, 0)
mini2.Visible = false

-- Tombol naik
up.Name = "up"
up.Parent = Frame
up.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
up.Size = UDim2.new(0, 100, 0, 30)
up.Position = UDim2.new(0, 10, 0, 40)
up.Font = Enum.Font.SourceSansBold
up.Text = "NAIK"
up.TextColor3 = Color3.fromRGB(255,255,255)
up.TextSize = 18

-- Tombol turun
down.Name = "down"
down.Parent = Frame
down.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
down.Size = UDim2.new(0, 100, 0, 30)
down.Position = UDim2.new(0, 10, 0, 80)
down.Font = Enum.Font.SourceSansBold
down.Text = "TURUN"
down.TextColor3 = Color3.fromRGB(255,255,255)
down.TextSize = 18

-- Tombol terbang
onof.Name = "onof"
onof.Parent = Frame
onof.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
onof.Size = UDim2.new(0, 100, 0, 30)
onof.Position = UDim2.new(0, 120, 0, 40)
onof.Font = Enum.Font.SourceSansBold
onof.Text = "TERBANG"
onof.TextColor3 = Color3.fromRGB(255,255,255)
onof.TextSize = 18

-- Speed label
speed.Name = "speed"
speed.Parent = Frame
speed.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
speed.BorderColor3 = Color3.fromRGB(0, 170, 255)
speed.Size = UDim2.new(0, 100, 0, 30)
speed.Position = UDim2.new(0, 120, 0, 80)
speed.Font = Enum.Font.SourceSansBold
speed.Text = "1"
speed.TextColor3 = Color3.fromRGB(0, 170, 255)
speed.TextSize = 18

-- Tombol plus
plus.Name = "plus"
plus.Parent = Frame
plus.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
plus.Size = UDim2.new(0, 45, 0, 30)
plus.Position = UDim2.new(0, 10, 0, 120)
plus.Font = Enum.Font.SourceSansBold
plus.Text = "+"
plus.TextColor3 = Color3.fromRGB(255,255,255)
plus.TextSize = 20

-- Tombol minus
mine.Name = "mine"
mine.Parent = Frame
mine.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
mine.Size = UDim2.new(0, 45, 0, 30)
mine.Position = UDim2.new(0, 65, 0, 120)
mine.Font = Enum.Font.SourceSansBold
mine.Text = "-"
mine.TextColor3 = Color3.fromRGB(255,255,255)
mine.TextSize = 20
