function sendNotif(text, title)
    local Event = game:GetService("ReplicatedStorage").Notification
    firesignal(Event.OnClientEvent, {
        Duration = 5,
        Text = text,
        Title = title or "AlienX",
        Button1 = "关闭"
    })
end

sendNotif("正在打开战争大亨")
wait(3)
sendNotif("启动成功", "War Tycoon")
wait(3)
sendNotif("作者:神道,还有一个给")

AlienX = loadstring(game:HttpGet("https://raw.githubusercontent.com/Lmmrcsy/AlienX/refs/heads/main/main.lua"))()

local _ = {}
_.uis = game:GetService("UserInputService")
_.Players = game:GetService("Players")
local Plr = _.Players.LocalPlayer
_.Char = game.Players.LocalPlayer.Character
_.ReplicatedStorage = game:GetService("ReplicatedStorage")
_.Workspace = game:GetService("Workspace")  
_.humanoid = _.Char:WaitForChild("Humanoid")
_.humanoidRootPart = _.Char:FindFirstChild("HumanoidRootPart")
_.RunService = game:GetService("RunService")
_.tycoon = workspace:FindFirstChild("Tycoon")
_.teamName = Plr.Team.Name
_.Camera = workspace.CurrentCamera

_.Positions = {
    ["Alpha"] = CFrame.new(-1197, 65, -4790),
    ["Bravo"] = CFrame.new(-220, 65, -4919),
    ["Charlie"] = CFrame.new(797, 65, -4740),
    ["Delta"] = CFrame.new(2044, 65, -3984),
    ["Echo"] = CFrame.new(2742, 65, -3031),
    ["Foxtrot"] = CFrame.new(3045, 65, -1788),
    ["Golf"] = CFrame.new(3376, 65, -562),
    ["Hotel"] = CFrame.new(3290, 65, 587),
    ["Juliet"] = CFrame.new(2955, 65, 1804),
    ["Kilo"] = CFrame.new(2569, 65, 2926),
    ["Lima"] = CFrame.new(989, 65, 3419),
    ["Omega"] = CFrame.new(-319, 65, 3932),
    ["Romeo"] = CFrame.new(-1479, 65, 3722),
    ["Sierra"] = CFrame.new(-2528, 65, 2549),
    ["Tango"] = CFrame.new(-3018, 65, 1503),
    ["Victor"] = CFrame.new(-3587, 65, 634),
    ["Yankee"] = CFrame.new(-3957, 65, -287),
    ["Zulu"] = CFrame.new(-4049, 65, -1334)
}

function gradient(text, startColor, endColor)
    local result, length = "", #text
    
    for i = 1, length do
        local t = (i - 1) / math.max(length - 1, 1)
        local r, g, b = math.floor((startColor.R + (endColor.R - startColor.R) * t) * 255), math.floor((startColor.G + (endColor.G - startColor.G) * t) * 255), math.floor((startColor.B + (endColor.B - startColor.B) * t) * 255)
        
        local char = text:sub(i, i)
        result = result .. "<font color=\"rgb(" .. r ..", " .. g .. ", " .. b .. ")\">" .. char .. "</font>"
    end
    
    return result
end

local WhitelistManager = {
    NameMaps = {},
    RefreshCallbacks = {},
    IsRefreshing = false,
    NeedsRefresh = true,
    UIOpen = true
}

function WhitelistManager:RefreshAllLists()
    if self.IsRefreshing then return end
    self.IsRefreshing = true
    self.NeedsRefresh = false
    
    task.spawn(function()
        local list, nameMap = {}, {}
        
        for _, p in ipairs(_.Players:GetPlayers()) do
            if p ~= Plr then
                local name, c = p.DisplayName ~= p.Name and p.DisplayName .. "(" .. p.Name .. ")" or p.Name, p.TeamColor.Color
                local text = string.format('<font color="rgb(%d,%d,%d)">%s</font>', math.floor(c.R * 255), math.floor(c.G * 255), math.floor(c.B * 255), name)
                table.insert(list, text)
                nameMap[text] = p.Name
            end
        end
        
        local all = gradient("All", Color3.fromRGB(255, 255, 255), Color3.fromRGB(200, 200, 200))
        table.insert(list, all)
        nameMap[all] = "All"
        
        self.NameMaps = nameMap
        
        for _, callback in pairs(self.RefreshCallbacks) do
            if type(callback) == "function" then
                pcall(callback, list)
            end
        end
        
        self.IsRefreshing = false
    end)
end

function WhitelistManager:SetUIOpen(isOpen)
    self.UIOpen = isOpen
    if isOpen and self.NeedsRefresh then
        self:RefreshAllLists()
    end
end

function WhitelistManager:RegisterRefreshCallback(name, callback)
    self.RefreshCallbacks[name] = callback
end

function WhitelistManager:GetPlayerName(displayName)
    return self.NameMaps[displayName]
end

function WhitelistManager:Initialize()
    self:RefreshAllLists()
end

task.wait(3)
WhitelistManager:Initialize()

titleText, authorText = gradient("AlienX Elite Dev", Color3.fromRGB(255, 100, 200), Color3.fromRGB(100, 200, 255)), gradient("War Tycoon", Color3.fromRGB(255, 200, 100), Color3.fromRGB(100, 255, 200))

Window = AlienX:CreateWindow({
	Title = titleText,
	Icon = "rbxassetid://96305381714766",
	IconThemed = true,
	Author = authorText,
	Folder = "CloudHub",
	Size = UDim2.fromOffset(300, 270),
	Transparent = true,
	Theme = "Dark",
	User = {
		Enabled = true,
		Callback = function()
			print("clicked")
		end,
		Anonymous = false,
	},
	SideBarWidth = 150,
	ScrollBarEnabled = true,
})

Window:EditOpenButton({
    Title = "AlienX Elite 开发版",
    Icon = "rbxassetid://96305381714766",
    CornerRadius = UDim.new(0, 20),
    StrokeThickness = 1.5,
    Draggable = true,
})

task.spawn(function()
    local pulse = 0
    while task.wait(0.05) do
        if Window.OpenButtonMain and Window.OpenButtonMain.Button then
            local stroke = Window.OpenButtonMain.Button:FindFirstChild("UIStroke")
            if stroke then
                local gradient = stroke:FindFirstChild("UIGradient")
                if gradient then
                    gradient.Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
                        ColorSequenceKeypoint.new(0.08, Color3.fromRGB(255, 100, 0)),
                        ColorSequenceKeypoint.new(0.16, Color3.fromRGB(255, 200, 0)),
                        ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 255, 0)),
                        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(200, 255, 0)),
                        ColorSequenceKeypoint.new(0.41, Color3.fromRGB(100, 255, 0)),
                        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 100)),
                        ColorSequenceKeypoint.new(0.58, Color3.fromRGB(0, 255, 200)),
                        ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 200, 255)),
                        ColorSequenceKeypoint.new(0.75, Color3.fromRGB(0, 100, 255)),
                        ColorSequenceKeypoint.new(0.83, Color3.fromRGB(100, 0, 255)),
                        ColorSequenceKeypoint.new(0.91, Color3.fromRGB(200, 0, 255)),
                        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 200)),
                    })
                    gradient.Rotation = (gradient.Rotation or 0) + 3.6
                    if gradient.Rotation > 360 then
                        gradient.Rotation = gradient.Rotation - 360
                    end
                end
                pulse = pulse + 0.08
                stroke.Transparency = 0.25 + math.sin(pulse) * 0.2
                stroke.Thickness = 1.5
            end
        end
    end
end)
COLOR_SCHEMES = {
    ["彩虹颜色"] = {ColorSequence.new({
        ColorSequenceKeypoint.new(0,    Color3.fromHex("FF0000")),
        ColorSequenceKeypoint.new(0.16, Color3.fromHex("FFA500")),
        ColorSequenceKeypoint.new(0.33, Color3.fromHex("FFFF00")),
        ColorSequenceKeypoint.new(0.5,  Color3.fromHex("00FF00")),
        ColorSequenceKeypoint.new(0.66, Color3.fromHex("0000FF")),
        ColorSequenceKeypoint.new(0.83, Color3.fromHex("4B0082")),
        ColorSequenceKeypoint.new(1,    Color3.fromHex("EE82EE"))
    }), "palette"},

    ["绿黄渐变"] = {ColorSequence.new({
        ColorSequenceKeypoint.new(0,   Color3.fromHex("30FF6A")),
        ColorSequenceKeypoint.new(0.5, Color3.fromHex("a8ff00")),
        ColorSequenceKeypoint.new(1,   Color3.fromHex("e7ff2f"))
    }), "waves"},
}

borderAnimation, animationSpeed = nil, 5

function createRainbowBorder(window, colorScheme)
    local mainFrame = window.UIElements.Main
    if not mainFrame then return nil end

    local existingStroke = mainFrame:FindFirstChild("RainbowStroke")
    if existingStroke then existingStroke:Destroy() end

    if not mainFrame:FindFirstChildOfClass("UICorner") then
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 16)
        corner.Parent = mainFrame
    end

    local rainbowStroke = Instance.new("UIStroke")
    rainbowStroke.Name = "RainbowStroke"
    rainbowStroke.Thickness = 2
    rainbowStroke.Color = Color3.new(1, 1, 1)
    rainbowStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    rainbowStroke.LineJoinMode = Enum.LineJoinMode.Round
    rainbowStroke.Parent = mainFrame

    local glowEffect = Instance.new("UIGradient")
    glowEffect.Name = "GlowEffect"
    local schemeData = COLOR_SCHEMES[colorScheme or "彩虹颜色"]
    glowEffect.Color = schemeData and schemeData[1] or COLOR_SCHEMES["彩虹颜色"][1]
    glowEffect.Rotation = 0
    glowEffect.Parent = rainbowStroke

    return rainbowStroke
end

function startBorderAnimation(window, speed)
    local mainFrame = window.UIElements.Main
    if not mainFrame then return nil end
    local rainbowStroke = mainFrame:FindFirstChild("RainbowStroke")
    if not rainbowStroke then return nil end
    local glowEffect = rainbowStroke:FindFirstChild("GlowEffect")
    if not glowEffect then return nil end

    return game:GetService("RunService").Heartbeat:Connect(function()
        if not rainbowStroke or rainbowStroke.Parent == nil then return end
        glowEffect.Rotation = (tick() * speed * 10) % 360
    end)
end

rainbowStroke = createRainbowBorder(Window, "彩虹颜色")
if rainbowStroke then
    borderAnimation = startBorderAnimation(Window, animationSpeed)
end

Window:Tag({
    Title = "VIP",
    Radius = 5,
    Color = Color3.fromRGB(0, 0, 0),
    TextColor = Color3.fromRGB(255, 215, 0),
})

timeTag = Window:Tag({
    Title = os.date("%H:%M:%S"),
    Radius = 5,
    Color = Color3.fromHex("#1A1A2E"),
    TextColor = Color3.fromRGB(255, 255, 255),
})

function safeUpdateTime()
    local currentTime = os.date("%H:%M:%S")
    local success = pcall(function()
        if timeTag.Update then
            timeTag:Update({ Title = currentTime })
        elseif timeTag.SetTitle then
            timeTag:SetTitle(currentTime)
        elseif timeTag.Edit then
            timeTag:Edit({ Title = currentTime })
        end
    end)
    return success
end

spawn(function()
    wait(1)
    while true do
        safeUpdateTime()
        wait(1)
    end
end)

StableSection = Window:Section({Title = "稳定功能", Opened = true})
TeleportTab, AutoTab, EspTab, AssistTab, AimTab = StableSection:Tab({Title = "传送", Icon = "rbxassetid://96305381714766"}), StableSection:Tab({Title = "自动", Icon = "rbxassetid://96305381714766"}), StableSection:Tab({Title = "透视", Icon = "rbxassetid://96305381714766"}), StableSection:Tab({Title = "辅助", Icon = "rbxassetid://96305381714766"}), StableSection:Tab({Title = "自瞄", Icon = "rbxassetid://96305381714766"})

FunSection = Window:Section({Title = "娱乐功能", Opened = true})
local AttackTab, WeaponTab, KillTab, PlayerTab, FlingTab, Gunlockb, CarTab, NotificationsTab, settings = FunSection:Tab({Title = "攻击", Icon = "rbxassetid://96305381714766"}), FunSection:Tab({Title = "武器", Icon = "rbxassetid://96305381714766"}), FunSection:Tab({Title = "杀戮", Icon = "rbxassetid://96305381714766"}), FunSection:Tab({Title = "玩家", Icon = "rbxassetid://96305381714766"}), FunSection:Tab({Title = "甩飞", Icon = "rbxassetid://96305381714766"}), FunSection:Tab({Title = "子追", Icon = "rbxassetid://96305381714766"}), FunSection:Tab({Title = "载具", Icon = "rbxassetid://96305381714766"}), FunSection:Tab({ Title = "通知", Icon = "rbxassetid://96305381714766"}), FunSection:Tab({Title = "调试", Icon = "rbxassetid://96305381714766"})

TeleportTab:Section({ Title = "传送设置", })

TeleportTab:Button({
    Title = "当前玩家基地: " .. _.teamName,
    Callback = function()
        if Plr.Character and Plr.Team and _.Positions[Plr.Team.Name] then
            Plr.Character:PivotTo(_.Positions[Plr.Team.Name])
        else
        end
    end
})

init = false
TeleportTab:Dropdown({
    Title = "传送基地", 
    Values = {"Alpha", "Bravo", "Charlie", "Delta", "Echo", "Foxtrot", "Golf", "Hotel", "Juliet", "Kilo", "Lima", "Omega", "Romeo", "Sierra", "Tango", "Victor", "Yankee", "Zulu"}, 
    Value = "Alpha", 
    Callback = function(d) 
        if not init then init = true return end
        if Plr.Character then Plr.Character:PivotTo(_.Positions[d]) end
    end
})

TeleportTab:Button({Title="传送到捕获点",Callback=function()if Plr.Character then Plr.Character:PivotTo(CFrame.new(-504.67,177.36,-1025))end end})

TeleportTab:Section({ Title = "玩家" })

targetPlayerName, spectateEnabled, autoTeleport, teleportLoop, spectateHeartbeat, spectateCharConn, spectatePlayerConn, isWaitingForCharacter, originalCameraSubject = nil, false, false, nil, nil, nil, nil, false, nil

local playerDropdown = TeleportTab:Dropdown({
    Title = "玩家",
    Values = {},
    Multi = false,
    Callback = function(s)
        targetPlayerName = WhitelistManager:GetPlayerName(s)
    end
})

WhitelistManager:RegisterRefreshCallback("Teleport", function(list)
    playerDropdown:Refresh(list)
end)

function getTarget()
    if not targetPlayerName then return nil end
    return _.Players:FindFirstChild(targetPlayerName)
end

function teleport()
    local target = getTarget()
    if not target then return end
    local targetChar = target.Character
    if not targetChar or not _.Char then return end
    local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")
    if targetHRP and _.humanoidRootPart then
        _.humanoidRootPart.CFrame = targetHRP.CFrame
    end
end

function clearSpectateConnections()
    if spectateHeartbeat then spectateHeartbeat:Disconnect() spectateHeartbeat = nil end
    if spectateCharConn then spectateCharConn:Disconnect() spectateCharConn = nil end
    if spectatePlayerConn then spectatePlayerConn:Disconnect() spectatePlayerConn = nil end
    isWaitingForCharacter = false
end

function resetCamera()
    clearSpectateConnections()
    
    if _.Char then

        if _.humanoid then
            _.Camera.CameraSubject = _.humanoid
            _.Camera.CameraType = Enum.CameraType.Custom
        end
    end
    
    originalCameraSubject = nil
end

function applySpectateSubject(target)
    if not spectateEnabled or not target or not target.Parent then return false end
    local hum = target.Character and target.Character:FindFirstChildOfClass("Humanoid")
    if hum and hum.Health > 0 then
        _.Camera.CameraSubject = hum
        _.Camera.CameraType = Enum.CameraType.Custom
        return true
    end
    return false
end

function waitForCharacter(target)
    if isWaitingForCharacter then return end
    isWaitingForCharacter = true
    
    task.spawn(function()
        local attempts = 0
        while spectateEnabled and target and target.Parent do
            if applySpectateSubject(target) then
                isWaitingForCharacter = false
                return
            end
            attempts = attempts + 1
            if attempts > 300 then
                isWaitingForCharacter = false
                resetCamera()
                spectateEnabled = false
                return
            end
            task.wait(0.1)
        end
        isWaitingForCharacter = false
    end)
end

function setupSpectate(target)
    if not originalCameraSubject then
        originalCameraSubject = _.Camera.CameraSubject
    end

    if not applySpectateSubject(target) then
        waitForCharacter(target)
    end

    if spectateCharConn then spectateCharConn:Disconnect() end
    spectateCharConn = target.CharacterAdded:Connect(function()
        task.wait(0.5)
        if spectateEnabled and target and target.Parent then
            if not applySpectateSubject(target) then
                waitForCharacter(target)
            else
                isWaitingForCharacter = false
            end
        end
    end)

    if spectateHeartbeat then spectateHeartbeat:Disconnect() end
    spectateHeartbeat = _.RunService.Heartbeat:Connect(function()
        if not spectateEnabled then return end
        if not target or not target.Parent then
            resetCamera()
            spectateEnabled = false
            return
        end
        if isWaitingForCharacter then return end
        local hum = target.Character and target.Character:FindFirstChildOfClass("Humanoid")
        if hum and hum.Health > 0 and _.Camera.CameraSubject ~= hum then
            _.Camera.CameraSubject = hum
            _.Camera.CameraType = Enum.CameraType.Custom
        elseif not target.Character then
            waitForCharacter(target)
        end
    end)
end

TeleportTab:Button({
    Title = "传送",
    Callback = teleport
})

TeleportTab:Toggle({
    Title = "持续传送",
    Callback = function(v)
        autoTeleport = v
        if teleportLoop then teleportLoop:Disconnect() teleportLoop = nil end
        if autoTeleport then
            teleportLoop = _.RunService.Heartbeat:Connect(teleport)
        end
    end
})

TeleportTab:Toggle({
    Title = "观看玩家",
    Callback = function(s)
        if not s then
            spectateEnabled = false
            isWaitingForCharacter = false
            resetCamera()
            return
        end

        local target = getTarget()
        if not target then
            spectateEnabled = false
            return
        end

        if not originalCameraSubject then
            originalCameraSubject = _.Camera.CameraSubject
        end

        spectateEnabled = true
        clearSpectateConnections()

        spectatePlayerConn = target.AncestryChanged:Connect(function(_, parent)
            if not parent then
                resetCamera()
                spectateEnabled = false
            end
        end)

        setupSpectate(target)
    end
})

AutoTab:Section({Title = "自动设置"})

AutoXZ = false

function getCratePrompt(crate)
    local promptPart = crate:FindFirstChild("PromptPart")
    if promptPart then
        local prompt = promptPart:FindFirstChildWhichIsA("ProximityPrompt")
        if prompt and prompt.Enabled then
            return prompt
        end
    end
    return nil
end

function isCrateAvailable(crate)
    return getCratePrompt(crate) ~= nil
end

function getCratePosition(crate)
    local mainPart = crate:FindFirstChild("MainPart")
    if mainPart then return mainPart.CFrame end
    return crate:GetPivot()
end

function getSellPrompt()
    if not _.teamName then return nil end
    if not _.tycoon then return nil end
    local tycoons = _.tycoon:FindFirstChild("Tycoons")
    if not tycoons then return nil end
    local myBase = tycoons:FindFirstChild(_.teamName)
    if not myBase then return nil end
    local essentials = myBase:FindFirstChild("Essentials")
    if not essentials then return nil end
    local oilCollector = essentials:FindFirstChild("Oil Collector")
    if not oilCollector then return nil end
    local persistant = oilCollector:FindFirstChild("Persistant")
    if not persistant then return nil end
    local promptPart = persistant:FindFirstChild("CratePromptPart")
    if not promptPart then return nil end
    local prompt = promptPart:FindFirstChildWhichIsA("ProximityPrompt")
    return prompt
end

function isSellPromptEnabled()
    local prompt = getSellPrompt()
    if prompt and prompt:IsA("ProximityPrompt") then
        return prompt.Enabled == true
    end
    return false
end

function isSellPromptExists()
    local prompt = getSellPrompt()
    return prompt ~= nil
end

function getSellPosition()
    if not _.teamName then return nil end
    local tycoons = workspace.Tycoon.Tycoons:FindFirstChild(_.teamName)
    if not tycoons then return nil end
    local oilCollector = tycoons:FindFirstChild("Essentials") and tycoons.Essentials:FindFirstChild("Oil Collector")
    if oilCollector then
        local collector = oilCollector:FindFirstChild("Collector")
        if collector then
            local part = collector:FindFirstChild("Part")
            if part then return part.CFrame * CFrame.new(0, 3, 0) end
            local plane = collector:FindFirstChild("Plane")
            if plane then return plane.CFrame * CFrame.new(0, 3, 0) end
        end
    end
    return nil
end

function getAllCrates()
    local crates, collectibles = {}, workspace:FindFirstChild("Game Systems") and workspace["Game Systems"]:FindFirstChild("Collectibles Workspace")
    if not collectibles then return crates end
    local partCrateFolder = collectibles:FindFirstChild("PartCrate")
    if not partCrateFolder then return crates end
    for _, child in ipairs(partCrateFolder:GetChildren()) do
        if child:IsA("Model") and child.Name:match("_[%d]+$") then
            local crateType = nil
            if child.Name:match("^Land_") then
                crateType = "坦克"
            elseif child.Name:match("^Air_") then
                crateType = "飞机"
            elseif child.Name:match("^Naval_") then
                crateType = "船"
            end
            if crateType then
                table.insert(crates, child)
            end
        end
    end
    return crates
end

function teleportToCFrame(cf)
    if _.humanoidRootPart then
        _.humanoidRootPart.CFrame = cf
        task.wait(0.3)
        return true
    end
    return false
end

function pickUpCrate(crate)
    if not _.humanoidRootPart then return false end
    
    local cratePos = getCratePosition(crate)
    if not cratePos then return false end
    
    _.humanoidRootPart.CFrame = cratePos * CFrame.new(0, 0, 3)
    task.wait(0.3)
    
    local startTime, pickedUp = tick(), false
    
    while AutoXZ and tick() - startTime < 8 do
        local prompt = getCratePrompt(crate)
        if prompt then
            fireproximityprompt(prompt)
        end
        if not isCrateAvailable(crate) then
            pickedUp = true
            break
        end
        task.wait(0.00001)
    end
    
    return pickedUp
end

function teleportToBase()
    if not _.teamName then return false end
    local baseCF = _.Positions[_.teamName]
    if not baseCF then return false end
    return teleportToCFrame(baseCF)
end

function teleportToSellPoint()
    local sellPos = getSellPosition()
    if sellPos then
        return teleportToCFrame(sellPos)
    else
        return teleportToBase()
    end
end

function waitForSellReady()
    while AutoXZ do
        if not isSellPromptExists() then
            teleportToBase()
            task.wait(0.5)
            continue
        end
        if isSellPromptEnabled() then
            return true
        end
        task.wait(0.1)
    end
    return false
end

function sellCrate()
    teleportToSellPoint()
    task.wait(0.3)
    
    if not waitForSellReady() then
        return false
    end
    
    local startTime = tick()
    while AutoXZ and tick() - startTime < 10 do
        local prompt = getSellPrompt()
        if prompt then
            fireproximityprompt(prompt)
        end
        if not isSellPromptEnabled() then
            return true
        end
        task.wait(0.001)
    end
    
    return false
end

AutoTab:Toggle({
    Title = "自动箱子",
    Value = false,
    Callback = function(isEnabled)
        AutoXZ = isEnabled
        if not AutoXZ then return end
        
        local crateLastPositions, MAX_CRATE_HEIGHT, currentCrate, isPicking, isSelling, pickUpTime = {}, 250, nil, false, false, 0
        
        local function isMoving(crate)
            local currentPos, lastPos = getCratePosition(crate).Position, crateLastPositions[crate]
            if not lastPos then
                crateLastPositions[crate] = currentPos
                return true
            end
            local moving = (currentPos - lastPos).Magnitude > 0.1
            crateLastPositions[crate] = currentPos
            return moving
        end
        
        local function getValidCrates()
            local allCrates, valid = getAllCrates(), {}
            for _, crate in ipairs(allCrates) do
                if isCrateAvailable(crate) then
                    local pos = getCratePosition(crate).Position
                    if pos.Y <= MAX_CRATE_HEIGHT and pos.Y >= 0 then
                        if not isMoving(crate) then
                            table.insert(valid, crate)
                        end
                    end
                end
            end
            return valid
        end
        
        local function getNearestToPlayer(crates)
            local hrp = Plr.Character and Plr.Character:FindFirstChild("HumanoidRootPart")
            if not hrp then return crates[1] end
            local nearest, nearestDist = nil, math.huge
            for _, crate in ipairs(crates) do
                local pos = getCratePosition(crate).Position
                local dist = (pos - hrp.Position).Magnitude
                if dist < nearestDist then
                    nearestDist = dist
                    nearest = crate
                end
            end
            return nearest
        end
        
        while AutoXZ do
            local validCrates = getValidCrates()
            local crate = getNearestToPlayer(validCrates)
            
            if crate and not isPicking and not isSelling then
                currentCrate = crate
                isPicking = true
                
                if pickUpCrate(crate) then
                    pickUpTime = tick()
                    isSelling = true
                    
                    teleportToSellPoint()
                    
                    local elapsed = tick() - pickUpTime
                    if elapsed < 2 then
                        task.wait(2 - elapsed)
                    end
                    
                    sellCrate()
                    isSelling = false
                end
                
                isPicking = false
                currentCrate = nil
            end
            task.wait(0.1)
        end
    end
})

autoCollectRunning, autoCollectThread = false, nil
autoCollectData = {
    OriginalSize = nil,
    OriginalCFrame = nil,
    Collector = nil,
    RenderSteppedConnection = nil,
    SizeLoopThread = nil
}

AutoTab:Toggle({
    Title = "自动拿钱",
    Value = false,
    Callback = function(state)
        autoCollectRunning = state
        
        if state then
            if autoCollectThread then
                task.cancel(autoCollectThread)
                autoCollectThread = nil
            end
            
            autoCollectThread = task.spawn(function()
                local player = Plr
                
                while autoCollectRunning do
                    local team = player.Team
                    if team and Workspace.Tycoon and Workspace.Tycoon.Tycoons then
                        local tycoon = Workspace.Tycoon.Tycoons:FindFirstChild(team.Name)
                        if tycoon then
                            local essentials = tycoon:FindFirstChild("Essentials")
                            if essentials then
                                local collectorParts = essentials:FindFirstChild("CollectorParts")
                                if collectorParts then
                                    local collector = collectorParts:FindFirstChild("Collector")
                                    if collector and collector:IsA("BasePart") then
                                        if not autoCollectData.OriginalSize then
                                            autoCollectData.OriginalSize = collector.Size
                                            autoCollectData.OriginalCFrame = collector.CFrame
                                            autoCollectData.Collector = collector
                                        end
                                        
                                        if not autoCollectData.RenderSteppedConnection then
                                            autoCollectData.RenderSteppedConnection = _.RunService.RenderStepped:Connect(function()
                                                if not autoCollectRunning then return end
                                                local char = player.Character
                                                if char then
                                                    local rootPart = char:FindFirstChild("HumanoidRootPart")
                                                    if rootPart then
                                                        local belowPos = rootPart.CFrame * CFrame.new(0, -5, 0)
                                                        collector.CFrame = belowPos
                                                    end
                                                end
                                            end)
                                        end
                                        
                                        if not autoCollectData.SizeLoopThread then
                                            autoCollectData.SizeLoopThread = task.spawn(function()
                                                while autoCollectRunning do
                                                    collector.Size = Vector3.new(6, 999, 6)
                                                    task.wait(0.1)
                                                    collector.Size = Vector3.new(6, 1, 6)
                                                    task.wait(0.1)
                                                end
                                            end)
                                        end
                                    end
                                end
                            end
                        end
                    end
                    task.wait()
                end
            end)
        else
            if autoCollectThread then
                task.cancel(autoCollectThread)
                autoCollectThread = nil
            end
            
            if autoCollectData.RenderSteppedConnection then
                autoCollectData.RenderSteppedConnection:Disconnect()
                autoCollectData.RenderSteppedConnection = nil
            end
            
            if autoCollectData.SizeLoopThread then
                task.cancel(autoCollectData.SizeLoopThread)
                autoCollectData.SizeLoopThread = nil
            end
            
            if autoCollectData.Collector and autoCollectData.OriginalSize then
                pcall(function()
                    autoCollectData.Collector.Size = autoCollectData.OriginalSize
                end)
            end
            
            if autoCollectData.Collector and autoCollectData.OriginalCFrame then
                pcall(function()
                    autoCollectData.Collector.CFrame = autoCollectData.OriginalCFrame
                end)
            end
            
            autoCollectData.OriginalSize = nil
            autoCollectData.OriginalCFrame = nil
            autoCollectData.Collector = nil
        end
    end
})

AutoTab:Button({
    Title = "获取钱堆",
    Callback = function()    
        if not _.humanoidRootPart then
            AlienX:Notify({Title = "提示", Content = "未获取到钱堆", Duration = 3})
            return
        end
        
        local originCFrame, originPosition = _.humanoidRootPart.CFrame, _.humanoidRootPart.Position
        
        local collectibles = _.Workspace:FindFirstChild("Game Systems")
        if not collectibles then
            AlienX:Notify({Title = "提示", Content = "未获取到钱堆", Duration = 3})
            return
        end
        
        local collectiblesWorkspace = collectibles:FindFirstChild("Collectibles Workspace")
        if not collectiblesWorkspace then
            AlienX:Notify({Title = "提示", Content = "未获取到钱堆", Duration = 3})
            return
        end
        
        local cashPile = collectiblesWorkspace:FindFirstChild("CashPile")
        if not cashPile then
            AlienX:Notify({Title = "提示", Content = "未获取到钱堆", Duration = 3})
            return
        end
        
        local validCashPiles = {}
        
        -- 遍历 CashPile 下的所有子对象，不管什么名字都检测
        for _, child in ipairs(cashPile:GetChildren()) do
            if child:IsA("Model") then
                local promptPart = child:FindFirstChild("PromptPart")
                if promptPart then
                    local prompt = promptPart:FindFirstChildWhichIsA("ProximityPrompt")
                    if prompt and prompt.Enabled then
                        local mainPart = child:FindFirstChild("MainPart")
                        if mainPart and mainPart:IsA("BasePart") then
                            table.insert(validCashPiles, {
                                Model = child,
                                MainPart = mainPart,
                                Prompt = prompt,
                                Name = child.Name
                            })
                        end
                    end
                end
            end
        end
        
        if #validCashPiles == 0 then
            AlienX:Notify({Title = "提示", Content = "未获取到钱堆", Duration = 3})
            return
        end
        
        local nearestCash, nearestDist = nil, math.huge
        
        for _, cash in ipairs(validCashPiles) do
            local dist = (cash.MainPart.Position - originPosition).Magnitude
            if dist < nearestDist then
                nearestDist = dist
                nearestCash = cash
            end
        end
        
        if not nearestCash then return end
        
        local targetPos = nearestCash.MainPart.CFrame
        
        _.humanoidRootPart.CFrame = targetPos * CFrame.new(0, 2, 2)
        task.wait(0.3)
        
        while nearestCash.Prompt and nearestCash.Prompt.Enabled == true do
            fireproximityprompt(nearestCash.Prompt)
            task.wait(0.1)
        end
        
        _.humanoidRootPart.CFrame = originCFrame
        _.humanoidRootPart.Velocity = Vector3.zero
        _.humanoidRootPart.RotVelocity = Vector3.zero
    end
})

AutoTab:Button({
    Title = "获取油桶",
    Callback = function()    
        if not _.humanoidRootPart then
            AlienX:Notify({Title = "提示", Content = "未找到角色", Duration = 3})
            return
        end
        
        local originCFrame, originPosition = _.humanoidRootPart.CFrame, _.humanoidRootPart.Position
        
        local collectibles = _.Workspace:FindFirstChild("Game Systems")
        if not collectibles then
            AlienX:Notify({Title = "提示", Content = "未获取到油桶", Duration = 3})
            return
        end
        
        local collectiblesWorkspace = collectibles:FindFirstChild("Collectibles Workspace")
        if not collectiblesWorkspace then
            AlienX:Notify({Title = "提示", Content = "未获取到油桶", Duration = 3})
            return
        end
        
        local oilBarrel = collectiblesWorkspace:FindFirstChild("OilBarrel")
        if not oilBarrel then
            AlienX:Notify({Title = "提示", Content = "未获取到油桶", Duration = 3})
            return
        end
        
        local validOilRigs = {}
        
        for _, child in ipairs(oilBarrel:GetChildren()) do
            if child:IsA("Model") then
                local promptPart = child:FindFirstChild("PromptPart")
                if promptPart then
                    local prompt = promptPart:FindFirstChildWhichIsA("ProximityPrompt")
                    if prompt and prompt.Enabled then
                        local mainPart = child:FindFirstChild("MainPart")
                        if mainPart and mainPart:IsA("BasePart") then
                            table.insert(validOilRigs, {
                                Model = child,
                                MainPart = mainPart,
                                Prompt = prompt,
                                Name = child.Name
                            })
                        end
                    end
                end
            end
        end
        
        if #validOilRigs == 0 then
            AlienX:Notify({Title = "提示", Content = "未获取到油桶", Duration = 3})
            return
        end
        
        local nearestOil, nearestDist = nil, math.huge
        
        for _, oil in ipairs(validOilRigs) do
            local dist = (oil.MainPart.Position - originPosition).Magnitude
            if dist < nearestDist then
                nearestDist = dist
                nearestOil = oil
            end
        end
        
        if not nearestOil then return end
        
        local targetPos = nearestOil.MainPart.CFrame
        
        _.humanoidRootPart.CFrame = targetPos * CFrame.new(0, 2, 2)
        task.wait(0.3)
        
        while nearestOil.Prompt and nearestOil.Prompt.Enabled == true do
            fireproximityprompt(nearestOil.Prompt)
            task.wait(0.1)
        end
        
        _.humanoidRootPart.CFrame = originCFrame
        _.humanoidRootPart.Velocity = Vector3.zero
        _.humanoidRootPart.RotVelocity = Vector3.zero
    end
})

AutoUpgrade = false
AutoTab:Toggle({
    Title = "自动升级", 
    Value = false, 
    Callback = function(t)
        AutoUpgrade = t

        if AutoUpgrade then
            local SETTINGS = {
                PART_NAME = "Neon",
                COLORS = {
                    GREEN = Color3.fromRGB(0, 255, 0),
                    BLUE = Color3.fromRGB(4, 175, 235),
                    YELLOW = Color3.fromRGB(255, 255, 0)
                },
                HEIGHT = 0,
                DELAY = 0.05,
                RADIUS = 800,
                SLIDE_SPEED = 1000
            }

            local char, root, currentRebirths = nil, nil, 0

            local skippedButtons = {
                ["Premium Air Upgrade 1"] = true,
                ["Premium Naval Upgrade 1"] = true,
                ["Premium Land Upgrade 1"] = true,
                ["Munition Generation Upgrade2"] = true,
                ["Munition Generation Upgrade1"] = true,
                ["Munition Generation Upgrade3"] = true
            }

            local function InitChar()
                char = Plr.Character or Plr.CharacterAdded:Wait()
                root = char:WaitForChild("HumanoidRootPart")
            end

            local function GetPlayerRebirths()
                local rebirths = 0
                pcall(function()
                    local stats = Plr:FindFirstChild("leaderstats")
                    if stats then
                        local rebirthStat = stats:FindFirstChild("Rebirths")
                        if rebirthStat then
                            rebirths = rebirthStat.Value
                        end
                    end
                end)
                currentRebirths = rebirths
                return rebirths
            end

            local function GetRequiredRebirthFromParentName(parentName, buttonName)
                if parentName == "Factory Foundation [3 Rebirth]" then
                    return 1
                end
                
                if buttonName == "SpecOps [5 Rebirths]" then
                    return 10
                end

                local specialCases = {
                    ["Hovercraft Vehicles"] = 4,
                    ["Unlock Bunker and Missile Silo"] = 2,
                    ["Tank Unlock"] = 6,
                    ["Vehicle Bay"] = 1,
                    ["Planes"] = 7,
                    ["Medbay Start"] = 1,
                    ["Trading Hub"] = 1,
                    ["WW2"] = 4,
                    ["Drone"] = 5,
                    ["Missile Silo Start"] = 5,
                    ["Vietnam Unlock"] = 4,
                    ["Advanced Factory Lines"] = 3
                }

                for name, num in pairs(specialCases) do
                    if string.find(parentName, name, 1, true) then
                        return num
                    end
                end

                local bracketNum = tonumber(string.match(parentName, "%[(%d+)%s*Rebirths?%]"))
                if bracketNum then return bracketNum end
                
                local numPatterns = {
                    "Rebirth%s*(%d+)",
                    "Start%s*(%d+)",
                    "(%d+)%s*Rebirths",
                    "(%d+)%s*$"
                }

                for _, pattern in ipairs(numPatterns) do
                    local num = tonumber(string.match(parentName, pattern))
                    if num then return num end
                end

                return nil
            end

            local function IsSkippedUpgrade(part)
                if not part or not part.Parent then return false end
                local button = part.Parent
                if button and skippedButtons[button.Name] then
                    return true
                end
                return false
            end

            local function IsPartValid(part, color)
                if not part or not part.Parent then return false end
                if part.Color ~= color then return false end
                
                if IsSkippedUpgrade(part) then
                    return false
                end

                if color == SETTINGS.COLORS.YELLOW then
                    local requiredRebirth = GetRequiredRebirthFromParentName(part.Parent.Name, part.Parent.Name)
                    if requiredRebirth and currentRebirths >= requiredRebirth then
                        return true
                    end
                    return false
                end

                return true
            end

            local function FindAllValidParts()
                if not root then return {}, {}, {} end
                
                local greens, yellows, blues, pos = {}, {}, {}, root.Position
                GetPlayerRebirths()

                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("BasePart") and obj.Name == SETTINGS.PART_NAME then
                        local dist = (obj.Position - pos).Magnitude
                        if dist < SETTINGS.RADIUS then
                            if obj.Color == SETTINGS.COLORS.GREEN then
                                table.insert(greens, obj)
                            elseif obj.Color == SETTINGS.COLORS.YELLOW then
                                if IsPartValid(obj, SETTINGS.COLORS.YELLOW) then
                                    table.insert(yellows, obj)
                                end
                            elseif obj.Color == SETTINGS.COLORS.BLUE then
                                table.insert(blues, obj)
                            end
                        end
                    end
                end

                local function sortByDistance(a, b)
                    return (a.Position - pos).Magnitude < (b.Position - pos).Magnitude
                end
                
                table.sort(greens, sortByDistance)
                table.sort(yellows, sortByDistance)
                table.sort(blues, sortByDistance)

                return greens, yellows, blues
            end

            local function SlideToPart(part)
                if not root or not part then return false end
                
                local targetPos, startPos = part.CFrame + Vector3.new(0, SETTINGS.HEIGHT, 0), root.CFrame
                local distance = (targetPos.Position - startPos.Position).Magnitude
                
                if distance < 1 then
                    root.CFrame = targetPos
                    return true
                end
                
                local duration, startTime = distance / SETTINGS.SLIDE_SPEED, tick()
                
                while tick() - startTime < duration and AutoUpgrade do
                    local alpha = (tick() - startTime) / duration
                    local currentPos = startPos.Position:Lerp(targetPos.Position, alpha)
                    root.CFrame = CFrame.new(currentPos) * (startPos - startPos.Position)
                    task.wait()
                end
                
                root.CFrame = targetPos
                return true
            end

            local function SafeTouch(part)
                if part and root then
                    pcall(function()
                        firetouchinterest(root, part, 0)
                        firetouchinterest(root, part, 1)
                    end)
                end
            end

            InitChar()

            while AutoUpgrade do
                local greens, yellows, blues = FindAllValidParts()

                local function handleParts(parts, color)
                    for _, part in ipairs(parts) do
                        if AutoUpgrade and IsPartValid(part, color) then
                            if SlideToPart(part) then
                                SafeTouch(part)
                                task.wait(SETTINGS.DELAY)
                            end
                        end
                    end
                end

                handleParts(greens, SETTINGS.COLORS.GREEN)
                handleParts(blues, SETTINGS.COLORS.BLUE)
                handleParts(yellows, SETTINGS.COLORS.YELLOW)

                task.wait(0.1)
            end
        end
    end
})

AutoTab:Toggle({
    Title = "自动M117",
    Value = false,
    Callback = function(state)
        if not state then
            local char = Plr.Character
            if char then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp and _G.M117Origin then
                    hrp.CFrame = _G.M117Origin
                    _G.M117Origin = nil
                end
            end
            return
        end
        local char = Plr.Character
        if not char then
            AlienX:Notify({Title = "提示", Content = "未获取到M117零件", Duration = 3})
            return
        end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then
            AlienX:Notify({Title = "提示", Content = "未获取到M117零件", Duration = 3})
            return
        end
        _G.M117Origin = hrp.CFrame
        local scavange = Workspace:FindFirstChild("Game Systems") and Workspace["Game Systems"]:FindFirstChild("Operations") and Workspace["Game Systems"].Operations:FindFirstChild("Scavange")
        if not scavange then
            AlienX:Notify({Title = "提示", Content = "未获取到M117零件", Duration = 3})
            _G.M117Origin = nil
            return
        end
        local parts, found = {"Body", "Doors", "Turret", "Wheels"}, false
        for _, partName in ipairs(parts) do
            local part = scavange:FindFirstChild(partName)
            if part then
                found = true
                local collection = part:FindFirstChild("Collection")
                if collection then
                    local prompt = collection:FindFirstChild("CollectOperation")
                    if prompt and prompt:IsA("ProximityPrompt") then
                        hrp.CFrame = part:GetPivot() * CFrame.new(0, 0, 3)
                        task.wait(0.3)
                        fireproximityprompt(prompt)
                        task.wait(0.5)
                        while part and part.Parent do
                            task.wait(0.1)
                        end
                    end
                end
            end
        end
        if not found then
            AlienX:Notify({Title = "提示", Content = "未获取到M117零件", Duration = 3})
        end
        if hrp and _G.M117Origin then
            hrp.CFrame = _G.M117Origin
            _G.M117Origin = nil
        end
    end
})

AutoTab:Toggle({
    Title = "自动S1",
    Value = false,
    Callback = function(state)
        if not state then
            local char = Plr.Character
            if char then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp and _G.S1Origin then
                    hrp.CFrame = _G.S1Origin
                    _G.S1Origin = nil
                end
            end
            return
        end
        local char = Plr.Character
        if not char then
            AlienX:Notify({Title = "提示", Content = "未获取到S1零件", Duration = 3})
            return
        end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then
            AlienX:Notify({Title = "提示", Content = "未获取到S1零件", Duration = 3})
            return
        end
        _G.S1Origin = hrp.CFrame
        local airDefense = Workspace:FindFirstChild("Game Systems") and Workspace["Game Systems"]:FindFirstChild("Operations") and Workspace["Game Systems"].Operations:FindFirstChild("Air Defense")
        if not airDefense then
            AlienX:Notify({Title = "提示", Content = "未获取到S1零件", Duration = 3})
            _G.S1Origin = nil
            return
        end
        local parts, found = {"Body", "Doors", "Radar", "Turret", "Wheels"}, false
        for _, partName in ipairs(parts) do
            local part = airDefense:FindFirstChild(partName)
            if part then
                found = true
                local collection = part:FindFirstChild("Collection")
                if collection then
                    local prompt = collection:FindFirstChild("CollectOperation")
                    if prompt and prompt:IsA("ProximityPrompt") then
                        hrp.CFrame = part:GetPivot() * CFrame.new(0, 0, 3)
                        task.wait(0.3)
                        fireproximityprompt(prompt)
                        task.wait(0.5)
                        while part and part.Parent do
                            task.wait(0.1)
                        end
                    end
                end
            end
        end
        if not found then
            AlienX:Notify({Title = "提示", Content = "未获取到S1零件", Duration = 3})
        end
        if hrp and _G.S1Origin then
            hrp.CFrame = _G.S1Origin
            _G.S1Origin = nil
        end
    end
})

AutoTab:Toggle({
    Title = "自动鼠氏",
    Value = false,
    Callback = function(state)
        if not state then
            local char = Plr.Character
            if char then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp and _G.ShrewOrigin then
                    hrp.CFrame = _G.ShrewOrigin
                    _G.ShrewOrigin = nil
                end
            end
            return
        end
        local char = Plr.Character
        if not char then
            AlienX:Notify({Title = "提示", Content = "未获取到鼠氏零件", Duration = 3})
            return
        end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then
            AlienX:Notify({Title = "提示", Content = "未获取到鼠氏零件", Duration = 3})
            return
        end
        _G.ShrewOrigin = hrp.CFrame
        local assemble = Workspace:FindFirstChild("Game Systems") and Workspace["Game Systems"]:FindFirstChild("Operations") and Workspace["Game Systems"].Operations:FindFirstChild("Assemble")
        if not assemble then
            AlienX:Notify({Title = "提示", Content = "未获取到鼠氏零件", Duration = 3})
            _G.ShrewOrigin = nil
            return
        end
        local parts, found = {"Body", "Cannon", "Turret", "Wheels"}, false
        for _, partName in ipairs(parts) do
            local part = assemble:FindFirstChild(partName)
            if part then
                found = true
                local collection = part:FindFirstChild("Collection")
                if collection then
                    local prompt = collection:FindFirstChild("CollectOperation")
                    if prompt and prompt:IsA("ProximityPrompt") then
                        hrp.CFrame = part:GetPivot() * CFrame.new(0, 0, 3)
                        task.wait(0.3)
                        fireproximityprompt(prompt)
                        task.wait(0.5)
                        while part and part.Parent do
                            task.wait(0.1)
                        end
                    end
                end
            end
        end
        if not found then
            AlienX:Notify({Title = "提示", Content = "未获取到鼠氏零件", Duration = 3})
        end
        if hrp and _G.ShrewOrigin then
            hrp.CFrame = _G.ShrewOrigin
            _G.ShrewOrigin = nil
        end
    end
})

AutoTab:Toggle({
    Title = "自动救人",
    Value = false,
    Callback = function(state)
        if not state then
            if _.Char then
                if _.humanoidRootPart then
                    _.humanoidRootPart.CFrame = _G.ReviveOrigin or _.humanoidRootPart.CFrame
                    _G.ReviveOrigin = nil
                end
            end
            autoRescueRunning = false
            return
        end
        
        if autoRescueRunning then return end
        autoRescueRunning = true
        
        if not _.Char then
            autoRescueRunning = false
            return
        end
        
        if not _.humanoidRootPart then
            autoRescueRunning = false
            return
        end
        
        task.spawn(function()
            while autoRescueRunning do
                local revivePart = workspace:FindFirstChild("RevivePart")
                if revivePart then
                    if not _G.ReviveOrigin then
                        _G.ReviveOrigin = _.humanoidRootPart.CFrame
                    end
                    local prompt = revivePart:FindFirstChild("RevivePrompt")
                    _.humanoidRootPart.CFrame = revivePart:GetPivot() * CFrame.new(0, 0, 3)
                    if prompt and prompt:IsA("ProximityPrompt") then
                        fireproximityprompt(prompt)
                    end
                else
                    if _.humanoidRootPart and _G.ReviveOrigin then
                        _.humanoidRootPart.CFrame = _G.ReviveOrigin
                        _G.ReviveOrigin = nil
                    end
                end
                task.wait(0.01)
            end
        end)
    end
})

EspTab:Section({Title = "透视设置"})

local Players, HttpService, RunService, CoreGui, Camera = game:GetService("Players"), game:GetService("HttpService"), game:GetService("RunService"), game:GetService("CoreGui"), workspace.CurrentCamera




local LP = Players.LocalPlayer

SUPABASE_URL, SUPABASE_KEY = "https://skvsecvifuxxiiwutgna.supabase.co", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNrdnNlY3ZpZnV4eGlpd3V0Z25hIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODczMTY3OTgsImV4cCI6MjEwMjg5Mjc5OH0.R_WNRLF335bUQHI97FfH2O-S9jhA1Zgmzzh_lvOFbJA"


VEHICLE_WORKSPACES = {
	"Drone Workspace", "Helicopter Workspace", "Hovercraft Workspace", "Plane Workspace",
	"RC Workspace", "Submarine Workspace", "Tank Workspace", "Vehicle Workspace",
}

VERSION_TAGS = {
	["A"] = {tag = "[Apex HUB]", color = Color3.fromRGB(0, 255, 0)},
	["B"] = {tag = "[AlienX Standard]", color = Color3.fromRGB(255, 255, 0)},
	["C"] = {tag = "[AlienX Elite]", color = Color3.fromRGB(255, 0, 255)},
}

CACHE_DURATION, VISUAL_INTERVAL, VEHICLE_CACHE_TTL, ESP_RANGE = 10, 1 / 30, 0.3, 50000




hue, currentColor, colorSpeed = 0, Color3.fromRGB(255, 255, 255), 0.3



oldESP = nil
if _G.AlienX_ESP then
	oldESP = _G.AlienX_ESP
	if oldESP.mainConn then pcall(function() oldESP.mainConn:Disconnect() end) end
	if oldESP.playerAddedConn then pcall(function() oldESP.playerAddedConn:Disconnect() end) end
	if oldESP.playerRemovingConn then pcall(function() oldESP.playerRemovingConn:Disconnect() end) end
	if oldESP.characterConns then
		for _, c in pairs(oldESP.characterConns) do
			if c then pcall(function() c:Disconnect() end) end
		end
	end
	oldESP.mainConn = nil
	oldESP.playerAddedConn = nil
	oldESP.playerRemovingConn = nil
	oldESP.characterConns = nil
end
for _, g in ipairs(CoreGui:GetChildren()) do
	if g:IsA("ScreenGui") and (g.Name == "ESPMainOverlay" or g.Name == "PlayerCountESP") then
		pcall(function() g:Destroy() end)
	end
end
for _, p in ipairs(Players:GetPlayers()) do
	local character = p.Character
	if character then
		for _, child in ipairs(character:GetDescendants()) do
			if child:IsA("BillboardGui") and child.Name:sub(1, 11) == "PlayerInfo_" then
				pcall(function() child:Destroy() end)
			elseif child:IsA("Highlight") and child.Name == "ESP_PlayerHL" then
				pcall(function() child:Destroy() end)
			end
		end
	end
end
guardGs = workspace:FindFirstChild("Game Systems")
if guardGs then
	for _, v in ipairs(guardGs:GetDescendants()) do
		if v:IsA("Highlight") and v.Name == "ESP_VehicleHL" then
			pcall(function() v:Destroy() end)
		elseif v:IsA("BillboardGui") and v.Name:sub(1, 12) == "VehicleInfo_" then
			pcall(function() v:Destroy() end)
		end
	end
end

ESP = {
	color = Color3.fromRGB(255, 255, 255),
	showAlienXTag = false,
	alienXCache = {},
	alienXCacheTime = 0,
	enabled = {
		boxes = false, names = false, tracers = false, health = false,
		chams = false, count = false, master = false,
		vehicleNames = false, vehicleHealth = false, vehicleChams = false, vehicleDistance = false,
	},
	playerData = {},
	vehicleData = {},
	mainScreenGui = nil,
	countLabel = nil,
	countGui = nil,
	mainConn = nil,
	playerAddedConn = nil,
	playerRemovingConn = nil,
	characterConns = {},
	frameCount = 0,
}
if oldESP then
	ESP.enabled = oldESP.enabled or ESP.enabled
	ESP.showAlienXTag = oldESP.showAlienXTag or false
	ESP.color = oldESP.color or ESP.color
end
_G.AlienX_ESP = ESP

function fetchAlienXUsers(cur)
	cur = cur or ESP
	if tick() - cur.alienXCacheTime < CACHE_DURATION and next(cur.alienXCache) then
		return cur.alienXCache
	end
	local serverId = game.JobId
	local url = SUPABASE_URL .. "/rest/v1/players?select=name,version&server_id=eq." .. serverId
	local headers = {
		["apikey"] = SUPABASE_KEY,
		["Authorization"] = "Bearer " .. SUPABASE_KEY
	}

	local requestFunc = syn and syn.request or request or http_request or function() return {Body = "{}"} end

	local success, response = pcall(function()
		return requestFunc({
			Url = url,
			Method = "GET",
			Headers = headers
		})
	end)
	if success and response and response.Body then
		local ok, data = pcall(function()
			return HttpService:JSONDecode(response.Body)
		end)
		if ok and type(data) == "table" then
			local cache = {}
			for _, p in ipairs(data) do
				if p.name and p.version then
					cache[p.name] = p.version
				end
			end
			cur.alienXCache = cache
			cur.alienXCacheTime = tick()
			return cache
		end
	end
	return cur.alienXCache
end

task.spawn(function()
	while true do
		task.wait(CACHE_DURATION)
		local cur = _G.AlienX_ESP
		if cur ~= ESP then return end
		fetchAlienXUsers(cur)
	end
end)

local function hsvToRgb(h, s, v)
	local i = math.floor(h * 6)
	local f, p = h * 6 - i, v * (1 - s)

	local q, t = v * (1 - f * s), v * (1 - (1 - f) * s)

	i = i % 6
	if i == 0 then return Color3.new(v, t, p)
	elseif i == 1 then return Color3.new(q, v, p)
	elseif i == 2 then return Color3.new(p, v, t)
	elseif i == 3 then return Color3.new(p, q, v)
	elseif i == 4 then return Color3.new(t, p, v)
	else return Color3.new(v, p, q) end
end

function isAlive(character)
	if not character then return false end
	local hum = character:FindFirstChildOfClass("Humanoid")
	return hum and hum.Health > 0
end

function healthColor(ratio)
	if ratio > 0.6 then return Color3.fromRGB(0, 255, 80)
	elseif ratio > 0.3 then return Color3.fromRGB(255, 220, 0)
	else return Color3.fromRGB(255, 40, 40) end
end

function vehicleHealthColor(vh)
	if vh > 50 then return Color3.fromRGB(0, 255, 80)
	elseif vh > 25 then return Color3.fromRGB(255, 220, 0)
	else return Color3.fromRGB(255, 40, 40) end
end

function findVehicleFromSeat(seat, folders)
	local vehicle = seat.Parent
	while vehicle and not vehicle:IsA("Model") do vehicle = vehicle.Parent end
	if not vehicle then return nil end
	local anc = vehicle.Parent
	while anc do
		for i = 1, #folders do
			if anc == folders[i] then return vehicle end
		end
		anc = anc.Parent
	end
	return nil
end

vehicleRootCache = {}
function getVehicleRootPart(vehicle)
	local c = vehicleRootCache[vehicle]
	if c and tick() - c.t < VEHICLE_CACHE_TTL then return c.root end
	local root = vehicle:FindFirstChild("HumanoidRootPart")
	if not root then
		for _, ch in ipairs(vehicle:GetDescendants()) do
			if ch:IsA("BasePart") and (ch.Name == "HumanoidRootPart" or ch.Name == "RootPart") then
				root = ch
				break
			end
		end
		if not root then
			for _, ch in ipairs(vehicle:GetDescendants()) do
				if ch:IsA("BasePart") then
					root = ch
					break
				end
			end
		end
	end
	vehicleRootCache[vehicle] = { root = root, t = tick() }
	return root
end

vehicleHealthCache = {}
function getVehicleHealth(vehicle)
	local c = vehicleHealthCache[vehicle]
	if c and tick() - c.t < VEHICLE_CACHE_TTL then return c.h end
	local h, value = vehicle:FindFirstChild("Health"), nil

	if h and h:IsA("NumberValue") then
		value = h.Value
	else
		for _, ch in ipairs(vehicle:GetDescendants()) do
			if ch.Name == "Health" and ch:IsA("NumberValue") then
				value = ch.Value
				break
			end
		end
	end
	vehicleHealthCache[vehicle] = { h = value, t = tick() }
	return value
end

function ensurePlayerData(player)
	if ESP.playerData[player] then return ESP.playerData[player] end
	ESP.playerData[player] = {
		highlight = nil,
		boxLines = nil,
		infoTag = nil,
		nameText = nil,
		healthBar = nil,
		healthFill = nil,
		tracer = nil,
		versionText = nil,
	}
	return ESP.playerData[player]
end

function cleanupPlayerESP(player)
	local data = ESP.playerData[player]
	if not data then return end
	if data.highlight then pcall(function() data.highlight:Destroy() end) end
	if data.infoTag then pcall(function() data.infoTag:Destroy() end) end
	if data.boxLines then
		for i = 1, #data.boxLines do
			local l = data.boxLines[i]
			if l and l.Parent then pcall(function() l:Destroy() end) end
		end
	end
	if data.tracer and data.tracer.Parent then pcall(function() data.tracer:Destroy() end) end
	ESP.playerData[player] = nil
end

function clearAllPlayerESP()
	for player in pairs(ESP.playerData) do
		cleanupPlayerESP(player)
	end
end

function ensureVehicleData(vehicle)
	if ESP.vehicleData[vehicle] then return ESP.vehicleData[vehicle] end
	ESP.vehicleData[vehicle] = {
		highlight = nil,
		nameTag = nil,
		driverLabel = nil,
		nameLabel = nil,
		healthLabel = nil,
		distLabel = nil,
	}
	return ESP.vehicleData[vehicle]
end

function cleanupVehicleESP(vehicle)
	local data = ESP.vehicleData[vehicle]
	if not data then return end
	if data.highlight then pcall(function() data.highlight:Destroy() end) end
	if data.nameTag then pcall(function() data.nameTag:Destroy() end) end
	ESP.vehicleData[vehicle] = nil
	vehicleRootCache[vehicle] = nil
	vehicleHealthCache[vehicle] = nil
end

function clearAllVehicleESP()
	for vehicle in pairs(ESP.vehicleData) do
		cleanupVehicleESP(vehicle)
	end
end

function forceClearAllVisuals(cur)
	cur = cur or ESP
	for _, p in ipairs(Players:GetPlayers()) do
		local character = p.Character
		if character then
			for _, child in ipairs(character:GetDescendants()) do
				if child:IsA("BillboardGui") and child.Name:sub(1, 11) == "PlayerInfo_" then
					pcall(function() child:Destroy() end)
				elseif child:IsA("Highlight") and child.Name == "ESP_PlayerHL" then
					pcall(function() child:Destroy() end)
				end
			end
		end
	end
	local gs = workspace:FindFirstChild("Game Systems")
	if gs then
		for _, v in ipairs(gs:GetDescendants()) do
			if v:IsA("Highlight") and v.Name == "ESP_VehicleHL" then
				pcall(function() v:Destroy() end)
			elseif v:IsA("BillboardGui") and v.Name:sub(1, 12) == "VehicleInfo_" then
				pcall(function() v:Destroy() end)
			end
		end
	end
	if cur.mainScreenGui and cur.mainScreenGui.Parent then
		pcall(function() cur.mainScreenGui:Destroy() end)
	end
	cur.mainScreenGui = nil
	if cur.countGui and cur.countGui.Parent then
		pcall(function() cur.countGui:Destroy() end)
	end
	cur.countGui = nil
	cur.countLabel = nil
	for player in pairs(cur.playerData) do cur.playerData[player] = nil end
	for v in pairs(cur.vehicleData) do cur.vehicleData[v] = nil end
end

function ensureMainScreenGui()
	if ESP.mainScreenGui and ESP.mainScreenGui.Parent then return ESP.mainScreenGui end
	local gui = Instance.new("ScreenGui")
	gui.Name = "ESPMainOverlay"
	gui.ResetOnSpawn = false
	gui.IgnoreGuiInset = true
	gui.DisplayOrder = 100
	gui.Parent = CoreGui
	ESP.mainScreenGui = gui
	return gui
end

function createPlayerHighlight(player, character)
	local data = ensurePlayerData(player)
	if data.highlight and data.highlight.Parent == character then return data.highlight end
	if data.highlight then pcall(function() data.highlight:Destroy() end) end
	local hl = Instance.new("Highlight")
	hl.Name = "ESP_PlayerHL"
	hl.FillTransparency = 0.85
	hl.OutlineTransparency = 0
	hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	local ok = pcall(function() hl.Parent = character end)
	if not ok then
		pcall(function() hl:Destroy() end)
		return nil
	end
	data.highlight = hl
	return hl
end

function createPlayerBox(player)
	local data = ensurePlayerData(player)
	if data.boxLines and data.boxLines[1] and data.boxLines[1].Parent then
		return data.boxLines
	end
	local gui, lines = ensureMainScreenGui(), {}

	for i = 1, 8 do
		local l = Instance.new("Frame")
		l.Name = "BoxLine_" .. i .. "_" .. player.Name
		l.BackgroundColor3 = currentColor
		l.BorderSizePixel = 0
		l.AnchorPoint = Vector2.new(0.5, 0.5)
		l.Visible = false
		l.Parent = gui
		lines[i] = l
	end
	data.boxLines = lines
	return lines
end

function createPlayerInfoTag(player, character)
	local data = ensurePlayerData(player)
	if data.infoTag and data.infoTag.Parent then
		return data.infoTag, data.nameText, data.healthBar, data.healthFill, data.versionText
	end
	if data.infoTag then pcall(function() data.infoTag:Destroy() end) end
	local head = character:FindFirstChild("Head")
	if not head then return nil, nil, nil, nil, nil end
	local tagName = "PlayerInfo_" .. player.Name
	for _, child in ipairs(head:GetChildren()) do
		if child:IsA("BillboardGui") and child.Name == tagName then
			pcall(function() child:Destroy() end)
		end
	end

	local userCache = fetchAlienXUsers(ESP)
	local version = userCache[player.Name]
	local versionData = version and VERSION_TAGS[version]
	local isAlienX = versionData ~= nil

	local billboard = Instance.new("BillboardGui")
	billboard.Name = tagName
	billboard.Adornee = head
	if isAlienX and ESP.showAlienXTag then
		billboard.Size = UDim2.new(0, 220, 0, 60)
		billboard.StudsOffset = Vector3.new(0, 2.8, 0)
	else
		billboard.Size = UDim2.new(0, 180, 0, 44)
		billboard.StudsOffset = Vector3.new(0, 2.2, 0)
	end
	billboard.AlwaysOnTop = true
	billboard.MaxDistance = 50000
	local ok = pcall(function() billboard.Parent = head end)
	if not ok then
		pcall(function() billboard:Destroy() end)
		return nil, nil, nil, nil, nil
	end

	local container = Instance.new("Frame")
	container.Name = "Container"
	container.Size = UDim2.new(1, 0, 1, 0)
	container.BackgroundTransparency = 1
	container.Parent = billboard

	local layout = Instance.new("UIListLayout")
	layout.FillDirection = Enum.FillDirection.Vertical
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	layout.VerticalAlignment = Enum.VerticalAlignment.Bottom
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Padding = UDim.new(0, 2)
	layout.Parent = container

	local name = Instance.new("TextLabel")
	name.Name = "Name"
	name.Size = UDim2.new(1, 0, 0, 16)
	name.BackgroundTransparency = 1
	name.Text = player.Name
	name.TextColor3 = currentColor
	name.TextStrokeColor3 = Color3.new(0, 0, 0)
	name.TextStrokeTransparency = 0
	name.TextScaled = false
	name.Font = Enum.Font.GothamBold
	name.TextSize = 14
	name.LayoutOrder = 1
	name.Parent = container

	local versionLabel = nil
	if isAlienX and ESP.showAlienXTag then
		versionLabel = Instance.new("TextLabel")
		versionLabel.Name = "Version"
		versionLabel.Size = UDim2.new(1, 0, 0, 16)
		versionLabel.BackgroundTransparency = 1
		versionLabel.Text = versionData.tag
		versionLabel.TextColor3 = versionData.color
		versionLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
		versionLabel.TextStrokeTransparency = 0
		versionLabel.TextScaled = false
		versionLabel.Font = Enum.Font.GothamBold
		versionLabel.TextSize = 12
		versionLabel.LayoutOrder = 2
		versionLabel.Parent = container
	end

	local bar = Instance.new("Frame")
	bar.Name = "Bar"
	bar.AnchorPoint = Vector2.new(0.5, 0)
	bar.Position = UDim2.new(0.5, 0, 0, 0)
	bar.Size = UDim2.new(0.5, 0, 0, 4)
	bar.BackgroundColor3 = Color3.new(0, 0, 0)
	bar.BorderSizePixel = 0
	bar.ClipsDescendants = true
	bar.LayoutOrder = 3
	bar.Parent = container

	local barCorner = Instance.new("UICorner")
	barCorner.CornerRadius = UDim.new(0, 2)
	barCorner.Parent = bar

	local fill = Instance.new("Frame")
	fill.Name = "Fill"
	fill.AnchorPoint = Vector2.new(0, 0.5)
	fill.Position = UDim2.new(0, 0, 0.5, 0)
	fill.Size = UDim2.new(1, 0, 1, 0)
	fill.BackgroundColor3 = Color3.fromRGB(0, 255, 80)
	fill.BorderSizePixel = 0
	fill.Parent = bar

	local fillCorner = Instance.new("UICorner")
	fillCorner.CornerRadius = UDim.new(0, 2)
	fillCorner.Parent = fill

	data.infoTag = billboard
	data.nameText = name
	data.healthBar = bar
	data.healthFill = fill
	data.versionText = versionLabel

	return billboard, name, bar, fill, versionLabel
end

function createPlayerTracer(player)
	local data = ensurePlayerData(player)
	if data.tracer and data.tracer.Parent then return data.tracer end
	local gui, line = ensureMainScreenGui(), Instance.new("Frame")

	line.Name = "Tracer_" .. player.Name
	line.BackgroundColor3 = currentColor
	line.BorderSizePixel = 0
	line.AnchorPoint = Vector2.new(0.5, 0.5)
	line.Size = UDim2.new(0, 1, 0, 1)
	line.Visible = false
	line.Parent = gui
	data.tracer = line
	return line
end

function createVehicleHighlight(vehicle)
	local data = ensureVehicleData(vehicle)
	if data.highlight and data.highlight.Parent == vehicle then return data.highlight end
	if data.highlight then pcall(function() data.highlight:Destroy() end) end
	local hl = Instance.new("Highlight")
	hl.Name = "ESP_VehicleHL"
	hl.FillTransparency = 0.7
	hl.OutlineTransparency = 0
	hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	local ok = pcall(function() hl.Parent = vehicle end)
	if not ok then
		pcall(function() hl:Destroy() end)
		return nil
	end
	data.highlight = hl
	return hl
end

function createVehicleNameTag(vehicle, rootPart)
	local data = ensureVehicleData(vehicle)
	if data.nameTag and data.nameTag.Parent then
		return data.nameTag, data.driverLabel, data.nameLabel, data.healthLabel, data.distLabel
	end
	if data.nameTag then pcall(function() data.nameTag:Destroy() end) end
	local billboard = Instance.new("BillboardGui")
	billboard.Name = "VehicleInfo_" .. vehicle.Name
	billboard.Adornee = rootPart
	billboard.Size = UDim2.new(0, 260, 0, 90)
	billboard.StudsOffset = Vector3.new(0, 4, 0)
	billboard.AlwaysOnTop = true
	billboard.MaxDistance = 50000
	local ok = pcall(function() billboard.Parent = rootPart end)
	if not ok then
		pcall(function() billboard:Destroy() end)
		return nil, nil, nil, nil, nil
	end
	local container = Instance.new("Frame")
	container.Name = "Container"
	container.Size = UDim2.new(1, 0, 1, 0)
	container.BackgroundTransparency = 1
	container.Parent = billboard
	local layout = Instance.new("UIListLayout")
	layout.FillDirection = Enum.FillDirection.Vertical
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	layout.VerticalAlignment = Enum.VerticalAlignment.Bottom
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Parent = container
	local driverLabel = Instance.new("TextLabel")
	driverLabel.Name = "Driver"
	driverLabel.Size = UDim2.new(1, 0, 0, 17)
	driverLabel.BackgroundTransparency = 1
	driverLabel.TextColor3 = Color3.new(1, 1, 1)
	driverLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
	driverLabel.TextStrokeTransparency = 0
	driverLabel.Font = Enum.Font.GothamBold
	driverLabel.TextSize = 14
	driverLabel.LayoutOrder = 1
	driverLabel.Parent = container
	local nameLabel = Instance.new("TextLabel")
	nameLabel.Name = "Name"
	nameLabel.Size = UDim2.new(1, 0, 0, 18)
	nameLabel.BackgroundTransparency = 1
	nameLabel.TextColor3 = ESP.color
	nameLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
	nameLabel.TextStrokeTransparency = 0
	nameLabel.Font = Enum.Font.GothamBold
	nameLabel.TextSize = 14
	nameLabel.LayoutOrder = 2
	nameLabel.Parent = container
	local healthLabel = Instance.new("TextLabel")
	healthLabel.Name = "Health"
	healthLabel.Size = UDim2.new(1, 0, 0, 16)
	healthLabel.BackgroundTransparency = 1
	healthLabel.TextColor3 = Color3.fromRGB(0, 255, 80)
	healthLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
	healthLabel.TextStrokeTransparency = 0
	healthLabel.Font = Enum.Font.GothamBold
	healthLabel.TextSize = 13
	healthLabel.LayoutOrder = 3
	healthLabel.Parent = container
	local distLabel = Instance.new("TextLabel")
	distLabel.Name = "Distance"
	distLabel.Size = UDim2.new(1, 0, 0, 16)
	distLabel.BackgroundTransparency = 1
	distLabel.TextColor3 = Color3.new(1, 1, 1)
	distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
	distLabel.TextStrokeTransparency = 0
	distLabel.Font = Enum.Font.GothamBold
	distLabel.TextSize = 13
	distLabel.LayoutOrder = 4
	distLabel.Parent = container
	data.nameTag = billboard
	data.driverLabel = driverLabel
	data.nameLabel = nameLabel
	data.healthLabel = healthLabel
	data.distLabel = distLabel
	return billboard, driverLabel, nameLabel, healthLabel, distLabel
end

function createCountDisplay(cur)
	if cur.countGui then return end
	local gui = Instance.new("ScreenGui")
	gui.Name = "PlayerCountESP"
	gui.ResetOnSpawn = false
	gui.IgnoreGuiInset = true
	gui.Parent = CoreGui
	cur.countGui = gui
	local label = Instance.new("TextLabel")
	label.Name = "PlayerCount"
	label.Parent = gui
	label.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	label.BackgroundTransparency = 0.3
	label.BorderSizePixel = 0
	label.Position = UDim2.new(0.5, 0, 0, 40)
	label.Size = UDim2.new(0, 200, 0, 34)
	label.AnchorPoint = Vector2.new(0.5, 0)
	label.Font = Enum.Font.GothamBold
	label.TextSize = 16
	label.TextStrokeTransparency = 0.5
	label.TextColor3 = Color3.new(1, 1, 1)
	label.Text = "在线玩家: 0"
	label.Visible = false
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = label
	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.new(0, 0, 0)
	stroke.Thickness = 1.2
	stroke.Transparency = 0.5
	stroke.Parent = label
	local gradient = Instance.new("UIGradient")
	gradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
		ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 255, 0)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 0)),
		ColorSequenceKeypoint.new(0.75, Color3.fromRGB(0, 255, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255)),
	})
	gradient.Rotation = 90
	gradient.Parent = label
	cur.countLabel = label
end

function updatePlayerCount(cur)
	cur = cur or ESP
	if not cur.countGui then createCountDisplay(cur) end
	if not cur.countLabel then return end
	local count = 0
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= LP and isAlive(p.Character) then count = count + 1 end
	end
	cur.countLabel.Text = "在线玩家: " .. count
	cur.countLabel.Visible = cur.enabled.count and cur.enabled.master
end

function setBoxLine(lines, idx, cx, cy, lw, lh)
	local l = lines[idx]
	l.Position = UDim2.new(0, cx, 0, cy)
	l.Size = UDim2.new(0, lw, 0, lh)
	l.BackgroundColor3 = currentColor
	l.Visible = true
end

function hideBoxLines(lines)
	for i = 1, 8 do
		local l = lines[i]
		if l and l.Parent then l.Visible = false end
	end
end

function renderBox(lines, hrpCF, headSizeY, cam)
	local scale = headSizeY / 2
	local sizeX, sizeY = scale * 2, scale * 3

	local T1, T2, T3, T4, B1, B2, B3, B4 = cam:WorldToViewportPoint((hrpCF * CFrame.new(-sizeX, sizeY, -sizeX)).p), cam:WorldToViewportPoint((hrpCF * CFrame.new(sizeX, sizeY, -sizeX)).p), cam:WorldToViewportPoint((hrpCF * CFrame.new(sizeX, sizeY, sizeX)).p), cam:WorldToViewportPoint((hrpCF * CFrame.new(-sizeX, sizeY, sizeX)).p), cam:WorldToViewportPoint((hrpCF * CFrame.new(-sizeX, -sizeY, -sizeX)).p), cam:WorldToViewportPoint((hrpCF * CFrame.new(sizeX, -sizeY, -sizeX)).p), cam:WorldToViewportPoint((hrpCF * CFrame.new(sizeX, -sizeY, sizeX)).p), cam:WorldToViewportPoint((hrpCF * CFrame.new(-sizeX, -sizeY, sizeX)).p)







	local allOn = T1.Z > 0 and T2.Z > 0 and T3.Z > 0 and T4.Z > 0
		and B1.Z > 0 and B2.Z > 0 and B3.Z > 0 and B4.Z > 0
	if not allOn then return false end
	local minX, maxX, minY, maxY = math.min(T1.X, T2.X, T3.X, T4.X, B1.X, B2.X, B3.X, B4.X), math.max(T1.X, T2.X, T3.X, T4.X, B1.X, B2.X, B3.X, B4.X), math.min(T1.Y, T2.Y, T3.Y, T4.Y, B1.Y, B2.Y, B3.Y, B4.Y), math.max(T1.Y, T2.Y, T3.Y, T4.Y, B1.Y, B2.Y, B3.Y, B4.Y)



	local w, h = maxX - minX, maxY - minY

	if w <= 10 or h <= 10 then return false end
	local cornerLen = math.min(w, h) * 0.22
	if cornerLen < 7 then cornerLen = 7 elseif cornerLen > 18 then cornerLen = 18 end
	setBoxLine(lines, 1, minX + cornerLen / 2, minY, cornerLen, 2)
	setBoxLine(lines, 2, minX, minY + cornerLen / 2, 2, cornerLen)
	setBoxLine(lines, 3, maxX - cornerLen / 2, minY, cornerLen, 2)
	setBoxLine(lines, 4, maxX, minY + cornerLen / 2, 2, cornerLen)
	setBoxLine(lines, 5, minX + cornerLen / 2, maxY, cornerLen, 2)
	setBoxLine(lines, 6, minX, maxY - cornerLen / 2, 2, cornerLen)
	setBoxLine(lines, 7, maxX - cornerLen / 2, maxY, cornerLen, 2)
	setBoxLine(lines, 8, maxX, maxY - cornerLen / 2, 2, cornerLen)
	return true
end

function renderTracer(line, pos, onScreen, cam)
	if not onScreen or pos.Z <= 0 then
		line.Visible = false
		return
	end
	local viewportSize = cam.ViewportSize
	local fromX, fromY = viewportSize.X * 0.5, viewportSize.Y

	local dx, dy = pos.X - fromX, pos.Y - fromY

	local len = math.sqrt(dx * dx + dy * dy)
	if len <= 1 then
		line.Visible = false
		return
	end
	local angle, midX, midY = math.atan2(dy, dx) - math.pi / 2, (fromX + pos.X) * 0.5, (fromY + pos.Y) * 0.5


	line.Position = UDim2.new(0, midX, 0, midY)
	line.Rotation = math.deg(angle)
	line.Size = UDim2.new(0, 1, 0, len)
	line.BackgroundColor3 = currentColor
	line.Visible = true
end

function destroyPlayerInfoTag(data)
	if data.infoTag then
		pcall(function() data.infoTag:Destroy() end)
		data.infoTag = nil
		data.nameText = nil
		data.healthBar = nil
		data.healthFill = nil
		data.versionText = nil
	end
end

function destroyVehicleNameTag(data)
	if data.nameTag then
		pcall(function() data.nameTag:Destroy() end)
		data.nameTag = nil
		data.driverLabel = nil
		data.nameLabel = nil
		data.healthLabel = nil
		data.distLabel = nil
	end
end

function updateHealthBar(data, humanoid)
	if not data or not data.healthFill or not data.healthFill.Parent then return end
	local maxH = humanoid.MaxHealth
	local ratio = maxH > 0 and math.clamp(humanoid.Health / maxH, 0, 1) or 0
	data.healthFill.Size = UDim2.new(ratio, 0, 1, 0)
	data.healthFill.BackgroundColor3 = healthColor(ratio)
end

framePlayerVehicle, framePassengerMap, frameVehicleFolders, frameSeenVehicles = {}, {}, {}, {}




function updatePlayerVisuals(lpPos)
	for _, p in ipairs(Players:GetPlayers()) do
		if p == LP then
			if ESP.playerData[p] then cleanupPlayerESP(p) end
		else
			local character = p.Character
			local hrp, head, humanoid, inVehicle = character and character:FindFirstChild("HumanoidRootPart"), character and character:FindFirstChild("Head"), character and character:FindFirstChildOfClass("Humanoid"), framePlayerVehicle[p] ~= nil



			local alive = character and hrp and head and humanoid and humanoid.Health > 0
			local valid, data = alive and not inVehicle and lpPos ~= nil and (hrp.Position - lpPos).Magnitude <= ESP_RANGE, ensurePlayerData(p)


			if inVehicle and data.infoTag then
				destroyPlayerInfoTag(data)
			end

			if ESP.enabled.chams and valid then
				local hl = createPlayerHighlight(p, character)
				if hl then
					hl.FillColor = currentColor
					hl.OutlineColor = currentColor
					hl.FillTransparency = 0.75
					hl.OutlineTransparency = 0
				end
			else
				if data.highlight then
					pcall(function() data.highlight:Destroy() end)
					data.highlight = nil
				end
			end

			local wantNames, wantHealth = ESP.enabled.names and valid, ESP.enabled.health and valid

			if wantNames or wantHealth then
				createPlayerInfoTag(p, character)
				if data.infoTag and (not data.healthBar or not data.healthBar.Parent
					or not data.healthFill or not data.healthFill.Parent) then
					destroyPlayerInfoTag(data)
					createPlayerInfoTag(p, character)
				end
				if data.infoTag then
					if ESP.enabled.names then
						data.nameText.Visible = true
						data.nameText.TextColor3 = (p.TeamColor and p.TeamColor.Color) or currentColor
					else
						data.nameText.Visible = false
					end
					if ESP.enabled.health then
						data.healthBar.Visible = true
						updateHealthBar(data, humanoid)
					else
						data.healthBar.Visible = false
					end
				end
			else
				if data.infoTag then
					destroyPlayerInfoTag(data)
				end
			end

			local wantBox, wantTracer, pos, onScreen = ESP.enabled.boxes and valid and head, ESP.enabled.tracers and valid and hrp, nil, nil


			if wantBox or wantTracer then
				pos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
			end
			if wantBox then
				local lines = createPlayerBox(p)
				if pos.Z > 0 and renderBox(lines, hrp.CFrame, head.Size.Y, Camera) then
				else
					hideBoxLines(lines)
				end
			else
				if data.boxLines then hideBoxLines(data.boxLines) end
			end
			if wantTracer then
				local line = createPlayerTracer(p)
				renderTracer(line, pos, onScreen, Camera)
			else
				if data.tracer and data.tracer.Parent then data.tracer.Visible = false end
			end
		end
	end

	for p in pairs(ESP.playerData) do
		if not p.Parent then cleanupPlayerESP(p) end
	end
end

function updateVehicleVisuals()
	local camPos = Camera.CFrame.Position
	for k in pairs(frameSeenVehicles) do frameSeenVehicles[k] = nil end

	for i = 1, #frameVehicleFolders do
		for _, vehicle in ipairs(frameVehicleFolders[i]:GetChildren()) do
			if vehicle:IsA("Model") then
				frameSeenVehicles[vehicle] = true
				local rootPart = getVehicleRootPart(vehicle)
				if not rootPart or not rootPart.Parent then
					cleanupVehicleESP(vehicle)
				else
					local passengerData = framePassengerMap[vehicle]
					local driverPlayer, distance = passengerData and passengerData.driver, (rootPart.Position - camPos).Magnitude

					local inRange, hasPassenger, data = distance <= ESP_RANGE, passengerData ~= nil, ensureVehicleData(vehicle)



					if ESP.enabled.vehicleChams and inRange and hasPassenger then
						local hl = createVehicleHighlight(vehicle)
						if hl then
							hl.FillColor = ESP.color
							hl.OutlineColor = ESP.color
							hl.FillTransparency = 0.7
							hl.OutlineTransparency = 0
						end
					else
						if data.highlight then
							pcall(function() data.highlight:Destroy() end)
							data.highlight = nil
						end
					end

					local wantText = inRange and (ESP.enabled.vehicleNames or ESP.enabled.vehicleHealth or ESP.enabled.vehicleDistance)
					if wantText then
						local _, dl, nl, hl, dst = createVehicleNameTag(vehicle, rootPart)
						if dl then
							if driverPlayer then
								dl.Text = "[驾驶员] " .. driverPlayer.Name
								dl.TextColor3 = (driverPlayer.TeamColor and driverPlayer.TeamColor.Color) or Color3.new(1, 1, 1)
								dl.Visible = true
							else
								dl.Visible = false
							end
						end
						if nl then
							if ESP.enabled.vehicleNames then
								nl.Text = "◆ " .. vehicle.Name
								nl.TextColor3 = ESP.color
								nl.Visible = true
							else
								nl.Visible = false
							end
						end
						if hl then
							local vh = getVehicleHealth(vehicle)
							if ESP.enabled.vehicleHealth and vh then
								hl.Text = "[HP: " .. math.floor(vh) .. "]"
								hl.TextColor3 = vehicleHealthColor(vh)
								hl.Visible = true
							else
								hl.Visible = false
							end
						end
						if dst then
							if ESP.enabled.vehicleDistance then
								dst.Text = "[" .. math.floor(distance) .. "m]"
								dst.Visible = true
							else
								dst.Visible = false
							end
						end
					else
						if data.nameTag then
							destroyVehicleNameTag(data)
						end
					end
				end
			end
		end
	end

	for v in pairs(ESP.vehicleData) do
		if not v.Parent or not frameSeenVehicles[v] then
			cleanupVehicleESP(v)
		end
	end
end

function updateVisuals()
	if not ESP.enabled.master then
		clearAllPlayerESP()
		clearAllVehicleESP()
		return
	end
	local playerFeatures = ESP.enabled.boxes or ESP.enabled.names or ESP.enabled.health
		or ESP.enabled.tracers or ESP.enabled.chams
	local vehicleFeatures = ESP.enabled.vehicleChams or ESP.enabled.vehicleNames
		or ESP.enabled.vehicleHealth or ESP.enabled.vehicleDistance
	if not playerFeatures and not vehicleFeatures then return end

	for i = 1, #frameVehicleFolders do frameVehicleFolders[i] = nil end
	local gs = workspace:FindFirstChild("Game Systems")
	if gs then
		for i = 1, #VEHICLE_WORKSPACES do
			local ws = gs:FindFirstChild(VEHICLE_WORKSPACES[i])
			if ws then frameVehicleFolders[#frameVehicleFolders + 1] = ws end
		end
	end

	for k in pairs(framePlayerVehicle) do framePlayerVehicle[k] = nil end
	if vehicleFeatures then
		for k in pairs(framePassengerMap) do framePassengerMap[k] = nil end
	end
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= LP then
			local character = p.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			if humanoid and humanoid.Health > 0 then
				local seat = humanoid.SeatPart
				if seat then
					local vehicle = findVehicleFromSeat(seat, frameVehicleFolders)
					if vehicle then
						framePlayerVehicle[p] = vehicle
						if vehicleFeatures then
							local entry = framePassengerMap[vehicle]
							if not entry then
								entry = {driver = nil, count = 0}
								framePassengerMap[vehicle] = entry
							end
							entry.count += 1
							if not entry.driver then entry.driver = p end
						end
					end
				end
			end
		end
	end

	local lpRoot = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
	local lpPos = lpRoot and lpRoot.Position

	if playerFeatures then
		updatePlayerVisuals(lpPos)
	end
	if vehicleFeatures then
		updateVehicleVisuals()
	end
end

visualAccumulator = 0
ESP.mainConn = RunService.RenderStepped:Connect(function(dt)
	hue = (hue + colorSpeed * dt) % 1
	currentColor = hsvToRgb(hue, 1, 1)
	visualAccumulator += dt
	if visualAccumulator < VISUAL_INTERVAL then return end
	visualAccumulator = visualAccumulator % VISUAL_INTERVAL

	local okFrame = pcall(updateVisuals)
	if not okFrame then
		pcall(forceClearAllVisuals, ESP)
	end

	ESP.frameCount += 1
	if ESP.frameCount % 30 == 0 and ESP.enabled.count and ESP.enabled.master then
		pcall(updatePlayerCount, ESP)
	end
end)

function setupPlayerHandler(player)
	if player == LP then return end
	local conn = player.CharacterAdded:Connect(function()
		local data = ESP.playerData[player]
		if data then
			if data.highlight then pcall(function() data.highlight:Destroy() end); data.highlight = nil end
			if data.infoTag then destroyPlayerInfoTag(data) end
		end
	end)
	ESP.characterConns[player] = conn
end

for _, p in ipairs(Players:GetPlayers()) do setupPlayerHandler(p) end
ESP.playerAddedConn = Players.PlayerAdded:Connect(setupPlayerHandler)
ESP.playerRemovingConn = Players.PlayerRemoving:Connect(function(p)
	if ESP.playerData[p] then cleanupPlayerESP(p) end
	if ESP.characterConns and ESP.characterConns[p] then
		pcall(function() ESP.characterConns[p]:Disconnect() end)
		ESP.characterConns[p] = nil
	end
end)

ensureMainScreenGui()

EspTab:Toggle({
	Title = "透视总开关",
	Value = false,
	Callback = function(t)
		local cur = _G.AlienX_ESP or ESP
		cur.enabled.master = t
		if not t then
			forceClearAllVisuals(cur)
		end
	end
})

EspTab:Toggle({
	Title = "名字透视",
	Value = false,
	Callback = function(t)
		local cur = _G.AlienX_ESP or ESP
		cur.enabled.names = t
		if not t then
			for player in pairs(cur.playerData) do
				local d = cur.playerData[player]
				if d and d.nameText then d.nameText.Visible = false end
				if not cur.enabled.health and d and d.infoTag then
					destroyPlayerInfoTag(d)
				end
			end
		end
	end
})

EspTab:Toggle({
	Title = "AlienX用户透视",
	Value = false,
	Callback = function(t)
		local cur = _G.AlienX_ESP or ESP
		cur.showAlienXTag = t
		if t then
			fetchAlienXUsers(cur)
		end
		for player in pairs(cur.playerData) do
			if player ~= LP then
				local d = cur.playerData[player]
				if d and d.infoTag then destroyPlayerInfoTag(d) end
			end
		end
	end
})

EspTab:Toggle({
	Title = "方框透视",
	Value = false,
	Callback = function(t)
		local cur = _G.AlienX_ESP or ESP
		cur.enabled.boxes = t
		if not t then
			for player in pairs(cur.playerData) do
				local d = cur.playerData[player]
				if d and d.boxLines then hideBoxLines(d.boxLines) end
			end
		end
	end
})

EspTab:Toggle({
	Title = "射线透视",
	Value = false,
	Callback = function(t)
		local cur = _G.AlienX_ESP or ESP
		cur.enabled.tracers = t
		if not t then
			for player in pairs(cur.playerData) do
				local d = cur.playerData[player]
				if d and d.tracer and d.tracer.Parent then d.tracer.Visible = false end
			end
		end
	end
})

EspTab:Toggle({
	Title = "血条透视",
	Value = false,
	Callback = function(t)
		local cur = _G.AlienX_ESP or ESP
		cur.enabled.health = t
		if not t then
			for player in pairs(cur.playerData) do
				local d = cur.playerData[player]
				if d and d.healthBar then d.healthBar.Visible = false end
				if not cur.enabled.names and d and d.infoTag then
					destroyPlayerInfoTag(d)
				end
			end
		end
	end
})

EspTab:Toggle({
	Title = "模型透视",
	Value = false,
	Callback = function(t)
		local cur = _G.AlienX_ESP or ESP
		cur.enabled.chams = t
		if not t then
			for player in pairs(cur.playerData) do
				local d = cur.playerData[player]
				if d and d.highlight then
					pcall(function() d.highlight:Destroy() end)
					d.highlight = nil
				end
			end
		end
	end
})

EspTab:Toggle({
	Title = "载具高光",
	Value = false,
	Callback = function(t)
		local cur = _G.AlienX_ESP or ESP
		cur.enabled.vehicleChams = t
		if not t then
			for v in pairs(cur.vehicleData) do
				local d = cur.vehicleData[v]
				if d and d.highlight then
					pcall(function() d.highlight:Destroy() end)
					d.highlight = nil
				end
			end
		end
	end
})

EspTab:Toggle({
	Title = "载具名称",
	Value = false,
	Callback = function(t)
		local cur = _G.AlienX_ESP or ESP
		cur.enabled.vehicleNames = t
		if not t then
			for v in pairs(cur.vehicleData) do
				local d = cur.vehicleData[v]
				if d and d.nameTag then destroyVehicleNameTag(d) end
			end
		end
	end
})

EspTab:Toggle({
	Title = "载具血量",
	Value = false,
	Callback = function(t)
		local cur = _G.AlienX_ESP or ESP
		cur.enabled.vehicleHealth = t
	end
})

EspTab:Toggle({
	Title = "载具距离",
	Value = false,
	Callback = function(t)
		local cur = _G.AlienX_ESP or ESP
		cur.enabled.vehicleDistance = t
	end
})

EspTab:Toggle({
	Title = "显示人数",
	Value = false,
	Callback = function(t)
		local cur = _G.AlienX_ESP or ESP
		cur.enabled.count = t
		if t and cur.enabled.master then
			pcall(updatePlayerCount, cur)
		elseif cur.countLabel then
			cur.countLabel.Visible = false
		end
	end
})

colorMap = {
	["白色"] = Color3.fromRGB(255, 255, 255),
	["红色"] = Color3.fromRGB(255, 0, 0),
	["绿色"] = Color3.fromRGB(0, 255, 0),
	["蓝色"] = Color3.fromRGB(0, 0, 255),
	["黄色"] = Color3.fromRGB(255, 255, 0),
	["紫色"] = Color3.fromRGB(255, 0, 255),
	["青色"] = Color3.fromRGB(0, 255, 255),
}

EspTab:Dropdown({
	Title = "载具颜色",
	Values = {"白色", "红色", "绿色", "蓝色", "黄色", "紫色", "青色"},
	Value = "白色",
	Callback = function(v)
		local cur = _G.AlienX_ESP or ESP
		cur.color = colorMap[v]
	end
})


AssistTab:Section({Title = "辅助设置"})

AssistTab:Button({
    Title = "删除摔落伤害",
    Callback = function()
        game:GetService("ReplicatedStorage").ACS_Engine.Events.FDMG:Destroy()
    end
})

showNameEnabled, showNameThread = false, nil

AssistTab:Toggle({
    Title = "不显示名字",
    Value = false,
    Callback = function(s)
        showNameEnabled = s
        
        if s then
            if showNameThread then
                task.cancel(showNameThread)
                showNameThread = nil
            end
            
            showNameThread = task.spawn(function()
                while showNameEnabled do
                    pcall(function()
                        game:GetService("ReplicatedStorage").ACS_Engine.Events.Stance:FireServer(1, 0)
                    end)
                    task.wait(0.1)
                end
            end)
        else
            if showNameThread then
                task.cancel(showNameThread)
                showNameThread = nil
            end
        end
    end
})

deleteDoorsEnabled, deleteDoorsThread = false, nil

AssistTab:Toggle({
    Title = "删除门",
    Value = false,
    Callback = function(state)
        deleteDoorsEnabled = state
        
        if state then
            deleteDoorsThread = task.spawn(function()
                while deleteDoorsEnabled do
                    if _.tycoon then
                        _.tycoon = _.tycoon:FindFirstChild("Tycoons")
                        if _.tycoon then
                            for _, tycoon in ipairs(_.tycoon:GetChildren()) do
                                local purchasedObjects = tycoon:FindFirstChild("PurchasedObjects")
                                if purchasedObjects then
                                    for _, obj in ipairs(purchasedObjects:GetChildren()) do
                                        local lowerName = obj.Name:lower()
                                        if lowerName:match("door") or lowerName:match("gate") then
                                            pcall(function() obj:Destroy() end)
                                        end
                                    end
                                end
                            end
                        end
                    end
                    task.wait(10)
                end
            end)
        else
            if deleteDoorsThread then
                task.cancel(deleteDoorsThread)
                deleteDoorsThread = nil
            end
        end
    end
})

deleteGridEnabled, deleteGridThread = false, nil

AssistTab:Toggle({
    Title = "删除电网",
    Value = false,
    Callback = function(state)
        deleteGridEnabled = state
        
        if state then
            deleteGridThread = task.spawn(function()
                while deleteGridEnabled do
                    local tycoons = workspace.Tycoon:FindFirstChild("Tycoons")
                    if tycoons then
                        for _, base in ipairs(tycoons:GetChildren()) do
                            local purchased = base:FindFirstChild("PurchasedObjects")
                            if purchased then
                                local baseWalls = purchased:FindFirstChild("Base Walls")
                                if baseWalls then
                                    local collision = baseWalls:FindFirstChild("Collision")
                                    if collision then
                                        for _, child in ipairs(collision:GetChildren()) do
                                            if child.Name == "MeshNet" then
                                                pcall(function() child:Destroy() end)
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                    task.wait(10)
                end
            end)
        else
            if deleteGridThread then
                task.cancel(deleteGridThread)
                deleteGridThread = nil
            end
        end
    end
})

connection = nil
AssistTab:Toggle({
    Title = "交互按钮无CD",
    Value = false,
    Callback = function(t)
        if t then
            if not connection then
                connection = game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(prompt)
                    prompt.HoldDuration = 0.000000000000000001
                end)
            end
        else
            if connection then
                connection:Disconnect()
                connection = nil
            end
        end
    end
})

AssistTab:Toggle({
    Title = "无限跳跃",
    Value = false,
    Callback = function(s)
        if IJ then IJ:Disconnect() end
        if s then
            IJ = _.RunService.RenderStepped:Connect(function()
                if (_.uis:IsKeyDown(Enum.KeyCode.Space) or Plr.Character:FindFirstChildOfClass("Humanoid") and Plr.Character:FindFirstChildOfClass("Humanoid").Jump) 
                and Plr.Character and Plr.Character:FindFirstChildOfClass("Humanoid") then
                    Plr.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        end
    end
})

conn,enabled,lastcf = nil, nil, nil
AssistTab:Toggle({
    Title="原地重生",
    Value=false,
    Callback=function(v)
        enabled=v
        if v then
            if conn then conn:Disconnect() end
            conn=game.Players.LocalPlayer.CharacterAdded:Connect(function(c)
                local r=c:WaitForChild("HumanoidRootPart")
                if enabled and lastcf then
                    for i=1,10 do
                        r.CFrame=lastcf
                        r.AssemblyLinearVelocity=Vector3.zero
                        r.AssemblyAngularVelocity=Vector3.zero
                        game:GetService("RunService").Heartbeat:Wait()
                    end
                end
                c:FindFirstChildOfClass("Humanoid").Died:Connect(function()
                    if enabled then lastcf=r.CFrame end
                end)
            end)
            if game.Players.LocalPlayer.Character then
                if _.humanoid then _.humanoid.Died:Connect(function() if enabled then lastcf=game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame end end) end
            end
        else
            if conn then conn:Disconnect() conn=nil end
            lastcf=nil
        end
    end
})

autoSkipEnabled, skipConnections = false, {}

AssistTab:Toggle({
    Title = "跳过击杀界面",
    Value = false,
    Callback = function(state)
        autoSkipEnabled = state
        for _, c in ipairs(skipConnections) do c:Disconnect() end
        skipConnections = {}
        if not state then return end

        local evt = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("KillCamSkipEvent")

        local function setup(char)
            local conn = char:WaitForChild("Humanoid").Died:Connect(function()
                if autoSkipEnabled then
                    task.wait(0.3)
                    pcall(function()
                        evt:FireServer()
                    end)
                end
            end)
            table.insert(skipConnections, conn)
        end

        if Plr.Character then setup(Plr.Character) end
        table.insert(skipConnections, Plr.CharacterAdded:Connect(setup))
    end
})

AssistTab:Button({
    Title = "重置人物",
    Callback = function()
        local StarterGui = game:GetService("StarterGui")

        if _.humanoid then
            _.humanoid.Health = 0
        else
            StarterGui:SetCore("ResetButtonCallback", true)
        end
    end
})

AimTab:Section({Title = "自瞄设置"})

Camera = workspace.CurrentCamera
Plr = game.Players.LocalPlayer
fov, maxDistance, autoAimEnabled, masterAimSwitch, fovVisible, ignoreCover, aimTarget, aimPosition, rainbowEnabled, ToggleButton, buttonPosition, aimWhitelist = 0, 0, false, false, false, false, "敌对", "Head", false, nil, UDim2.new(0, 10, 0, 10), {}

aimWhitelistDropdown = AimTab:Dropdown({
    Title = "自瞄白名单",
    Values = {},
    Multi = true,
    AllowNone = true,
    Callback = function(selected)
        aimWhitelist = {}
        for _, v in pairs(selected) do
            table.insert(aimWhitelist, WhitelistManager:GetPlayerName(v))
        end
    end
})

WhitelistManager:RegisterRefreshCallback("Aim", function(list)
    aimWhitelistDropdown:Refresh(list)
end)

FOVring = Drawing.new("Circle")
FOVring.Visible = false
FOVring.Thickness = 0.5
FOVring.Color = Color3.new(1, 1, 1)
FOVring.Filled = false
FOVring.Radius = 1
FOVring.Position = workspace.CurrentCamera.ViewportSize / 2

AimTab:Toggle({
    Title="玩家自瞄",
    Value=false,
    Callback=function(t)
        masterAimSwitch=t
        autoAimEnabled=t
        if ToggleButton then ToggleButton.Visible=masterAimSwitch end
        FOVring.Visible=masterAimSwitch and fovVisible
    end
})

AimTab:Toggle({
    Title="显示范围",
    Value=false,
    Callback=function(t)
        fovVisible=t
        FOVring.Visible=masterAimSwitch and autoAimEnabled and fovVisible
    end
})

AimTab:Toggle({
    Title="掩体不瞄",
    Value=false,
    Callback=function(t)
        ignoreCover=t
    end
})

AimTab:Slider({
    Title="自瞄范围",
    Value={Min=0,Max=200,Default=50},
    Callback=function(v)
        fov = tonumber(v) or 0
        FOVring.Radius = (fov > 0) and fov or 1
    end
})

AimTab:Slider({
    Title="自瞄距离",
    Value={Min=0,Max=12000,Default=0},
    Callback=function(v)
        maxDistance = tonumber(v) or 0
    end
})

AimTab:Slider({
    Title="自瞄圈粗细",
    Value={Min=0.5,Max=1,Default=0.5},
    Callback=function(v)
        FOVring.Thickness = v
    end
})

AimTab:Dropdown({
    Title="选择自瞄目标",
    Values={"敌对","全部"},
    Value="敌对",
    Callback=function(d)
        aimTarget=d
    end
})

AimTab:Dropdown({
    Title="选择自瞄位置",
    Values={"头部","躯干"},
    Value="头部",
    Callback=function(d)
        aimPosition = d=="头部" and "Head" or "Torso"
    end
})

AimTab:Dropdown({
    Title="选择圈的颜色",
    Values={"红","黄","蓝","绿","青","紫","彩虹"},
    Value="彩虹",
    Callback=function(d)
        if d=="彩虹" then
            rainbowEnabled=true
        else
            rainbowEnabled=false
            local colors={
                ["红"]=Color3.new(1,0,0),
                ["黄"]=Color3.new(1,1,0),
                ["蓝"]=Color3.new(0,0,1),
                ["绿"]=Color3.new(0,1,0),
                ["青"]=Color3.new(0,1,1),
                ["紫"]=Color3.new(1,0,1)
            }
            FOVring.Color=colors[d]
        end
    end
})

local function hsvToRgb(h,s,v)
    local r, g, b, i = nil, nil, nil, math.floor(h*6)
    local f, p = h*6-i, v*(1-s)
    local q, t = v*(1-f*s), v*(1-(1-f)*s)
    i=i%6
    if i==0 then r,g,b=v,t,p
    elseif i==1 then r,g,b=q,v,p
    elseif i==2 then r,g,b=p,v,t
    elseif i==3 then r,g,b=p,q,v
    elseif i==4 then r,g,b=t,p,v
    elseif i==5 then r,g,b=v,p,q end
    return Color3.new(r,g,b)
end

function createToggleButton()
    local ScreenGui=Instance.new("ScreenGui")
    ScreenGui.Name="AlienXAimToggle"
    ScreenGui.Parent=game:GetService("CoreGui")

    ToggleButton=Instance.new("ImageButton")
    ToggleButton.Size=UDim2.new(0,40,0,40)
    ToggleButton.Position=buttonPosition
    ToggleButton.BackgroundTransparency=1
    ToggleButton.Image="rbxassetid://7733992469"
    ToggleButton.Visible=false
    ToggleButton.Parent=ScreenGui

    local dragging, dragStart, buttonStart = false, nil, nil

    ToggleButton.InputBegan:Connect(function(input)
        if input.UserInputType==Enum.UserInputType.MouseButton1 then
            dragging=true
            dragStart=input.Position
            buttonStart=ToggleButton.Position
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType==Enum.UserInputType.MouseMovement then
            local delta=input.Position-dragStart
            ToggleButton.Position=UDim2.new(buttonStart.X.Scale,buttonStart.X.Offset+delta.X,buttonStart.Y.Scale,buttonStart.Y.Offset+delta.Y)
        end
    end)

    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType==Enum.UserInputType.MouseButton1 then
            dragging=false
        end
    end)

    ToggleButton.MouseButton1Click:Connect(function()
        if masterAimSwitch then
            autoAimEnabled=not autoAimEnabled
            AimTab:FindToggle("玩家自瞄"):SetValue(autoAimEnabled)
            FOVring.Visible=autoAimEnabled and fovVisible
        end
    end)

    local hue=0
    game:GetService("RunService").RenderStepped:Connect(function()
        if ToggleButton.Visible then
            if autoAimEnabled then
                hue=(hue+0.005)%1
                ToggleButton.ImageColor3=hsvToRgb(hue,1,1)
            else
                ToggleButton.ImageColor3=Color3.new(1,1,1)
            end
        end
    end)
end
createToggleButton()

game:GetService("UserInputService").InputBegan:Connect(function(input,gp)
    if input.KeyCode==Enum.KeyCode.LeftAlt and masterAimSwitch then
        autoAimEnabled=not autoAimEnabled
        AimTab:FindToggle("玩家自瞄"):SetValue(autoAimEnabled)
        FOVring.Visible=autoAimEnabled and fovVisible
    end
end)

function getClosestPlayerInFOV(trg_part)
    if not (masterAimSwitch and autoAimEnabled) then return nil end
    local nearest, last, center, fovNum, maxDistNum = nil,math.huge, _.Camera.ViewportSize/2, (fov>0) and fov or 1, tonumber(maxDistance) or 0

    for _,p in ipairs(game:GetService("Players"):GetPlayers()) do
        if p~=Plr and (aimTarget=="全部" or p.TeamColor~=Plr.TeamColor) and not table.find(aimWhitelist, p.Name) then
            local char=p.Character
            if char then
                local hum, part = char:FindFirstChildOfClass("Humanoid"), char:FindFirstChild(trg_part)
                if part and hum and hum.Health>0 then
                    local pos,vis=Camera:WorldToViewportPoint(part.Position)
                    local dist=(Vector2.new(pos.X,pos.Y)-center).Magnitude
                    if vis and dist<last and dist<fovNum then
                        if (part.Position-Camera.CFrame.Position).Magnitude<=maxDistNum then
                            if not ignoreCover or #Camera:GetPartsObscuringTarget({part.Position},{char,Plr.Character})==0 then
                                last=dist
                                nearest=p
                            end
                        end
                    end
                end
            end
        end
    end
    return nearest
end

game:GetService("RunService").RenderStepped:Connect(function()
    FOVring.Position=workspace.CurrentCamera.ViewportSize/2
    FOVring.Radius = (fov > 0) and fov or 1

    if masterAimSwitch and autoAimEnabled then
        local target=getClosestPlayerInFOV(aimPosition)
        if target and target.Character:FindFirstChild(aimPosition) then
            workspace.CurrentCamera.CFrame=CFrame.new(
                workspace.CurrentCamera.CFrame.Position,
                target.Character[aimPosition].Position
            )
        end
    end

    if rainbowEnabled then
        local t=tick()*2
        FOVring.Color=Color3.new(
            math.abs(math.sin(t)),
            math.abs(math.sin(t+2*math.pi/3)),
            math.abs(math.sin(t+4*math.pi/3))
        )
    end
end)

AttackTab:Section({Title = "RPG设置"})

do
    local cameraSwitchEnabled, cameraSwitchThread, currentRocket, checkedRockets, player, camera, switching, fireDisappearTime, fireChecked = false, nil, nil, {}, game:GetService("Players").LocalPlayer, workspace.CurrentCamera, false, 0, false









    local function getRockets()
        local rockets, visualRockets = {}, workspace:FindFirstChild("VisualRockets")

        if not visualRockets then return rockets end
        for _, rocket in ipairs(visualRockets:GetChildren()) do
            if string.match(rocket.Name, player.Name) then
                table.insert(rockets, rocket)
            end
        end
        return rockets
    end

    local function getFire(rocket)
        local mainPart = rocket:FindFirstChild("MainPart")
        if mainPart then
            local vfx = mainPart:FindFirstChild("VFXAttachment")
            if vfx then
                return vfx:FindFirstChild("Fire")
            end
        end
        return nil
    end

    local function switchTo(rocket)
        if switching then return end
        if not rocket or not rocket.Parent then return false end
        switching = true
        checkedRockets[rocket] = true
        camera.CameraSubject = rocket
        camera.CameraType = Enum.CameraType.Custom
        currentRocket = rocket
        fireDisappearTime = 0
        fireChecked = false
        switching = false
        return true
    end

    local function restore()
        if switching then return end
        switching = true
        local char = player.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                camera.CameraSubject = hum
                camera.CameraType = Enum.CameraType.Custom
            end
        end
        currentRocket = nil
        fireDisappearTime = 0
        fireChecked = false
        switching = false
    end

    local function loop()
        while cameraSwitchEnabled do
            if switching then
                task.wait(0.01)
                continue
            end
            
            local rockets = getRockets()
            
            if #rockets == 0 then
                if currentRocket then
                    restore()
                end
                checkedRockets = {}
                task.wait(0.1)
                continue
            end
            
            local latest, maxNum = nil, 0

            for _, r in ipairs(rockets) do
                if not checkedRockets[r] then
                    local num = tonumber(string.match(r.Name, "Rocket(%d+)")) or 0
                    if num > maxNum then
                        maxNum = num
                        latest = r
                    end
                end
            end
            
            if latest and latest ~= currentRocket then
                switchTo(latest)
            end
            
            if currentRocket and currentRocket.Parent then
                local fire = getFire(currentRocket)
                if fire and fire.Parent then
                    fireChecked = false
                else
                    if not fireChecked then
                        fireDisappearTime = tick()
                        fireChecked = true
                    end
                    if tick() - fireDisappearTime >= 1 then
                        restore()
                    end
                end
            else
                if currentRocket then
                    restore()
                end
            end
            
            task.wait(0.5)
        end
    end

    AttackTab:Toggle({
        Title = "视角切换",
        Callback = function(state)
            cameraSwitchEnabled = state
            if state then
                checkedRockets = {}
                currentRocket = nil
                switching = false
                fireDisappearTime = 0
                fireChecked = false
                if cameraSwitchThread then task.cancel(cameraSwitchThread) end
                cameraSwitchThread = task.spawn(loop)
            else
                if cameraSwitchThread then task.cancel(cameraSwitchThread) end
                checkedRockets = {}
                restore()
            end
        end
    })
end

do
    local autoRPGEnabled, autoRPGThread = false, nil


    local function getClosestRPG()
        local Char = game.Players.LocalPlayer.Character
        local Root = Char and Char:FindFirstChild("HumanoidRootPart")
        if not Root then return nil end
        
        local Closest, MinDist = nil, math.huge

        
        for _, t in pairs(workspace.Tycoon.Tycoons:GetChildren()) do
            local purchased = t:FindFirstChild("PurchasedObjects")
            if purchased then
                local giver = purchased:FindFirstChild("RPG Giver") or purchased:FindFirstChild("RPG Giver 2")
                if giver then
                    local part = giver:FindFirstChild("Prompt")
                    if part then
                        local dist = (Root.Position - part.Position).Magnitude
                        if dist < MinDist then
                            MinDist = dist
                            Closest = part
                        end
                    end
                end
            end
        end
        
        return Closest
    end

    local function getRPG()
        local player = game.Players.LocalPlayer
        local backpack, character = player:FindFirstChild("Backpack"), player.Character

        
        local rpg = backpack and backpack:FindFirstChild("RPG")
        if not rpg then
            rpg = character and character:FindFirstChild("RPG")
        end
        return rpg
    end

    local function getRPGFromGiver()
        local Closest = getClosestRPG()
        if not Closest then return false end
        
        local Char = game.Players.LocalPlayer.Character
        local Root = Char and Char:FindFirstChild("HumanoidRootPart")
        if not Root then return false end
        
        local OldPos = Root.CFrame
        Root.CFrame = CFrame.new(Closest.Position + Vector3.new(0, 3, 0))
        task.wait()
        
        local prompt = Closest:FindFirstChildWhichIsA("ProximityPrompt")
        if prompt then
            for i = 1, 3 do
                fireproximityprompt(prompt)
                task.wait(0.2)
            end
        end
        
        task.wait()
        Root.CFrame = OldPos
        return true
    end

    local function autoRPGLoop()
        while autoRPGEnabled do
            local rpg = getRPG()
            if not rpg then
                getRPGFromGiver()
            end
            task.wait(1)
        end
    end

    AttackTab:Toggle({
        Title = "自动获取RPG",
        Callback = function(state)
            autoRPGEnabled = state
            if state then
                if autoRPGThread then
                    task.cancel(autoRPGThread)
                    autoRPGThread = nil
                end
                autoRPGThread = task.spawn(autoRPGLoop)
            else
                if autoRPGThread then
                    task.cancel(autoRPGThread)
                    autoRPGThread = nil
                end
            end
        end
    })
end

do
    local rocketOrbitEnabled, rocketCount, orbitRadius, orbitSpeed, orbitingRockets, orbitAngle, updateConnection, isOrbiting = false, 5, 15, 1, {}, 0, nil, false








    local function getRocketTemplate()
        local rocketSystem = game:GetService("ReplicatedStorage"):FindFirstChild("RocketSystem")
        if not rocketSystem then return nil end
        local rockets = rocketSystem:FindFirstChild("Rockets")
        if not rockets then return nil end
        return rockets:FindFirstChild("RPG Rocket")
    end

    local function getPrimaryPart(rocket)
        return rocket.PrimaryPart or rocket:FindFirstChildOfClass("BasePart")
    end

    local function createRocket(index)
        local template = getRocketTemplate()
        if not template then return nil end
        local rocket = template:Clone()
        rocket.Name = "OrbitRocket_" .. index
        rocket.Parent = workspace
        local lp = game:GetService("Players").LocalPlayer
        local rootPart = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            local angle = (index - 1) * (2 * math.pi / rocketCount)
            local x, z, y, primaryPart = rootPart.Position.X + orbitRadius * math.cos(angle), rootPart.Position.Z + orbitRadius * math.sin(angle), rootPart.Position.Y + 3, getPrimaryPart(rocket)



            if primaryPart then
                primaryPart.CFrame = CFrame.new(x, y, z)
            end
        end
        return rocket
    end

    local function updateOrbit()
        local lp = game:GetService("Players").LocalPlayer
        local rootPart = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
        if not rootPart then return end
        orbitAngle = orbitAngle + orbitSpeed * 0.02
        local centerPos, count = rootPart.Position, #orbitingRockets

        for i, rocket in ipairs(orbitingRockets) do
            if rocket and rocket.Parent then
                local angle = orbitAngle + (i - 1) * (2 * math.pi / count)
                local x, z, y, primaryPart = centerPos.X + orbitRadius * math.cos(angle), centerPos.Z + orbitRadius * math.sin(angle), centerPos.Y + 3 + math.sin(angle * 1.5) * 1.5, getPrimaryPart(rocket)



                if primaryPart then
                    local nextAngle = angle + 0.01
                    local nextX, nextZ, nextY, currentPos = centerPos.X + orbitRadius * math.cos(nextAngle), centerPos.Z + orbitRadius * math.sin(nextAngle), centerPos.Y + 3 + math.sin(nextAngle * 1.5) * 1.5, Vector3.new(x, y, z)



                    local direction = (Vector3.new(nextX, nextY, nextZ) - currentPos).Unit
                    primaryPart.CFrame = CFrame.lookAt(currentPos, currentPos + direction)
                end
            end
        end
    end

    local function startOrbit()
        if isOrbiting then return end
        isOrbiting = true
        rocketOrbitEnabled = true
        for _, rocket in ipairs(orbitingRockets) do
            if rocket and rocket.Parent then
                rocket:Destroy()
            end
        end
        orbitingRockets = {}
        for i = 1, rocketCount do
            local rocket = createRocket(i)
            if rocket then
                table.insert(orbitingRockets, rocket)
            end
            task.wait(0.05)
        end
        if updateConnection then
            updateConnection:Disconnect()
        end
        updateConnection = game:GetService("RunService").Heartbeat:Connect(updateOrbit)
    end

    local function stopOrbit()
        isOrbiting = false
        rocketOrbitEnabled = false
        if updateConnection then
            updateConnection:Disconnect()
            updateConnection = nil
        end
        for _, rocket in ipairs(orbitingRockets) do
            if rocket and rocket.Parent then
                rocket:Destroy()
            end
        end
        orbitingRockets = {}
    end

    AttackTab:Toggle({
        Title = "RPG火箭环绕",
        Callback = function(state)
            if state then startOrbit() else stopOrbit() end
        end
    })

    AttackTab:Slider({
        Title = "火箭数量",
        Value = {Min = 1, Max = 100, Default = 5},
        Callback = function(value)
            rocketCount = value
            if isOrbiting then
                stopOrbit()
                task.wait(0.1)
                startOrbit()
            end
        end
    })

    AttackTab:Slider({
        Title = "环绕距离",
        Value = {Min = 3, Max = 50, Default = 15},
        Callback = function(value)
            orbitRadius = value
        end
    })

    AttackTab:Slider({
        Title = "环绕速度",
        Value = {Min = 0, Max = 100, Default = 1},
        Callback = function(value)
            orbitSpeed = value
        end
    })
end

do
    local circleBombingEnabled, circleBombingLoop, circleBombingInnerRadius, circleBombingOuterRadius, circleBombingAngleStep, circleBombingRadiusStep, circleBombingLastAttack, circleBombingInterval, bombMode, targetPlayerName, targetPlayer = false, nil, 10, 100, 15, 10, 0, 0.5, "自身", nil, nil











    AttackTab:Dropdown({
        Title = "轰炸模式",
        Values = {"自身", "指定"},
        Value = "自身",
        Callback = function(value)
            bombMode = value
        end
    })

    local playerDropdown = AttackTab:Dropdown({
        Title = "选择玩家",
        Values = {},
        Multi = false,
        Callback = function(value)
            targetPlayerName = WhitelistManager:GetPlayerName(value)
            if targetPlayerName then
                targetPlayer = game:GetService("Players"):FindFirstChild(targetPlayerName)
            end
        end
    })

    WhitelistManager:RegisterRefreshCallback("CircleBomb", function(list)
        playerDropdown:Refresh(list)
    end)

    local function getRPGInfo()
        local lp = game:GetService("Players").LocalPlayer
        local character = lp.Character
        local hrp, rpg = character and character:FindFirstChild("HumanoidRootPart"), lp.Backpack:FindFirstChild("RPG") or (character and character:FindFirstChild("RPG"))

        return lp, character, hrp, rpg
    end

    local function fireCircleRocket(targetPosition)
        local lp, character, hrp, rpg = getRPGInfo()
        
        if not character or not hrp or not rpg then return end
        if not targetPosition then return end
        
        local rs = game:GetService("ReplicatedStorage")
        local rocketEvent = rs:FindFirstChild("RocketSystem") and rs.RocketSystem:FindFirstChild("Events") and rs.RocketSystem.Events:FindFirstChild("RocketHit")
        if not rocketEvent then return end
        
        local args = {{
            Normal = Vector3.yAxis,
            Player = lp,
            HitPart = nil,
            Origin = hrp.Position,
            Label = "CircleBomb",
            Vehicle = rpg,
            Position = targetPosition,
            Weapon = rpg
        }}
        
        pcall(function()
            rocketEvent:FireServer(unpack(args))
        end)
    end

    local function getCirclePoints(radius, centerPosition)
        local points, angleStep = {}, circleBombingAngleStep

        
        for angle = 0, 360 - angleStep, angleStep do
            local rad = math.rad(angle)
            local x, z, y = centerPosition.X + radius * math.cos(rad), centerPosition.Z + radius * math.sin(rad), centerPosition.Y


            
            table.insert(points, Vector3.new(x, y, z))
        end
        
        return points
    end

    local function performCircleBombing()
        local lp = game:GetService("Players").LocalPlayer
        local character = lp.Character
        if not character then return end
        
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        
        local centerPosition = hrp.Position
        
        if bombMode == "指定" and targetPlayer then
            local targetChar = targetPlayer.Character
            if targetChar then
                local targetHrp = targetChar:FindFirstChild("HumanoidRootPart")
                if targetHrp then
                    centerPosition = targetHrp.Position
                end
            end
        end
        
        local allTargets = {}
        
        for radius = circleBombingInnerRadius + circleBombingRadiusStep, circleBombingOuterRadius, circleBombingRadiusStep do
            local points = getCirclePoints(radius, centerPosition)
            for _, point in ipairs(points) do
                table.insert(allTargets, point)
            end
        end
        
        for _, target in ipairs(allTargets) do
            task.spawn(function()
                fireCircleRocket(target)
            end)
        end
    end

    local function circleBombingLoop()
        while circleBombingEnabled do
            local now = tick()
            
            if now - circleBombingLastAttack >= circleBombingInterval then
                performCircleBombing()
                circleBombingLastAttack = now
            end
            
            task.wait(0.1)
        end
    end

    AttackTab:Toggle({
        Title = "轰炸区",
        Callback = function(state)
            circleBombingEnabled = state
            if state then
                task.spawn(circleBombingLoop)
            end
        end
    })
end

do
	local rpgBombingEnabled, shieldAttackActive, autoBombEnabled, ignoreShieldPlayers, rpgBombingList, currentListMode, lastRpgFire, heartbeatConnection, baseBombingEnabled, currentTycoonName, autoBombThread = false, false, false, false, {}, "白名单", 0, nil, false, nil, nil











	local function shouldTarget(player)
		local inList = table.find(rpgBombingList, player.Name) ~= nil
		if currentListMode == "白名单" then
			return not inList
		else
			return inList
		end
	end

	local rpgListDropdown = AttackTab:Dropdown({
		Title = "RPG列表",
		Values = {},
		Multi = true,
		AllowNone = true,
		Callback = function(selected)
			rpgBombingList = {}
			for _, v in pairs(selected) do
				local name = WhitelistManager:GetPlayerName(v)
				if name then
					table.insert(rpgBombingList, name)
				end
			end
		end,
	})

	WhitelistManager:RegisterRefreshCallback("RPGBombing", function(list)
		rpgListDropdown:Refresh(list)
	end)

	AttackTab:Dropdown({
		Title = "列表模式",
		Values = {"白名单", "黑名单"},
		Value = "白名单",
		Callback = function(value)
			currentListMode = value
		end,
	})

	local function hasShield(player)
		if not ignoreShieldPlayers then
			return false
		end
		local char = player.Character
		if not char then
			return false
		end
		local shieldNames = { "SpawnShield", "BaseShieldForceField", "StarterShield_ForceField" }
		for _, name in ipairs(shieldNames) do
			if char:FindFirstChild(name) then
				return true
			end
		end
		return false
	end

	local function getClosestEnemyShield()
		local lp = game:GetService("Players").LocalPlayer
		if not lp.Character or not lp.Character:FindFirstChild("HumanoidRootPart") then
			return nil
		end

		local localPos, myTeam, closestShield, shortestDistance = lp.Character.HumanoidRootPart.Position, lp.Team and lp.Team.Name, nil, math.huge




		local tycoons = workspace:FindFirstChild("Tycoon") and workspace.Tycoon:FindFirstChild("Tycoons")
		if not tycoons then
			return nil
		end

		for _, tycoon in ipairs(tycoons:GetChildren()) do
			if tycoon.Name == myTeam then
				continue
			end

			local shield = tycoon:FindFirstChild("PurchasedObjects") and tycoon.PurchasedObjects:FindFirstChild("Base Shield")
			if shield then
				local shieldParts = shield:FindFirstChild("Shield")
				if shieldParts then
					for _, part in ipairs(shieldParts:GetChildren()) do
						if part:IsA("BasePart") and part.Transparency < 1 then
							local distance = (localPos - part.Position).Magnitude
							if distance < shortestDistance then
								shortestDistance = distance
								closestShield = part
							end
						end
					end
				end
			end
		end

		return closestShield
	end

	local function getClosestPlayer()
		local lp, players, closestPlayer, closestDist = game:GetService("Players").LocalPlayer, game:GetService("Players"):GetPlayers(), nil, math.huge



		
		for _, targetPlayer in ipairs(players) do
			if targetPlayer == lp then
				continue
			end
			if not shouldTarget(targetPlayer) then
				continue
			end
			if hasShield(targetPlayer) then
				continue
			end
			
			local character = targetPlayer.Character
			if not character then
				continue
			end
			
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if not humanoid or humanoid.Health <= 0 then
				continue
			end
			
			local hrp = character:FindFirstChild("HumanoidRootPart")
			if hrp then
				local dist = (lp.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
				if dist < closestDist then
					closestDist = dist
					closestPlayer = targetPlayer
				end
			end
		end
		
		return closestPlayer
	end

	local function fireRocket(targetPlayer)
		local lp = game:GetService("Players").LocalPlayer
		local character = lp.Character
		local hrp, rpg = character and character:FindFirstChild("HumanoidRootPart"), lp.Backpack:FindFirstChild("RPG") or (character and character:FindFirstChild("RPG"))


		if not character or not hrp or not rpg then
			return
		end
		if not targetPlayer or not targetPlayer.Character then
			return
		end

		local targetHrp = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
		if not targetHrp then
			return
		end

		local rs = game:GetService("ReplicatedStorage")
		local rocketEvent = rs:FindFirstChild("RocketSystem") and rs.RocketSystem:FindFirstChild("Events") and rs.RocketSystem.Events:FindFirstChild("RocketHit")
		if not rocketEvent then
			return
		end

		local args = {
			{
				Normal = Vector3.yAxis,
				Player = targetPlayer,
				HitPart = targetHrp,
				Origin = hrp.Position,
				Label = targetPlayer.Name .. "Rocket1",
				Vehicle = rpg,
				Position = targetHrp.Position,
				Weapon = rpg,
			},
		}

		pcall(function()
			rocketEvent:FireServer(unpack(args))
		end)

		lastRpgFire = os.clock()
	end

	local function fireRocketAtShield(shieldPart)
		local lp = game:GetService("Players").LocalPlayer
		local character = lp.Character
		local hrp, rpg = character and character:FindFirstChild("HumanoidRootPart"), lp.Backpack:FindFirstChild("RPG") or (character and character:FindFirstChild("RPG"))


		if not character or not hrp or not rpg or not shieldPart then
			return
		end

		local rs = game:GetService("ReplicatedStorage")
		local rocketEvent = rs:FindFirstChild("RocketSystem") and rs.RocketSystem:FindFirstChild("Events") and rs.RocketSystem.Events:FindFirstChild("RocketHit")
		if not rocketEvent then
			return
		end

		local args = {
			{
				Normal = Vector3.yAxis,
				Player = lp,
				HitPart = shieldPart,
				Origin = hrp.Position,
				Label = "ShieldRocket",
				Vehicle = rpg,
				Position = shieldPart.Position,
				Weapon = rpg,
			},
		}

		pcall(function()
			rocketEvent:FireServer(unpack(args))
		end)
	end

	local function autoBombLoop()
		while autoBombEnabled do
			local shield = getClosestEnemyShield()
			if shield then
				fireRocketAtShield(shield)
				task.wait(0.1)
			else
				local target = getClosestPlayer()
				if target then
					fireRocket(target)
				end
				task.wait(0.1)
			end
		end
	end

	AttackTab:Toggle({
		Title = "自动轰炸",
		Callback = function(state)
			autoBombEnabled = state
			if state then
				if autoBombThread then
					task.cancel(autoBombThread)
					autoBombThread = nil
				end
				autoBombThread = task.spawn(autoBombLoop)
			else
				if autoBombThread then
					task.cancel(autoBombThread)
					autoBombThread = nil
				end
			end
		end
	})

	AttackTab:Toggle({
		Title = "RPG轰炸(RPG)",
		Callback = function(state)
			rpgBombingEnabled = state
			if state then
				task.spawn(function()
					while rpgBombingEnabled do
						local lp, players = game:GetService("Players").LocalPlayer, game:GetService("Players"):GetPlayers()


						for _, targetPlayer in ipairs(players) do
							if targetPlayer == lp then
								continue
							end
							if not shouldTarget(targetPlayer) then
								continue
							end
							if hasShield(targetPlayer) then
								continue
							end

							local character = targetPlayer.Character
							if not character then
								continue
							end

							local humanoid = character:FindFirstChildOfClass("Humanoid")
							if not humanoid or humanoid.Health <= 0 then
								continue
							end

							fireRocket(targetPlayer)
							task.wait(0.05)
						end

						task.wait()
					end
				end)
			end
		end,
	})

	AttackTab:Toggle({
		Title = "护盾攻击(RPG)",
		Callback = function(state)
			shieldAttackActive = state
			if state then
				task.spawn(function()
					while shieldAttackActive do
						if not rpgBombingEnabled then
							local shield = getClosestEnemyShield()
							if shield then
								fireRocketAtShield(shield)
							end
						end
						task.wait(0.1)
					end
				end)
			end
		end,
	})
end

TreeBomb = {
    enabled = false,
    targetQueue = {},
    lastScanTime = 0,
    scanInterval = 1.5,
    scannedTrees = {},
    scannedLights = {},
    lastAttackTime = 0,
    attackInterval = 8,
}

function fireTreeRocket(targetPlayer, targetPosition, targetPart)
    local lp = game:GetService("Players").LocalPlayer
    local character = lp.Character
    local hrp, rpg = character and character:FindFirstChild("HumanoidRootPart"), lp.Backpack:FindFirstChild("RPG") or (character and character:FindFirstChild("RPG"))

    
    if not character or not hrp or not rpg then return end
    if not targetPosition then return end
    
    local rs = game:GetService("ReplicatedStorage")
    local rocketEvent = rs:FindFirstChild("RocketSystem") and rs.RocketSystem:FindFirstChild("Events") and rs.RocketSystem.Events:FindFirstChild("RocketHit")
    if not rocketEvent then return end
    
    local args = {{
        Normal = Vector3.yAxis,
        Player = targetPlayer or lp,
        HitPart = targetPart or nil,
        Origin = hrp.Position,
        Label = "TreeBomb",
        Vehicle = rpg,
        Position = targetPosition,
        Weapon = rpg
    }}
    
    pcall(function()
        rocketEvent:FireServer(unpack(args))
    end)
end

function fireBatch(targets)
    for _, target in ipairs(targets) do
        task.spawn(function()
            fireTreeRocket(nil, target.position, target.part)
        end)
    end
end

clickBombingEnabled, clickBombingConnection = false, nil


function getRPGInfo()
    local lp = game:GetService("Players").LocalPlayer
    local character = lp.Character
    local hrp, rpg = character and character:FindFirstChild("HumanoidRootPart"), lp.Backpack:FindFirstChild("RPG") or (character and character:FindFirstChild("RPG"))

    return lp, character, hrp, rpg
end

function fireClickRocket(targetPosition)
    local lp, character, hrp, rpg = getRPGInfo()
    
    if not character or not hrp or not rpg then return end
    if not targetPosition then return end
    
    local rs = game:GetService("ReplicatedStorage")
    local rocketEvent = rs:FindFirstChild("RocketSystem") and rs.RocketSystem:FindFirstChild("Events") and rs.RocketSystem.Events:FindFirstChild("RocketHit")
    if not rocketEvent then return end
    
    local args = {{
        Normal = Vector3.yAxis,
        Player = lp,
        HitPart = nil,
        Origin = hrp.Position,
        Label = "ClickBomb",
        Vehicle = rpg,
        Position = targetPosition,
        Weapon = rpg
    }}
    
    pcall(function()
        rocketEvent:FireServer(unpack(args))
    end)
end

function onMouseClick()
    if not clickBombingEnabled then return end
    
    local mouse = game:GetService("Players").LocalPlayer:GetMouse()
    local targetPosition = mouse.Hit.Position
    
    if targetPosition then
        fireClickRocket(targetPosition)
    end
end

AttackTab:Toggle({
    Title = "点击轰炸",
    Callback = function(state)
        clickBombingEnabled = state
        
        if state then
            local mouse = game:GetService("Players").LocalPlayer:GetMouse()
            if mouse then
                clickBombingConnection = mouse.Button1Down:Connect(onMouseClick)
            end
        else
            if clickBombingConnection then
                clickBombingConnection:Disconnect()
                clickBombingConnection = nil
            end
        end
    end
})

function scanAndDestroyLights()
    local tycoons = workspace:FindFirstChild("Tycoon")
    if not tycoons then return end
    
    local tycoonsFolder = tycoons:FindFirstChild("Tycoons")
    if not tycoonsFolder then return end
    
    for _, base in ipairs(tycoonsFolder:GetChildren()) do
        local purchased = base:FindFirstChild("PurchasedObjects")
        if purchased then
            local streetLights = purchased:FindFirstChild("Street Lights")
            if streetLights and streetLights:IsA("Model") and not TreeBomb.scannedLights[streetLights] then
                TreeBomb.scannedLights[streetLights] = true
                
                local children = streetLights:GetChildren()
                for _, child in ipairs(children) do
                    local hitPoint = child:FindFirstChild("ObstacleHitPoint")
                    if hitPoint and hitPoint:IsA("BasePart") then
                        table.insert(TreeBomb.targetQueue, {
                            position = hitPoint.Position,
                            part = hitPoint,
                            targetModel = child
                        })
                    end
                end
            end
        end
    end
end

function scanAndDestroyTrees()
    local trees = {}
    
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj.Name == "Palm Tree" and obj:IsA("Model") and not TreeBomb.scannedTrees[obj] then
            table.insert(trees, obj)
        end
    end
    
    for _, tree in ipairs(trees) do
        TreeBomb.scannedTrees[tree] = true
        
        for _, descendant in ipairs(tree:GetDescendants()) do
            if descendant.Name == "ObstacleHitPoint" and descendant:IsA("BasePart") then
                table.insert(TreeBomb.targetQueue, {
                    position = descendant.Position,
                    part = descendant,
                })
            end
        end
        
        pcall(function() tree:Destroy() end)
    end
end

function deleteAttackedLights()
    local newQueue = {}
    for _, target in ipairs(TreeBomb.targetQueue) do
        if target.targetModel and target.targetModel.Parent then
            table.insert(newQueue, target)
        elseif target.targetModel and not target.targetModel.Parent then
        else
            table.insert(newQueue, target)
        end
    end
    TreeBomb.targetQueue = newQueue
end

function treeBombLoop()
    while TreeBomb.enabled do
        local now = tick()
        
        if now - TreeBomb.lastScanTime >= TreeBomb.scanInterval then
            scanAndDestroyTrees()
            scanAndDestroyLights()
            TreeBomb.lastScanTime = now
        end
        
        if #TreeBomb.targetQueue > 0 and now - TreeBomb.lastAttackTime >= TreeBomb.attackInterval then
            fireBatch(TreeBomb.targetQueue)
            TreeBomb.lastAttackTime = now
            
            for _, target in ipairs(TreeBomb.targetQueue) do
                if target.targetModel and target.targetModel.Parent then
                    pcall(function() target.targetModel:Destroy() end)
                end
            end
            deleteAttackedLights()
        end
        
        task.wait(0.1)
    end
end

AttackTab:Toggle({
    Title = "刷钱",
    Callback = function(state)
        TreeBomb.enabled = state
        if state then
            task.spawn(treeBombLoop)
        end
    end
})

WeaponTab:Section({Title = "武器获取"})


ReplicatedStorage = game:GetService("ReplicatedStorage")
Plr = game.Players.LocalPlayer
Workspace = game:GetService("Workspace")
local selectedWeapon, weaponSearch, weaponDropdown, displayLimit = "", "", nil, 15

function refreshWeaponList()
    local success, weaponsFolder = pcall(function()
        return ReplicatedStorage:FindFirstChild("Configurations") and ReplicatedStorage.Configurations:FindFirstChild("ACS_Guns")
    end)
    local list, allWeapons = {}, {}
    if success and weaponsFolder then
        for _, weapon in pairs(weaponsFolder:GetChildren()) do
            if weaponSearch == "" or string.find(string.lower(weapon.Name), string.lower(weaponSearch)) then
                table.insert(allWeapons, weapon.Name)
            end
        end
        table.sort(allWeapons)
        for i = 1, math.min(#allWeapons, displayLimit) do
            table.insert(list, allWeapons[i])
        end
        if #allWeapons > displayLimit then
            table.insert(list, string.format("... (共 %d 个武器，请使用搜索)", #allWeapons))
        end
    end
    if weaponDropdown then
        weaponDropdown:Refresh(list)
    end
end

WeaponTab:Input({
    Title = "搜索武器",
    Placeholder = "输入武器名称搜索",
    Callback = function(input)
        weaponSearch = input
        refreshWeaponList()
    end
})

weaponDropdown = WeaponTab:Dropdown({
    Title = "选择武器",
    Values = {},
    Multi = false,
    Callback = function(selected)
        if not string.find(selected, "... %(共") then
            selectedWeapon = selected
        end
    end
})

refreshWeaponList()

WeaponTab:Button({
    Title = "获取",
    Callback = function()
        if selectedWeapon == "" then return end
        local Char = Plr.Character
        local Root = Char and Char:FindFirstChild("HumanoidRootPart")
        if not Root then return end
        local OldPos, Closest, MinDist = Root.CFrame, nil, math.huge
        for _, t in pairs(Workspace.Tycoon.Tycoons:GetChildren()) do
            local giverName = selectedWeapon .. " Giver"
            local giver = t:FindFirstChild("PurchasedObjects") and t.PurchasedObjects:FindFirstChild(giverName)
            local part = giver and giver:FindFirstChild("Prompt")
            if part then
                local dist = (Root.Position - part.Position).Magnitude
                if dist < MinDist then
                    MinDist = dist
                    Closest = part
                end
            end
        end
        if not Closest then return end
        Root.CFrame = CFrame.new(Closest.Position + Vector3.new(0, 3, 0))
        task.wait()
        local prompt = Closest:FindFirstChildWhichIsA("ProximityPrompt")
        if prompt then
            for i = 1, 3 do
                fireproximityprompt(prompt)
                task.wait(0.2)
            end
        end
        task.wait()
        Root.CFrame = OldPos
    end
})

WeaponTab:Section({Title = "武器篡改"})

Players = game:GetService("Players")
Plr = Players.LocalPlayer
RunService = game:GetService("RunService")
UserInputService = game:GetService("UserInputService")
Workspace = game:GetService("Workspace")
Camera = workspace.CurrentCamera

autoJavelinStatus = {
    running = false,
    thread = nil
}

WeaponTab:Toggle({
    Title = "自动标枪锁定",
    Value = false,
    Callback = function(state)
        if state then
            if autoJavelinStatus.running then return end
            autoJavelinStatus.running = true
            
            autoJavelinStatus.thread = task.spawn(function()
                
                local function getClosestVehicle()
                    local vehicleWorkspace = workspace:FindFirstChild("Game Systems")
                    if not vehicleWorkspace then return nil end
                    
                    local folders = {
                        "Tank Workspace", "Vehicle Workspace", "Helicopter Workspace",
                        "Boat Workspace", "Hovercraft Workspace", "Plane Workspace", 
                        "Submarine Workspace", "RC Workspace", "Drone Workspace"
                    }
                    
                    local center, closest, closestDist = Vector2.new(_.Camera.ViewportSize.X / 2, _.Camera.ViewportSize.Y / 2), nil, math.huge
                    
                    for _, folderName in ipairs(folders) do
                        local folder = vehicleWorkspace:FindFirstChild(folderName)
                        if folder then
                            for _, vehicle in ipairs(folder:GetChildren()) do
                                if vehicle and vehicle.Parent then
                                    local health = vehicle:FindFirstChild("Health")
                                    if health and health:IsA("NumberValue") and health.Value <= 0 then
                                        continue
                                    end
                                    
                                    local part, partNames = nil, {"BoatPivot", "PrimaryPart", "MainPart", "Body", "TargetPart", "HumanoidRootPart"}
                                    for _, name in ipairs(partNames) do
                                        local p = vehicle:FindFirstChild(name)
                                        if p and p:IsA("BasePart") then
                                            part = p
                                            break
                                        end
                                    end
                                    if not part then
                                        for _, child in ipairs(vehicle:GetDescendants()) do
                                            if child:IsA("BasePart") then
                                                part = child
                                                break
                                            end
                                        end
                                    end
                                    
                                    if part then
                                        local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
                                        if onScreen then
                                            local dist = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
                                            if dist < closestDist then
                                                closestDist = dist
                                                closest = part
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                    
                    return closest
                end
                
                while autoJavelinStatus.running do
                    local targetPart = getClosestVehicle()
                    if targetPart then
                        local javelin = Plr.Character and Plr.Character:FindFirstChild("Javelin")
                        if not javelin then
                            local backpack = Plr:FindFirstChild("Backpack")
                            if backpack then
                                javelin = backpack:FindFirstChild("Javelin")
                            end
                        end
                        
                        if javelin then
                            local args = {targetPart, javelin}
                            game:GetService("ReplicatedStorage"):WaitForChild("TurretSystem"):WaitForChild("TargetChange"):FireServer(unpack(args))
                        end
                    end
                    task.wait(0.15)
                end
            end)
        else
            autoJavelinStatus.running = false
            if autoJavelinStatus.thread then
                task.cancel(autoJavelinStatus.thread)
                autoJavelinStatus.thread = nil
            end
        end
    end
})

autoStingerStatus = {
    running = false,
    thread = nil
}

WeaponTab:Toggle({
    Title = "自动毒刺锁定",
    Value = false,
    Callback = function(state)
        if state then
            if autoStingerStatus.running then return end
            autoStingerStatus.running = true
            
            autoStingerStatus.thread = task.spawn(function()
                
                local function getClosestVehicle()
                    local vehicleWorkspace = workspace:FindFirstChild("Game Systems")
                    if not vehicleWorkspace then return nil end
                    
                    local folders = {
                        "Tank Workspace", "Vehicle Workspace", "Helicopter Workspace",
                        "Boat Workspace", "Hovercraft Workspace", "Plane Workspace", 
                        "Submarine Workspace", "RC Workspace", "Drone Workspace"
                    }
                    
                    local center, closest, closestDist = Vector2.new(_.Camera.ViewportSize.X / 2, _.Camera.ViewportSize.Y / 2), nil, math.huge
                    
                    for _, folderName in ipairs(folders) do
                        local folder = vehicleWorkspace:FindFirstChild(folderName)
                        if folder then
                            for _, vehicle in ipairs(folder:GetChildren()) do
                                if vehicle and vehicle.Parent then
                                    local health = vehicle:FindFirstChild("Health")
                                    if health and health:IsA("NumberValue") and health.Value <= 0 then
                                        continue
                                    end
                                    
                                    local part, partNames = nil, {"BoatPivot", "PrimaryPart", "MainPart", "Body", "TargetPart", "HumanoidRootPart"}
                                    for _, name in ipairs(partNames) do
                                        local p = vehicle:FindFirstChild(name)
                                        if p and p:IsA("BasePart") then
                                            part = p
                                            break
                                        end
                                    end
                                    if not part then
                                        for _, child in ipairs(vehicle:GetDescendants()) do
                                            if child:IsA("BasePart") then
                                                part = child
                                                break
                                            end
                                        end
                                    end
                                    
                                    if part then
                                        local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
                                        if onScreen then
                                            local dist = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
                                            if dist < closestDist then
                                                closestDist = dist
                                                closest = part
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                    
                    return closest
                end
                
                while autoStingerStatus.running do
                    local targetPart = getClosestVehicle()
                    if targetPart then
                        local stinger = Plr.Backpack:FindFirstChild("Stinger") or (Plr.Character and Plr.Character:FindFirstChild("Stinger"))
                        
                        if stinger then
                            local args = {targetPart, stinger}
                            game:GetService("ReplicatedStorage"):WaitForChild("TurretSystem"):WaitForChild("TargetChange"):FireServer(unpack(args))
                        end
                    end
                    task.wait(0.15)
                end
            end)
        else
            autoStingerStatus.running = false
            if autoStingerStatus.thread then
                task.cancel(autoStingerStatus.thread)
                autoStingerStatus.thread = nil
            end
        end
    end
})

t, s = nil, false

WeaponTab:Toggle({
    Title = "自动举盾",
    Value = false,
    Callback = function(v)
        s = v
        if s then
            if t then task.cancel(t) end
            t = task.spawn(function()
                while s do
                    pcall(function()
                        game.ReplicatedStorage.ACS_Engine.Events.Equip:FireServer(
                            game.Players.LocalPlayer.Backpack["Riot Shield"],
                            { Durability = 999999 }
                        )
                    end)
                    task.wait(0.5)
                end
            end)
        else
            if t then task.cancel(t) end
            t = nil
        end
    end
})

gunModEnabled, gunModThread, OriginalConfigs = false, nil, {}

WeaponTab:Button({
    Title = "枪械修改",
    Callback = function()
        if gunModEnabled then
            return
        end
        
        gunModEnabled = true
        
        local ACS_Guns, TweenService, SPEED = game:GetService("ReplicatedStorage"):WaitForChild("Configurations"):WaitForChild("ACS_Guns"), game:GetService("TweenService"), 0
        
        for _, gun in ipairs(ACS_Guns:GetChildren()) do
            local Settings = gun:FindFirstChild("Settings")
            if Settings then
                local ok, cfg = pcall(require, Settings)
                if ok then
                    if not OriginalConfigs[gun.Name] then
                        OriginalConfigs[gun.Name] = {
                            FireRate = cfg.FireRate,
                            HRecoil = cfg.HRecoil,
                            VRecoil = cfg.VRecoil,
                            MaxSpread = cfg.MaxSpread,
                            MinSpread = cfg.MinSpread,
                            Distance = cfg.Distance
                        }
                    end
                    cfg.FireRate = 9999
                    cfg.HRecoil = {0, 0}
                    cfg.VRecoil = {0, 0}
                    cfg.MaxSpread = 0
                    cfg.MinSpread = 0
                    cfg.Distance = 9999999
                end
            end
            
            local Animations = gun:FindFirstChild("Animations")
            if Animations then
                local ok, cfg = pcall(require, Animations)
                if ok then
                    local Settings2, RightPos, LeftPos = Animations.Parent:FindFirstChild("Settings"), nil, nil
                    
                    if Settings2 then
                        local ok2, settings = pcall(require, Settings2)
                        if ok2 then
                            RightPos = settings.RightPos
                            LeftPos = settings.LeftPos
                        end
                    end
                    
                    if cfg.EquipAnim then
                        cfg.EquipAnim = function(p1, p2, p3)
                            if not p3[5] or not p3[5]:FindFirstChild("Handle") then return end
                            
                            local function fastTween(obj, props)
                                if obj then
                                    TweenService:Create(obj, TweenInfo.new(SPEED), props):Play()
                                end
                            end
                            
                            fastTween(p3[2], {C1 = RightPos or CFrame.new(-0.875, -0.2, -1.25)})
                            fastTween(p3[3], {C1 = LeftPos or CFrame.new(1.2, -0.05, -1.65)})
                            task.wait()
                            
                            if p3[5]:FindFirstChild("Handle") then
                                fastTween(p3[2], {C1 = RightPos})
                                fastTween(p3[3], {C1 = LeftPos})
                                task.wait()
                            end
                        end
                    end
                    
                    if cfg.ReloadAnim then
                        cfg.ReloadAnim = function(p1, p2, p3)
                            if not p3[5] or not p3[5]:FindFirstChild("Handle") then return end
                            
                            local function fastTween(obj, props)
                                if obj then
                                    TweenService:Create(obj, TweenInfo.new(SPEED), props):Play()
                                end
                            end
                            
                            local mag = p3[5]:FindFirstChild("Mag")
                            if mag then mag.Transparency = 1 end
                            local mag2 = p3[5]:FindFirstChild("Mag2")
                            if mag2 then mag2.Transparency = 1 end
                            
                            fastTween(p3[2], {C1 = RightPos or CFrame.new(-0.875, 0, -1.15)})
                            fastTween(p3[3], {C1 = LeftPos or CFrame.new(-0.5, 0.55, -1.4)})
                            task.wait()
                            
                            if mag then mag.Transparency = 0 end
                            if mag2 then mag2.Transparency = 0 end
                            
                            fastTween(p3[2], {C1 = RightPos or CFrame.new(-0.875, 0, -1.125)})
                            task.wait()
                            
                            fastTween(p3[2], {C1 = RightPos})
                            fastTween(p3[3], {C1 = LeftPos})
                            task.wait()
                        end
                    end
                    
                    if cfg.ChamberAnim then
                        cfg.ChamberAnim = function(p1, p2, p3)
                            if not p3[5] or not p3[5]:FindFirstChild("Handle") then return end
                            
                            local function fastTween(obj, props)
                                if obj then
                                    TweenService:Create(obj, TweenInfo.new(SPEED), props):Play()
                                end
                            end
                            
                            fastTween(p3[3], {C1 = LeftPos})
                            fastTween(p3[2], {C1 = RightPos})
                            task.wait()
                            
                            local bolt, slide = p3[5].Handle and p3[5].Handle:FindFirstChild("Bolt"), p3[5].Handle and p3[5].Handle:FindFirstChild("Slide")
                            
                            if bolt then fastTween(bolt, {C0 = CFrame.new(0, 0, 0)}) end
                            if slide then fastTween(slide, {C0 = CFrame.new(0, 0, 0)}) end
                            
                            fastTween(p3[2], {C1 = RightPos})
                            fastTween(p3[3], {C1 = LeftPos})
                            task.wait()
                        end
                    end
                    
                    if cfg.ChamberBKAnim then
                        cfg.ChamberBKAnim = function(p1, p2, p3)
                            if not p3[5] or not p3[5]:FindFirstChild("Handle") then return end
                            
                            local function fastTween(obj, props)
                                if obj then
                                    TweenService:Create(obj, TweenInfo.new(SPEED), props):Play()
                                end
                            end
                            
                            fastTween(p3[2], {C1 = RightPos})
                            fastTween(p3[3], {C1 = LeftPos})
                            task.wait()
                            
                            local bolt, slide = p3[5].Handle and p3[5].Handle:FindFirstChild("Bolt"), p3[5].Handle and p3[5].Handle:FindFirstChild("Slide")
                            
                            if bolt then fastTween(bolt, {C0 = CFrame.new(0, 0, 0)}) end
                            if slide then fastTween(slide, {C0 = CFrame.new(0, 0, 0)}) end
                            
                            fastTween(p3[2], {C1 = RightPos})
                            fastTween(p3[3], {C1 = LeftPos})
                            task.wait()
                        end
                    end
                    
                    if cfg.SprintAnim then
                        cfg.SprintAnim = function(p1, p2, p3)
                            if not p3[5] or not p3[5]:FindFirstChild("Handle") then return end
                            TweenService:Create(p3[2], TweenInfo.new(SPEED), {C1 = RightPos or CFrame.new(-0.875, -0.2, -1.25)}):Play()
                            TweenService:Create(p3[3], TweenInfo.new(SPEED), {C1 = LeftPos or CFrame.new(1.2, -0.05, -1.65)}):Play()
                        end
                    end
                    
                    if Settings2 then
                        local ok2, settings = pcall(require, Settings2)
                        if ok2 then
                            if settings.ReloadTime then settings.ReloadTime = 0 end
                            if settings.EmptyReloadTime then settings.EmptyReloadTime = 0 end
                            if settings.FireRate then settings.FireRate = 9999 end
                        end
                    end
                end
            end
        end
        
        local lastWeapon = nil
        gunModThread = task.spawn(function()
            while gunModEnabled do
                local tool = _.Char and _.Char:FindFirstChildOfClass("Tool")
                local weapon = tool and tool.Name or nil
                
                if weapon and weapon ~= lastWeapon then
                    local gun = ACS_Guns:FindFirstChild(weapon)
                    if gun then
                        local Settings = gun:FindFirstChild("Settings")
                        if Settings and OriginalConfigs[weapon] then
                            local ok, cfg = pcall(require, Settings)
                            if ok then
                                local orig = OriginalConfigs[weapon]
                                cfg.FireRate = orig.FireRate
                                cfg.HRecoil = orig.HRecoil
                                cfg.VRecoil = orig.VRecoil
                                cfg.MaxSpread = orig.MaxSpread
                                cfg.MinSpread = orig.MinSpread
                                cfg.Distance = orig.Distance
                            end
                        end
                    end
                elseif not weapon and lastWeapon then
                    local gun = ACS_Guns:FindFirstChild(lastWeapon)
                    if gun then
                        local Settings = gun:FindFirstChild("Settings")
                        if Settings then
                            local ok, cfg = pcall(require, Settings)
                            if ok then
                                cfg.FireRate = 9999
                                cfg.HRecoil = {0, 0}
                                cfg.VRecoil = {0, 0}
                                cfg.MaxSpread = 0
                                cfg.MinSpread = 0
                                cfg.Distance = 9999
                            end
                        end
                    end
                end
                
                lastWeapon = weapon
                task.wait(0.2)
            end
        end)
    end
})

WeaponTab:Button({
    Title = "无散布",
    Callback = function()
        local injectConnection = nil
        local function modifyAllGuns()
            pcall(function()
                local acsGuns = game:GetService("ReplicatedStorage").Configurations.ACS_Guns
                for _, gun in pairs(acsGuns:GetChildren()) do
                    local settings = gun:FindFirstChild("Settings")
                    if settings then
                        local ok, cfg = pcall(require, settings)
                        if ok and cfg then
                            cfg.MinSpread = 0
                            cfg.AimInaccuracyStepAmount = 0
                        end
                    end
                end
            end)
        end
        modifyAllGuns()
        if injectConnection then
            injectConnection:Disconnect()
            injectConnection = nil
        end
        injectConnection = game:GetService("RunService").Heartbeat:Connect(function()
            modifyAllGuns()
        end)
    end
})

WeaponTab:Button({
    Title = "无限子弹",
    Callback = function()
        local ACS_Guns = game:GetService("ReplicatedStorage"):WaitForChild("Configurations"):WaitForChild("ACS_Guns")
        for _, gun in ipairs(ACS_Guns:GetChildren()) do
            local ammo = gun:FindFirstChild("Ammo")
            if ammo then
                ammo.Value = "inf"
            end
        end
    end
})

WeaponTab:Section({Title = "导弹篡改"})

rocketEnabled = false
rocketSettings = {
    velocity = 1,
    gravity = true,
    FireRate = 1,
    TurnSpeed = 1,
    Acceleration = 1,
    VertexHeight = 1
}

FireRocket, oldNamecall, hookActive = game:GetService("ReplicatedStorage"):WaitForChild("RocketSystem"):WaitForChild("Events"):WaitForChild("FireRocket"), nil, false

function applyHook()
    if hookActive then return end
    hookActive = true
    
    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        
        if self == FireRocket and method == "InvokeServer" then
            local args = {...}
            
            if rocketEnabled and args[1] and args[1].Settings then
                local settings = args[1].Settings
                
                if settings.velocity then
                    settings.velocity = rocketSettings.velocity
                end
                
                if settings.FireRate then
                    settings.FireRate = rocketSettings.FireRate
                end
                
                if settings.TurnSpeed then
                    settings.TurnSpeed = rocketSettings.TurnSpeed
                end
                
                if settings.Acceleration then
                    settings.Acceleration = rocketSettings.Acceleration
                end
                
                if settings.VertexHeight then
                    settings.VertexHeight = rocketSettings.VertexHeight
                end
                
                if rocketSettings.gravity and settings.gravity then
                    settings.gravity = vector.zero
                end
            end
            
            return oldNamecall(self, unpack(args))
        end
        
        return oldNamecall(self, ...)
    end)
end

WeaponTab:Toggle({
    Title = "导弹篡改开关",
    Value = false,
    Callback = function(state)
        rocketEnabled = state
        if state then
            applyHook()
        end
    end
})

WeaponTab:Slider({
    Title = "飞行速度",
    Value = {Min = 1, Max = 9999, Default = 1},
    Callback = function(v)
        rocketSettings.velocity = tonumber(v) or 1
    end
})

WeaponTab:Slider({
    Title = "加速度",
    Value = {Min = 0, Max = 9999, Default = 1},
    Callback = function(v)
        rocketSettings.Acceleration = tonumber(v) or 1
    end
})

WeaponTab:Slider({
    Title = "上升高度",
    Value = {Min = 1, Max = 9999, Default = 1},
    Callback = function(v)
        rocketSettings.VertexHeight = tonumber(v) or 1
    end
})

WeaponTab:Slider({
    Title = "射速",
    Value = {Min = 1, Max = 9999, Default = 1},
    Callback = function(v)
        rocketSettings.FireRate = tonumber(v) or 1
    end
})

WeaponTab:Slider({
    Title = "转弯速度",
    Value = {Min = 1, Max = 9999, Default = 1},
    Callback = function(v)
        rocketSettings.TurnSpeed = tonumber(v) or 1
    end
})

WeaponTab:Toggle({
    Title = "无重力衰减",
    Value = true,
    Callback = function(state)
        rocketSettings.gravity = state
    end
})

KillTab:Section({Title = "杀戮设置"})

_G.currentKillMethod = "枪械杀戮"
_G.currentListMode = "白名单"
_G.currentPlayerList = {}
_G.killEnabled = false
_G.shieldEnabled = false
_G.vehicleEnabled = false
_G.killLoop = nil
_G.shieldLoop = nil
_G.vehicleLoop = nil

_G.vehicleFolders = {
    "Tank Workspace", "Vehicle Workspace", "Helicopter Workspace",
    "Boat Workspace", "Hovercraft Workspace", "Plane Workspace",
    "Submarine Workspace", "RC Workspace", "Drone Workspace"
}

_G.Players = game:GetService("Players")
_G.LP = _G.Players.LocalPlayer
_G.ReplicatedStorage = game:GetService("ReplicatedStorage")
_G.Camera = workspace.CurrentCamera

function shouldTarget(player)
    local inList = table.find(_G.currentPlayerList, player.Name) ~= nil
    if _G.currentListMode == "黑名单" then
        return inList
    end
    return not inList
end

function getCurrentWeapon()
    local char = _G.LP.Character
    if char then
        for _, c in ipairs(char:GetChildren()) do
            if c:IsA("Tool") then return c end
        end
    end
    local bp = _G.LP:FindFirstChildOfClass("Backpack")
    if bp then
        for _, c in ipairs(bp:GetChildren()) do
            if c:IsA("Tool") then return c end
        end
    end
    return nil
end

function getSecondaryWeapon(weaponName, character)
    local w2 = character:FindFirstChild("S" .. weaponName)
    if not w2 then
        local bp = _G.LP:FindFirstChildOfClass("Backpack")
        if bp then w2 = bp:FindFirstChild("S" .. weaponName) end
    end
    return w2 or Instance.new("Model")
end

function getClosestShield()
    if not _G.LP.Character or not _G.LP.Character:FindFirstChild("HumanoidRootPart") then
        return nil
    end
    local localPos, myTeam = _G.LP.Character.HumanoidRootPart.Position, _G.LP.Team and _G.LP.Team.Name
    if not myTeam then return nil end
    
    local tycoons = workspace:FindFirstChild("Tycoon") and workspace.Tycoon:FindFirstChild("Tycoons")
    if not tycoons then return nil end

    local best, bestDist = nil, math.huge
    for _, tycoon in ipairs(tycoons:GetChildren()) do
        if tycoon.Name ~= myTeam then
            local owner = tycoon:FindFirstChild("Owner")
            if owner and owner.Value ~= _G.LP.Name then
                local purchased = tycoon:FindFirstChild("PurchasedObjects")
                if purchased then
                    local baseShield = purchased:FindFirstChild("Base Shield")
                    if baseShield then
                        local shieldModel = baseShield:FindFirstChild("Shield")
                        if shieldModel then
                            for _, part in ipairs(shieldModel:GetChildren()) do
                                if part:IsA("BasePart") and (part.Name:match("Shield%d*") or part.Name == "Shield") then
                                    local d = (localPos - part.Position).Magnitude
                                    if d < bestDist then
                                        bestDist, best = d, part
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return best
end

function getAllVehicles()
    local vehicles, gameSystems = {}, workspace:FindFirstChild("Game Systems")
    if not gameSystems then return vehicles end
    
    local playerChar, playerVehicle = _G.LP.Character, nil
    if playerChar then
        playerVehicle = playerChar:FindFirstChild("SeatPart")
        if playerVehicle then
            playerVehicle = playerVehicle.Parent
        end
    end
    
    for _, folderName in ipairs(_G.vehicleFolders) do
        local folder = gameSystems:FindFirstChild(folderName)
        if folder then
            for _, vehicle in ipairs(folder:GetChildren()) do
                if vehicle:IsA("Model") and vehicle ~= playerVehicle then
                    local targetPart = nil
                    
                    local body = vehicle:FindFirstChild("Body")
                    if body then
                        targetPart = body:FindFirstChild("ObstacleDetector") 
                            or body:FindFirstChild("TargetPart") 
                            or body:FindFirstChildOfClass("BasePart")
                    end
                    
                    if not targetPart then
                        local functionality = vehicle:FindFirstChild("Functionality")
                        if functionality then
                            targetPart = functionality:FindFirstChild("ObstacleDetector1")
                                or functionality:FindFirstChild("ObstacleDetector")
                                or functionality:FindFirstChild("TargetPart")
                                or functionality:FindFirstChildOfClass("BasePart")
                        end
                    end
                    
                    if not targetPart then
                        for _, part in ipairs(vehicle:GetDescendants()) do
                            if part:IsA("BasePart") and part.Name ~= "Handle" and part.Name ~= "Weld" then
                                targetPart = part
                                break
                            end
                        end
                    end
                    
                    if targetPart and targetPart:IsA("BasePart") then
                        table.insert(vehicles, targetPart)
                    end
                end
            end
        end
    end
    return vehicles
end

function getClosestVehicleToCrosshair()
    local vehicles = getAllVehicles()
    if #vehicles == 0 then return nil end
    
    local camera = _G.Camera
    if not camera then return nil end
    
    local screenCenter, best, bestDist = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2), nil, math.huge
    
    for _, vehiclePart in ipairs(vehicles) do
        local screenPos, onScreen = camera:WorldToViewportPoint(vehiclePart.Position)
        if onScreen then
            local dist = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
            if dist < bestDist then
                bestDist, best = dist, vehiclePart
            end
        end
    end
    
    return best
end

function gunAttack(targetPart)
    local char = _G.LP.Character
    if not char or not targetPart then return end
    local weapon = getCurrentWeapon()
    if not weapon then return end
    local gunConfigs = _G.ReplicatedStorage:WaitForChild("Configurations"):WaitForChild("ACS_Guns")
    local config = gunConfigs:FindFirstChild(weapon.Name)
    if not config then return end
    local settings, w2, origin, targetPos = require(config:WaitForChild("Settings")), getSecondaryWeapon(weapon.Name, char), char.HumanoidRootPart.Position, targetPart.Position
    local direction, fireGunEvent, bulletHitEvent = (targetPos - origin).Unit, _G.ReplicatedStorage:WaitForChild("BulletFireSystem"):WaitForChild("FireGun"), _G.ReplicatedStorage:WaitForChild("BulletFireSystem"):WaitForChild("BulletHit")
    
    for i = 1, 3 do
        local offset = Vector3.new(math.random(-3, 3), math.random(-3, 3), math.random(-3, 3))
        local adjustedTarget = targetPos + offset
        local adjustedDirection = (adjustedTarget - origin).Unit
        pcall(function()
            fireGunEvent:FireServer({ adjustedDirection }, weapon, w2, origin, false)
            bulletHitEvent:FireServer(
                weapon, targetPart, adjustedTarget,
                { { origin, adjustedDirection, settings.Distance or 500 }, { origin, adjustedDirection, settings.Distance or 500 } },
                Vector3.xAxis,
                {
                    FireRate = settings.FireRate or 550,
                    MaxSpread = settings.MaxSpread or 35,
                    Mode = settings.Mode or "Auto",
                    MaxRecoilPower = settings.MaxRecoilPower or 3,
                    Distance = settings.Distance or 500,
                    BSpeed = settings.BSpeed or 2000
                }
            )
        end)
        task.wait(0.05)
    end
end

function getPlayerCRAM()
    local tycoons = workspace:FindFirstChild("Tycoon") and workspace.Tycoon:FindFirstChild("Tycoons")
    if not tycoons then return nil end
    local teamName = _G.LP.Team and _G.LP.Team.Name
    if not teamName then return nil end
    local tycoon = tycoons:FindFirstChild(teamName)
    if not tycoon then return nil end
    local purchased = tycoon:FindFirstChild("PurchasedObjects")
    if not purchased then return nil end
    local cram = purchased:FindFirstChild("CRAM")
    if not cram then return nil end
    local cramModel = cram:FindFirstChild("CRAM")
    if not cramModel then return nil end
    local smokePart = cramModel:FindFirstChild("SmokePart")
    if not smokePart then return nil end
    return { cram = cram, cramModel = cramModel, smokePart = smokePart }
end

function getCramSettings(cramData)
    if not cramData then return nil end
    local sm = cramData.cramModel:FindFirstChild("Settings")
    if sm and sm:IsA("ModuleScript") then
        local ok, s = pcall(require, sm)
        if ok then return s end
    end
    return { FireRate = 1000, CooldownTime = 4, BulletSpread = 0.8, OverheatCount = 150 }
end

function cramAttack(targetPart)
    local cramData = getPlayerCRAM()
    if not cramData or not targetPart then return end
    local settings = getCramSettings(cramData)
        or { FireRate = 1000, CooldownTime = 4, BulletSpread = 0.8, OverheatCount = 150 }
    local smokePart = cramData.smokePart
    if not smokePart or not smokePart.Parent then return end
    local origin, targetPos = smokePart.Position, targetPart.Position
    local direction = (targetPos - origin).Unit
    local normal = Vector3.new(-direction.Z, 0, direction.X).Unit
    if normal.Magnitude < 0.001 then normal = Vector3.new(0, 1, 0) end
    local bulletSystem = _G.ReplicatedStorage:FindFirstChild("BulletFireSystem")
    if not bulletSystem then return end
    local ev = bulletSystem:FindFirstChild("RegisterTurretHit")
    if not ev then return end
    pcall(function()
        ev:FireServer(cramData.cramModel, smokePart, cramData.cram, {
            normal = normal, hitPart = targetPart,
            origin = origin, hitPoint = targetPos, direction = direction,
        }, settings)
    end)
end

function getHumveeData()
    local vs = workspace:FindFirstChild("Game Systems")
        and workspace["Game Systems"]:FindFirstChild("Vehicle Workspace")
    if not vs then return nil end
    local veh = vs:FindFirstChild("Humvee TOW-II")
    if not veh then return nil end
    local misc = veh:FindFirstChild("Misc")
    if not misc then return nil end
    local turrets = misc:FindFirstChild("Turrets")
    if not turrets then return nil end
    local turret = turrets:FindFirstChild("Humvee TOW Weapons")
    if not turret then return nil end
    local mid = turret:FindFirstChild("Mid Turret")
    if not mid then return nil end
    local smoke = mid:FindFirstChild("SmokePart")
    if not smoke then return nil end
    return { vehicle = veh, turret = mid, smokePart = smoke }
end

function humveeAttack(targetPart)
    local d = getHumveeData()
    if not d or not targetPart then return end
    local targetPos, origin = targetPart.Position, d.smokePart.Position
    local direction = (targetPos - origin).Unit
    local normal = Vector3.new(-direction.Z, 0, direction.X).Unit
    if normal.Magnitude < 0.001 then normal = Vector3.new(0, 1, 0) end
    local args = {
        d.turret, d.smokePart, d.vehicle,
        { normal = normal, hitPart = targetPart, origin = origin,
          hitPoint = targetPos, direction = direction },
        { FireRate = 600, CooldownTime = 3.5, BulletSpread = 0, OverheatCount = 70 },
    }
    local bs = _G.ReplicatedStorage:FindFirstChild("BulletFireSystem")
    if not bs then return end
    local ev = bs:FindFirstChild("RegisterTurretHit")
    if not ev then return end
    pcall(function() ev:FireServer(unpack(args)) end)
end

function getLittlebirdData()
    local vs = workspace:FindFirstChild("Game Systems")
        and workspace["Game Systems"]:FindFirstChild("Helicopter Workspace")
    if not vs then return nil end
    local veh = vs:FindFirstChild("AH-6 Littlebird")
    if not veh then return nil end
    local misc = veh:FindFirstChild("Misc")
    if not misc then return nil end
    local turrets = misc:FindFirstChild("Turrets")
    if not turrets then return nil end
    local turret = turrets:FindFirstChild("AH Weapons")
    if not turret then return nil end
    local rl = turret:FindFirstChild("Rocket Launchers")
    if not rl then return nil end
    return { vehicle = veh, rocketLaunchers = rl }
end

function littlebirdAttack(targetPart, targetPlayer)
    local d = getLittlebirdData()
    if not d or not targetPart then return end
    local targetPos = targetPart.Position
    local origin = targetPos + Vector3.new(0, 50, 0)
    local direction = (targetPos - origin).Unit
    local normal = Vector3.new(-direction.Z, 0, direction.X).Unit
    if normal.Magnitude < 0.001 then normal = Vector3.new(0, 1, 0) end
    local label = (targetPlayer and targetPlayer.Name or "Shield")
        .. "Rocket" .. math.random(1000, 9999)
    local args = {{
        Normal = normal,
        Player = targetPlayer or _G.LP,
        HitPart = targetPart,
        Origin = origin,
        Label = label,
        Vehicle = d.vehicle,
        Position = targetPos,
        Weapon = d.rocketLaunchers,
    }}
    local rs = _G.ReplicatedStorage:FindFirstChild("RocketSystem")
    if not rs then return nil end
    local events = rs:FindFirstChild("Events")
    if not events then return nil end
    local ev = events:FindFirstChild("RocketHit")
    if not ev then return end
    pcall(function() ev:FireServer(unpack(args)) end)
end

function getShermanData()
    local ts = workspace:FindFirstChild("Game Systems")
        and workspace["Game Systems"]:FindFirstChild("Tank Workspace")
    if not ts then return nil end
    local sh = ts:FindFirstChild("M4 Sherman")
    if not sh then return nil end
    local misc = sh:FindFirstChild("Misc")
    if not misc then return nil end
    local turrets = misc:FindFirstChild("Turrets")
    if not turrets then return nil end
    local weapons = turrets:FindFirstChild("Sherman Weapons")
    if not weapons then return nil end
    local mt = weapons:FindFirstChild("Mounted Turret1")
    if not mt then return nil end
    local smoke = mt:FindFirstChild("SmokePart")
    if not smoke then return nil end
    return { tank = sh, turret = mt, smokePart = smoke }
end

function shermanAttack(targetPart)
    local d = getShermanData()
    if not d or not targetPart then return end
    local targetPos, origin = targetPart.Position, d.smokePart.Position
    local direction = (targetPos - origin).Unit
    local normal = Vector3.new(-direction.Z, 0, direction.X).Unit
    if normal.Magnitude < 0.001 then normal = Vector3.new(0, 1, 0) end
    local args = {
        d.turret, d.smokePart, d.tank,
        { normal = normal, hitPart = targetPart, origin = origin,
          hitPoint = targetPos, direction = direction },
        { FireRate = 18, CooldownTime = 10, BulletSpread = 0.05, OverheatCount = 1 },
    }
    local bs = _G.ReplicatedStorage:FindFirstChild("BulletFireSystem")
    if not bs then return nil end
    local ev = bs:FindFirstChild("RegisterTurretHit")
    if not ev then return end
    pcall(function() ev:FireServer(unpack(args)) end)
end

function attackPlayerByMethod(player, method)
    if player == _G.LP then return end
    if not player.Character then return end
    local hrp, head = player.Character:FindFirstChild("HumanoidRootPart"), player.Character:FindFirstChild("Head")
    if not hrp then return end

    if method == "枪械杀戮" then
        if head then gunAttack(head) end
    elseif method == "防空杀戮" then
        cramAttack(hrp)
    elseif method == "悍马杀戮" then
        humveeAttack(hrp)
    elseif method == "小鸟杀戮" then
        littlebirdAttack(hrp, player)
    elseif method == "谢尔曼杀戮" then
        shermanAttack(hrp)
    end
end

function attackShieldByMethod(method)
    local shield = getClosestShield()
    if not shield then return end

    if method == "枪械杀戮" then
        gunAttack(shield)
    elseif method == "防空杀戮" then
        cramAttack(shield)
    elseif method == "悍马杀戮" then
        humveeAttack(shield)
    elseif method == "小鸟杀戮" then
        littlebirdAttack(shield)
    elseif method == "谢尔曼杀戮" then
        shermanAttack(shield)
    end
end

function attackVehicleByMethod(method)
    local vehiclePart = getClosestVehicleToCrosshair()
    if not vehiclePart then return end

    if method == "枪械杀戮" then
        gunAttack(vehiclePart)
    elseif method == "防空杀戮" then
        cramAttack(vehiclePart)
    elseif method == "悍马杀戮" then
        humveeAttack(vehiclePart)
    elseif method == "小鸟杀戮" then
        littlebirdAttack(vehiclePart)
    elseif method == "谢尔曼杀戮" then
        shermanAttack(vehiclePart)
    end
end

function killLoopFunc()
    while _G.killEnabled do
        pcall(function()
            for _, player in ipairs(_G.Players:GetPlayers()) do
                if player ~= _G.LP and shouldTarget(player) then
                    attackPlayerByMethod(player, _G.currentKillMethod)
                end
            end
        end)
        task.wait()
    end
end

function shieldLoopFunc()
    while _G.shieldEnabled do
        pcall(function()
            attackShieldByMethod(_G.currentKillMethod)
        end)
        task.wait(0.1)
    end
end

function vehicleLoopFunc()
    while _G.vehicleEnabled do
        pcall(function()
            attackVehicleByMethod(_G.currentKillMethod)
        end)
        task.wait(0.1)
    end
end

KillTab:Dropdown({
    Title = "杀戮方式",
    Values = { "枪械杀戮", "防空杀戮", "悍马杀戮", "小鸟杀戮", "谢尔曼杀戮" },
    Value = "枪械杀戮",
    Callback = function(value)
        _G.currentKillMethod = value
    end,
})

KillTab:Dropdown({
    Title = "列表模式",
    Values = { "白名单", "黑名单" },
    Value = "白名单",
    Callback = function(value)
        _G.currentListMode = value
    end,
})

local playerDropdown = KillTab:Dropdown({
    Title = "玩家列表",
    Values = {},
    Multi = true,
    AllowNone = true,
    Callback = function(selected)
        _G.currentPlayerList = {}
        for _, v in pairs(selected) do
            table.insert(_G.currentPlayerList, WhitelistManager:GetPlayerName(v))
        end
    end,
})

WhitelistManager:RegisterRefreshCallback("UnifiedKill", function(list)
    playerDropdown:Refresh(list)
end)

KillTab:Toggle({
    Title = "启用杀戮",
    Value = false,
    Callback = function(state)
        _G.killEnabled = state
        if state then
            if _G.killLoop then task.cancel(_G.killLoop); _G.killLoop = nil end
            _G.killLoop = task.spawn(killLoopFunc)
        else
            if _G.killLoop then task.cancel(_G.killLoop); _G.killLoop = nil end
        end
    end,
})

KillTab:Toggle({
    Title = "攻击基地护盾",
    Value = false,
    Callback = function(state)
        _G.shieldEnabled = state
        if state then
            if _G.shieldLoop then task.cancel(_G.shieldLoop); _G.shieldLoop = nil end
            _G.shieldLoop = task.spawn(shieldLoopFunc)
        else
            if _G.shieldLoop then task.cancel(_G.shieldLoop); _G.shieldLoop = nil end
        end
    end,
})

KillTab:Toggle({
    Title = "载具杀戮",
    Value = false,
    Callback = function(state)
        _G.vehicleEnabled = state
        if state then
            if _G.vehicleLoop then task.cancel(_G.vehicleLoop); _G.vehicleLoop = nil end
            _G.vehicleLoop = task.spawn(vehicleLoopFunc)
        else
            if _G.vehicleLoop then task.cancel(_G.vehicleLoop); _G.vehicleLoop = nil end
        end
    end,
})

PlayerTab:Section({Title = "玩家设置"})

shieldBypassConnection = nil

PlayerTab:Toggle({
    Title = "护盾绕过",
    Value = false,
    Callback = function(state)
        
        if state then
            if shieldBypassConnection then
                shieldBypassConnection:Disconnect()
                shieldBypassConnection = nil
            end
            
            shieldBypassConnection = _.RunService.Heartbeat:Connect(function()
                if not Plr.Team then return end
                
                local shieldPath, shieldFolder = "Tycoon.Tycoons." .. _.teamName .. ".PurchasedObjects.Base Shield.Shield", workspace
                for _, part in ipairs(string.split(shieldPath, ".")) do
                    if shieldFolder then
                        shieldFolder = shieldFolder:FindFirstChild(part)
                    else
                        break
                    end
                end
                
                if shieldFolder then
                    local shieldFound = false
                    for _, child in ipairs(shieldFolder:GetChildren()) do
                        if child.Name:match("^Shield%d+$") and child:IsA("BasePart") and child.Transparency < 1 then
                            shieldFound = true
                            break
                        end
                    end
                    
                    if shieldFound then
                        return
                    end
                end
                
                local args = {
                    workspace:WaitForChild("Tycoon"):WaitForChild("Tycoons"):WaitForChild(_.teamName):WaitForChild("PurchasedObjects"):WaitForChild("Base Shield"):WaitForChild("Generator"):WaitForChild("Prompt"):WaitForChild("Generator")
                }
                pcall(function()
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("RepairObject"):FireServer(unpack(args))
                end)
            end)
        else
            if shieldBypassConnection then
                shieldBypassConnection:Disconnect()
                shieldBypassConnection = nil
            end
        end
    end
})

function setupCharacter(char)
    _.Char = char
    _.humanoid = char:WaitForChild("Humanoid")
    _.humanoidRootPart = char:WaitForChild("HumanoidRootPart")

    if speedEnabled then
        _.humanoid.WalkSpeed = walkSpeed
    else
        _.humanoid.WalkSpeed = 16
    end
    if FlyEnabled then flying = true; startFly() end
    if floatEnabled then baseHeight = _.humanoidRootPart.Position.Y end
    if fovEnabled then _.Camera.FieldOfView = fovValue else _.Camera.FieldOfView = 70 end
end

if Plr.Character then setupCharacter(Plr.Character) end
Plr.CharacterAdded:Connect(setupCharacter)

walkSpeed, speedEnabled, speedConnection = 1, false, nil

PlayerTab:Slider({
    Title="玩家移速",
    Value={Min=1,Max=100,Default=1},
    Callback=function(v)
        walkSpeed = tonumber(v) or 1
    end
})

PlayerTab:Toggle({
    Title="开启移速",
    Value=false,
    Callback=function(state)
        speedEnabled = state
        if state then
            if not speedConnection then
                speedConnection = _.RunService.Heartbeat:Connect(function()
                    if _.humanoid then
                        _.humanoid.WalkSpeed = walkSpeed
                    end
                end)
            end
        else
            if speedConnection then
                speedConnection:Disconnect()
                speedConnection = nil
            end
            if _.humanoid then
                _.humanoid.WalkSpeed = 16
            end
        end
    end
})

floatValue, floatEnabled, baseHeight, floatConnection = 1, false, 0, nil

PlayerTab:Slider({
    Title="玩家浮空",
    Value={Min=1,Max=1000,Default=1},
    Callback=function(v)
        floatValue = tonumber(v) or 1
    end
})

PlayerTab:Toggle({
    Title="开启浮空",
    Value=false,
    Callback=function(state)
        floatEnabled = state
        if state then
            if _.humanoidRootPart then
                baseHeight = _.humanoidRootPart.Position.Y
            end
            if not floatConnection then
                floatConnection = _.RunService.Heartbeat:Connect(function()
                    if floatEnabled and _.humanoidRootPart and not flying then
                        local pos = _.humanoidRootPart.Position
                        _.humanoidRootPart.CFrame = CFrame.new(pos.X, baseHeight + floatValue, pos.Z)
                    end
                end)
            end
        else
            if floatConnection then
                floatConnection:Disconnect()
                floatConnection = nil
            end
        end
    end
})

fovValue, fovEnabled, fovConnection = 70, false, nil

PlayerTab:Slider({
    Title="FOV大小调整",
    Value={Min=50,Max=150,Default=70},
    Callback=function(v)
        fovValue = tonumber(v) or 70
    end
})

PlayerTab:Toggle({
    Title="开启FOV",
    Value=false,
    Callback=function(state)
        fovEnabled = state
        if state then
            _.Camera.FieldOfView = fovValue
            if not fovConnection then
                fovConnection = _.RunService.RenderStepped:Connect(function()
                    if fovEnabled then
                        _.Camera.FieldOfView = fovValue
                    end
                end)
            end
        else
            _.Camera.FieldOfView = 70
            if fovConnection then
                fovConnection:Disconnect()
                fovConnection = nil
            end
        end
    end
})

flySpeed, FlyEnabled, flying, OrientToCamera, FlyConn, activeDirections = 500, false, false, false, nil, {Forward=false,Back=false,Left=false,Right=false,Up=false,Down=false}

function isMobile()
    return _.uis.TouchEnabled and not _.uis.KeyboardEnabled
end

function startFly()
    if FlyConn then FlyConn:Disconnect() end
    FlyConn = _.RunService.RenderStepped:Connect(function()
        if not flying or not _.Char or not _.humanoidRootPart then return end
        
        local dir, camCF = Vector3.zero, _.Camera.CFrame

        if isMobile() then
            dir = _.humanoid.MoveDirection
        else
            if _.uis:IsKeyDown(Enum.KeyCode.W) or activeDirections.Forward then dir += camCF.LookVector end
            if _.uis:IsKeyDown(Enum.KeyCode.S) or activeDirections.Back then dir -= camCF.LookVector end
            if _.uis:IsKeyDown(Enum.KeyCode.A) or activeDirections.Left then dir -= camCF.RightVector end
            if _.uis:IsKeyDown(Enum.KeyCode.D) or activeDirections.Right then dir += camCF.RightVector end
            if _.uis:IsKeyDown(Enum.KeyCode.E) or activeDirections.Up then dir += camCF.UpVector end
            if _.uis:IsKeyDown(Enum.KeyCode.Q) or activeDirections.Down then dir -= camCF.UpVector end
        end

        if OrientToCamera then
            _.humanoidRootPart.CFrame = CFrame.new(_.humanoidRootPart.Position, _.humanoidRootPart.Position + camCF.LookVector * Vector3.new(1,0,1))
        end

        _.humanoidRootPart.Velocity = dir.Magnitude > 0 and dir.Unit * flySpeed or Vector3.zero
    end)
end

function stopFly()
    if FlyConn then FlyConn:Disconnect(); FlyConn = nil end
    if _.humanoidRootPart then _.humanoidRootPart.Velocity = Vector3.zero end
end

PlayerTab:Slider({
    Title="玩家飞行速度",
    Value={Min=1,Max=5000,Default=500},
    Callback=function(v) flySpeed = tonumber(v) or 500 end
})

PlayerTab:Toggle({
    Title="开启飞行",
    Value=false,
    Callback=function(state)
        FlyEnabled = state
        flying = state
        if state then startFly() else stopFly() end
    end
})

PlayerTab:Toggle({
    Title="角色朝向摄像机",
    Value=false,
    Callback=function(state) OrientToCamera = state end
})

_.uis.InputBegan:Connect(function(input,gp)
    if gp then return end
    if FlyEnabled and input.KeyCode == Enum.KeyCode.CapsLock then
        flying = not flying
        if flying then startFly() else stopFly() end
    end
    if input.KeyCode==Enum.KeyCode.W then activeDirections.Forward=true end
    if input.KeyCode==Enum.KeyCode.S then activeDirections.Back=true end
    if input.KeyCode==Enum.KeyCode.A then activeDirections.Left=true end
    if input.KeyCode==Enum.KeyCode.D then activeDirections.Right=true end
    if input.KeyCode==Enum.KeyCode.E then activeDirections.Up=true end
    if input.KeyCode==Enum.KeyCode.Q then activeDirections.Down=true end
end)

_.uis.InputEnded:Connect(function(input)
    if input.KeyCode==Enum.KeyCode.W then activeDirections.Forward=false end
    if input.KeyCode==Enum.KeyCode.S then activeDirections.Back=false end
    if input.KeyCode==Enum.KeyCode.A then activeDirections.Left=false end
    if input.KeyCode==Enum.KeyCode.D then activeDirections.Right=false end
    if input.KeyCode==Enum.KeyCode.E then activeDirections.Up=false end
    if input.KeyCode==Enum.KeyCode.Q then activeDirections.Down=false end
end)

PlayerTab:Toggle({
    Title = "玩家穿墙",
    Value = false,
    Callback = function(s)
        if NC then NC:Disconnect() end
        if s then
            NC = game:GetService("RunService").RenderStepped:Connect(function()
                if Plr.Character then
                    for _, v in pairs(Plr.Character:GetDescendants()) do
                        if v:IsA("BasePart") then v.CanCollide = false end
                    end
                end
            end)
        end
    end
})

antiHeadshotTrack, antiHeadshotConn, antiHeadshotRunning = nil, nil, false

PlayerTab:Toggle({
    Title = "防止被爆头",
    Value = false,
    Callback = function(state)
        antiHeadshotRunning = state
        
        if state then
            local function loadAnim(char)
                local anim = Instance.new("Animation")
                anim.AnimationId = "rbxassetid://68339848"
                local track = _.humanoid:LoadAnimation(anim)
                track.Looped = true
                track:Play()
                return track
            end
            
            local char = Plr.Character
            if char then
                task.spawn(function()
                    task.wait(0.5)
                    local track = loadAnim(char)
                    antiHeadshotTrack = track
                end)
            end
            
            if not antiHeadshotConn then
                antiHeadshotConn = Plr.CharacterAdded:Connect(function(char)
                    char:WaitForChild("HumanoidRootPart")
                    task.spawn(function()
                        task.wait(0.5)
                        local track = loadAnim(char)
                        antiHeadshotTrack = track
                    end)
                end)
            end
        else
            if antiHeadshotTrack then
                antiHeadshotTrack:Stop()
                antiHeadshotTrack = nil
            end
            if antiHeadshotConn then
                antiHeadshotConn:Disconnect()
                antiHeadshotConn = nil
            end
        end
    end
})

local V = {
    running = false,
    conn = nil,
    teamConn = nil,
    lastMed = 0,
    lastUse = 0
}

PlayerTab:Toggle({
    Title = "自动急救包",
    Value = false,
    Callback = function(state)
        if state then
            if V.running then return end
            V.running = true
            if V.conn then V.conn:Disconnect() end
            if V.teamConn then V.teamConn:Disconnect() end
            
            V.conn = _.RunService.Heartbeat:Connect(function()
                if not _.humanoid or _.humanoid.Health <= 0 or _.humanoid.Health >= 100 then return end
                
                local now, bp = tick(), Plr:FindFirstChild("Backpack")
                local med = _.Char:FindFirstChild("Medkit") or (bp and bp:FindFirstChild("Medkit"))
                
                if med then
                    if now - V.lastUse > 0.3 then
                        if med.Parent == bp then med.Parent = _.Char task.wait(0.1) end
                        local r = _.ReplicatedStorage:FindFirstChild("Remotes")
                        if r then
                            r = r:FindFirstChild("Medkit")
                            if r then
                                local h = r:FindFirstChild("HPlr")
                                if h then pcall(h.FireServer, h) end
                            end
                        end
                        V.lastUse = now
                    end
                elseif now - V.lastMed > 0.5 then
                    local tn = Plr.Team and Plr.Team.Name
                    if tn then
                        local t = workspace:FindFirstChild("Tycoon")
                        if t then
                            t = t:FindFirstChild("Tycoons")
                            if t then
                                local b = t:FindFirstChild(tn)
                                if b then
                                    local p = b:FindFirstChild("PurchasedObjects")
                                    if p then
                                        local g = p:FindFirstChild("Medkit Giver")
                                        if g then
                                            local pp = g:FindFirstChild("Prompt")
                                            if pp then
                                                local pr = pp:FindFirstChildWhichIsA("ProximityPrompt")
                                                if pr then
                                                    local rr = _.ReplicatedStorage:FindFirstChild("Remotes")
                                                    if rr then
                                                        local ro = rr:FindFirstChild("RepairObject")
                                                        if ro then
                                                            pcall(function()
                                                                ro:FireServer(pr)
                                                                V.lastMed = now
                                                                task.wait(0.1)
                                                                local m = _.Char:FindFirstChild("Medkit") or (bp and bp:FindFirstChild("Medkit"))
                                                                if m then
                                                                    if m.Parent == bp then m.Parent = _.Char task.wait(0.1) end
                                                                    local r2 = _.ReplicatedStorage:FindFirstChild("Remotes")
                                                                    if r2 then
                                                                        r2 = r2:FindFirstChild("Medkit")
                                                                        if r2 then
                                                                            local h2 = r2:FindFirstChild("HPlr")
                                                                            if h2 then pcall(h2.FireServer, h2) end
                                                                        end
                                                                    end
                                                                    V.lastUse = tick()
                                                                end
                                                            end)
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end)
            
            V.teamConn = Plr:GetPropertyChangedSignal("Team"):Connect(function() end)
        else
            V.running = false
            if V.conn then V.conn:Disconnect() V.conn = nil end
            if V.teamConn then V.teamConn:Disconnect() V.teamConn = nil end
            V.lastMed = 0
            V.lastUse = 0
        end
    end
})

FlingTab:Section({Title = "甩飞设置"})

continuousFlingEnabled, flingWhitelist, OldPos = false, {}, nil

whitelistDropdown = FlingTab:Dropdown({
    Title = "甩飞目标",
    Values = {},
    Multi = true,
    AllowNone = true,
    Callback = function(selected)
        flingWhitelist = {}
        for _, v in pairs(selected) do 
            table.insert(flingWhitelist, WhitelistManager:GetPlayerName(v)) 
        end
    end
})

WhitelistManager:RegisterRefreshCallback("Fling", function(list)
    whitelistDropdown:Refresh(list)
end)

local function fling(target)
    local targetCharacter = target.Character
    if not _.Char or not targetCharacter then return end
    
    local thrp = targetCharacter:FindFirstChild("HumanoidRootPart") or targetCharacter:FindFirstChild("Head")
    if not _.humanoidRootPart or not thrp then return end
    
    if not OldPos then OldPos = _.humanoidRootPart.CFrame end
    
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(9e8, 9e8, 9e8)
    bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bodyVelocity.Parent = _.humanoidRootPart
    
    local startTime, lastTargetPos = tick(), thrp.Position
    
    while tick() - startTime < 3 and continuousFlingEnabled and _.humanoidRootPart and thrp and thrp.Parent do
        local elapsed = tick() - startTime
        local rotationAngle = elapsed * 720
        
        local currentTargetPos = thrp.Position
        
        if (currentTargetPos - lastTargetPos).Magnitude > 0.5 then
            lastTargetPos = currentTargetPos
        end
        
        local targetCFrame = thrp.CFrame
        local targetPosition, targetLookVector = targetCFrame.Position, targetCFrame.LookVector
        
        local flingOffset = targetLookVector * -2 + Vector3.new(0, 1.5, 0)
        local flingPosition = targetPosition + flingOffset
        
        _.humanoidRootPart.CFrame = CFrame.new(flingPosition) * CFrame.Angles(math.rad(rotationAngle), math.rad(rotationAngle * 0.5), 0)
        _.humanoidRootPart.Velocity = Vector3.new(9e7, 9e7 * 25, 9e7)
        _.humanoidRootPart.RotVelocity = Vector3.new(9e9, 9e9, 9e9)
        
        task.wait()
    end
    
    bodyVelocity:Destroy()
    
    if _.humanoidRootPart and OldPos then
        _.humanoidRootPart.CFrame = OldPos
        _.humanoidRootPart.Velocity = Vector3.zero
        _.humanoidRootPart.RotVelocity = Vector3.zero
    end
end

FlingTab:Toggle({
    Title = "持续甩飞",
    Callback = function(state)
        continuousFlingEnabled = state
        
        if state then
            if _.humanoidRootPart then OldPos = _.humanoidRootPart.CFrame end
            
            task.spawn(function()
                while continuousFlingEnabled do
                    for _, targetName in pairs(flingWhitelist) do
                        if targetName == "All" then
                            for _, player in pairs(_.Players:GetPlayers()) do 
                                if player ~= Plr then 
                                    pcall(fling, player) 
                                end 
                            end
                        else
                            local targetPlayer = _.Players:FindFirstChild(targetName)
                            if targetPlayer then 
                                pcall(fling, targetPlayer) 
                            end
                        end
                    end
                    task.wait(0.02)
                end
            end)
        else
            if _.humanoidRootPart and OldPos then
                _.humanoidRootPart.CFrame = OldPos
                _.humanoidRootPart.Velocity = Vector3.zero
                _.humanoidRootPart.RotVelocity = Vector3.zero
                for _, child in pairs(_.humanoidRootPart:GetChildren()) do 
                    if child:IsA("BodyMover") then 
                        child:Destroy() 
                    end 
                end
            end
        end
    end
})

CarTab:Section({Title = "载具设置"})

autoAllVehicleMissileStatus = {
    running = false,
    thread = nil
}

CarTab:Toggle({
    Title = "载具导弹自动锁定",
    Value = false,
    Callback = function(state)
        if state then
            if autoAllVehicleMissileStatus.running then return end
            autoAllVehicleMissileStatus.running = true
            
            autoAllVehicleMissileStatus.thread = task.spawn(function()
                
                local function getMyVehicle()
                    local vehicleWorkspace = workspace:FindFirstChild("Game Systems")
                    if not vehicleWorkspace then return nil end
                    
                    local folders = {
                        "Boat Workspace", "Vehicle Workspace", "Helicopter Workspace",
                        "Plane Workspace", "Hovercraft Workspace", "Tank Workspace",
                        "Submarine Workspace", "RC Workspace", "Drone Workspace"
                    }
                    
                    for _, folderName in ipairs(folders) do
                        local folder = vehicleWorkspace:FindFirstChild(folderName)
                        if folder then
                            for _, vehicle in ipairs(folder:GetChildren()) do
                                if vehicle:IsA("Model") then
                                    local owner = vehicle:GetAttribute("Owner")
                                    if owner == Plr.Name then
                                        return vehicle
                                    end
                                end
                            end
                        end
                    end
                    return nil
                end
                
                local function getClosestEnemyVehicle()
                    local vehicleWorkspace = workspace:FindFirstChild("Game Systems")
                    if not vehicleWorkspace then return nil end
                    
                    local folders = {
                        "Tank Workspace", "Vehicle Workspace", "Helicopter Workspace",
                        "Boat Workspace", "Hovercraft Workspace", "Plane Workspace", 
                        "Submarine Workspace", "RC Workspace", "Drone Workspace"
                    }
                    
                    local center, closest, closestDist = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2), nil, math.huge
                    
                    for _, folderName in ipairs(folders) do
                        local folder = vehicleWorkspace:FindFirstChild(folderName)
                        if folder then
                            for _, vehicle in ipairs(folder:GetChildren()) do
                                if vehicle and vehicle.Parent then
                                    local owner = vehicle:GetAttribute("Owner")
                                    if owner == Plr.Name then
                                        continue
                                    end
                                    
                                    local health = vehicle:FindFirstChild("Health")
                                    if health and health:IsA("NumberValue") and health.Value <= 0 then
                                        continue
                                    end
                                    
                                    local part, partNames = nil, {"BoatPivot", "PrimaryPart", "MainPart", "Body", "TargetPart", "HumanoidRootPart"}
                                    for _, name in ipairs(partNames) do
                                        local p = vehicle:FindFirstChild(name)
                                        if p and p:IsA("BasePart") then
                                            part = p
                                            break
                                        end
                                    end
                                    if not part then
                                        for _, child in ipairs(vehicle:GetDescendants()) do
                                            if child:IsA("BasePart") then
                                                part = child
                                                break
                                            end
                                        end
                                    end
                                    
                                    if part then
                                        local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
                                        if onScreen then
                                            local dist = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
                                            if dist < closestDist then
                                                closestDist = dist
                                                closest = part
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                    
                    return closest
                end
                
                while autoAllVehicleMissileStatus.running do
                    local myVehicle, targetPart = getMyVehicle(), getClosestEnemyVehicle()
                    
                    if myVehicle and targetPart then
                        pcall(function()
                            local args = {targetPart, myVehicle}
                            game:GetService("ReplicatedStorage"):WaitForChild("TurretSystem"):WaitForChild("TargetChange"):FireServer(unpack(args))
                        end)
                    end
                    task.wait(0.15)
                end
            end)
        else
            autoAllVehicleMissileStatus.running = false
            if autoAllVehicleMissileStatus.thread then
                task.cancel(autoAllVehicleMissileStatus.thread)
                autoAllVehicleMissileStatus.thread = nil
            end
        end
    end
})

fireRateValue = 9999

CarTab:Slider({
    Title = "载具武器射速",
    Value = {Min = 1, Max = 9999, Default = 9999},
    Callback = function(v)
        fireRateValue = v
    end
})

CarTab:Button({
    Title = "载具篡改",
    Callback = function()
        
        local function safeRequire(module)
            local ok, result = pcall(require, module)
            return ok and result
        end

        local function cleanMudParticles(vehicle)
            for _, attachment in ipairs(vehicle:GetDescendants()) do
                if attachment:IsA("Attachment") and attachment:FindFirstChild("MudWheelParticle") then
                    attachment.MudWheelParticle:Destroy()
                end
            end
        end

        local function cleanEffects(obj)
            for _, v in ipairs(obj:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") then v:Destroy() end
                if v:IsA("VehicleSeat") then v.Disabled = true end
            end
        end

        local function modifyWeapon(settings)
            if not settings then return end
            settings.FireRate = fireRateValue
            settings.StopRequired = false 
            if settings.OverheatCount then settings.OverheatCount = math.huge end
            if settings.CooldownTime then settings.CooldownTime = 0 end
            if settings.Cooldown then settings.Cooldown = 0 end
            if settings.DepleteDelay then settings.DepleteDelay = 0 end
            if settings.OverheatIncrement then settings.OverheatIncrement = 0 end
            if settings.MaxAmmo then settings.MaxAmmo = math.huge end
            if settings.Ammo then settings.Ammo = math.huge end
            if settings.StoredAmmo then settings.StoredAmmo = math.huge end
            if settings.ReserveAmmo then settings.ReserveAmmo = math.huge end
            if settings.AutoReload ~= nil then settings.AutoReload = true end
            if settings.ReloadTime then settings.ReloadTime = 0 end
            if settings.HeatPerShot then settings.HeatPerShot = 0 end
            if settings.HeatCooldown then settings.HeatCooldown = 999999 end
            if settings.Spread then settings.Spread = 0 end
            if settings.Recoil then settings.Recoil = 0 end
        end

        local function processWeaponModules(container)
            for _, mod in ipairs(container:GetDescendants()) do
                if mod:IsA("ModuleScript") and mod.Name == "Settings" then
                    modifyWeapon(safeRequire(mod))
                end
            end
        end

        local function processVehicle(vehicle)
            cleanEffects(vehicle)
            cleanMudParticles(vehicle)
            processWeaponModules(vehicle)
        end

        local function processWorkspace(name)
            local folder = _.Workspace:FindFirstChild("Game Systems") and Workspace["Game Systems"]:FindFirstChild(name)
            if folder then 
                for _, v in ipairs(folder:GetChildren()) do 
                    pcall(processVehicle, v) 
                end 
            end
        end

        local function modifyAllConstraints()
            local count = 0
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj.Name == "Constraints" and obj:IsA("ModuleScript") then
                    local config = safeRequire(obj)
                    if config then
                        if config.ElevationAngle ~= nil then
                            config.ElevationAngle = 90
                            count = count + 1
                        end
                        if config.DepressionAngle ~= nil then
                            config.DepressionAngle = 90
                            count = count + 1
                        end
                        if config.LowerDepressionAngle ~= nil then
                            config.LowerDepressionAngle = 90
                            count = count + 1
                        end
                        if config.LowerDepressionTrigger ~= nil then
                            config.LowerDepressionTrigger = 0
                            count = count + 1
                        end
                        if config.AngularSpeed ~= nil then
                            config.AngularSpeed = 999
                            count = count + 1
                        end
                        if config.ClampSpeed ~= nil then
                            config.ClampSpeed = 0
                            count = count + 1
                        end
                        if config.ReturnSpeed ~= nil then
                            config.ReturnSpeed = 0
                            count = count + 1
                        end
                    end
                end
            end
            return count
        end

        local totalCount = 0
        
        for _, ws in ipairs({"Tank Workspace","Vehicle Workspace","Helicopter Workspace","Boat Workspace","Hovercraft Workspace","Plane Workspace","Submarine Workspace"}) do
            processWorkspace(ws)
        end
        
        totalCount = totalCount + modifyAllConstraints()
        
        AlienX:Notify({
            Title = "载具篡改",
            Content = "已修改 " .. totalCount .. " 个参数",
            Duration = 2
        })
    end
})

game:GetService("UserInputService").InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.Backquote then
        
        local function safeRequire(module)
            local ok, result = pcall(require, module)
            return ok and result
        end

        local function cleanMudParticles(vehicle)
            for _, attachment in ipairs(vehicle:GetDescendants()) do
                if attachment:IsA("Attachment") and attachment:FindFirstChild("MudWheelParticle") then
                    attachment.MudWheelParticle:Destroy()
                end
            end
        end

        local function cleanEffects(obj)
            for _, v in ipairs(obj:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") then v:Destroy() end
                if v:IsA("VehicleSeat") then v.Disabled = true end
            end
        end

        local function modifyWeapon(settings)
            if not settings then return end
            settings.FireRate = fireRateValue
            settings.StopRequired = false
            if settings.OverheatCount then settings.OverheatCount = math.huge end
            if settings.CooldownTime then settings.CooldownTime = 0 end
            if settings.Cooldown then settings.Cooldown = 0 end
            if settings.DepleteDelay then settings.DepleteDelay = 0 end
            if settings.OverheatIncrement then settings.OverheatIncrement = 0 end
            if settings.MaxAmmo then settings.MaxAmmo = math.huge end
            if settings.Ammo then settings.Ammo = math.huge end
            if settings.StoredAmmo then settings.StoredAmmo = math.huge end
            if settings.ReserveAmmo then settings.ReserveAmmo = math.huge end
            if settings.AutoReload ~= nil then settings.AutoReload = true end
            if settings.ReloadTime then settings.ReloadTime = 0 end
            if settings.HeatPerShot then settings.HeatPerShot = 0 end
            if settings.HeatCooldown then settings.HeatCooldown = 999999 end
            if settings.Spread then settings.Spread = 0 end
            if settings.Recoil then settings.Recoil = 0 end
        end

        local function processWeaponModules(container)
            for _, mod in ipairs(container:GetDescendants()) do
                if mod:IsA("ModuleScript") and mod.Name == "Settings" then
                    modifyWeapon(safeRequire(mod))
                end
            end
        end

        local function processVehicle(vehicle)
            cleanEffects(vehicle)
            cleanMudParticles(vehicle)
            processWeaponModules(vehicle)
        end

        local function processWorkspace(name)
            local folder = _.Workspace:FindFirstChild("Game Systems") and _.Workspace["Game Systems"]:FindFirstChild(name)
            if folder then 
                for _, v in ipairs(folder:GetChildren()) do 
                    pcall(processVehicle, v) 
                end 
            end
        end

        local function modifyAllConstraints()
            local count = 0
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj.Name == "Constraints" and obj:IsA("ModuleScript") then
                    local config = safeRequire(obj)
                    if config then
                        if config.ElevationAngle ~= nil then
                            config.ElevationAngle = 90
                            count = count + 1
                        end
                        if config.DepressionAngle ~= nil then
                            config.DepressionAngle = 90
                            count = count + 1
                        end
                        if config.LowerDepressionAngle ~= nil then
                            config.LowerDepressionAngle = 90
                            count = count + 1
                        end
                        if config.LowerDepressionTrigger ~= nil then
                            config.LowerDepressionTrigger = 0
                            count = count + 1
                        end
                        if config.AngularSpeed ~= nil then
                            config.AngularSpeed = 999
                            count = count + 1
                        end
                        if config.ClampSpeed ~= nil then
                            config.ClampSpeed = 0
                            count = count + 1
                        end
                        if config.ReturnSpeed ~= nil then
                            config.ReturnSpeed = 0
                            count = count + 1
                        end
                    end
                end
            end
            return count
        end

        local totalCount = 0
        
        for _, ws in ipairs({"Tank Workspace","Vehicle Workspace","Helicopter Workspace","Boat Workspace","Hovercraft Workspace","Plane Workspace","Submarine Workspace"}) do
            processWorkspace(ws)
        end
        
        totalCount = totalCount + modifyAllConstraints()
        
        AlienX:Notify({
            Title = "载具篡改",
            Content = "已修改 " .. totalCount .. " 个参数",
            Duration = 2
        })
    end
end)

CarTab:Section({Title = "属性修改"})

local V = {
    speed = 1,
    turnSpeed = 1,
    turnAngle = 1,
    acceleration = 1,
    brakePower = 1,
    targetType = "船",
    types = {"船", "地面车辆", "两栖车辆", "直升机", "飞机", "气垫船", "坦克"}
}

CarTab:Dropdown({
    Title = "选择载具类型",
    Values = V.types,
    Value = "船",
    Callback = function(v)
        V.targetType = v
    end
})

function applyModifications()
    local totalModified = 0
    
    local function safeRequire(module)
        local ok, result = pcall(require, module)
        return ok and result
    end
    
    local function modifyVehicle(vehicle, configName, configType)
        local config = vehicle:FindFirstChild(configName)
        if not config or not config:IsA("ModuleScript") then return false end
        
        local ok, cfg = pcall(require, config)
        if not ok or not cfg then return false end
        
        local s, t, ang, a, b = V.speed, V.turnSpeed, V.turnAngle, V.acceleration, V.brakePower
        
        if configType == "Boat" then
            if cfg.MaxSpeed then cfg.MaxSpeed = s end
            if cfg.MaxReverseSpeed then cfg.MaxReverseSpeed = s end
            if cfg.TurnSpeed then cfg.TurnSpeed = t end
            if cfg.MaxTurn then cfg.MaxTurn = ang end
            if cfg.Acceleration then cfg.Acceleration = a end
            if cfg.BrakePower then cfg.BrakePower = b end
            return true
            
        elseif configType == "Vehicle" then
            if cfg.Gears then
                for i, gear in ipairs(cfg.Gears) do
                    if gear[2] then gear[2] = s end
                end
            end
            if cfg.ReverseMaxSpeed then cfg.ReverseMaxSpeed = -s end
            if cfg.TurnSpeed then cfg.TurnSpeed = t end
            if cfg.TurnAngle then cfg.TurnAngle = ang end
            if cfg.Throttle then cfg.Throttle = a * 1000 end
            if cfg.BrakePower then cfg.BrakePower = b end
            return true
            
        elseif configType == "Amphibious" then
            if cfg.Gears then
                for i, gear in ipairs(cfg.Gears) do
                    if gear[2] then gear[2] = s end
                end
            end
            if cfg.ReverseMaxSpeed then cfg.ReverseMaxSpeed = -s end
            if cfg.TurnSpeed then cfg.TurnSpeed = t end
            if cfg.TurnAngle then cfg.TurnAngle = ang end
            if cfg.Throttle then cfg.Throttle = a * 1000 end
            if cfg.BrakePower then cfg.BrakePower = b end
            if cfg.AmphibiousMaxSpeed then cfg.AmphibiousMaxSpeed = s end
            if cfg.AmphibiousMinSpeed then cfg.AmphibiousMinSpeed = -s end
            if cfg.AmphibiousAcceleration then cfg.AmphibiousAcceleration = a end
            return true
            
        elseif configType == "Helicopter" then
            if cfg.MaxFlightForce then cfg.MaxFlightForce = s end
            if cfg.FlightForceAcceleration then cfg.FlightForceAcceleration = a end
            if cfg.MaxYaw then cfg.MaxYaw = t end
            if cfg.OrientSpeed then cfg.OrientSpeed = t end
            if cfg.MaxPitch then cfg.MaxPitch = ang end
            if cfg.MaxRoll then cfg.MaxRoll = ang end
            return true
            
        elseif configType == "Plane" then
            if cfg.MaxSpeed then cfg.MaxSpeed = s end
            if cfg.ReverseSpeed then cfg.ReverseSpeed = -s end
            if cfg.TurnSpeed then cfg.TurnSpeed = t end
            if cfg.RollSpeed then cfg.RollSpeed = t end
            if cfg.TurnAngle then cfg.TurnAngle = ang end
            if cfg.MaxRoll then cfg.MaxRoll = ang end
            if cfg.ThrottleAcceleration then cfg.ThrottleAcceleration = a end
            if cfg.Throttle then cfg.Throttle = a * 1000 end
            return true
            
        elseif configType == "Hovercraft" then
            if cfg.MaxSpeed then cfg.MaxSpeed = s end
            if cfg.ReverseMaxSpeed then cfg.ReverseMaxSpeed = -s end
            if cfg.TurnSpeed then cfg.TurnSpeed = t end
            if cfg.MaxTurnSpeed then cfg.MaxTurnSpeed = t end
            if cfg.TurnAngle then cfg.TurnAngle = ang end
            if cfg.MaxSteeringAngle then cfg.MaxSteeringAngle = ang end
            if cfg.MovementPower then cfg.MovementPower = a * 10000 end
            if cfg.BrakePower then cfg.BrakePower = b end
            return true
            
        elseif configType == "Tank" then
            if cfg.DriveGear then cfg.DriveGear[2] = s end
            if cfg.ReverseGear then cfg.ReverseGear[2] = -s end
            if cfg.MaxTurnSpeed then cfg.MaxTurnSpeed = t end
            if cfg.TurnAcceleration then cfg.TurnAcceleration = t end
            if cfg.MaxSteeringAngle then cfg.MaxSteeringAngle = ang end
            if cfg.Throttle then cfg.Throttle = a * 1000 end
            if cfg.BrakePower then cfg.BrakePower = b end
            return true
        end
        
        return false
    end
    
    local typeMap = {
        ["船"] = {folder = "Boat Workspace", name = "BoatConfig", type = "Boat"},
        ["地面车辆"] = {folder = "Vehicle Workspace", name = "VehicleConfig", type = "Vehicle"},
        ["两栖车辆"] = {folder = "Vehicle Workspace", name = "VehicleConfig", type = "Amphibious"},
        ["直升机"] = {folder = "Helicopter Workspace", name = "HelicopterConfig", type = "Helicopter"},
        ["飞机"] = {folder = "Plane Workspace", name = "PlaneConfig", type = "Plane"},
        ["气垫船"] = {folder = "Hovercraft Workspace", name = "HovercraftConfig", type = "Hovercraft"},
        ["坦克"] = {folder = "Tank Workspace", name = "TankConfig", type = "Tank"},
    }
    
    local target = V.targetType
    local info = typeMap[target]
    if not info then return end
    
    local gs = _.Workspace:FindFirstChild("Game Systems")
    if not gs then
        AlienX:Notify({Title = "错误", Content = "未找到 Game Systems", Duration = 2})
        return
    end
    
    local folder = gs:FindFirstChild(info.folder)
    if folder then
        for _, vehicle in ipairs(folder:GetChildren()) do
            if vehicle:IsA("Model") then
                if info.type == "Amphibious" then
                    local config = vehicle:FindFirstChild("VehicleConfig")
                    if config then
                        local ok, cfg = pcall(require, config)
                        if ok and cfg and cfg.IsAmphibious then
                            if modifyVehicle(vehicle, "VehicleConfig", "Amphibious") then
                                totalModified = totalModified + 1
                            end
                        end
                    end
                else
                    if modifyVehicle(vehicle, info.name, info.type) then
                        totalModified = totalModified + 1
                    end
                end
            end
        end
    end
    
    AlienX:Notify({
        Title = "载具修改",
        Content = "已修改 " .. totalModified .. " 辆" .. target,
        Duration = 2
    })
end

CarTab:Button({
    Title = "应用修改",
    Callback = function()
        applyModifications()
    end
})

CarTab:Slider({
    Title = "速度",
    Value = {Min = 1, Max = 999, Default = 1},
    Callback = function(v)
        V.speed = v
    end
})

CarTab:Slider({
    Title = "转向速度",
    Value = {Min = 1, Max = 999, Default = 1},
    Callback = function(v)
        V.turnSpeed = v
    end
})

CarTab:Slider({
    Title = "转弯角度",
    Value = {Min = 1, Max = 180, Default = 1},
    Callback = function(v)
        V.turnAngle = v
    end
})

CarTab:Slider({
    Title = "加速度",
    Value = {Min = 1, Max = 999, Default = 1},
    Callback = function(v)
        V.acceleration = v
    end
})

CarTab:Slider({
    Title = "刹车力度",
    Value = {Min = 1, Max = 999, Default = 1},
    Callback = function(v)
        V.brakePower = v
    end
})

CarTab:Section({ Title = "自动/手动刷车" })

local V = {
    Enabled = false,
    VehicleName = "MRZR Buggy",
    SpawnInterval = 0,
    LastSpawn = 0
}

CarTab:Input({
    Title = "载具名称",
    Placeholder = "输入载具名称",
    Callback = function(input)
        if input and input ~= "" then
            V.VehicleName = input
        end
    end
})

CarTab:Toggle({
    Title = "自动刷车",
    Callback = function(v) 
        V.Enabled = v
        V.LastSpawn = 0
    end
})

CarTab:Slider({
    Title = "刷车间隔 (秒)",
    Value = {Min = 0, Max = 20, Default = 0},
    Callback = function(v) 
        V.SpawnInterval = tonumber(v) or 0
    end
})

CarTab:Button({
    Title = "手动刷车",
    Callback = function()
        if V.VehicleName and V.VehicleName ~= "" then
            pcall(function()
                local Event = game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("MountService"):WaitForChild("RE"):WaitForChild("SpawnMount")
                Event:FireServer(V.VehicleName)
                AlienX:Notify({
                    Title = "刷车",
                    Content = "已刷出: " .. V.VehicleName,
                    Duration = 2
                })
            end)
        else
            AlienX:Notify({
                Title = "错误",
                Content = "请输入载具名称",
                Duration = 2
            })
        end
    end
})

task.spawn(function()
    while true do
        task.wait()
        if V.Enabled and V.VehicleName and V.VehicleName ~= "" then
            if V.LastSpawn == 0 or tick() - V.LastSpawn >= V.SpawnInterval then
                pcall(function()
                    local Event = game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("MountService"):WaitForChild("RE"):WaitForChild("SpawnMount")
                    Event:FireServer(V.VehicleName)
                    V.LastSpawn = tick()
                end)
            end
        else
            V.LastSpawn = 0
        end
    end
end)

CarTab:Toggle({
    Title = "关闭自动上车",
    Value = false,
    Callback = function(state)
        pcall(function()
            local Event = game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("GameSettingsService"):WaitForChild("RF"):WaitForChild("SetSetting")
            Event:InvokeServer("automaticSeating", not state)
        end)
    end
})

CarTab:Toggle({
    Title = "关闭自动起落架",
    Value = false,
    Callback = function(state)
        pcall(function()
            local Event = game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("GameSettingsService"):WaitForChild("RF"):WaitForChild("SetSetting")
            Event:InvokeServer("automaticLandingGear", not state)
        end)
    end
})

CarTab:Button({
    Title = "起落架收/放",
    Callback = function()
        pcall(function()
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PlaneRemotes"):WaitForChild("ToggleLandingGear"):FireServer()
        end)
    end
})

CarTab:Section({ Title = "传送刷车控制台" })

local V = {
    ConsoleCache = {},
    SelectedVehicle = "地面车辆",
    Types = {
        ["地面车辆"] = {"VehicleFloor.Spawner.SpawnerText", "Starter Garage.Spawner.SpawnerText"},
        ["直升机"] = {"Helipad.Spawner.SpawnerText"},
        ["飞机"] = {"Plane Start.SpawnerText"},
        ["坦克"] = {"Tank Building Floor.Spawner.SpawnerText"},
        ["船"] = {"Dock Path.Spawner.SpawnerText"},
        ["汽艇"] = {"Hovercraft Dock.Spawner.SpawnerText"},
        ["潜艇"] = {"Submarine Dock.Spawner.SpawnerText"},
        ["无人机"] = {"Drone Spawner.Spawner.CooldownScreen.SpawnerText"},
        ["UAV"] = {"UAV Control Center.LargeDroneSpawner.SpawnerText"},
        ["UGV"] = {"UGV Control Center.UGVSpawner.SpawnerText"},
    },
    List = {"地面车辆", "直升机", "飞机", "坦克", "船", "汽艇", "潜艇", "无人机(小)", "UAV", "UGV"}
}

CarTab:Dropdown({
    Title = "传送刷车控制台",
    Values = V.List,
    Value = "地面车辆",
    Callback = function(v)
        V.SelectedVehicle = v
    end
})

function GetPartByPath(path)
    local parts = {}
    for word in string.gmatch(path, "[^%.]+") do
        table.insert(parts, word)
    end
    local current = workspace
    for _, part in ipairs(parts) do
        if current then
            current = current:FindFirstChild(part)
        else
            return nil
        end
    end
    return current
end

function RefreshConsoles()
    V.ConsoleCache = {}
    local teamName = Plr.Team and Plr.Team.Name
    if not teamName then return end
    
    local basePath = "Tycoon.Tycoons." .. teamName .. ".PurchasedObjects."
    
    for displayName, pathList in pairs(V.Types) do
        for _, pathSuffix in ipairs(pathList) do
            local fullPath = basePath .. pathSuffix
            local part = GetPartByPath(fullPath)
            if part and part:IsA("BasePart") then
                V.ConsoleCache[displayName] = part.CFrame
                break
            end
        end
    end
end

CarTab:Button({
    Title = "传送",
    Callback = function()
        local cframe = V.ConsoleCache[V.SelectedVehicle]
        if cframe then
            if _.Char then
                local hrp = _.Char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = cframe * CFrame.new(0, 3, 0)
                end
            end
        end
    end
})

CarTab:Button({
    Title = "刷新控制台",
    Callback = function()
        RefreshConsoles()
    end
})

local V = {
    rotating = false,
    speed = 500,
    conn = nil
}

function updateHRP()
    if _.Char then
        _.humanoidRootPart = _.Char:FindFirstChild("HumanoidRootPart")
    else
        _.humanoidRootPart = nil
    end
end

Plr.CharacterAdded:Connect(function(chr)
    _.Char = chr
    chr:WaitForChild("HumanoidRootPart", 5)
end)

Plr.CharacterRemoving:Connect(function()
    _.humanoidRootPart = nil
    _.Char = nil
end)

CarTab:Toggle({
    Title = "载具旋转",
    Default = false,
    Callback = function(v)
        V.rotating = v
        if v then
            updateHRP()
        end
    end
})

CarTab:Slider({
    Title = "旋转速度",
    Value = {Min = 500, Max = 3000, Default = 500},
    Callback = function(val)
        V.speed = val
    end
})

_.uis.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.J then
        V.rotating = not V.rotating
        if V.rotating then
            updateHRP()
        end
    end
end)

_.RunService.RenderStepped:Connect(function(dt)
    if not V.rotating then return end
    if not _.humanoidRootPart or not _.humanoidRootPart.Parent then
        updateHRP()
        if not _.humanoidRootPart then return end
    end
    _.humanoidRootPart.CFrame = _.humanoidRootPart.CFrame * CFrame.Angles(0, math.rad(V.speed * dt), 0)
end)

Gunlockb:Section({Title = "子弹追踪设置"})

BulletLock_Whitelist, nameMap = {}, {}
bulletLockWhitelistDropdown = Gunlockb:Dropdown({
    Title = "子弹追踪白名单",
    Values = {},
    Multi = true,
    AllowNone = true,
    Callback = function(selected)
        BulletLock_Whitelist = {}
        for _, v in pairs(selected) do
            table.insert(BulletLock_Whitelist, WhitelistManager:GetPlayerName(v))
        end
    end
})

WhitelistManager:RegisterRefreshCallback("BulletLock", function(list)
    bulletLockWhitelistDropdown:Refresh(list)
end)

SelectedAttackMode = "准心优先"
Gunlockb:Dropdown({
    Title = "攻击模式",
    Values = {"准心优先", "距离优先"},
    Value = SelectedAttackMode,
    Callback = function(m) SelectedAttackMode = m end
})

BulletLockEnabled, BulletLockLoop, LastTargetHead, toggleConnection = false, nil, nil, nil

function getClosestHead()
    local closest, shortestDist, closestScreenDist, foundTarget = nil, math.huge, math.huge, false
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= Plr
           and not table.find(BulletLock_Whitelist, plr.Name)
           and plr.Character
           and plr.Character:FindFirstChild("Head") then
            local head = plr.Character.Head
            local dist = (head.Position - Camera.CFrame.Position).Magnitude
            if SelectedAttackMode == "距离优先" then
                if dist < shortestDist then
                    shortestDist, closest = dist, head
                    foundTarget = true
                end
            else
                local screenPos, visible = Camera:WorldToViewportPoint(head.Position)
                if visible then
                    local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
                    local screenDist = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
                    if screenDist < closestScreenDist then
                        closestScreenDist, closest = screenDist, head
                        foundTarget = true
                    end
                end
            end
        end
    end
    if foundTarget then
        LastTargetHead = closest
        return closest
    else
        return LastTargetHead
    end
end

function startBulletLock()
    if BulletLockLoop then
        BulletLockLoop:Disconnect()
        BulletLockLoop = nil
    end
    BulletLockLoop = RunService.Heartbeat:Connect(function()
        local head = getClosestHead()
        if BulletLockEnabled and head and Plr.Character and Plr.Character:FindFirstChildOfClass("Tool") then
            local tool = Plr.Character:FindFirstChildOfClass("Tool")
            if tool:FindFirstChild("Handle") then
                local character = Plr.Character
                local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                if humanoidRootPart then
                    local direction = (head.Position - humanoidRootPart.Position).Unit
                    humanoidRootPart.CFrame = CFrame.new(humanoidRootPart.Position, humanoidRootPart.Position + Vector3.new(direction.X, 0, direction.Z))
                    if tool:FindFirstChild("Handle") then
                        tool.Handle.CFrame = CFrame.new(tool.Handle.Position, head.Position)
                    end
                    tool:Activate()
                end
            end
        end
    end)
end

function stopBulletLock()
    if BulletLockLoop then
        BulletLockLoop:Disconnect()
        BulletLockLoop = nil
    end
    LastTargetHead = nil
end

function toggleBulletLock()
    BulletLockEnabled = not BulletLockEnabled
    if BulletLockEnabled then
        startBulletLock()
    else
        stopBulletLock()
    end
end

Gunlockb:Toggle({
    Title = "子弹追踪",
    Value = false,
    Callback = function(state)
        BulletLockEnabled = state
        if toggleConnection then
            toggleConnection:Disconnect()
            toggleConnection = nil
        end
        if state then
            toggleConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if not gameProcessed and input.KeyCode == Enum.KeyCode.X then
                    toggleBulletLock()
                end
            end)
            startBulletLock()
        else
            stopBulletLock()
        end
    end
})

if not _G.BulletLockHooked then
    _G.BulletLockHooked = true
    local OldNamecall
    OldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        if not BulletLockEnabled then
            return OldNamecall(self, ...)
        end
        local method = getnamecallmethod()
        if not checkcaller() and self == Workspace then
            if method == "Raycast" then
                local origin, direction, head = ..., getClosestHead()

                if origin and direction and head then
                    local rayDirection = (head.Position - origin).Unit
                    return {Instance = head, Position = head.Position, Normal = rayDirection, Material = Enum.Material.Plastic}
                end
            elseif method == "FindPartOnRay" then
                local ray, head = ..., getClosestHead()
                if ray and head then
                    local rayDirection = (head.Position - ray.Origin).Unit
                    return head, head.Position, rayDirection
                end
            end
        end
        return OldNamecall(self, ...)
    end)
end

NotificationsTab:Section({ Title = "玩家通知" })

do
    local V = {
        on = false,
        time = 5,
        times = {}
    }
    
    local function playerJoin(player)
        V.times[player] = os.time()
        if V.on then
            AlienX:Notify({Title = "加入", Content = player.Name, Duration = V.time})
        end
    end
    
    local function playerLeave(player)
        if V.on then
            AlienX:Notify({Title = "离开", Content = player.Name, Duration = V.time})
        end
        V.times[player] = nil
    end
    
    NotificationsTab:Toggle({
        Title = "玩家进入/离开通知",
        Callback = function(state)
            V.on = state
            if state then
                _.Players.PlayerAdded:Connect(playerJoin)
                _.Players.PlayerRemoving:Connect(playerLeave)
            end
        end
    })
end

V2 = {
    on = false,
    time = 5,
    connected = {}
}

function setupPlayer(player)
    if V2.connected[player] then return end
    V2.connected[player] = true

    local function onCharacterAdded(character)
        local hum = character:WaitForChild("Humanoid")
        hum.Died:Connect(function()
            if V2.on then
                AlienX:Notify({Title = "死亡", Content = player.Name, Duration = V2.time})
            end
        end)
    end

    if player.Character then
        onCharacterAdded(player.Character)
    end
    player.CharacterAdded:Connect(onCharacterAdded)
end

NotificationsTab:Toggle({
    Title = "死亡通知",
    Callback = function(state)
        V2.on = state
        if state then
            for _, player in ipairs(_.Players:GetPlayers()) do
                if player ~= Plr then
                    setupPlayer(player)
                end
            end
            _.Players.PlayerAdded:Connect(function(player)
                if player ~= Plr then
                    setupPlayer(player)
                end
            end)
        end
    end
})

settings:Section({Title = "调试设置"})

settings:Button({
    Title = "dex",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
    end
})

settings:Button({
    Title = "infinitey",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end
})

local serverId, TeleportService, HttpService, placeId = "", game:GetService("TeleportService"), game:GetService("HttpService"), 4639625707

settings:Input({
    Title = "服务器ID",
    Placeholder = "输入服务器ID",
    Callback = function(input) serverId = input end
})

settings:Button({
    Title = "进入服务器",
    Callback = function()
        if serverId ~= "" then
            pcall(TeleportService.TeleportToPlaceInstance, TeleportService, game.PlaceId, serverId, _.Players.LocalPlayer)
        end
    end
})

settings:Button({
    Title = "重进服务器",
    Callback = function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, _.Players.LocalPlayer)
    end
})

function findServer()
    local current, cursor = game.JobId, nil
    repeat
        local url = "https://games.roblox.com/v1/games/"..placeId.."/servers/Public?sortOrder=Asc&limit=100"..(cursor and "&cursor="..cursor or "")
        local data = HttpService:JSONDecode(game:HttpGet(url))
        for _, s in ipairs(data.data) do
            if s.id ~= current and s.playing < s.maxPlayers then return s.id end
        end
        cursor = data.nextPageCursor
    until not cursor
end

settings:Button({
    Title = "切换服务器",
    Callback = function()
        local jobId = findServer()
        if jobId then
            TeleportService:TeleportToPlaceInstance(placeId, jobId, _.Players.LocalPlayer)
        end
    end
})

settings:Button({
    Title = "复制当前服务器ID",
    Callback = function()
        pcall(setclipboard, game.JobId)
    end
})

settings:Input({
    Title = "设置快捷键",
    Value = "LeftControl",
    Placeholder = "输入快捷键",
    Callback = function(input)
        if input and input ~= "" then
            local keyCode = Enum.KeyCode[input]
            if keyCode then
                Window:SetToggleKey(keyCode)
            end
        end
    end
})

rightAltRefreshEnabled = true

game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.RightAlt and rightAltRefreshEnabled then
        WhitelistManager:RefreshAllLists()
        AlienX:Notify({
            Title = "刷新成功",
            Content = "玩家列表已刷新",
            Duration = 2
        })
    end
end)

TeleportTab:Button({
    Title = "刷新玩家列表 (右Alt)",
    Callback = function()
        WhitelistManager:RefreshAllLists()
        AlienX:Notify({
            Title = "刷新成功",
            Content = "玩家列表已刷新",
            Duration = 2
        })
    end
})

task.spawn(function()
    task.wait(0)
    if TeleportTab and TeleportTab.Select then
        TeleportTab:Select()
    end
end)
