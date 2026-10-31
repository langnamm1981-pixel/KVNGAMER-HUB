KVNGAMER.lua 

--[[
    KVNGAMER HUB V1.0
    NEON BLUE EDITION
    Made by: KVNGAMER
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local Old = PlayerGui:FindFirstChild("KVNGAMER_HUB")
if Old then Old:Destroy() end

local Gui = Instance.new("ScreenGui")
Gui.Name = "KVNGAMER_HUB"
Gui.ResetOnSpawn = false
Gui.Parent = PlayerGui

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(420, 300)
Main.Position = UDim2.new(0.5, -210, 0.5, -150)
Main.BackgroundColor3 = Color3.fromRGB(8, 14, 27)
Main.Parent = Gui

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 14)

local Border = Instance.new("UIStroke")
Border.Color = Color3.fromRGB(0, 190, 255)
Border.Thickness = 2
Border.Parent = Main

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 55)
Header.BackgroundColor3 = Color3.fromRGB(12, 30, 48)
Header.Parent = Main
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 14)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -100, 1, 0)
Title.Position = UDim2.fromOffset(15, 0)
Title.BackgroundTransparency = 1
Title.Text = "KVNGAMER HUB"
Title.TextColor3 = Color3.fromRGB(0, 210, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local function Button(parent, text, position, size)
    local B = Instance.new("TextButton")
    B.Size = size
    B.Position = position
    B.BackgroundColor3 = Color3.fromRGB(15, 42, 65)
    B.Text = text
    B.TextColor3 = Color3.new(1, 1, 1)
    B.Font = Enum.Font.GothamBold
    B.TextSize = 14
    B.Parent = parent

    Instance.new("UICorner", B).CornerRadius = UDim.new(0, 8)

    local S = Instance.new("UIStroke")
    S.Color = Color3.fromRGB(0, 180, 255)
    S.Parent = B

    return B
end

local Close = Button(
    Header, "X",
    UDim2.new(1, -42, 0, 10),
    UDim2.fromOffset(30, 30)
)

Close.MouseButton1Click:Connect(function()
    Gui:Destroy()
end)

local Mini = Button(
    Header, "-",
    UDim2.new(1, -80, 0, 10),
    UDim2.fromOffset(30, 30)
)

local Content = Instance.new("Frame")
Content.Position = UDim2.fromOffset(130, 70)
Content.Size = UDim2.new(1, -145, 1, -110)
Content.BackgroundTransparency = 1
Content.Parent = Main

local Sidebar = Instance.new("Frame")
Sidebar.Position = UDim2.fromOffset(10, 70)
Sidebar.Size = UDim2.fromOffset(110, 190)
Sidebar.BackgroundTransparency = 1
Sidebar.Parent = Main

local Pages = {}

local function CreatePage(name)
    local Page = Instance.new("Frame")
    Page.Size = UDim2.fromScale(1, 1)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.Parent = Content
    Pages[name] = Page
    return Page
end

local Home = CreatePage("HOME")
local MainPage = CreatePage("MAIN")
local Settings = CreatePage("SETTINGS")

Home.Visible = true

local function AddText(page, text, y)
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 35)
    Label.Position = UDim2.fromOffset(0, y)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(0, 210, 255)
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 16
    Label.Parent = page
end

AddText(Home, "WELCOME TO KVNGAMER HUB", 10)
AddText(Home, "Version: 1.0", 50)
AddText(Home, "Made by KVNGAMER", 90)

AddText(MainPage, "MAIN MENU", 10)
AddText(MainPage, "UI Demo - No game modifications", 50)

AddText(Settings, "SETTINGS", 10)
AddText(Settings, "Neon Blue Theme", 50)

local y = 0

for _, name in ipairs({"HOME", "MAIN", "SETTINGS"}) do
    local Tab = Button(
        Sidebar,
        name,
        UDim2.fromOffset(0, y),
        UDim2.fromOffset(110, 38)
    )

    Tab.MouseButton1Click:Connect(function()
        for _, page in pairs(Pages) do
            page.Visible = false
        end

        Pages[name].Visible = true
    end)

    y = y + 48
end

local Minimized = false

Mini.MouseButton1Click:Connect(function()
    Minimized = not Minimized
    Content.Visible = not Minimized
    Sidebar.Visible = not Minimized

    Main:TweenSize(
        Minimized and UDim2.fromOffset(420, 55)
        or UDim2.fromOffset(420, 300),
        Enum.EasingDirection.Out,
        Enum.EasingStyle.Quad,
        0.2,
        true
    )
end)

-- DRAG WINDOW
local dragging = false
local dragStart
local startPos

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart

        Main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

print("KVNGAMER HUB V1.0 Loaded!")
