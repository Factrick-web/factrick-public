-- // Factrick Cheat con Key, Pantalla de Carga y Panel Pro

-- Servicios
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local humanoid = player.Character:WaitForChild("Humanoid")

-- Estados
local speedEnabled = false
local jumpEnabled = false
local floatEnabled = false
local espEnabled = false
local savedPos = nil
local floatPart = nil

-- Crear GUI principal
local gui = Instance.new("ScreenGui")
gui.Parent = game.CoreGui
gui.ResetOnSpawn = false

-----------------------------------------------------
-- Pantalla de Key
-----------------------------------------------------
local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 300, 0, 150)
keyFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
keyFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
keyFrame.Active = true
keyFrame.Draggable = true
keyFrame.Parent = gui

local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0, 12)
keyCorner.Parent = keyFrame

local keyTitle = Instance.new("TextLabel")
keyTitle.Text = "🔑 Ingresa tu Key"
keyTitle.Size = UDim2.new(1, 0, 0, 40)
keyTitle.BackgroundTransparency = 1
keyTitle.Font = Enum.Font.GothamBold
keyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
keyTitle.TextSize = 20
keyTitle.Parent = keyFrame

local keyBox = Instance.new("TextBox")
keyBox.PlaceholderText = "Escribe la key..."
keyBox.Size = UDim2.new(1, -40, 0, 35)
keyBox.Position = UDim2.new(0, 20, 0, 55)
keyBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
keyBox.TextSize = 16
keyBox.Font = Enum.Font.Gotham
keyBox.Parent = keyFrame

local keyBtn = Instance.new("TextButton")
keyBtn.Text = "Confirmar"
keyBtn.Size = UDim2.new(0.6, 0, 0, 35)
keyBtn.Position = UDim2.new(0.2, 0, 0, 100)
keyBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
keyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
keyBtn.TextSize = 16
keyBtn.Font = Enum.Font.GothamBold
keyBtn.Parent = keyFrame

local keyCornerBtn = Instance.new("UICorner")
keyCornerBtn.CornerRadius = UDim.new(0, 8)
keyCornerBtn.Parent = keyBtn

-----------------------------------------------------
-- Pantalla de carga
-----------------------------------------------------
local loadingFrame = Instance.new("Frame")
loadingFrame.Size = UDim2.new(0, 320, 0, 160)
loadingFrame.Position = UDim2.new(0.5, -160, 0.5, -80)
loadingFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
loadingFrame.Visible = false
loadingFrame.Parent = gui

local loadCorner = Instance.new("UICorner")
loadCorner.CornerRadius = UDim.new(0, 12)
loadCorner.Parent = loadingFrame

local loadLabel = Instance.new("TextLabel")
loadLabel.Text = "Cargando..."
loadLabel.Size = UDim2.new(1, 0, 0, 50)
loadLabel.Position = UDim2.new(0, 0, 0, 20)
loadLabel.BackgroundTransparency = 1
loadLabel.Font = Enum.Font.GothamBold
loadLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
loadLabel.TextSize = 22
loadLabel.Parent = loadingFrame

local barBack = Instance.new("Frame")
barBack.Size = UDim2.new(0.8, 0, 0, 20)
barBack.Position = UDim2.new(0.1, 0, 0, 100)
barBack.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
barBack.Parent = loadingFrame
local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(0, 8)
barCorner.Parent = barBack

local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
barFill.Parent = barBack
local barFillCorner = Instance.new("UICorner")
barFillCorner.CornerRadius = UDim.new(0, 8)
barFillCorner.Parent = barFill

-----------------------------------------------------
-- Botón flotante
-----------------------------------------------------
local mainBtn = Instance.new("TextButton")
mainBtn.Size = UDim2.new(0, 160, 0, 40)
mainBtn.Position = UDim2.new(0.05, 0, 0.2, 0)
mainBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainBtn.Text = "Panel Factrick Cheat"
mainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
mainBtn.TextSize = 16
mainBtn.Font = Enum.Font.GothamBold
mainBtn.Active = true
mainBtn.Draggable = true
mainBtn.Visible = false
mainBtn.Parent = gui
local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 10)
btnCorner.Parent = mainBtn

-----------------------------------------------------
-- Panel de opciones
-----------------------------------------------------
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 230, 0, 320)
frame.Position = UDim2.new(0.3, 0, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Visible = false
frame.Parent = gui
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Text = "⚡ Factrick Cheat ⚡"
title.Size = UDim2.new(1, -30, 0, 35)
title.Position = UDim2.new(0, 10, 0, 5)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 20
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.Parent = frame
task.spawn(function()
    while task.wait(0.2) do
        title.TextColor3 = Color3.fromHSV(tick() % 5 / 5, 1, 1)
    end
end)

local scrolling = Instance.new("ScrollingFrame")
scrolling.Size = UDim2.new(1, -20, 1, -50)
scrolling.Position = UDim2.new(0, 10, 0, 45)
scrolling.CanvasSize = UDim2.new(0, 0, 3, 0)
scrolling.ScrollBarThickness = 6
scrolling.BackgroundTransparency = 1
scrolling.Parent = frame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 8)
layout.Parent = scrolling

-----------------------------------------------------
-- Función para crear botones ON/OFF
-----------------------------------------------------
local function createButton(name, color, callback)
    local btn = Instance.new("TextButton")
    btn.Text = name .. " (OFF)"
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 16
    btn.Font = Enum.Font.GothamBold
    btn.Parent = scrolling

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn

    local toggled = false
    btn.MouseButton1Click:Connect(function()
        toggled = not toggled
        if toggled then
            btn.Text = name .. " (ON)"
            btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            btn.TextColor3 = Color3.fromRGB(0, 0, 0)
            callback(true)
        else
            btn.Text = name .. " (OFF)"
            btn.BackgroundColor3 = color
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            callback(false)
        end
    end)
end

-----------------------------------------------------
-- Funciones
-----------------------------------------------------
-- Speed
createButton("Speed", Color3.fromRGB(70, 130, 180), function(state)
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

-- High Jump
createButton("High Jump", Color3.fromRGB(138, 43, 226), function(state)
    jumpEnabled = state
    if state then
        task.spawn(function()
            while jumpEnabled do
                local root = player.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    root.Velocity = Vector3.new(0, 100, 0)
                end
                task.wait(0.5)
            end
        end)
    end
end)

-- Float (arreglado con plataforma)
createButton("Float", Color3.fromRGB(60, 179, 113), function(state)
    floatEnabled = state
    if state then
        local root = player.Character:FindFirstChild("HumanoidRootPart")
        if root then
            floatPart = Instance.new("Part")
            floatPart.Name = "FloatPlatform"
            floatPart.Size = Vector3.new(6, 1, 6)
            floatPart.Anchored = true
            floatPart.Transparency = 1
            floatPart.CanCollide = true
            floatPart.Parent = workspace

            task.spawn(function()
                while floatEnabled and root do
                    floatPart.CFrame = CFrame.new(root.Position.X, root.Position.Y - 3, root.Position.Z)
                    task.wait(0.05)
                end
                if floatPart then floatPart:Destroy() end
            end)
        end
    else
        if floatPart then floatPart:Destroy() end
    end
end)

-- ESP Players
createButton("ESP Players", Color3.fromRGB(220, 20, 60), function(state)
    espEnabled = state
    if state then
        task.spawn(function()
            while espEnabled do
                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                        if not plr.Character:FindFirstChild("ESPBox") then
                            local box = Instance.new("BoxHandleAdornment")
                            box.Name = "ESPBox"
                            box.Adornee = plr.Character.HumanoidRootPart
                            box.Size = Vector3.new(5, 6, 1)
                            box.Color3 = Color3.fromRGB(255, 0, 0)
                            box.Transparency = 0.5
                            box.AlwaysOnTop = true
                            box.ZIndex = 5
                            box.Parent = plr.Character
                        end
                    end
                end
                task.wait(1)
            end
            -- limpiar cuando se apaga
            for _, plr in pairs(Players:GetPlayers()) do
                if plr.Character and plr.Character:FindFirstChild("ESPBox") then
                    plr.Character.ESPBox:Destroy()
                end
            end
        end)
    end
end)

-- Teleport Save
createButton("Save Position", Color3.fromRGB(255, 140, 0), function(state)
    if state then
        local root = player.Character:FindFirstChild("HumanoidRootPart")
        if root then
            savedPos = root.CFrame
        end
    end
end)

-- Teleport Go
createButton("Go Position", Color3.fromRGB(255, 215, 0), function(state)
    if state and savedPos then
        local root = player.Character:FindFirstChild("HumanoidRootPart")
        if root then
            root.CFrame = savedPos
        end
    end
end)

-----------------------------------------------------
-- Lógica abrir/cerrar panel
-----------------------------------------------------
mainBtn.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

-----------------------------------------------------
-- Confirmar Key
-----------------------------------------------------
keyBtn.MouseButton1Click:Connect(function()
    if keyBox.Text == "keygratis1" then
        keyFrame.Visible = false
        loadingFrame.Visible = true
        for i = 0, 1, 0.02 do
            barFill.Size = UDim2.new(i, 0, 1, 0)
            task.wait(0.05)
        end
        loadingFrame.Visible = false
        mainBtn.Visible = true
    else
        keyBox.Text = ""
        keyBox.PlaceholderText = "❌ Key incorrecta"
    end
end)
