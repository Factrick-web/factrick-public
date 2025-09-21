-- Servicios
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local humanoid = player.Character:WaitForChild("Humanoid")

-- Estados
local speedEnabled = false
local jumpEnabled = false
local floatEnabled = false
local espEnabled = false
local noclipEnabled = false
local savedPos = nil
local floatPart = nil

-- GUI principal
local gui = Instance.new("ScreenGui")
gui.Parent = game.CoreGui
gui.ResetOnSpawn = false

-----------------------------------------------------
-- Pantalla Key
-----------------------------------------------------
local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0,280,0,140)
keyFrame.Position = UDim2.new(0.5,-140,0.5,-70)
keyFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
keyFrame.Active = true
keyFrame.Draggable = true
keyFrame.Parent = gui
local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0,12)
keyCorner.Parent = keyFrame

local keyTitle = Instance.new("TextLabel")
keyTitle.Text = "🔑 Ingresa tu Key"
keyTitle.Size = UDim2.new(1,0,0,35)
keyTitle.BackgroundTransparency = 1
keyTitle.Font = Enum.Font.GothamBold
keyTitle.TextColor3 = Color3.fromRGB(255,255,255)
keyTitle.TextSize = 18
keyTitle.Parent = keyFrame

local keyBox = Instance.new("TextBox")
keyBox.PlaceholderText = "Escribe la key..."
keyBox.Size = UDim2.new(1,-40,0,30)
keyBox.Position = UDim2.new(0,20,0,50)
keyBox.BackgroundColor3 = Color3.fromRGB(50,50,50)
keyBox.TextColor3 = Color3.fromRGB(255,255,255)
keyBox.TextSize = 14
keyBox.Font = Enum.Font.Gotham
keyBox.Parent = keyFrame

local keyBtn = Instance.new("TextButton")
keyBtn.Text = "Confirmar"
keyBtn.Size = UDim2.new(0.6,0,0,30)
keyBtn.Position = UDim2.new(0.2,0,0,90)
keyBtn.BackgroundColor3 = Color3.fromRGB(70,130,180)
keyBtn.TextColor3 = Color3.fromRGB(255,255,255)
keyBtn.TextSize = 14
keyBtn.Font = Enum.Font.GothamBold
keyBtn.Parent = keyFrame
local keyCornerBtn = Instance.new("UICorner")
keyCornerBtn.CornerRadius = UDim.new(0,8)
keyCornerBtn.Parent = keyBtn

-- Pantalla de carga
local loadingFrame = Instance.new("Frame")
loadingFrame.Size = UDim2.new(0,300,0,150)
loadingFrame.Position = UDim2.new(0.5,-150,0.5,-75)
loadingFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
loadingFrame.Visible = false
loadingFrame.Parent = gui
local loadCorner = Instance.new("UICorner")
loadCorner.CornerRadius = UDim.new(0,12)
loadCorner.Parent = loadingFrame

local loadLabel = Instance.new("TextLabel")
loadLabel.Text = "Cargando..."
loadLabel.Size = UDim2.new(1,0,0,50)
loadLabel.Position = UDim2.new(0,0,0,20)
loadLabel.BackgroundTransparency = 1
loadLabel.Font = Enum.Font.GothamBold
loadLabel.TextColor3 = Color3.fromRGB(255,255,255)
loadLabel.TextSize = 22
loadLabel.Parent = loadingFrame

local barBack = Instance.new("Frame")
barBack.Size = UDim2.new(0.8,0,0,20)
barBack.Position = UDim2.new(0.1,0,0,100)
barBack.BackgroundColor3 = Color3.fromRGB(50,50,50)
barBack.Parent = loadingFrame
local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(0,8)
barCorner.Parent = barBack

local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0,0,1,0)
barFill.BackgroundColor3 = Color3.fromRGB(70,130,180)
barFill.Parent = barBack
local barFillCorner = Instance.new("UICorner")
barFillCorner.CornerRadius = UDim.new(0,8)
barFillCorner.Parent = barFill

-----------------------------------------------------
-- Panel flotante compacto
-----------------------------------------------------
local mainBtn = Instance.new("TextButton")
mainBtn.Size = UDim2.new(0,140,0,35)
mainBtn.Position = UDim2.new(0.05,0,0.2,0)
mainBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
mainBtn.Text = "Factrick Cheat"
mainBtn.TextColor3 = Color3.fromRGB(255,255,255)
mainBtn.TextSize = 14
mainBtn.Font = Enum.Font.GothamBold
mainBtn.Active = true
mainBtn.Draggable = true
mainBtn.Visible = false
mainBtn.Parent = gui
local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0,10)
btnCorner.Parent = mainBtn

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,200,0,280)
frame.Position = UDim2.new(0.3,0,0.2,0)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Visible = false
frame.Parent = gui
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0,10)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Text = "⚡ Factrick Cheat ⚡"
title.Size = UDim2.new(1,0,0,30)
title.Position = UDim2.new(0,0,0,5)
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextSize = 16
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.Parent = frame
task.spawn(function()
    while task.wait(0.2) do
        title.TextColor3 = Color3.fromHSV(tick()%5/5,1,1)
    end
end)

local tiktok = Instance.new("TextLabel")
tiktok.Text = "@castillo_Fx4"
tiktok.Size = UDim2.new(1,0,0,18)
tiktok.Position = UDim2.new(0,0,0,30)
tiktok.TextColor3 = Color3.fromRGB(200,200,200)
tiktok.TextSize = 12
tiktok.BackgroundTransparency = 1
tiktok.Font = Enum.Font.Gotham
tiktok.TextXAlignment = Enum.TextXAlignment.Center
tiktok.Parent = frame

-- Scrolling para botones
local scrolling = Instance.new("ScrollingFrame")
scrolling.Size = UDim2.new(1,-10,1,-55)
scrolling.Position = UDim2.new(0,5,0,50)
scrolling.CanvasSize = UDim2.new(0,0,6,0)
scrolling.ScrollBarThickness = 6
scrolling.BackgroundTransparency = 1
scrolling.Parent = frame
local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0,5)
layout.Parent = scrolling

-- Función para crear botones ON/OFF
local function createButton(name,color,callback)
    local btn = Instance.new("TextButton")
    btn.Text = name.." (OFF)"
    btn.Size = UDim2.new(1,-10,0,35)
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamBold
    btn.Parent = scrolling
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0,6)
    corner.Parent = btn
    local toggled = false
    btn.MouseButton1Click:Connect(function()
        toggled = not toggled
        if toggled then
            btn.Text = name.." (ON)"
            btn.BackgroundColor3 = Color3.fromRGB(255,255,255)
            btn.TextColor3 = Color3.fromRGB(0,0,0)
            callback(true)
        else
            btn.Text = name.." (OFF)"
            btn.BackgroundColor3 = color
            btn.TextColor3 = Color3.fromRGB(255,255,255)
            callback(false)
        end
    end)
end

-- Botón flotante independiente (inicialmente oculto)
local floatBtn = Instance.new("TextButton")
floatBtn.Size = UDim2.new(0,120,0,30)
floatBtn.Position = UDim2.new(0.5,-60,0.5,100)
floatBtn.BackgroundColor3 = Color3.fromRGB(60,179,113)
floatBtn.TextColor3 = Color3.fromRGB(255,255,255)
floatBtn.Text = "Float (OFF)"
floatBtn.Font = Enum.Font.GothamBold
floatBtn.TextSize = 14
floatBtn.Active = true
floatBtn.Draggable = true
floatBtn.Visible = false
floatBtn.Parent = gui
local floatCorner = Instance.new("UICorner")
floatCorner.CornerRadius = UDim.new(0,6)
floatCorner.Parent = floatBtn
local floatBtnEnabled = false

-- Speed
createButton("Speed", Color3.fromRGB(70,130,180), function(state)
    speedEnabled = state
    if state then
        task.spawn(function()
            while speedEnabled do
                humanoid.WalkSpeed = 50
                task.wait(0.1)
            end
        end)
    else
        humanoid.WalkSpeed = 16
    end
end)

-- High Jump ON/OFF
createButton("High Jump", Color3.fromRGB(138,43,226), function(state)
    jumpEnabled = state
end)

-- Detectar input para salto
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if jumpEnabled then
        if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.Space then
            local root = player.Character:FindFirstChild("HumanoidRootPart")
            if root then root.Velocity = Vector3.new(root.Velocity.X,100,root.Velocity.Z) end
        elseif input.UserInputType == Enum.UserInputType.Touch then
            local root = player.Character:FindFirstChild("HumanoidRootPart")
            if root then root.Velocity = Vector3.new(root.Velocity.X,100,root.Velocity.Z) end
        end
    end
end)

-- Float desde panel
createButton("Float", Color3.fromRGB(60,179,113), function(state)
    if state then
        floatBtn.Visible = true
        floatBtn.Text = "Float (OFF)"
        floatBtnEnabled = false
    else
        floatBtn.Visible = false
        floatEnabled = false
        if floatPart then floatPart:Destroy() end
    end
end)

-- Lógica del botón flotante
floatBtn.MouseButton1Click:Connect(function()
    floatBtnEnabled = not floatBtnEnabled
    floatEnabled = floatBtnEnabled
    if floatBtnEnabled then
        floatBtn.Text = "Float (ON)"
        local root = player.Character:FindFirstChild("HumanoidRootPart")
        if root then
            floatPart = Instance.new("Part")
            floatPart.Name = "FloatPlatform"
            floatPart.Size = Vector3.new(6,1,6)
            floatPart.Anchored = true
            floatPart.Transparency = 1
            floatPart.CanCollide = true
            floatPart.Parent = workspace
            task.spawn(function()
                while floatEnabled and root do
                    floatPart.CFrame = CFrame.new(root.Position.X, root.Position.Y-3, root.Position.Z)
                    task.wait(0.05)
                end
                if floatPart then floatPart:Destroy() end
            end)
        end
    else
        floatBtn.Text = "Float (OFF)"
        if floatPart then floatPart:Destroy() end
    end
end)

-- ESP RGB con nombre
createButton("ESP Players", Color3.fromRGB(220,20,60), function(state)
    espEnabled = state
    task.spawn(function()
        while espEnabled do
            for _,plr in pairs(Players:GetPlayers()) do
                if plr~=player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    if not plr.Character:FindFirstChild("ESP") then
                        local bb = Instance.new("BillboardGui")
                        bb.Name="ESP"
                        bb.Size=UDim2.new(0,100,0,50)
                        bb.Adornee=plr.Character.HumanoidRootPart
                        bb.AlwaysOnTop=true
                        bb.StudsOffset=Vector3.new(0,3,0)
                        bb.Parent=plr.Character

                        local txt = Instance.new("TextLabel")
                        txt.Size=UDim2.new(1,0,0.3,0)
                        txt.Position=UDim2.new(0,0,0,0)
                        txt.BackgroundTransparency=1
                        txt.Text=plr.Name
                        txt.Font=Enum.Font.GothamBold
                        txt.TextColor3=Color3.fromHSV(tick()%5/5,1,1)
                        txt.TextScaled=true
                        txt.Parent=bb

                        for _,part in pairs(plr.Character:GetChildren()) do
                            if part:IsA("BasePart") and not part:FindFirstChild("ESPPart") then
                                local adorn = Instance.new("BoxHandleAdornment")
                                adorn.Name="ESPPart"
                                adorn.Adornee=part
                                adorn.Size=part.Size
                                adorn.Color3=Color3.fromHSV(tick()%5/5,1,1)
                                adorn.AlwaysOnTop=true
                                adorn.Transparency=0.5
                                adorn.ZIndex=5
                                adorn.Parent=part
                            end
                        end
                    end
                end
            end
            task.wait(0.5)
        end
        for _,plr in pairs(Players:GetPlayers()) do
            if plr.Character then
                if plr.Character:FindFirstChild("ESP") then plr.Character.ESP:Destroy() end
                for _,part in pairs(plr.Character:GetChildren()) do
                    if part:FindFirstChild("ESPPart") then part.ESPPart:Destroy() end
                end
            end
        end
    end)
end)

-- Save / Go Position
createButton("Save Pos", Color3.fromRGB(255,140,0), function(state)
    if state then
        local root = player.Character:FindFirstChild("HumanoidRootPart")
        if root then savedPos = root.CFrame end
    end
end)
createButton("Go Pos", Color3.fromRGB(255,215,0), function(state)
    if state and savedPos then
        local root = player.Character:FindFirstChild("HumanoidRootPart")
        if root then root.CFrame = savedPos end
    end
end)

-- No Clip
createButton("No Clip", Color3.fromRGB(255,105,180), function(state)
    noclipEnabled = state
    task.spawn(function()
        while noclipEnabled do
            local char = player.Character
            if char then
                for _,part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide=false end
                end
            end
            task.wait(0.1)
        end
        local char = player.Character
        if char then
            for _,part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide=true end
            end
        end
    end)
end)

-- Abrir panel
mainBtn.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

-- Confirmar Key con pantalla de carga
keyBtn.MouseButton1Click:Connect(function()
    if keyBox.Text=="keygratis1" then
        keyFrame.Visible=false
        loadingFrame.Visible=true
        for i=0,1,0.02 do
            barFill.Size=UDim2.new(i,0,1,0)
            task.wait(0.03)
        end
        loadingFrame.Visible=false
        mainBtn.Visible=true
    else
        keyBox.Text=""
        keyBox.PlaceholderText="❌ Key incorrecta"
    end
end)
