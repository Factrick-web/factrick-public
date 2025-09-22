-- Servicios
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local player = Players.LocalPlayer
local humanoid = player.Character:WaitForChild("Humanoid")

-- Estados
local speedEnabled = false
local jumpEnabled = false
local floatEnabled = false
local espEnabled = false
local noclipEnabled = false
local floatPart = nil
local floatGuiBtn = nil

-- Colores Float
local floatColorMode = "RGB"
local floatFixedColor = Color3.fromRGB(70,130,180)
local floatGradientColor1 = Color3.fromRGB(70,130,180)
local floatGradientColor2 = Color3.fromRGB(138,43,226)

-- GUI principal
local gui = Instance.new("ScreenGui")
gui.Parent = game.CoreGui
gui.ResetOnSpawn = false

-- Pantalla Key
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

-- Panel flotante
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
frame.Size = UDim2.new(0,220,0,300)
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

-- Botones de sección
local generalBtn = Instance.new("TextButton")
generalBtn.Text = "General"
generalBtn.Size = UDim2.new(0.5,-2,0,25)
generalBtn.Position = UDim2.new(0,0,0,35)
generalBtn.BackgroundColor3 = Color3.fromRGB(70,130,180)
generalBtn.TextColor3 = Color3.fromRGB(255,255,255)
generalBtn.Font = Enum.Font.GothamBold
generalBtn.TextSize = 14
generalBtn.Parent = frame
local generalCorner = Instance.new("UICorner")
generalCorner.CornerRadius = UDim.new(0,6)
generalCorner.Parent = generalBtn

local infoBtn = Instance.new("TextButton")
infoBtn.Text = "Info"
infoBtn.Size = UDim2.new(0.5,-2,0,25)
infoBtn.Position = UDim2.new(0.5,2,0,35)
infoBtn.BackgroundColor3 = Color3.fromRGB(100,100,100)
infoBtn.TextColor3 = Color3.fromRGB(255,255,255)
infoBtn.Font = Enum.Font.GothamBold
infoBtn.TextSize = 14
infoBtn.Parent = frame
local infoCorner = Instance.new("UICorner")
infoCorner.CornerRadius = UDim.new(0,6)
infoCorner.Parent = infoBtn

-- Contenedor
local generalFrame = Instance.new("ScrollingFrame")
generalFrame.Size = UDim2.new(1,-10,1,-65)
generalFrame.Position = UDim2.new(0,5,0,65)
generalFrame.CanvasSize = UDim2.new(0,0,6,0)
generalFrame.ScrollBarThickness = 6
generalFrame.BackgroundTransparency = 1
generalFrame.Visible = true
generalFrame.Parent = frame
local generalLayout = Instance.new("UIListLayout")
generalLayout.Padding = UDim.new(0,5)
generalLayout.Parent = generalFrame

local infoFrame = Instance.new("Frame")
infoFrame.Size = UDim2.new(1,-10,1,-65)
infoFrame.Position = UDim2.new(0,5,0,65)
infoFrame.BackgroundTransparency = 0.1
infoFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
infoFrame.Visible = false
infoFrame.Parent = frame
local infoCornerFrame = Instance.new("UICorner")
infoCornerFrame.CornerRadius = UDim.new(0,6)
infoCornerFrame.Parent = infoFrame

local infoText = Instance.new("TextLabel")
infoText.Text = "🎮 Factrick Cheat\n👤 Creador: @castillo_Fx4\n⚡ Version: 1.0\n💡 Usa con cuidado\n\n📌 Creadores de contenido:\n@tradeos.brainrotslzv\n@subass2\n@brainrotscripts2"
infoText.Size = UDim2.new(1,-10,1,-10)
infoText.Position = UDim2.new(0,5,0,5)
infoText.BackgroundTransparency = 1
infoText.TextColor3 = Color3.fromRGB(200,200,200)
infoText.Font = Enum.Font.Gotham
infoText.TextSize = 14
infoText.TextWrapped = true
infoText.TextYAlignment = Enum.TextYAlignment.Top
infoText.Parent = infoFrame

-- Función para crear botones de hacks
local function createButton(name,color,callback)
    local btn = Instance.new("TextButton")
    btn.Text = name.." (OFF)"
    btn.Size = UDim2.new(1,0,0,30)
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.Parent = generalFrame
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

-- Conexión pestañas
generalBtn.MouseButton1Click:Connect(function()
    generalFrame.Visible = true
    infoFrame.Visible = false
    generalBtn.BackgroundColor3 = Color3.fromRGB(70,130,180)
    infoBtn.BackgroundColor3 = Color3.fromRGB(100,100,100)
end)
infoBtn.MouseButton1Click:Connect(function()
    generalFrame.Visible = false
    infoFrame.Visible = true
    infoBtn.BackgroundColor3 = Color3.fromRGB(70,130,180)
    generalBtn.BackgroundColor3 = Color3.fromRGB(100,100,100)
end)

-- Hacks

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

-- High Jump
createButton("High Jump", Color3.fromRGB(138,43,226), function(state)
    jumpEnabled = state
end)

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

-- Float con botón flotante y colores
local function createFloatButton()
    if floatGuiBtn then return end
    floatGuiBtn = Instance.new("TextButton")
    floatGuiBtn.Size = UDim2.new(0,80,0,30)
    floatGuiBtn.Position = UDim2.new(0.5,-40,0.5,-15)
    floatGuiBtn.Text = "Float OFF"
    floatGuiBtn.BackgroundColor3 = Color3.fromRGB(70,130,180)
    floatGuiBtn.TextColor3 = Color3.fromRGB(255,255,255)
    floatGuiBtn.Font = Enum.Font.GothamBold
    floatGuiBtn.TextSize = 14
    floatGuiBtn.Parent = gui
    floatGuiBtn.Active = true
    floatGuiBtn.Draggable = true

    local toggled = false
    floatGuiBtn.MouseButton1Click:Connect(function()
        toggled = not toggled
        floatEnabled = toggled
        floatGuiBtn.Text = toggled and "Float ON" or "Float OFF"
    end)
end

createButton("Float", Color3.fromRGB(60,179,113), function(state)
    if state then
        createFloatButton()
    else
        floatEnabled = false
        if floatGuiBtn then floatGuiBtn:Destroy() floatGuiBtn=nil end
        if floatPart then floatPart:Destroy() floatPart=nil end
    end
end)

task.spawn(function()
    while task.wait(0.05) do
        if floatEnabled then
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                if not floatPart then
                    floatPart = Instance.new("Part")
                    floatPart.Size = Vector3.new(6,1,6)
                    floatPart.Anchored = true
                    floatPart.CanCollide = true
                    floatPart.Parent = workspace
                    floatPart.Material = Enum.Material.SmoothPlastic
                    floatPart.Transparency = 0.5
                end
                floatPart.CFrame = CFrame.new(root.Position.X, root.Position.Y-3, root.Position.Z)

                -- Color dinámico
                if floatColorMode == "RGB" then
                    floatPart.Color = Color3.fromHSV(tick()%5/5,1,1)
                elseif floatColorMode == "Fijo" then
                    floatPart.Color = floatFixedColor
                elseif floatColorMode == "Degradado" then
                    local t = (math.sin(tick())+1)/2
                    floatPart.Color = floatGradientColor1:lerp(floatGradientColor2,t)
                end
            end
        else
            if floatPart then 
                floatPart:Destroy() 
                floatPart=nil 
            end
        end
    end
end)

-- FPS Booting con AntiLag
createButton("FPS Booting", Color3.fromRGB(255,165,0), function(state)
    if state then
        if setfpscap then setfpscap(360) end
        for _,plr in pairs(Players:GetPlayers()) do
            if plr.Character then
                for _,part in pairs(plr.Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.Material = Enum.Material.SmoothPlastic
                        part.Reflectance = 0
                    end
                end
            end
        end
    else
        if setfpscap then setfpscap(60) end
        for _,plr in pairs(Players:GetPlayers()) do
            if plr.Character then
                for _,part in pairs(plr.Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.Material = Enum.Material.Plastic
                        part.Reflectance = 0
                    end
                end
            end
        end
    end
end)

-- ESP Players
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
                            if part:IsA("BasePart") then
                                local adorn = Instance.new("BoxHandleAdornment")
                                adorn.Size=part.Size
                                adorn.Adornee=part
                                adorn.AlwaysOnTop=true
                                adorn.ZIndex=0
                                adorn.Transparency=0.5
                                adorn.Color3=Color3.fromHSV(tick()%5/5,1,1)
                                adorn.Parent=part
                            end
                        end
                    else
                        local esp=plr.Character.ESP
                        for _,obj in pairs(esp:GetChildren()) do
                            if obj:IsA("TextLabel") then
                                obj.TextColor3=Color3.fromHSV(tick()%5/5,1,1)
                            end
                        end
                        for _,part in pairs(plr.Character:GetChildren()) do
                            for _,ad in pairs(part:GetChildren()) do
                                if ad:IsA("BoxHandleAdornment") then
                                    ad.Color3=Color3.fromHSV(tick()%5/5,1,1)
                                end
                            end
                        end
                    end
                end
            end
            task.wait(0.2)
        end
        for _,plr in pairs(Players:GetPlayers()) do
            if plr.Character and plr.Character:FindFirstChild("ESP") then
                plr.Character.ESP:Destroy()
            end
            if plr.Character then
                for _,part in pairs(plr.Character:GetChildren()) do
                    for _,ad in pairs(part:GetChildren()) do
                        if ad:IsA("BoxHandleAdornment") then ad:Destroy() end
                    end
                end
            end
        end
    end)
end)

-- Noclip
createButton("Noclip", Color3.fromRGB(255,69,0), function(state)
    noclipEnabled = state
    task.spawn(function()
        while noclipEnabled do
            for _,v in pairs(player.Character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide=false end
            end
            task.wait()
        end
    end)
end)

-- ✅ Serverhop (corregido sin error 773)
createButton("Serverhop", Color3.fromRGB(0,191,255), function(state)
    if state then
        local placeId = game.PlaceId
        TeleportService:Teleport(placeId, player)
    end
end)

-- Key confirmación
local correctKey="keygratis1"
keyBtn.MouseButton1Click:Connect(function()
    if keyBox.Text==correctKey then
        keyFrame.Visible=false
        loadingFrame.Visible=true
        for i=1,100 do
            barFill.Size=UDim2.new(i/100,0,1,0)
            task.wait(0.02)
        end
        loadingFrame.Visible=false
        mainBtn.Visible=true
    else
        keyBox.Text="❌ Incorrecta!"
        task.delay(1,function() keyBox.Text="" end)
    end
end)

-- Abrir panel
mainBtn.MouseButton1Click:Connect(function()
    frame.Visible=not frame.Visible
end)
