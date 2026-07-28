-- =================== TAY HUB COMPLETE ===================
-- Full UI + Logic + Logo + Minimize Button

-- =================== LOAD UI LIBRARY ===================
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/discoart/FluentPlus/refs/heads/main/release.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-- =================== CREATE WINDOW ===================
local Window = Fluent:CreateWindow({
    Title = "Tay Hub",
    SubTitle = "by @tungdepzai",
    TitleIcon = "rbxassetid://96454140798208",
    Image = "rbxassetid://96454140798208",
    DropdownsOutsideWindow = true,
    Size = UDim2.fromOffset(580, 480),
    TabWidth = 180,
    Acrylic = true,
    Theme = "Dark",
    Search = true,
    MinimizeKey = Enum.KeyCode.RightControl,
    UserInfo = false,
    UserInfoTop = true,
    UserInfoTitle = game:GetService("Players").LocalPlayer.DisplayName,
    UserInfoSubtitle = "User",
    UserInfoSubtitleColor = Color3.fromRGB(255, 255, 255)
})

-- =================== CREATE MINIMIZE BUTTON WITH LOGO ===================
local Minimizer = Window:NewMinimizer({
    KeyCode = Enum.KeyCode.RightControl
})

local MobileButton = Minimizer:CreateMobileMinimizer({
    Image = "rbxassetid://96454140798208",
    BackgroundColor3 = Color3.fromRGB(0, 255, 254),
    ImageSize = UDim2.fromOffset(50, 50),
    Position = UDim2.new(0.92, 0, 0.85, 0)
})

-- =================== CREATE TABS ===================
local Tabs = {
    Info = Window:AddTab({ Title = "Info", Icon = "info" }),
    Main = Window:AddTab({ Title = "Farming", Icon = "sword" }),
    Hop = Window:AddTab({ Title = "Hop", Icon = "map-pin" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),
    Fish = Window:AddTab({ Title = "Fishing", Icon = "fish" }),
    Quests = Window:AddTab({ Title = "Quest & Item", Icon = "scroll" }),
    SeaEvent = Window:AddTab({ Title = "Sea Event", Icon = "waves" }),
    Race = Window:AddTab({ Title = "Mirage & Race", Icon = "moon" }),
    Prehistoric = Window:AddTab({ Title = "Volcano", Icon = "flame" }),
    Esp = Window:AddTab({ Title = "Stats & Esp", Icon = "eye" }),
    Raids = Window:AddTab({ Title = "Fruit & Raid", Icon = "apple" }),
    Combat = Window:AddTab({ Title = "Local Player", Icon = "user" }),
    Travel = Window:AddTab({ Title = "Teleport", Icon = "locate" }),
    Shop = Window:AddTab({ Title = "Shopping", Icon = "shopping-bag" }),
    Misc = Window:AddTab({ Title = "Miscellaneous", Icon = "settings" })
}

-- =================== BIẾN TOÀN CỤC ===================
do
    ply = game.Players
    plr = ply.LocalPlayer
    Root = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
    replicated = game:GetService("ReplicatedStorage")
    Lv = plr.Data.Level.Value
    TeleportService = game:GetService("TeleportService")
    TW = game:GetService("TweenService")
    Lighting = game:GetService("Lighting")
    Enemies = workspace.Enemies
    vim1 = game:GetService("VirtualInputManager")
    vim2 = game:GetService("VirtualUser")
    TeamSelf = plr.Team
    RunSer = game:GetService("RunService")
    Stats = game:GetService("Stats")
    shouldTween = false
    SoulGuitar = false
    KenTest = true
    Sec = 0.1
    ClickState = 0
    Num_self = 25
end

repeat 
    local start = plr.PlayerGui:WaitForChild("Main"):WaitForChild("Loading") and game:IsLoaded() 
    wait() 
until start

World1 = game.PlaceId == 2753915549 or game.PlaceId == 85211729168715
World2 = game.PlaceId == 4442272183 or game.PlaceId == 79091703265657
World3 = game.PlaceId == 7449423635 or game.PlaceId == 100117331123089

Marines = function() replicated.Remotes.CommF_:InvokeServer("SetTeam","Marines") end
Pirates = function() replicated.Remotes.CommF_:InvokeServer("SetTeam","Pirates") end

-- =================== DANH SÁCH ===================
if World1 then 
    BossList = {"The Gorilla King","Bobby","The Saw","Yeti","Mob Leader","Vice Admiral","Saber Expert","Warden","Chief Warden","Swan","Magma Admiral","Fishman Lord","Wysper","Thunder God","Cyborg","Ice Admiral","Greybeard"}
    MaterialList = {"Leather + Scrap Metal", "Angel Wings", "Magma Ore", "Fish Tail"}
elseif World2 then 
    BossList = {"Diamond","Jeremy","Orbitus","Don Swan","Smoke Admiral","Awakened Ice Admiral","Tide Keeper","Darkbeard","Cursed Captain","Order"}
    MaterialList = {"Leather + Scrap Metal", "Radioactive Material", "Ectoplasm", "Mystic Droplet", "Magma Ore", "Vampire Fang"}
elseif World3 then 
    BossList = {"Stone","Hydra Leader","Kilo Admiral","Captain Elephant","Beautiful Pirate","Cake Queen","Dough King","Longma","Soul Reaper","rip_indra True Form","Tyrant of the Skies"}
    MaterialList = {"Scrap Metal", "Demonic Wisp", "Conjured Cocoa", "Dragon Scale", "Gunpowder", "Fish Tail", "Mini Tusk"}
end

local DungeonTables = {"Flame","Ice","Quake","Light","Dark","String","Rumble","Magma","Human: Buddha","Sand","Bird: Phoenix","Dough"}
local ListSeaBoat = {"Guardian","PirateGrandBrigade","MarineGrandBrigade","PirateBrigade","MarineBrigade","PirateSloop","MarineSloop","Beast Hunter"}
local ListSeaZone = {"Lv 1","Lv 2","Lv 3","Lv 4","Lv 5","Lv 6","Lv Infinite"}
local HakiSt = {"State 0","State 1","State 2","State 3","State 4","State 5"}

-- =================== HÀM CHÍNH ===================
EquipWeapon = function(text)
    if not text then return end
    if plr.Backpack:FindFirstChild(text) then
        plr.Character.Humanoid:EquipTool(plr.Backpack:FindFirstChild(text))
    end
end

weaponSc = function(weapon)
    for __in, v in pairs(plr.Backpack:GetChildren()) do
        if v:IsA("Tool") then
            if v.ToolTip == weapon then EquipWeapon(v.Name) end
        end
    end
end

-- =================== FIX M1 FRUIT ===================
local function FixM1Fruit()
    pcall(function()
        local char = plr.Character
        if not char then return end
        
        local tool = char:FindFirstChildOfClass("Tool")
        if not tool or tool.ToolTip ~= "Blox Fruit" then return end
        
        local leftClickRemote = tool:FindFirstChild("LeftClickRemote")
        if leftClickRemote then
            pcall(function()
                leftClickRemote:FireServer(Vector3.new(0.01, -500, 0.01), 1, true)
                wait(0.03)
                leftClickRemote:FireServer(false)
            end)
        end
        
        local remoteEvent = tool:FindFirstChild("RemoteEvent")
        if remoteEvent then
            pcall(function()
                remoteEvent:FireServer("M1")
            end)
        end
        
        vim1:SendMouseButtonEvent(0, 0, 0, true, game, 1)
        wait(0.03)
        vim1:SendMouseButtonEvent(0, 0, 0, false, game, 1)
    end)
end

-- =================== ATTACK MODULE ===================
local Attack = {}
Attack.__index = Attack

Attack.Alive = function(model) 
    if not model then return end 
    local Humanoid = model:FindFirstChild("Humanoid") 
    return Humanoid and Humanoid.Health > 0 
end

Attack.Kill = function(model, Succes)
    if model and Succes then
        if not model:GetAttribute("Locked") then 
            model:SetAttribute("Locked", model.HumanoidRootPart.CFrame) 
        end
        PosMon = model:GetAttribute("Locked").Position
        BringEnemy()
        EquipWeapon(_G.SelectWeapon)
        
        local char = plr.Character
        if not char then return end
        
        local tool = char:FindFirstChildOfClass("Tool")
        if not tool then return end
        
        local ToolTip = tool.ToolTip
        
        if ToolTip == "Blox Fruit" then
            _tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0) * CFrame.Angles(0, math.rad(90), 0))
            FixM1Fruit()
        else
            _tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0) * CFrame.Angles(0, math.rad(180), 0))
        end
        
        if RandomCFrame then
            wait(0.5)
            _tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25))
            wait(0.5)
            _tp(model.HumanoidRootPart.CFrame * CFrame.new(25, 30, 0))
            wait(0.5)
            _tp(model.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0))
            wait(0.5)
            _tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25))
            wait(0.5)
            _tp(model.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0))
        end
    end
end

Attack.KillSea = function(model, Succes)
    if model and Succes then
        if not model:GetAttribute("Locked") then 
            model:SetAttribute("Locked", model.HumanoidRootPart.CFrame) 
        end
        PosMon = model:GetAttribute("Locked").Position
        BringEnemy()
        EquipWeapon(_G.SelectWeapon)
        
        local char = plr.Character
        if not char then return end
        
        local tool = char:FindFirstChildOfClass("Tool")
        if not tool then return end
        
        local ToolTip = tool.ToolTip
        local targetPos = model.HumanoidRootPart.Position
        local waterLevel = workspace.Map["WaterBase-Plane"].Position.Y
        
        if model.Name == "Leviathan" or model:FindFirstChild("Leviathan Segment") or model.Name == "SeaBeast1" then
            _tp(CFrame.new(targetPos.X, waterLevel + 200, targetPos.Z))
            
            for i = 1, 10 do
                if not model.Parent or model.Health.Value <= 0 then break end
                
                local currentPos = model.HumanoidRootPart.Position
                if (char.HumanoidRootPart.Position - CFrame.new(currentPos.X, waterLevel + 200, currentPos.Z).Position).Magnitude > 100 then
                    _tp(CFrame.new(currentPos.X, waterLevel + 200, currentPos.Z))
                end
                
                if ToolTip == "Blox Fruit" then
                    FixM1Fruit()
                    vim1:SendKeyEvent(true, "Z", false, game)
                    wait(0.05)
                    vim1:SendKeyEvent(false, "Z", false, game)
                    wait(0.05)
                    vim1:SendKeyEvent(true, "X", false, game)
                    wait(0.05)
                    vim1:SendKeyEvent(false, "X", false, game)
                    wait(0.05)
                    vim1:SendKeyEvent(true, "C", false, game)
                    wait(0.05)
                    vim1:SendKeyEvent(false, "C", false, game)
                    wait(0.1)
                elseif ToolTip == "Gun" then
                    local RE_ShootGunEvent = replicated.Modules.Net["RE/ShootGunEvent"]
                    if RE_ShootGunEvent then
                        RE_ShootGunEvent:FireServer(currentPos, { model.HumanoidRootPart })
                    end
                    vim1:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                    wait(0.03)
                    vim1:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                    wait(0.05)
                    vim1:SendKeyEvent(true, "Z", false, game)
                    wait(0.05)
                    vim1:SendKeyEvent(false, "Z", false, game)
                    wait(0.05)
                    vim1:SendKeyEvent(true, "X", false, game)
                    wait(0.05)
                    vim1:SendKeyEvent(false, "X", false, game)
                    wait(0.1)
                else
                    vim1:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                    wait(0.03)
                    vim1:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                    wait(0.05)
                    vim1:SendKeyEvent(true, "Z", false, game)
                    wait(0.05)
                    vim1:SendKeyEvent(false, "Z", false, game)
                    wait(0.05)
                    vim1:SendKeyEvent(true, "X", false, game)
                    wait(0.05)
                    vim1:SendKeyEvent(false, "X", false, game)
                    wait(0.05)
                    vim1:SendKeyEvent(true, "C", false, game)
                    wait(0.05)
                    vim1:SendKeyEvent(false, "C", false, game)
                    wait(0.1)
                end
            end
            return
        end
        
        if ToolTip == "Blox Fruit" then
            _tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
            FixM1Fruit()
            vim1:SendKeyEvent(true, "Z", false, game)
            wait(0.05)
            vim1:SendKeyEvent(false, "Z", false, game)
            wait(0.05)
            vim1:SendKeyEvent(true, "X", false, game)
            wait(0.05)
            vim1:SendKeyEvent(false, "X", false, game)
            wait(0.05)
            vim1:SendKeyEvent(true, "C", false, game)
            wait(0.05)
            vim1:SendKeyEvent(false, "C", false, game)
            wait(0.1)
        elseif ToolTip == "Gun" then
            _tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 35, 8))
            local RE_ShootGunEvent = replicated.Modules.Net["RE/ShootGunEvent"]
            if RE_ShootGunEvent then
                RE_ShootGunEvent:FireServer(model.HumanoidRootPart.Position, { model.HumanoidRootPart })
            end
            vim1:SendMouseButtonEvent(0, 0, 0, true, game, 1)
            wait(0.03)
            vim1:SendMouseButtonEvent(0, 0, 0, false, game, 1)
            wait(0.05)
            vim1:SendKeyEvent(true, "Z", false, game)
            wait(0.05)
            vim1:SendKeyEvent(false, "Z", false, game)
            wait(0.05)
            vim1:SendKeyEvent(true, "X", false, game)
            wait(0.05)
            vim1:SendKeyEvent(false, "X", false, game)
            wait(0.1)
        else
            _tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
            vim1:SendMouseButtonEvent(0, 0, 0, true, game, 1)
            wait(0.03)
            vim1:SendMouseButtonEvent(0, 0, 0, false, game, 1)
            wait(0.05)
            vim1:SendKeyEvent(true, "Z", false, game)
            wait(0.05)
            vim1:SendKeyEvent(false, "Z", false, game)
            wait(0.05)
            vim1:SendKeyEvent(true, "X", false, game)
            wait(0.05)
            vim1:SendKeyEvent(false, "X", false, game)
            wait(0.05)
            vim1:SendKeyEvent(true, "C", false, game)
            wait(0.05)
            vim1:SendKeyEvent(false, "C", false, game)
            wait(0.1)
        end
    end
end

-- =================== TELEPORT FUNCTIONS ===================
_tp = function(target)
    local gg
    if typeof(target) == "Vector3" then
        gg = CFrame.new(target)
    elseif typeof(target) == "CFrame" then
        gg = target
    else
        gg = target and target.CFrame
    end
    
    if not gg then return end
    
    local character = plr.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    local rootPart = character.HumanoidRootPart
    
    local distance = (gg.Position - rootPart.Position).Magnitude
    local tweenInfo = TweenInfo.new(distance / 300, Enum.EasingStyle.Linear)
    local tween = game:GetService("TweenService"):Create(block, tweenInfo, {CFrame = gg})
    
    if plr.Character.Humanoid.Sit == true then
        block.CFrame = CFrame.new(block.Position.X, gg.Y, block.Position.Z)
    end
    
    tween:Play()
    
    task.spawn(function() 
        while tween.PlaybackState == Enum.PlaybackState.Playing do 
            if not shouldTween then 
                tween:Cancel() 
                break 
            end 
            task.wait(0.1) 
        end 
    end)
    
    return tween
end

old_tp = function(p) 
    local char = plr.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = p 
    end
end

TeleportToTarget = function(targetCFrame) 
    if (targetCFrame.Position - plr.Character.HumanoidRootPart.Position).Magnitude > 1000 then 
        _tp(targetCFrame)
    else 
        _tp(targetCFrame)
    end
end

notween = function(p) 
    plr.Character.HumanoidRootPart.CFrame = p 
end

function topos(target)
    _tp(target)
end

function fireproximityprompt(prompt, holdTime)
    if not prompt then return end
    if not holdTime then holdTime = 1 end
    pcall(function()
        if prompt:IsA("ProximityPrompt") then
            prompt:InputHoldBegin()
            wait(holdTime)
            prompt:InputHoldEnd()
        end
    end)
end

function fireclickdetector(detector)
    if not detector then return end
    pcall(function()
        if detector:IsA("ClickDetector") then
            detector:Click()
        end
    end)
end

-- =================== NOCLIP + TWEEN BLOCK ===================
local block = Instance.new("Part", workspace)
block.Size = Vector3.new(1, 1, 1)
block.Name = "Rip_Indra"
block.Anchored = true
block.CanCollide = false
block.CanTouch = false
block.Transparency = 1

task.spawn(function()
    while task.wait() do
        if block and block.Parent == workspace then
            if shouldTween then 
                getgenv().OnFarm = true 
            else 
                getgenv().OnFarm = false 
            end
        else 
            getgenv().OnFarm = false 
        end
    end
end)

task.spawn(function()
    local a = game.Players.LocalPlayer
    repeat task.wait() until a.Character and a.Character.PrimaryPart
    block.CFrame = a.Character.PrimaryPart.CFrame
    while task.wait() do
        pcall(function()
            if getgenv().OnFarm then
                if block and block.Parent == workspace then
                    local b = a.Character and a.Character.PrimaryPart
                    if b and (b.Position - block.Position).Magnitude <= 200 then 
                        b.CFrame = block.CFrame 
                    else 
                        block.CFrame = b.CFrame 
                    end
                end
                local c = a.Character
                if c then
                    for d, e in pairs(c:GetChildren()) do
                        if e:IsA("BasePart") then 
                            e.CanCollide = false 
                        end
                    end
                end
            else
                local c = a.Character
                if c then
                    for d, e in pairs(c:GetChildren()) do
                        if e:IsA("BasePart") then 
                            e.CanCollide = true 
                        end
                    end
                end
            end
        end)
    end
end)

spawn(function()
    while task.wait() do
        pcall(function()
            if _G.SailBoats or _G.Prehis_Find or _G.FindMirage or _G.SailBoat_Hydra or _G.AutofindKitIs then
                for a,b in pairs(workspace.Boats:GetChildren()) do
                    for c,d in pairs(workspace.Boats[b.Name]:GetDescendants()) do
                        if d:IsA("BasePart") then
                            d.CanCollide = false
                        end
                    end
                end
            else
                for a,b in pairs(workspace.Boats:GetChildren()) do
                    for c,d in pairs(workspace.Boats[b.Name]:GetDescendants()) do
                        if d:IsA("BasePart") then
                            d.CanCollide = true
                        end
                    end
                end
            end
        end)
    end
end)

-- =================== SEA EVENT LOOP ===================
spawn(function()
    while wait() do
        pcall(function()
            if _G.Leviathan1 then
                if workspace.SeaBeasts:FindFirstChild("Leviathan") then
                    for _, leviathan in pairs(workspace.SeaBeasts:GetChildren()) do
                        if leviathan:FindFirstChild("HumanoidRootPart") 
                            and leviathan:FindFirstChild("Health") 
                            and leviathan.Health.Value > 0 then
                            repeat
                                wait(0.2)
                                Attack.KillSea(leviathan, _G.Leviathan1)
                            until not _G.Leviathan1 
                                or not leviathan.Parent 
                                or leviathan.Health.Value <= 0
                        end
                    end
                end
            end
            
            if _G.SeaBeast1 then
                if workspace.SeaBeasts:FindFirstChild("SeaBeast1") then
                    for _, beast in pairs(workspace.SeaBeasts:GetChildren()) do
                        if beast:FindFirstChild("HumanoidRootPart") 
                            and beast:FindFirstChild("Health") 
                            and beast.Health.Value > 0 then
                            repeat
                                wait(0.2)
                                Attack.KillSea(beast, _G.SeaBeast1)
                            until not _G.SeaBeast1 
                                or not beast.Parent 
                                or beast.Health.Value <= 0
                        end
                    end
                end
            end
            
            if _G.TerrorShark then
                for _, shark in pairs(workspace.Enemies:GetChildren()) do
                    if shark.Name == "Terrorshark" and Attack.Alive(shark) then
                        repeat
                            wait(0.2)
                            Attack.KillSea(shark, _G.TerrorShark)
                        until not _G.TerrorShark 
                            or not shark.Parent 
                            or shark.Humanoid.Health <= 0
                    end
                end
            end
            
            if _G.FishBoat then
                for _, boat in pairs(workspace.Enemies:GetChildren()) do
                    if boat.Name == "FishBoat" 
                        and boat:FindFirstChild("Health") 
                        and boat.Health.Value > 0 
                        and boat:FindFirstChild("Engine") then
                        repeat
                            wait(0.2)
                            _tp(boat.Engine.CFrame * CFrame.new(0, -20, -15))
                            Attack.KillSea(boat, _G.FishBoat)
                        until not _G.FishBoat 
                            or not boat.Parent 
                            or boat.Health.Value <= 0
                    end
                end
            end
            
            if _G.PGB then
                for _, pg in pairs(workspace.Enemies:GetChildren()) do
                    if (pg.Name == "PirateGrandBrigade" or pg.Name == "PirateBrigade") 
                        and pg:FindFirstChild("Health") 
                        and pg.Health.Value > 0 
                        and pg:FindFirstChild("Engine") then
                        repeat
                            wait(0.2)
                            _tp(pg.Engine.CFrame * CFrame.new(0, -20, -10))
                            Attack.KillSea(pg, _G.PGB)
                        until not _G.PGB 
                            or not pg.Parent 
                            or pg.Health.Value <= 0
                    end
                end
            end
        end)
    end
end)

-- =================== SAIL BOAT LOOP ===================
CheckBoat = function()
    for i, v in pairs(workspace.Boats:GetChildren()) do
        if tostring(v.Owner.Value) == tostring(plr.Name) then
            return v    
        end
    end
    return false
end

CheckEnemiesBoat = function()
    for _,v in pairs(workspace.Enemies:GetChildren()) do
        if (v.Name == "FishBoat") and v:FindFirstChild("Health").Value > 0 then
            return true    
        end
    end
    return false
end

CheckPirateGrandBrigade = function()
    for _,v in pairs(workspace.Enemies:GetChildren()) do
        if (v.Name == "PirateGrandBrigade" or v.Name == "PirateBrigade") and v:FindFirstChild("Health").Value > 0 then
            return true
        end
    end
    return false
end

CheckShark = function()
    for _,v in pairs(workspace.Enemies:GetChildren()) do
        if v.Name == "Shark" and Attack.Alive(v) then
            return true    
        end
    end
    return false
end

CheckTerrorShark = function()
    for _,v in pairs(workspace.Enemies:GetChildren()) do
        if v.Name == "Terrorshark" and Attack.Alive(v) then
            return true    
        end
    end
    return false
end

CheckSeaBeast = function()
    if workspace.SeaBeasts:FindFirstChild("SeaBeast1") then
        return true  
    end
    return false
end

CheckLeviathan = function()
    if workspace.SeaBeasts:FindFirstChild("Leviathan") then
        return true  
    end
    return false
end

spawn(function()
    while wait() do
        if _G.SailBoats then 
            pcall(function()        
                local myBoat = CheckBoat()
                if not myBoat and not(CheckShark() and _G.Shark or CheckTerrorShark() and _G.TerrorShark or CheckEnemiesBoat() and _G.FishBoat) and not(CheckSeaBeast() and _G.SeaBeast1) and not(_G.PGB and CheckPirateGrandBrigade()) and not(_G.Leviathan1 and CheckLeviathan()) then
                    local buyBoatCFrame = CFrame.new(-16927.451, 9.086, 433.864)
                    TeleportToTarget(buyBoatCFrame)
                    if (buyBoatCFrame.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 then 
                        replicated.Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat) 
                    end
                elseif myBoat and not(CheckShark() and _G.Shark or CheckTerrorShark() and _G.TerrorShark or CheckEnemiesBoat() and _G.FishBoat) and not(CheckSeaBeast() and _G.SeaBeast1) and not(_G.PGB and CheckPirateGrandBrigade()) and not(_G.Leviathan1 and CheckLeviathan()) then
                    if plr.Character.Humanoid.Sit == false then
                        local boatSeatCFrame = myBoat.VehicleSeat.CFrame * CFrame.new(0, 1, 0)
                        _tp(boatSeatCFrame)
                    else                         
                        if _G.DangerSc == "Lv 1" then CFrameSelectedZone = CFrame.new(-21998.375, 30.0006084, -682.309143)
                        elseif _G.DangerSc == "Lv 2" then CFrameSelectedZone = CFrame.new(-26779.5215, 30.0005474, -822.858032)
                        elseif _G.DangerSc == "Lv 3" then CFrameSelectedZone = CFrame.new(-31171.957, 30.0001011, -2256.93774)
                        elseif _G.DangerSc == "Lv 4" then CFrameSelectedZone = CFrame.new(-34054.6875, 30.2187767, -2560.12012)
                        elseif _G.DangerSc == "Lv 5" then CFrameSelectedZone = CFrame.new(-38887.5547, 30.0004578, -2162.99023)
                        elseif _G.DangerSc == "Lv 6" then CFrameSelectedZone = CFrame.new(-44541.7617, 30.0003204, -1244.8584)
                        elseif _G.DangerSc == "Lv Infinite" then CFrameSelectedZone = CFrame.new(-10000000, 31, 37016.25)
                        end           
                        repeat wait() 
                            if (not _G.FishBoat and CheckEnemiesBoat()) or (not _G.PGB and CheckPirateGrandBrigade()) or (not _G.TerrorShark and CheckTerrorShark()) then
                                _tp(CFrameSelectedZone * CFrame.new(0, 150, 0))
                            else
                                _tp(CFrameSelectedZone)
                            end           
                        until _G.SailBoats == false or (CheckShark() and _G.Shark or CheckTerrorShark() and _G.TerrorShark or CheckEnemiesBoat() and _G.FishBoat) or CheckSeaBeast() and _G.SeaBeast1 or _G.Leviathan1 and CheckLeviathan() or _G.PGB and CheckPirateGrandBrigade() or plr.Character:WaitForChild("Humanoid").Sit == false
                        plr.Character.Humanoid.Sit = false
                    end
                end
            end)
        end
    end
end)

-- =================== BUILD UI ===================

-- ===== TAB INFO =====
Tabs.Info:AddSection("Information")
Tabs.Info:AddParagraph("Tay Hub | Community", "A community for Tay hub Users - official scripts, updates, and support in one place.")

local TimeZone = Tabs.Info:AddParagraph("Time Zone", "Loading...")
spawn(function()
    while true do
        local date = os.date("*t")
        local hour = (date.hour) % 24
        local ampm = hour < 12 and "AM" or "PM"
        local timezone = string.format("%02i:%02i:%02i %s", ((hour - 1) % 12) + 1, date.min, date.sec, ampm)
        local datetime = string.format("%02d/%02d/%04d", date.day, date.month, date.year)
        TimeZone:SetContent(datetime.." - "..timezone)
        wait(1)
    end
end)

local GameTime = Tabs.Info:AddParagraph("Game Time", "Loading...")
spawn(function()
    while true do
        local GameTimeValue = math.floor(workspace.DistributedGameTime + 0.5)
        local Hour = math.floor(GameTimeValue / (60^2)) % 24
        local Minute = math.floor(GameTimeValue / (60^1)) % 60
        local Second = math.floor(GameTimeValue / (60^0)) % 60
        GameTime:SetContent(Hour.."h "..Minute.."m "..Second.."s")
        wait(1)
    end
end)

local MirageCheck = Tabs.Info:AddParagraph("Mirage Island", "Status: ❌")
spawn(function()
    while wait(1) do
        local exists = workspace._WorldOrigin.Locations:FindFirstChild('Mirage Island') ~= nil
        MirageCheck:SetContent("Status: " .. (exists and '✅' or '❌'))
    end
end)

local KitsuneCheck = Tabs.Info:AddParagraph("Kitsune Island", "Status: ❌")
spawn(function()
    while wait(1) do
        local exists = workspace.Map:FindFirstChild("KitsuneIsland") ~= nil
        KitsuneCheck:SetContent("Status: " .. (exists and '✅' or '❌'))
    end
end)

local FullMoonCheck = Tabs.Info:AddParagraph("Full Moon", "Loading...")
spawn(function()
    while wait(1) do
        local moonId = Lighting.Sky.MoonTextureId
        local status = "Moon: 0/5"
        if moonId == "http://www.roblox.com/asset/?id=9709149431" then
            status = "Moon: 5/5 (Full Moon) ✅"
        elseif moonId == "http://www.roblox.com/asset/?id=9709149052" then
            status = "Moon: 4/5"
        elseif moonId == "http://www.roblox.com/asset/?id=9709143733" then
            status = "Moon: 3/5"
        end
        FullMoonCheck:SetContent(status)
    end
end)

-- ===== TAB MAIN =====
Tabs.Main:AddSection("Settings")

Tabs.Main:AddDropdown("Select Weapon", {
    Title = "Select Weapon",
    Options = {"Melee", "Sword", "Blox Fruit", "Gun"},
    Default = "Melee",
    Callback = function(Value)
        _G.ChooseWP = Value
        _G.SelectWeapon = Value
    end
})

Tabs.Main:AddSection("Farming")

Tabs.Main:AddToggle("Auto Farm Level", {
    Title = "Auto Farm Level",
    Default = false,
    Callback = function(Value)
        _G.Level = Value
    end
})

Tabs.Main:AddToggle("Auto Farm Nearest", {
    Title = "Auto Farm Nearest",
    Default = false,
    Callback = function(Value)
        _G.AutoFarmNear = Value
    end
})

Tabs.Main:AddToggle("Auto Factory Raid", {
    Title = "Auto Factory Raid",
    Default = false,
    Callback = function(Value)
        _G.AutoFactory = Value
    end
})

Tabs.Main:AddToggle("Auto Pirate Raid", {
    Title = "Auto Pirate Raid",
    Default = false,
    Callback = function(Value)
        _G.AutoRaidCastle = Value
    end
})

Tabs.Main:AddToggle("Auto Farm Ectoplasm", {
    Title = "Auto Farm Ectoplasm",
    Default = false,
    Callback = function(Value)
        _G.AutoEctoplasm = Value
    end
})

Tabs.Main:AddSection("Chest")

Tabs.Main:AddToggle("Auto Farm Chest", {
    Title = "Auto Farm Chest",
    Default = false,
    Callback = function(Value)
        _G.AutoFarmChest = Value
    end
})

Tabs.Main:AddToggle("Auto Chest Bypass", {
    Title = "Auto Chest Bypass",
    Default = false,
    Callback = function(Value)
        _G.AutoChestBP = Value
    end
})

Tabs.Main:AddToggle("Stop Items", {
    Title = "Stop Items",
    Default = true,
    Callback = function(Value)
        _G.StopWhenChalice = Value
    end
})

Tabs.Main:AddSection("Collect Berry")

Tabs.Main:AddToggle("Auto Farm Berry", {
    Title = "Auto Farm Berry",
    Default = false,
    Callback = function(Value)
        _G.AutoBerry = Value
    end
})

Tabs.Main:AddToggle("Auto Farm Berry + Hop", {
    Title = "Auto Farm Berry + Hop",
    Default = false,
    Callback = function(Value)
        _G.AutoBerryH = Value
    end
})

Tabs.Main:AddSection("Farm Mob")

if World1 then
    Tabs.Main:AddDropdown("Select Mob", {
        Title = "Select Mob",
        Options = {"Bandit", "Monkey", "Gorilla", "Pirate", "Brute", "Desert Bandit", "Desert Officer", "Snow Bandit", "Snowman", "Chief Petty Officer", "Sky Bandit", "Dark Master", "Toga Warrior", "Gladiator", "Military Soldier", "Military Spy", "Fishman Warrior", "Fishman Commando", "God's Guard", "Shanda", "Royal Squad", "Royal Soldier", "Galley Pirate", "Galley Captain"},
        Default = "Bandit",
        Callback = function(Value)
            getgenv().SelectMob = Value
        end
    })
elseif World2 then
    Tabs.Main:AddDropdown("Select Mob", {
        Title = "Select Mob",
        Options = {"Raider", "Mercenary", "Swan Pirate", "Factory Staff", "Marine Lieutenant", "Marine Captain", "Zombie", "Vampire", "Snow Trooper", "Winter Warrior", "Lab Subordinate", "Horned Warrior", "Magma Ninja", "Lava Pirate", "Ship Deckhand", "Ship Engineer", "Ship Steward", "Ship Officer", "Arctic Warrior", "Snow Lurker", "Sea Soldier", "Water Fighter"},
        Default = "Raider",
        Callback = function(Value)
            getgenv().SelectMob = Value
        end
    })
elseif World3 then
    Tabs.Main:AddDropdown("Select Mob", {
        Title = "Select Mob",
        Options = {"Pirate Millionaire", "Dragon Crew Warrior", "Dragon Crew Archer", "Female Islander", "Giant Islander", "Marine Commodore", "Marine Rear Admiral", "Fishman Raider", "Fishman Captain", "Forest Pirate", "Mythological Pirate", "Jungle Pirate", "Musketeer Pirate", "Reborn Skeleton", "Living Zombie", "Demonic Soul", "Posessed Mummy", "Peanut Scout", "Peanut President", "Ice Cream Chef", "Ice Cream Commander", "Cookie Crafter", "Cake Guard", "Baking Staff", "Head Baker", "Cocoa Warrior", "Chocolate Bar Battler", "Sweet Thief", "Candy Rebel", "Candy Pirate", "Snow Demon", "Isle Outlaw", "Island Boy", "Sun-kissed Warrior", "Isle Champion"},
        Default = "Pirate Millionaire",
        Callback = function(Value)
            getgenv().SelectMob = Value
        end
    })
end

Tabs.Main:AddToggle("Auto Kill Mob", {
    Title = "Auto Kill Mob",
    Default = false,
    Callback = function(Value)
        _G.AutoKillMob = Value
    end
})

Tabs.Main:AddSection("Farm Boss")

Tabs.Main:AddDropdown("Select Boss", {
    Title = "Select Boss",
    Options = BossList,
    Default = BossList[1] or "The Gorilla King",
    Callback = function(Value)
        _G.FindBoss = Value
    end
})

Tabs.Main:AddToggle("Auto Farm Boss", {
    Title = "Auto Farm Boss",
    Default = false,
    Callback = function(Value)
        _G.FarmBoss = Value
    end
})

Tabs.Main:AddToggle("Auto Farm All Boss", {
    Title = "Auto Farm All Boss",
    Default = false,
    Callback = function(Value)
        _G.AutoFarmAllBoss = Value
    end
})

Tabs.Main:AddSection("Farm Material")

Tabs.Main:AddDropdown("Choose Material", {
    Title = "Choose Material",
    Options = MaterialList,
    Default = MaterialList[1] or "Leather + Scrap Metal",
    Callback = function(Value)
        getgenv().SelectMaterial = Value
    end
})

Tabs.Main:AddToggle("Auto Farm Materials", {
    Title = "Auto Farm Materials",
    Default = false,
    Callback = function(Value)
        getgenv().AutoMaterial = Value
    end
})

-- ===== TAB SETTINGS =====
Tabs.Settings:AddSection("Settings / Configure")

Tabs.Settings:AddToggle("Fast Attack", {
    Title = "Fast Attack",
    Default = true,
    Callback = function(Value)
        _G.Seriality = Value
    end
})

Tabs.Settings:AddToggle("Bring Mobs", {
    Title = "Bring Mobs",
    Default = true,
    Callback = function(Value)
        _B = Value
    end
})

Tabs.Settings:AddToggle("Auto Turn on Buso", {
    Title = "Auto Turn on Buso",
    Default = true,
    Callback = function(Value)
        Boud = Value
    end
})

Tabs.Settings:AddToggle("Safe Mode", {
    Title = "Safe Mode",
    Default = false,
    Callback = function(Value)
        _G.Safemode = Value
    end
})

Tabs.Settings:AddToggle("Remove Hit VFX", {
    Title = "Remove Hit VFX",
    Default = false,
    Callback = function(Value)
        _G.DestroyHit = Value
    end
})

Tabs.Settings:AddToggle("Anti AFK", {
    Title = "Anti AFK",
    Default = true,
    Callback = function(Value)
        if Value then
            local vu = game:GetService("VirtualUser")
            repeat wait() until game:IsLoaded()
            game:GetService("Players").LocalPlayer.Idled:Connect(function()
                vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                wait(1)
                vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            end)
        end
    end
})

Tabs.Settings:AddToggle("No Clip", {
    Title = "No Clip",
    Default = false,
    Callback = function(Value)
        getgenv().NoClip = Value
    end
})

-- ===== TAB SEA EVENT =====
Tabs.SeaEvent:AddSection("Sea Event")

Tabs.SeaEvent:AddToggle("Ship Speed Modifier", {
    Title = "Ship Speed Modifier",
    Default = false,
    Callback = function(Value)
        getgenv().SpeedBoat = Value
    end
})

Tabs.SeaEvent:AddSlider("Ship Speed", {
    Title = "Ship Speed",
    Min = 0,
    Max = 1000,
    Default = 300,
    Callback = function(Value)
        SetSpeedBoat = Value
    end
})

Tabs.SeaEvent:AddToggle("Auto Press W", {
    Title = "Auto Press W",
    Default = false,
    Callback = function(Value)
        getgenv().AutoPressW = Value
    end
})

Tabs.SeaEvent:AddToggle("No Clip Ship", {
    Title = "No Clip Ship",
    Default = false,
    Callback = function(Value)
        getgenv().NoClipShip = Value
    end
})

Tabs.SeaEvent:AddSection("Choose Sea Event")

Tabs.SeaEvent:AddDropdown("Select Boats", {
    Title = "Select Boats",
    Options = ListSeaBoat,
    Default = ListSeaBoat[1],
    Callback = function(Value)
        _G.SelectedBoat = Value
    end
})

Tabs.SeaEvent:AddDropdown("Select Sea Level", {
    Title = "Select Sea Level",
    Options = ListSeaZone,
    Default = ListSeaZone[1],
    Callback = function(Value)
        _G.DangerSc = Value
    end
})

Tabs.SeaEvent:AddToggle("Auto Sail Boat", {
    Title = "Auto Sail Boat",
    Default = false,
    Callback = function(Value)
        _G.SailBoats = Value
    end
})

Tabs.SeaEvent:AddSection("Entity Sea Event")

Tabs.SeaEvent:AddToggle("Auto Shark", {
    Title = "Auto Shark",
    Default = false,
    Callback = function(Value)
        _G.Shark = Value
    end
})

Tabs.SeaEvent:AddToggle("Auto Terror Shark", {
    Title = "Auto Terror Shark",
    Default = false,
    Callback = function(Value)
        _G.TerrorShark = Value
    end
})

Tabs.SeaEvent:AddToggle("Auto Attack Sea Beast", {
    Title = "Auto Attack Sea Beast",
    Default = false,
    Callback = function(Value)
        _G.SeaBeast1 = Value
    end
})

Tabs.SeaEvent:AddToggle("Auto Attack Leviathan", {
    Title = "Auto Attack Leviathan",
    Default = false,
    Callback = function(Value)
        _G.Leviathan1 = Value
    end
})

Tabs.SeaEvent:AddToggle("Auto Attack Fish Boat", {
    Title = "Auto Attack Fish Boat",
    Default = false,
    Callback = function(Value)
        _G.FishBoat = Value
    end
})

Tabs.SeaEvent:AddToggle("Auto Attack PirateGrandBrigade", {
    Title = "Auto Attack PirateGrandBrigade",
    Default = false,
    Callback = function(Value)
        _G.PGB = Value
    end
})

-- ===== TAB HOP =====
Tabs.Hop:AddSection("Server Browser")

Tabs.Hop:AddToggle("Auto Hop Full Moon", {
    Title = "Auto Hop Full Moon",
    Default = false,
    Callback = function(Value)
        _G.AutoHopFullMoon = Value
        if Value then
            task.spawn(function()
                while _G.AutoHopFullMoon do
                    pcall(function()
                        local servers = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
                        for _, v in pairs(servers.data) do
                            if v.playing < v.maxPlayers and v.id ~= game.JobId then
                                local isFullMoon = false
                                pcall(function()
                                    isFullMoon = game:GetService("TeleportService"):GetServerInfo(v.id).MoonPhase == 5
                                end)
                                if isFullMoon then
                                    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, v.id)
                                    break
                                end
                            end
                        end
                    end)
                    task.wait(1)
                end
            end)
        end
    end
})

Tabs.Hop:AddButton("Hop Server", {
    Title = "Hop Server",
    Callback = function()
        task.spawn(function()
            local servers = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
            for _, v in pairs(servers.data) do
                if v.playing < v.maxPlayers and v.id ~= game.JobId then
                    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, v.id)
                    break
                end
            end
        end)
    end
})

Tabs.Hop:AddButton("Copy JobID", {
    Title = "Copy JobID",
    Callback = function()
        setclipboard(tostring(game.JobId))
        Window:Notify({
            Title = "Tay Hub",
            Content = "Đã copy JobID: " .. game.JobId,
            Duration = 3
        })
    end
})

-- ===== TAB MISC =====
Tabs.Misc:AddSection("Player Gui / Others")

Tabs.Misc:AddButton("Set Pirate Team", {
    Title = "Set Pirate Team",
    Callback = function()
        Pirates()
        Window:Notify({
            Title = "Tay Hub",
            Content = "Đã chuyển sang đội Pirate!",
            Duration = 2
        })
    end
})

Tabs.Misc:AddButton("Set Marine Team", {
    Title = "Set Marine Team",
    Callback = function()
        Marines()
        Window:Notify({
            Title = "Tay Hub",
            Content = "Đã chuyển sang đội Marine!",
            Duration = 2
        })
    end
})

Tabs.Misc:AddButton("Redeem All Codes", {
    Title = "Redeem All Codes",
    Callback = function()
        local codes = {"LIGHTNINGABUSE","1LOSTADMIN","ADMINFIGHT","GIFTING_HOURS","NOMOREHACK","BANEXPLOIT","WildDares","BossBuild","GetPranked","EARN_FRUITS","SUB2GAMERROBOT_RESET1","KITT_RESET","Bignews","CHANDLER","Fudd10","fudd10_v2","Sub2UncleKizaru","FIGHT4FRUIT","kittgaming","TRIPLEABUSE","Sub2CaptainMaui","Sub2Fer999","Enyu_is_Pro","Magicbus","JCWK","Starcodeheo","Bluxxy","SUB2GAMERROBOT_EXP1","Sub2NoobMaster123","Sub2Daigrock","Axiore","TantaiGaming","StrawHatMaine","Sub2OfficialNoobie","TheGreatAce","JULYUPDATE_RESET","ADMINHACKED","SEATROLLING","24NOADMIN","ADMIN_TROLL","NEWTROLL","SECRET_ADMIN","staffbattle","NOEXPLOIT","NOOB2ADMIN","CODESLIDE","fruitconcepts","krazydares"}
        local RedeemRemote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):FindFirstChild("Redeem")
        if not RedeemRemote then return end
        for _, code in ipairs(codes) do
            task.wait(0.1)
            pcall(function()
                RedeemRemote:InvokeServer(code)
            end)
        end
        Window:Notify({
            Title = "Tay Hub",
            Content = "Đã redeem tất cả codes!",
            Duration = 3
        })
    end
})

Tabs.Misc:AddSection("Graphics")

Tabs.Misc:AddToggle("Turn on Full Bright", {
    Title = "Turn on Full Bright",
    Default = false,
    Callback = function(Value)
        if Value then
            Lighting.Ambient = Color3.new(1, 1, 1)
            Lighting.ColorShift_Bottom = Color3.new(1, 1, 1)
            Lighting.ColorShift_Top = Color3.new(1, 1, 1)
        else
            Lighting.Ambient = Color3.new(0, 0, 0)
            Lighting.ColorShift_Bottom = Color3.new(0, 0, 0)
            Lighting.ColorShift_Top = Color3.new(0, 0, 0)
        end
    end
})

Tabs.Misc:AddButton("Turn on Low CPU", {
    Title = "Turn on Low CPU",
    Callback = function()
        local decalsyeeted = true
        local g = game
        local w = g.Workspace
        local l = g.Lighting
        local t = w.Terrain
        t.WaterWaveSize = 0
        t.WaterWaveSpeed = 0
        t.WaterReflectance = 0
        t.WaterTransparency = 0
        l.GlobalShadows = false
        l.FogEnd = 9e9
        l.Brightness = 0
        settings().Rendering.QualityLevel = "Level01"
        for i, v in pairs(g:GetDescendants()) do
            if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
                v.Material = "Plastic"
                v.Reflectance = 0
            elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
                v.Transparency = 1
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Lifetime = NumberRange.new(0)
            elseif v:IsA("Explosion") then
                v.BlastPressure = 1
                v.BlastRadius = 1
            elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
                v.Enabled = false
            elseif v:IsA("MeshPart") then
                v.Material = "Plastic"
                v.Reflectance = 0
            end
        end
        Window:Notify({
            Title = "Tay Hub",
            Content = "Đã bật Low CPU!",
            Duration = 2
        })
    end
})

-- ===== TAB ESP =====
Tabs.Esp:AddSection("Stats Upgrade")

Tabs.Esp:AddSlider("Stats Value", {
    Title = "Stats Value",
    Min = 0,
    Max = 1000,
    Default = 10,
    Callback = function(Value)
        pSats = Value
    end
})

Tabs.Esp:AddToggle("Auto Melee", {
    Title = "Auto Melee",
    Default = false,
    Callback = function(Value)
        _G.Auto_Melee = Value
    end
})

Tabs.Esp:AddToggle("Auto Swords", {
    Title = "Auto Swords",
    Default = false,
    Callback = function(Value)
        _G.Auto_Sword = Value
    end
})

Tabs.Esp:AddToggle("Auto Gun", {
    Title = "Auto Gun",
    Default = false,
    Callback = function(Value)
        _G.Auto_Gun = Value
    end
})

Tabs.Esp:AddToggle("Auto Blox Fruit", {
    Title = "Auto Blox Fruit",
    Default = false,
    Callback = function(Value)
        _G.Auto_DevilFruit = Value
    end
})

Tabs.Esp:AddToggle("Auto Defense", {
    Title = "Auto Defense",
    Default = false,
    Callback = function(Value)
        _G.Auto_Defense = Value
    end
})

Tabs.Esp:AddSection("ESP")

Tabs.Esp:AddToggle("Esp Player", {
    Title = "Esp Player",
    Default = false,
    Callback = function(Value)
        PlayerEsp = Value
    end
})

Tabs.Esp:AddToggle("Esp Chest", {
    Title = "Esp Chest",
    Default = false,
    Callback = function(Value)
        ChestESP = Value
    end
})

Tabs.Esp:AddToggle("Esp Fruit", {
    Title = "Esp Fruit",
    Default = false,
    Callback = function(Value)
        DevilFruitESP = Value
    end
})

Tabs.Esp:AddToggle("Esp Island", {
    Title = "Esp Island",
    Default = false,
    Callback = function(Value)
        IslandESP = Value
    end
})

-- ===== TAB SHOP =====
Tabs.Shop:AddSection("Shop Options")

Tabs.Shop:AddButton("Buy Buso", {
    Title = "Buy Buso",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuyHaki","Buso")
    end
})

Tabs.Shop:AddButton("Buy Geppo", {
    Title = "Buy Geppo",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuyHaki","Geppo")
    end
})

Tabs.Shop:AddButton("Buy Soru", {
    Title = "Buy Soru",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuyHaki","Soru")
    end
})

Tabs.Shop:AddSection("Fighting - Style")

Tabs.Shop:AddButton("Buy Black Leg", {
    Title = "Buy Black Leg",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuyBlackLeg")
    end
})

Tabs.Shop:AddButton("Buy Electro", {
    Title = "Buy Electro",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuyElectro")
    end
})

Tabs.Shop:AddButton("Buy Superhuman", {
    Title = "Buy Superhuman",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuySuperhuman")
    end
})

Tabs.Shop:AddButton("Buy Godhuman", {
    Title = "Buy Godhuman",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuyGodhuman")
    end
})

-- ===== NOTIFY =====
Window:Notify({
    Title = "Tay Hub",
    Content = "Tay hub da comeback!",
    Image = "rbxassetid://96454140798208",
    Duration = 5
})

-- ===== SAVE MANAGER =====
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})

InterfaceManager:SetFolder("TayHub")
SaveManager:SetFolder("TayHub/saves")

InterfaceManager:BuildInterfaceSection(Tabs.Info)
SaveManager:BuildConfigSection(Tabs.Info)

Window:SelectTab(Tabs.Info)

print("Tay Hub loaded successfully!")