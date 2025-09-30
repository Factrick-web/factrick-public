-- Factrick Cheat con UI estilo Inscript (Switches modernos)
-- Servicios
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local player = Players.LocalPlayer

-- Estado y datos globales
local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
player.CharacterAdded:Connect(function(char)
    humanoid = char:WaitForChild("Humanoid")
end)

local speedEnabled = false
local jumpEnabled = false
local floatEnabled = false
local espEnabled = false
local noclipEnabled = false
local floatPart = nil
local floatGuiBtn = nil
local timeBaseEnabled = false

local timeBaseData = {
    espMap = {},
    connAdded = nil,
    connRemoved = nil,
    renderConn = nil,
    PLOTS_FOLDER = nil
}

-- Colores Float
local floatColorMode = "RGB"
local floatFixedColor = Color3.fromRGB(70,130,180)
local floatGradientColor1 = Color3.fromRGB(70,130,180)
local floatGradientColor2 = Color3.fromRGB(138,43,226)

-- GUI principal (usar PlayerGui para mayor compatibilidad)
local playerGui = player:WaitForChild("PlayerGui")
local gui = Instance.new("ScreenGui")
gui.Name = "FactrickHubUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = playerGui

-- -----------------------
-- 📢 Comunicado inicial
-- -----------------------
local comunicadoFrame = Instance.new("Frame")
comunicadoFrame.Size = UDim2.new(0,320,0,180)
comunicadoFrame.Position = UDim2.new(0.5,-160,0.5,-90)
comunicadoFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
comunicadoFrame.Active = true
comunicadoFrame.Draggable = true
comunicadoFrame.Parent = gui
local comunicadoCorner = Instance.new("UICorner")
comunicadoCorner.CornerRadius = UDim.new(0,12)
comunicadoCorner.Parent = comunicadoFrame

local comunicadoTitulo = Instance.new("TextLabel")
comunicadoTitulo.Text = "👋 Hola, ¿cómo estás?"
comunicadoTitulo.Size = UDim2.new(1,0,0,35)
comunicadoTitulo.BackgroundTransparency = 1
comunicadoTitulo.Font = Enum.Font.GothamBold
comunicadoTitulo.TextColor3 = Color3.fromRGB(255,255,255)
comunicadoTitulo.TextSize = 18
comunicadoTitulo.Parent = comunicadoFrame

local comunicadoTexto = Instance.new("TextLabel")
comunicadoTexto.Text = "Te invito a mi comunidad de Discord,\nallí pasamos todo actualizado.\n\n📌 ¿Qué esperas para entrar?"
comunicadoTexto.Size = UDim2.new(1,-20,0,80)
comunicadoTexto.Position = UDim2.new(0,10,0,45)
comunicadoTexto.BackgroundTransparency = 1
comunicadoTexto.Font = Enum.Font.Gotham
comunicadoTexto.TextWrapped = true
comunicadoTexto.TextYAlignment = Enum.TextYAlignment.Top
comunicadoTexto.TextColor3 = Color3.fromRGB(200,200,200)
comunicadoTexto.TextSize = 14
comunicadoTexto.Parent = comunicadoFrame

local discordBtn = Instance.new("TextButton")
discordBtn.Text = "Unirme al Discord"
discordBtn.Size = UDim2.new(0.7,0,0,35)
discordBtn.Position = UDim2.new(0.15,0,0,135)
discordBtn.BackgroundColor3 = Color3.fromRGB(70,130,180)
discordBtn.TextColor3 = Color3.fromRGB(255,255,255)
discordBtn.Font = Enum.Font.GothamBold
discordBtn.TextSize = 14
discordBtn.Parent = comunicadoFrame
local discordCorner = Instance.new("UICorner")
discordCorner.CornerRadius = UDim.new(0,8)
discordCorner.Parent = discordBtn

discordBtn.MouseButton1Click:Connect(function()
    pcall(function() setclipboard("https://discord.gg/vaaPztfw") end)
    discordBtn.Text = "✅ Copiado!"
    task.delay(2, function() if discordBtn and discordBtn.Parent then discordBtn.Text = "Unirme al Discord" end end)
end)

local cerrarBtn = Instance.new("TextButton")
cerrarBtn.Text = "Cerrar"
cerrarBtn.Size = UDim2.new(0.25,0,0,25)
cerrarBtn.Position = UDim2.new(0.72,0,0,5)
cerrarBtn.BackgroundColor3 = Color3.fromRGB(100,100,100)
cerrarBtn.TextColor3 = Color3.fromRGB(255,255,255)
cerrarBtn.Font = Enum.Font.GothamBold
cerrarBtn.TextSize = 12
cerrarBtn.Parent = comunicadoFrame
local cerrarCorner = Instance.new("UICorner")
cerrarCorner.CornerRadius = UDim.new(0,6)
cerrarCorner.Parent = cerrarBtn

-- -----------------------
-- 🔑 Pantalla Key (se oculta hasta que pase el comunicado)
-- -----------------------
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
keyFrame.Visible = false -- hide until comunicado closes

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

-- -----------------------
-- ⏳ Auto cerrar comunicado y mostrar key (5 seconds)
-- -----------------------
task.delay(5, function()
    if comunicadoFrame and comunicadoFrame.Parent then
        pcall(function() comunicadoFrame:Destroy() end)
    end
    if keyFrame then
        keyFrame.Visible = true
    end
end)

-- Also allow manual close
cerrarBtn.MouseButton1Click:Connect(function()
    if comunicadoFrame and comunicadoFrame.Parent then
        comunicadoFrame:Destroy()
    end
    keyFrame.Visible = true
end)

-- -----------------------
-- Pantalla de carga
-- -----------------------
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

-- -----------------------
-- Panel flotante y menu (botón y panel principal)
-- -----------------------
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
        if title and title.Parent then
            title.TextColor3 = Color3.fromHSV(tick()%5/5,1,1)
        else
            break
        end
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
infoText.Text = "🎮 Factrick Cheat\n👤 Creador: @castillo_Fx4\n⚡ Version: 1.0\n💡 Usa con cuidado\n\n📌 Creadores de contenido:\n@tradeos.brainrotslzv\n@subass2\n"
infoText.Size = UDim2.new(1,-10,1,-10)
infoText.Position = UDim2.new(0,5,0,5)
infoText.BackgroundTransparency = 1
infoText.TextColor3 = Color3.fromRGB(200,200,200)
infoText.Font = Enum.Font.Gotham
infoText.TextSize = 14
infoText.TextWrapped = true
infoText.TextYAlignment = Enum.TextYAlignment.Top
infoText.Parent = infoFrame

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

-- Función para crear switch (estilo Inscript moderno)
local function createSwitch(name, parent, callback)
    local option = Instance.new("Frame")
    option.Size = UDim2.new(1, 0, 0, 40)
    option.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    option.BorderSizePixel = 0
    option.Parent = parent
    Instance.new("UICorner", option).CornerRadius = UDim.new(0, 8)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 10, 0, 0)
    label.Text = name
    label.Font = Enum.Font.Gotham
    label.TextSize = 18
    label.TextColor3 = Color3.fromRGB(230, 230, 230)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = option

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 50, 0, 24)
    button.Position = UDim2.new(1, -60, 0.5, -12)
    button.BackgroundColor3 = Color3.fromRGB(90, 90, 95)
    button.Text = ""
    button.BorderSizePixel = 0
    button.AutoButtonColor = false
    button.Parent = option
    Instance.new("UICorner", button).CornerRadius = UDim.new(1, 0)

    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 20, 0, 20)
    circle.Position = UDim2.new(0, 2, 0.5, -10)
    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    circle.BorderSizePixel = 0
    circle.Parent = button
    Instance.new("UICorner", circle).CornerRadius = UDim.new(1, 0)

    local state = false
    button.MouseButton1Click:Connect(function()
        state = not state
        if state then
            button.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
            circle:TweenPosition(UDim2.new(1, -22, 0.5, -10), "Out", "Quad", 0.2, true)
        else
            button.BackgroundColor3 = Color3.fromRGB(90, 90, 95)
            circle:TweenPosition(UDim2.new(0, 2, 0.5, -10), "Out", "Quad", 0.2, true)
        end
        if callback then
            pcall(function() callback(state) end)
        end
    end)
end

-- -----------------------
-- Funciones auxiliares (Float button, etc)
-- -----------------------
local function createFloatButton()
    if floatGuiBtn then return end
    floatGuiBtn = Instance.new("TextButton")
    floatGuiBtn.Size = UDim2.new(0,90,0,35)
    floatGuiBtn.Position = UDim2.new(0.5,-45,0.5,-18)
    floatGuiBtn.Text = "Float OFF"
    floatGuiBtn.TextColor3 = Color3.fromRGB(255,255,255)
    floatGuiBtn.Font = Enum.Font.GothamBold
    floatGuiBtn.TextSize = 14
    floatGuiBtn.Parent = gui
    floatGuiBtn.Active = true
    floatGuiBtn.Draggable = true
    floatGuiBtn.BackgroundTransparency = 0

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0,12)
    corner.Parent = floatGuiBtn

    local shadow = Instance.new("ImageLabel")
    shadow.AnchorPoint = Vector2.new(0.5,0.5)
    shadow.Position = UDim2.new(0.5,0,0.5,4)
    shadow.Size = UDim2.new(1,12,1,12)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://5028857084"
    shadow.ImageColor3 = Color3.fromRGB(0,0,0)
    shadow.ImageTransparency = 0.5
    shadow.Parent = floatGuiBtn

    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(70,130,180)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(138,43,226))
    }
    gradient.Rotation = 45
    gradient.Parent = floatGuiBtn

    task.spawn(function()
        while floatGuiBtn and floatGuiBtn.Parent do
            gradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromHSV(tick()%5/5,1,1)),
                ColorSequenceKeypoint.new(1, Color3.fromHSV((tick()%5/5)+0.2,1,1))
            }
            task.wait(0.1)
        end
    end)

    local toggled = false
    floatGuiBtn.MouseButton1Click:Connect(function()
        toggled = not toggled
        floatEnabled = toggled
        floatGuiBtn.Text = toggled and "Float ON" or "Float OFF"
    end)

    floatGuiBtn.MouseEnter:Connect(function()
        floatGuiBtn.TextSize = 16
    end)
    floatGuiBtn.MouseLeave:Connect(function()
        floatGuiBtn.TextSize = 14
    end)
end

-- Loop de float que mantiene la plataforma debajo del jugador y aplica color dinámico
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
                pcall(function() floatPart:Destroy() end)
                floatPart=nil
            end
        end
    end
end)

-- -----------------------
-- Hacks (ahora con switches)
-- -----------------------

-- Speed
createSwitch("Speed", generalFrame, function(state)
    speedEnabled = state
    if state then
        task.spawn(function()
            while speedEnabled do
                if humanoid then pcall(function() humanoid.WalkSpeed = 50 end) end
                task.wait(0.1)
            end
        end)
    else
        if humanoid then pcall(function() humanoid.WalkSpeed = 16 end) end
    end
end)

-- High Jump
local function highJumpInput(input, gameProcessed)
    if gameProcessed then return end
    if not jumpEnabled then return end
    if (input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.Space) or (input.UserInputType == Enum.UserInputType.Touch) then
        local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if root then
            root.Velocity = Vector3.new(root.Velocity.X,100,root.Velocity.Z)
        end
    end
end
UserInputService.InputBegan:Connect(highJumpInput)
createSwitch("High Jump", generalFrame, function(state)
    jumpEnabled = state
end)

-- Float (con botón flotante)
createSwitch("Float", generalFrame, function(state)
    if state then
        createFloatButton()
        floatEnabled = false -- el Usuario debe activar con el floatGuiBtn
    else
        floatEnabled = false
        if floatGuiBtn then pcall(function() floatGuiBtn:Destroy() end) floatGuiBtn = nil end
        if floatPart then pcall(function() floatPart:Destroy() end) floatPart = nil end
    end
end)

-- FPS Booting con AntiLag
createSwitch("FPS Booting", generalFrame, function(state)
    if state then
        if setfpscap then pcall(function() setfpscap(360) end) end
        for _,plr in pairs(Players:GetPlayers()) do
            if plr.Character then
                for _,part in pairs(plr.Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        pcall(function()
                            part.Material = Enum.Material.SmoothPlastic
                            part.Reflectance = 0
                        end)
                    end
                end
            end
        end
    else
        if setfpscap then pcall(function() setfpscap(60) end) end
        for _,plr in pairs(Players:GetPlayers()) do
            if plr.Character then
                for _,part in pairs(plr.Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        pcall(function()
                            part.Material = Enum.Material.Plastic
                            part.Reflectance = 0
                        end)
                    end
                end
            end
        end
    end
end)

-- ESP Players (RGB)
createSwitch("ESP Players", generalFrame, function(state)
    espEnabled = state
    if state then
        task.spawn(function()
            while espEnabled do
                for _,plr in pairs(Players:GetPlayers()) do
                    if plr~=player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                        if not plr.Character:FindFirstChild("ESP") then
                            local success,err = pcall(function()
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

                                for _,p in pairs(plr.Character:GetDescendants()) do
                                    if p:IsA("BasePart") then
                                        local box = Instance.new("BoxHandleAdornment")
                                        box.Adornee=p
                                        box.AlwaysOnTop=true
                                        box.ZIndex=0
                                        box.Size=p.Size
                                        box.Transparency=0.5
                                        box.Color3=Color3.fromHSV(tick()%5/5,1,1)
                                        box.Parent=p
                                    end
                                end
                            end)
                            if not success then
                                -- ignore errors
                            end
                        else
                            -- update color
                            for _,desc in pairs(plr.Character.ESP:GetChildren()) do
                                if desc:IsA("TextLabel") then
                                    desc.TextColor3=Color3.fromHSV(tick()%5/5,1,1)
                                end
                            end
                        end
                    end
                end
                task.wait(0.2)
            end
            -- cleanup on disable
            for _,plr in pairs(Players:GetPlayers()) do
                if plr.Character and plr.Character:FindFirstChild("ESP") then
                    pcall(function() plr.Character.ESP:Destroy() end)
                end
                -- also remove BoxHandleAdornment if present
                if plr.Character then
                    for _,d in pairs(plr.Character:GetDescendants()) do
                        if d:IsA("BoxHandleAdornment") then
                            pcall(function() d:Destroy() end)
                        end
                    end
                end
            end
        end)
    end
end)

-- ✅ Time Base (plots) - toma la lógica completa del script Time Base
createSwitch("Time Base", generalFrame, function(state)
    timeBaseEnabled = state

    if not state then
        if timeBaseData.renderConn and timeBaseData.renderConn.Connected then
            pcall(function() timeBaseData.renderConn:Disconnect() end)
        end
        if timeBaseData.connAdded and timeBaseData.connAdded.Connected then
            pcall(function() timeBaseData.connAdded:Disconnect() end)
        end
        if timeBaseData.connRemoved and timeBaseData.connRemoved.Connected then
            pcall(function() timeBaseData.connRemoved:Disconnect() end)
        end
        for plot,info in pairs(timeBaseData.espMap) do
            if info and info.billboard and info.billboard.Parent then
                pcall(function() info.billboard:Destroy() end)
            end
            timeBaseData.espMap[plot] = nil
        end
        timeBaseData = { espMap = {}, connAdded = nil, connRemoved = nil, renderConn = nil, PLOTS_FOLDER = nil }
        return
    end

    timeBaseData.PLOTS_FOLDER = workspace:FindFirstChild("Plots")
    local PLOTS_FOLDER = timeBaseData.PLOTS_FOLDER
    local espMap = timeBaseData.espMap

    local function findHitbox(plot)
        local candidate = plot:FindFirstChild("Hitbox", true)
        if candidate then return candidate end
        for _, d in ipairs(plot:GetDescendants()) do
            if d:IsA("BasePart") and d.Name:lower():find("hit") then
                return d
            end
        end
        return nil
    end

    local function findRemainingLabel(plot)
        for _, d in ipairs(plot:GetDescendants()) do
            if d:IsA("TextLabel") and d.Name:lower():find("remaining") then
                return d
            end
        end
        return nil
    end

    local function createESPFor(plot)
        if not plot or espMap[plot] then return end

        local hitbox = findHitbox(plot)
        local sourceLabel = findRemainingLabel(plot)

        if not hitbox then return end

        local bb = Instance.new("BillboardGui")
        bb.Name = "ESP_RemainingTime"
        bb.Size = UDim2.new(0,150,0,60)
        bb.Adornee = hitbox
        bb.AlwaysOnTop = true
        bb.LightInfluence = 0
        bb.StudsOffset = Vector3.new(0, 3.2, 0)
        bb.Parent = hitbox

        local timeLabel = Instance.new("TextLabel", bb)
        timeLabel.Size = UDim2.new(1,0,0.7,0)
        timeLabel.Position = UDim2.new(0,0,0.15,0)
        timeLabel.BackgroundTransparency = 1
        timeLabel.Font = Enum.Font.SourceSansBold
        timeLabel.TextScaled = true
        timeLabel.Text = "0s"
        timeLabel.TextStrokeTransparency = 0
        timeLabel.TextStrokeColor3 = Color3.fromRGB(0,0,0)
        timeLabel.TextColor3 = Color3.fromRGB(255,255,255)

        local hueOffset = math.random()
        espMap[plot] = {
            billboard = bb,
            timeLabel = timeLabel,
            sourceLabel = sourceLabel,
            hueOffset = hueOffset
        }
    end

    local function removeESPFor(plot)
        local info = espMap[plot]
        if not info then return end
        if info.billboard and info.billboard.Parent then
            pcall(function() info.billboard:Destroy() end)
        end
        espMap[plot] = nil
    end

    local function collectAll()
        for plot, info in pairs(espMap) do
            if not plot.Parent then
                removeESPFor(plot)
            end
        end

        if not PLOTS_FOLDER then
            PLOTS_FOLDER = workspace:FindFirstChild("Plots")
            timeBaseData.PLOTS_FOLDER = PLOTS_FOLDER
        end
        if not PLOTS_FOLDER then return end
        for _, plot in ipairs(PLOTS_FOLDER:GetChildren()) do
            createESPFor(plot)
        end
    end

    collectAll()

    if PLOTS_FOLDER then
        timeBaseData.connAdded = PLOTS_FOLDER.ChildAdded:Connect(function(child)
            task.wait(0.15)
            createESPFor(child)
        end)
        timeBaseData.connRemoved = PLOTS_FOLDER.ChildRemoved:Connect(function(child)
            removeESPFor(child)
        end)
    end

    timeBaseData.renderConn = RunService.RenderStepped:Connect(function()
        local now = tick()
        for plot, info in pairs(espMap) do
            if info and info.timeLabel then
                local txt = "0s"
                if info.sourceLabel and info.sourceLabel.Parent then
                    pcall(function()
                        local s = info.sourceLabel.Text
                        if s and #s > 0 then txt = s end
                    end)
                end
                pcall(function() info.timeLabel.Text = txt end)

                local hueSpeed = 0.15
                local hue = (now * hueSpeed + (info.hueOffset or 0)) % 1
                local color = Color3.fromHSV(hue, 1, 1)
                pcall(function()
                    info.timeLabel.TextColor3 = color
                    info.timeLabel.TextStrokeColor3 = Color3.new(0,0,0)
                end)
            end
        end
    end)
end)

-- ============================
-- ESP BREINROT (Jugadores + Bosses con distancia) --> SOLO BOSSES (RGB + Distancia)
-- ============================
do
    local breinrotEnabled = false
    local bossesTracked = {}
    local bossesConnAdded = nil
    local bossesConnRemoving = nil

    local TARGET_BOSSES = {
        "Graipuss Medussi",
        "La Vacca Saturno Sarturnita",
        "Los Tralaleritos",
        "Sammyni Spyderini",
        "Garama and Madundung",
        "La Grande Combinasion",
        "Las Sis",
        "Chimpanzini Spiderini",
        "Nuclearo Dinossauro",
        "La Extinct Grande",
        "Chicleteira Bicicleteira",
        "Dragon Cannelloni",
        "Los Combinasionas",
        "Los Hotspotsitos",
        "Spaghetti Tualetti",
        "La Supreme Combinasion",
        "Strawberry Elephant",
        "Ketupat Kepat",
        "Los Noo My Hotspotsitos",
    }

    local BOSS_COLORS = {
        ["Graipuss Medussi"] = Color3.fromRGB(255,80,80),
        ["Nuclearo Dinossauro"] = Color3.fromRGB(0,255,0),
        ["Dragon Cannelloni"] = Color3.fromRGB(255,60,60),
        ["Strawberry Elephant"] = Color3.fromRGB(255,80,180),
    }

    local function normalizeName(s)
        return (tostring(s):gsub("^%s*(.-)%s*$","%1")):lower()
    end
    local normalizedBosses = {}
    for _,b in ipairs(TARGET_BOSSES) do
        normalizedBosses[normalizeName(b)] = b
    end

    local function cleanupBossESP(model)
        local data = bossesTracked[model]
        if data then
            if data.conn and data.conn.Connected then
                pcall(function() data.conn:Disconnect() end)
            end
            if data.highlight and data.highlight.Parent then
                pcall(function() data.highlight:Destroy() end)
            end
            if data.billboard and data.billboard.Parent then
                pcall(function() data.billboard:Destroy() end)
            end
            bossesTracked[model] = nil
        end
    end

    local function attachBossESP(model)
        if not breinrotEnabled or bossesTracked[model] then return end
        local bossName = normalizedBosses[normalizeName(model.Name)]
        if not bossName then return end

        local adornee = model:FindFirstChild("HumanoidRootPart") or model.PrimaryPart
        if not adornee then
            for _,d in ipairs(model:GetDescendants()) do
                if d:IsA("BasePart") then adornee = d break end
            end
        end
        if not adornee then return end

        local color = BOSS_COLORS[bossName] or Color3.fromRGB(255,255,255)

        local hl = Instance.new("Highlight")
        hl.Name = "BREINROT_Highlight"
        hl.Adornee = model
        hl.FillTransparency = 0.6
        hl.OutlineColor = color
        hl.Parent = model

        local bb = Instance.new("BillboardGui")
        bb.Name = "BREINROT_Billboard"
        bb.Size = UDim2.new(0,200,0,50)
        bb.Adornee = adornee
        bb.AlwaysOnTop = true
        bb.StudsOffset = Vector3.new(0,4,0)
        bb.Parent = model

        local txt = Instance.new("TextLabel")
        txt.Size = UDim2.new(1,0,1,0)
        txt.BackgroundTransparency = 1
        txt.Font = Enum.Font.GothamBold
        txt.Text = "👹 "..bossName
        txt.TextColor3 = color
        txt.TextScaled = true
        txt.Parent = bb

        local hueOffset = math.random()
        local conn
        conn = RunService.Heartbeat:Connect(function()
            if not breinrotEnabled or not model.Parent or not adornee.Parent then
                if conn and conn.Connected then pcall(function() conn:Disconnect() end) end
                cleanupBossESP(model)
                return
            end
            if player.Character and player.Character.PrimaryPart then
                local dist = (player.Character.PrimaryPart.Position - adornee.Position).Magnitude
                txt.Text = string.format("👹 %s (%.0fm)", bossName, dist)
            else
                txt.Text = "👹 "..bossName
            end
            local hueSpeed = 0.15
            local hue = (tick() * hueSpeed + hueOffset) % 1
            txt.TextColor3 = Color3.fromHSV(hue, 1, 1)
        end)

        bossesTracked[model] = { highlight = hl, billboard = bb, text = txt, conn = conn, hueOffset = hueOffset }
    end

    createSwitch("ESP BREINROT", generalFrame, function(state)
        breinrotEnabled = state

        if not state then
            if bossesConnAdded and bossesConnAdded.Connected then
                pcall(function() bossesConnAdded:Disconnect() end)
                bossesConnAdded = nil
            end
            if bossesConnRemoving and bossesConnRemoving.Connected then
                pcall(function() bossesConnRemoving:Disconnect() end)
                bossesConnRemoving = nil
            end

            for model,_ in pairs(bossesTracked) do
                cleanupBossESP(model)
            end
            bossesTracked = {}
            return
        end

        for _,desc in ipairs(workspace:GetDescendants()) do
            if desc:IsA("Model") and normalizedBosses[normalizeName(desc.Name)] then
                pcall(function() attachBossESP(desc) end)
            end
        end

        if not bossesConnAdded then
            bossesConnAdded = workspace.DescendantAdded:Connect(function(obj)
                if breinrotEnabled and obj:IsA("Model") and normalizedBosses[normalizeName(obj.Name)] then
                    task.wait(0.1)
                    pcall(function() attachBossESP(obj) end)
                end
            end)
        end
        if not bossesConnRemoving then
            bossesConnRemoving = workspace.DescendantRemoving:Connect(function(obj)
                if bossesTracked[obj] then
                    pcall(function() cleanupBossESP(obj) end)
                end
            end)
        end
    end)
end

-- ✅ Serverhop directo (al activar, te cambia de servidor)
createSwitch("Serverhop", generalFrame, function(state)
    if state then
        local placeId = game.PlaceId
        pcall(function() TeleportService:Teleport(placeId, player) end)
    end
end)

-- -----------------------
-- KeyCheck (fix duplicado)
local KEY="keygratis1"
keyBtn.MouseButton1Click:Connect(function()
    if keyBox.Text == KEY then
        pcall(function() keyFrame:Destroy() end) -- 🔹 destruir en vez de ocultar
        loadingFrame.Visible = true
        for i=1,100 do
            barFill.Size = UDim2.new(i/100,0,1,0)
            task.wait(0.03)
        end
        loadingFrame.Visible = false
        mainBtn.Visible = true
    else
        keyBox.Text = ""
        keyBox.PlaceholderText = "❌ Key incorrecta"
    end
end)


-- Panel toggle
mainBtn.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

-- Toggle con tecla Insert
UserInputService.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.Insert then
        frame.Visible = not frame.Visible
    end
end)
