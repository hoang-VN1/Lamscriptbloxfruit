-- =================== TAY HUB HOÀN CHỈNH ===================
-- Kết hợp UI Fluent + Attack Fix + Sea Event

-- =================== UI FLUENT (MARU HUB) ===================
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/discoart/FluentPlus/refs/heads/main/release.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Tay Hub",
    SubTitle = "by @tungdepzai",
    TitleIcon = "rbxassetid://96454140798208",
    Image = "rbxassetid://96454140798208",
    DropdownsOutsideWindow = true,
    Size = UDim2.fromOffset(550, 400),
    TabWidth = 180,
    Acrylic = true,
    Theme = "Dark",
    Search = true,
    MinimizeKey = Enum.KeyCode.LeftControl,
    UserInfo = false,
    UserInfoTop = true,
    UserInfoTitle = game:GetService("Players").LocalPlayer.DisplayName,
    UserInfoSubtitle = "User",
    UserInfoSubtitleColor = Color3.fromRGB(255, 255, 255)
})

-- =================== CÁC TAB ===================
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
    Root = plr.Character.HumanoidRootPart
    replicated = game:GetService("ReplicatedStorage")
    Lv = game.Players.LocalPlayer.Data.Level.Value
    TeleportService = game:GetService("TeleportService")
    TW = game:GetService("TweenService")
    Lighting = game:GetService("Lighting")
    Enemies = workspace.Enemies
    vim1 = game:GetService("VirtualInputManager")
    vim2 = game:GetService("VirtualUser")
    TeamSelf = plr.Team
    RunSer = game:GetService("RunService")
    Stats = game:GetService("Stats")
    Energy = plr.Character.Energy.Value
    BringConnections = {}
    BossList = {}
    MaterialList = {}
    NPCList = {}
    shouldTween = false
    SoulGuitar = false
    KenTest = true
    debug = false
    Brazier1 = false
    Brazier2 = false
    Brazier3 = false
    Sec = 0.1
    ClickState = 0
    Num_self = 25
end

repeat local start = plr.PlayerGui:WaitForChild("Main"):WaitForChild("Loading") and game:IsLoaded() wait() until start

World1 = game.PlaceId == 2753915549 or game.PlaceId == 85211729168715
World2 = game.PlaceId == 4442272183 or game.PlaceId == 79091703265657
World3 = game.PlaceId == 7449423635 or game.PlaceId == 100117331123089

Marines = function() replicated.Remotes.CommF_:InvokeServer("SetTeam","Marines") end
Pirates = function() replicated.Remotes.CommF_:InvokeServer("SetTeam","Pirates") end

-- =================== DANH SÁCH ===================
if World1 then 
    BossList = {"The Gorilla King","Bobby","The Saw","Yeti","Mob Leader","Vice Admiral","Saber Expert","Warden","Chief Warden","Swan","Magma Admiral","Fishman Lord","Wysper","Thunder God","Cyborg","Ice Admiral","Greybeard"}
elseif World2 then 
    BossList = {"Diamond","Jeremy","Orbitus","Don Swan","Smoke Admiral","Awakened Ice Admiral","Tide Keeper","Darkbeard","Cursed Captain","Order"}
elseif World3 then 
    BossList = {"Stone","Hydra Leader","Kilo Admiral","Captain Elephant","Beautiful Pirate","Cake Queen","Dough King","Longma","Soul Reaper","rip_indra True Form","Tyrant of the Skies"}
end

if World1 then 
    MaterialList = {"Leather + Scrap Metal", "Angel Wings", "Magma Ore", "Fish Tail"}
elseif World2 then 
    MaterialList = {"Leather + Scrap Metal", "Radioactive Material", "Ectoplasm", "Mystic Droplet", "Magma Ore", "Vampire Fang"}
elseif World3 then 
    MaterialList = {"Scrap Metal", "Demonic Wisp", "Conjured Cocoa", "Dragon Scale", "Gunpowder", "Fish Tail", "Mini Tusk"}
end

local DungeonTables = {"Flame","Ice","Quake","Light","Dark","String","Rumble","Magma","Human: Buddha","Sand","Bird: Phoenix","Dough"}
local RenMon = {"Snow Lurker","Arctic Warrior","Hidden Key","Awakened Ice Admiral"}
local CursedTables = {["Mob"] = "Mythological Pirate",["Mob2"] = "Cursed Skeleton","Hell's Messenger",["Mob3"] = "Cursed Skeleton","Heaven's Guardian"}
local Past = {"Part","SpawnLocation","Terrain","WedgePart","MeshPart"}
local BartMon = {"Swan Pirate","Jeremy"}
local CitizenTable = {"Forest Pirate","Captain Elephant"}
local Human_v3_Mob = {"Fajita","Jeremy","Diamond"}
local AllBoats = {"Beast Hunter","Lantern","Guardian","Grand Brigade","Dinghy","Sloop","The Sentinel"}
local mastery1 = {"Cookie Crafter"}
local mastery2 = {"Reborn Skeleton"}

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
        
        -- Cách 1: LeftClickRemote
        local leftClickRemote = tool:FindFirstChild("LeftClickRemote")
        if leftClickRemote then
            pcall(function()
                leftClickRemote:FireServer(Vector3.new(0.01, -500, 0.01), 1, true)
                wait(0.03)
                leftClickRemote:FireServer(false)
            end)
        end
        
        -- Cách 2: RemoteEvent
        local remoteEvent = tool:FindFirstChild("RemoteEvent")
        if remoteEvent then
            pcall(function()
                remoteEvent:FireServer("M1")
            end)
        end
        
        -- Cách 3: Simulate click
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

Attack.Pos = function(model,dist) 
    return (Root.Position - model.Position).Magnitude <= dist 
end

Attack.Dist = function(model,dist) 
    return (Root.Position - model:FindFirstChild("HumanoidRootPart").Position).Magnitude <= dist 
end

Attack.DistH = function(model,dist) 
    return (Root.Position - model:FindFirstChild("HumanoidRootPart").Position).Magnitude > dist 
end

-- Attack.Kill cải tiến
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

-- Attack.KillSea cải tiến cho Sea Event
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
        
        -- Nếu là Leviathan hoặc Sea Beast
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
                
                -- Random CFrame để né đòn
                if RandomCFrame then
                    wait(0.1)
                    _tp(CFrame.new(currentPos.X + math.random(-30, 30), waterLevel + 200, currentPos.Z + math.random(-30, 30)))
                end
            end
            return
        end
        
        -- Sea Event khác (Terror Shark, Fish Boat, PGB)
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
        
        if RandomCFrame then
            wait(0.1)
            _tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25))
            wait(0.1)
            _tp(model.HumanoidRootPart.CFrame * CFrame.new(25, 30, 0))
            wait(0.1)
            _tp(model.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0))
            wait(0.1)
            _tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25))
            wait(0.1)
            _tp(model.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0))
        end
    end
end

-- =================== CÁC HÀM KHÁC ===================
statsSetings = function(Num, value)
    if Num == "Melee" then
        if plr.Data.Points.Value ~= 0 then
            replicated.Remotes.CommF_:InvokeServer("AddPoint","Melee",value)
        end
    elseif Num == "Defense" then
        if plr.Data.Points.Value ~= 0 then
            replicated.Remotes.CommF_:InvokeServer("AddPoint","Defense",value)
        end
    elseif Num == "Sword" then
        if plr.Data.Points.Value ~= 0 then
            replicated.Remotes.CommF_:InvokeServer("AddPoint","Sword",value)
        end
    elseif Num == "Gun" then
        if plr.Data.Points.Value ~= 0 then
            replicated.Remotes.CommF_:InvokeServer("AddPoint","Gun",value)
        end
    elseif Num == "Devil" then
        if plr.Data.Points.Value ~= 0 then
            replicated.Remotes.CommF_:InvokeServer("AddPoint","Demon Fruit",value)
        end
    end
end

BringEnemy = function(Mon)
    if not _B then return end
    if not Mon then 
        local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        
        local closestDist = math.huge
        for _, enemy in ipairs(workspace.Enemies:GetChildren()) do
            local hum = enemy:FindFirstChildOfClass("Humanoid")
            local root = enemy:FindFirstChild("HumanoidRootPart")
            if hum and root and hum.Health > 0 then
                local dist = (root.Position - hrp.Position).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    Mon = enemy
                end
            end
        end
        if not Mon then return end
    end
    
    local AreaMob = false
    
    local function Mobs(enemy)
        local hum = enemy:FindFirstChildOfClass("Humanoid")
        local root = enemy:FindFirstChild("HumanoidRootPart")
        return hum and root and hum.Health > 0, root, hum
    end

    local function Network(part)
        if isnetworkowner then
            return isnetworkowner(part)
        end
        return part.ReceiveAge == 0 and not part.Anchored and part.Velocity.Magnitude > 0
    end
    
    pcall(function()
        if sethiddenproperty then 
            sethiddenproperty(plr, "SimulationRadius", math.huge)
        end
        
        local targetPos = Mon.HumanoidRootPart.Position
        
        for _, v in ipairs(workspace.Enemies:GetChildren()) do
            if v ~= Mon then
                local alive, root, hum = Mobs(v)
                if alive and v.Name == Mon.Name then
                    local distance = (root.Position - targetPos).Magnitude
                    if distance <= 3000 then
                        local bv = root:FindFirstChild("BodyVelocity")
                        if not bv then
                            bv = Instance.new("BodyVelocity")
                            bv.Name = "BodyVelocity"
                            bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
                            bv.Velocity = Vector3.zero
                            bv.Parent = root
                        end
                        
                        if distance <= 10 then
                            AreaMob = true
                        end
                        
                        if not AreaMob and Network(root) then
                            root.CFrame = CFrame.new(targetPos)
                        end
                        
                        root.CanCollide = false
                        hum.WalkSpeed = 0
                        hum.JumpPower = 0
                    end
                end
            end
        end
        
        if Mon and Mon:FindFirstChild("HumanoidRootPart") then
            Mon.HumanoidRootPart.CanCollide = false
            Mon.Humanoid.WalkSpeed = 0
            Mon.Humanoid.JumpPower = 0
        end
    end)
end

Useskills = function(weapon, skill)
    if weapon == "Melee" then
        weaponSc("Melee")
        if skill == "Z" then
            vim1:SendKeyEvent(true, "Z", false, game)
            wait(0.05)
            vim1:SendKeyEvent(false, "Z", false, game)
        elseif skill == "X" then
            vim1:SendKeyEvent(true, "X", false, game)
            wait(0.05)
            vim1:SendKeyEvent(false, "X", false, game)
        elseif skill == "C" then
            vim1:SendKeyEvent(true, "C", false, game)
            wait(0.05)
            vim1:SendKeyEvent(false, "C", false, game)
        end
    elseif weapon == "Sword" then
        weaponSc("Sword")
        if skill == "Z" then
            vim1:SendKeyEvent(true, "Z", false, game)
            wait(0.05)
            vim1:SendKeyEvent(false, "Z", false, game)
        elseif skill == "X" then
            vim1:SendKeyEvent(true, "X", false, game)
            wait(0.05)
            vim1:SendKeyEvent(false, "X", false, game)
        end
    elseif weapon == "Blox Fruit" then
        weaponSc("Blox Fruit")
        FixM1Fruit()
        if skill == "Z" then
            vim1:SendKeyEvent(true, "Z", false, game)
            wait(0.05)
            vim1:SendKeyEvent(false, "Z", false, game)
        elseif skill == "X" then
            vim1:SendKeyEvent(true, "X", false, game)
            wait(0.05)
            vim1:SendKeyEvent(false, "X", false, game)
        elseif skill == "C" then
            vim1:SendKeyEvent(true, "C", false, game)
            wait(0.05)
            vim1:SendKeyEvent(false, "C", false, game)        
        elseif skill == "V" then
            vim1:SendKeyEvent(true, "V", false, game)
            wait(0.05)
            vim1:SendKeyEvent(false, "V", false, game)
        end
    elseif weapon == "Gun" then
        weaponSc("Gun")
        if skill == "Z" then
            vim1:SendKeyEvent(true, "Z", false, game)
            wait(0.05)
            vim1:SendKeyEvent(false, "Z", false, game)
        elseif skill == "X" then
            vim1:SendKeyEvent(true, "X", false, game)
            wait(0.05)
            vim1:SendKeyEvent(false, "X", false, game)
        end
    end
    if weapon == "nil" and skill == "Y" then
        vim1:SendKeyEvent(true, "Y", false, game)
        wait(0.05)
        vim1:SendKeyEvent(false, "Y", false, game)
    end
end

-- =================== REMOTE SPOOF ===================
local gg = getrawmetatable(game)
local old = gg.__namecall
setreadonly(gg, false)
gg.__namecall = newcclosure(function(...)
    local method = getnamecallmethod()
    local args = {...}    
    if tostring(method) == "FireServer" then
        if tostring(args[1]) == "RemoteEvent" then
            if tostring(args[2]) ~= "true" and tostring(args[2]) ~= "false" then
                if (_G.FarmMastery_G and not SoulGuitar) or (_G.FarmMastery_Dev) or (_G.FarmBlazeEM) or (_G.Prehis_Skills) or (_G.SeaBeast1 or _G.FishBoat or _G.PGB or _G.Leviathan1 or _G.Complete_Trials) or (_G.AimMethod and ABmethod == "Aim Player") or (_G.AimMethod and ABmethod == "Nearest Aim") then
                    args[2] = MousePos
                    return old(unpack(args))
                end
            end
        end
    end
    return old(...)
end)

-- =================== HÀM KIỂM TRA ===================
GetConnectionEnemies = function(a)
    for i,v in pairs(replicated:GetChildren()) do
        if v:IsA("Model") and ((typeof(a) == "table" and table.find(a, v.Name)) or v.Name == a) and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            return v
        end
    end
    for i,v in next,game.Workspace.Enemies:GetChildren() do
        if v:IsA("Model") and ((typeof(a) == "table" and table.find(a, v.Name)) or v.Name == a) and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            return v
        end
    end
end

LowCpu = function()
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
            v.TextureID = 10385902758728957
        end
    end
    for i, e in pairs(l:GetChildren()) do
        if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
            e.Enabled = false
        end
    end
end

CheckF = function()
    if GetBP("Dragon-Dragon") or GetBP("Gas-Gas") or GetBP("Yeti-Yeti") or GetBP("Kitsune-Kitsune") or GetBP("T-Rex-T-Rex") then return true end
end

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

CheckPiranha = function()
    for _,v in pairs(workspace.Enemies:GetChildren()) do
        if v.Name == "Piranha" and Attack.Alive(v) then
            return true    
        end
    end
    return false
end

CheckFishCrew = function()
    for _,v in pairs(workspace.Enemies:GetChildren()) do
        if (v.Name == "Fish Crew Member" or v.Name == "Haunted Crew Member") and Attack.Alive(v) then
            return true    
        end
    end
    return false
end

CheckHauntedCrew = function()
    for _,v in pairs(workspace.Enemies:GetChildren()) do
        if (v.Name == "Haunted Crew Member") and Attack.Alive(v) then
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

GetBP = function(v)
    return plr.Backpack:FindFirstChild(v) or plr.Character:FindFirstChild(v)
end

GetIn = function(Name)
    for _ ,v1 in pairs(replicated.Remotes.CommF_:InvokeServer("getInventory")) do
        if type(v1) == "table" then
            if v1.Name == Name or plr.Character:FindFirstChild(Name) or plr.Backpack:FindFirstChild(Name) then
                return true
            end
        end
    end
    return false
end

GetM = function(Name)
    for _,tab in pairs(replicated.Remotes.CommF_:InvokeServer("getInventory")) do
        if type(tab) == "table" then
            if tab.Type == "Material" then
                if tab.Name == Name then
                    return tab.Count
                end
            end
        end
    end
    return 0
end

GetWP = function(nametool)
    for _,v4 in pairs(replicated.Remotes.CommF_:InvokeServer("getInventory")) do
        if type(v4) == "table" then
            if v4.Type == "Sword" then
                if v4.Name == nametool or plr.Character:FindFirstChild(nametool) or plr.Backpack:FindFirstChild(nametool) then
                    return true
                end
            end
        end
    end
    return false
end

getInfinity_Ability = function(Method, Var)
    if not Root then return end
    if Method == "Soru" and Var then
        for _,gc in next, getgc() do
            if plr.Character.Soru then
                if ((typeof(gc) == "function") and (getfenv(gc).script == plr.Character.Soru)) then
                    for _, v in next, getupvalues(gc) do
                        if (typeof(v) == "table") then
                            repeat wait(Sec) v.LastUse = 0 until not Var or (plr.Character.Humanoid.Health <= 0)
                        end
                    end
                end
            end
        end    
    elseif Method == "Energy" and Var then
        plr.Character.Energy.Changed:connect(function()
            if Var then plr.Character.Energy.Value = Energy end 
        end)
    elseif Method == "Observation" and Var then
        local VisionRadius = plr.VisionRadius
        VisionRadius.Value = math.huge
    end
end

Hop = function()
    pcall(function()
        for count = math.random(1, math.random(40, 75)), 100 do
            local remote = replicated.__ServerBrowser:InvokeServer(count)
            for _, v in next, remote do
                if tonumber(v['Count']) < 12 then TeleportService:TeleportToPlaceInstance(game.PlaceId, _) end
            end    
        end
    end)
end

-- =================== TELEPORT FUNCTIONS ===================
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

sea1 = (game.PlaceId == 2753915549 or game.PlaceId == 85211729168715)
sea2 = (game.PlaceId == 4442272183 or game.PlaceId == 79091703265657)
sea3 = (game.PlaceId == 7449423635 or game.PlaceId == 100117331123089)

local Settings = {
    ["Tween Speed"] = 350,
    ["Bypass Teleport"] = true,
    ["Up Y"] = false,
    ["Up Y When Low Health"] = false,
    ["Same Y"] = false
}

local newdao = CFrame.new(10641.0918, -1953.92981, 9825.07031, -0.652825892, -9.2805891e-08, -0.757508039, -2.73638356e-08, 1, -9.89323823e-08, 0.757508039, -4.38572947e-08, -0.652825892)
local cframenpc = CFrame.new(-16271.126, 25.5847301, 1371.98755, 0.999396622, -5.78875188e-08, -0.0347310975, 5.52972779e-08, 1, -8.7544322e-08, 0.034731105, 8.28877091e-08, 0.999396741)

function Convert_CFrame(x)
    if not x then return end
    if typeof(x) == "Vector3" then
        return CFrame.new(x)
    elseif typeof(x) == "CFrame" then
        return x
    elseif typeof(x) == "Model" then
        return x:GetPivot()
    elseif x.CFrame then
        return x.CFrame
    end
    return nil
end

function GetDistance(POS_1, POS_2, NO_Y)
    if POS_1 == nil then return 9e9 end
    
    local Character = LocalPlayer.Character
    if not Character then return 9e9 end
    
    local Humanoid = Character:FindFirstChild("Humanoid")
    if not Humanoid or Humanoid.Health <= 0 then
        return 9e9
    end
    
    if POS_2 == nil then
        POS_2 = Character:FindFirstChild("HumanoidRootPart")
        if not POS_2 then return 9e9 end
    end
    
    local pos1 = Convert_CFrame(POS_1)
    local pos2 = Convert_CFrame(POS_2)
    
    if NO_Y then
        return (Vector3.new(pos1.X, 0, pos1.Z) - Vector3.new(pos2.X, 0, pos2.Z)).Magnitude
    else
        return (pos1.Position - pos2.Position).Magnitude
    end
end

function InArea(POS)
    local WorldOrigin = workspace:FindFirstChild("_WorldOrigin")
    if not WorldOrigin then return {Name = ""} end
    
    local pos = Convert_CFrame(POS)
    for i,v in next, WorldOrigin.Locations:GetChildren() do
        if v:FindFirstChild("Mesh") and (pos.Position - v.Position).Magnitude <= v.Mesh.Scale.X then
            return v
        end
    end
    return {Name = ""}
end

function GetSpawnPoint(x)
    local Spawns = workspace:FindFirstChild("_WorldOrigin") 
        and workspace._WorldOrigin:FindFirstChild("PlayerSpawns") 
        and workspace._WorldOrigin.PlayerSpawns:FindFirstChild("Pirates")
    if not Spawns then return end
    
    for i,v in next, Spawns:GetChildren() do
        if v:FindFirstChild("Part") and (v.Part.Position - x.Position).Magnitude <= 2500 then
            return v
        end
    end
end

function CheckLegendaryItems()
    local function CheckItem(ITEM_NAME)
        for i,v in next, LocalPlayer.Backpack:GetChildren() do
            if v:IsA('Tool') and (v.Name == ITEM_NAME or string.find(v.Name, ITEM_NAME)) then 
                return v 
            end
        end
        for i,v in next, LocalPlayer.Character:GetChildren() do
            if v:IsA('Tool') and (v.Name == ITEM_NAME or string.find(v.Name, ITEM_NAME)) then 
                return v 
            end
        end
    end
    
    if CheckItem("God's Chalice") or CheckItem("Fist of Darkness") or CheckItem("Sweet Chalice") or CheckItem("Hallow Essence") or CheckItem("Flower1") then
        return true
    end
    return false
end

function WaitForHumanoid()
    local Character = LocalPlayer.Character
    if not Character then return nil end
    
    local Humanoid = Character:FindFirstChild("Humanoid")
    if Humanoid then return Humanoid end
    
    local timeout = tick() + 5
    while tick() < timeout do
        Humanoid = Character:FindFirstChild("Humanoid")
        if Humanoid then return Humanoid end
        task.wait(0.1)
    end
    return nil
end

function checkinventory(v)
    if v then
        for i, vl in pairs(ReplicatedStorage.Remotes.CommF_:InvokeServer("getInventory")) do
            if vl.Name == v then
                return true
            end
        end
    end
    return false
end

function getdis(a,b)
    b = b or LocalPlayer.Character.HumanoidRootPart.CFrame
    local _a = CFrame.new(a.X, b.Y, a.Z)
    local _b = CFrame.new(b.X,b.Y,b.Z)
    return (_a.Position - _b.Position).Magnitude
end

function CanBypassTeleport(x)
    local AreaName = InArea(x).Name
    if AreaName == "" then return false end
    
    if not Settings["Bypass Teleport"] 
        or AreaName:find("Dimension") 
        or AreaName:find("Submerged") 
        or AreaName == "Sealed Cavern" 
        or AreaName:lower():find("under") 
        or CheckLegendaryItems() then
        return false
    end
    
    if LocalPlayer.Data and LocalPlayer.Data.LastSpawnPoint and LocalPlayer.Data.LastSpawnPoint.Value == "SubmergedIsland" then 
        return false 
    end
    
    if GetDistance(x.Position) <= 3500 then
        return false
    end
    
    return true
end

function GetBypassCFrame(x)
    local Max = math.huge
    local Pos
    local Spawns = workspace._WorldOrigin.PlayerSpawns.Pirates:GetChildren()
    local HRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not HRP then return nil end
    
    for i,v in next, Spawns do
        if v:FindFirstChild("Part") then
            if (x.Position - HRP.Position).Magnitude >= 3000 
            and GetSpawnPoint(v.Part) ~= GetSpawnPoint(HRP) 
            and (v.Part.Position - HRP.Position).Magnitude <= 10000 
            and (v.Part.Position - x.Position).Magnitude <= Max then
                Max = (v.Part.Position - x.Position).Magnitude
                Pos = v
            end
        end
    end
    return Pos
end

function BypassTP(Target)
    local Character = LocalPlayer.Character
    if not Character then return end
    
    local Humanoid = WaitForHumanoid()
    if not Humanoid or Humanoid.Health <= 0 then return end
    
    if CanBypassTeleport(Target) and GetBypassCFrame(Target) then
        local TargetTP = GetBypassCFrame(Target)
        if TargetTP and TargetTP:FindFirstChild("Part") then
            Character.LastSpawnPoint.Disabled = true
            ReplicatedStorage.Remotes.CommF_:InvokeServer("SetLastSpawnPoint", TargetTP.Name)
            ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
            Character:PivotTo(TargetTP.Part.CFrame)
            Humanoid:ChangeState(15)
            
            repeat 
                task.wait() 
            until LocalPlayer.Character and WaitForHumanoid() and WaitForHumanoid().Health > 0
        end
    end
end

function totopofgreattree()
    if getdis(CFrame.new(28310.0234, 14895.1123, 109.456741)) > 1500 then
        ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(28310.0234, 14895.1123, 109.456741))
        wait(0.3)
    end
    
    local targetCF = CFrame.new(28607.5352, 14896.5449, 106.011726)
    _tp(targetCF)
    
    repeat
        wait()
    until getdis(targetCF) <= 5
    
    wait(0.5)
    for i = 1, 4 do
        ReplicatedStorage.Remotes.CommF_:InvokeServer("RaceV4Progress", "TeleportBack")
    end
end

function requestentrance(pos)
    local tb = {}
    local targetPos = pos
    
    if typeof(pos) == "CFrame" then
        targetPos = pos.Position
    end
    
    if sea1 then
        tb = {
            ["Sky3"] = Vector3.new(-7894, 5547, -380),
            ["Sky3Exit"] = Vector3.new(-4607, 874, -1667),
            ["UnderWater"] = Vector3.new(61163, 11, 1819),
            ["Underwater City"] = Vector3.new(61165.19140625, 0.18704631924629211, 1897.379150390625),
            ["Pirate Village"] = Vector3.new(-1242.4625244140625, 4.787059783935547, 3901.282958984375),
            ["UnderwaterExit"] = Vector3.new(4050, -1, -1814)
        }
    elseif sea2 then
        tb = {
            ["Swan Mansion"] = Vector3.new(-390, 332, 673),
            ["Swan Room"] = Vector3.new(2285, 15, 905),
            ["Cursed Ship"] = Vector3.new(923, 126, 32852),
            ["Zombie Island"] = Vector3.new(-6509, 83, -133)
        }
    else
        tb = {
            ["Hydra Island"] = Vector3.new(5657.88623046875, 1013.0790405273438, -335.4996337890625),
            ["Mansion"] = Vector3.new(-12462, 375, -7552),
            ["Castle"] = Vector3.new(-5036, 315, -3179),
            ["Temple of Time"] = Vector3.new(28286, 14897, 103),
            ["Greate Tree"] = Vector3.new(3024.1709, 2280.69434, -7325.12793)
        }
        if not checkinventory("Valkyrie Helm") then
            return
        end
    end
    
    local x, y = nil, math.huge
    for i, v in pairs(tb) do
        local distance = (typeof(v) == "Vector3" and (v - targetPos).Magnitude) or (v.Position - targetPos).Magnitude
        if distance < y then
            y = distance
            x = v
        end
    end
    
    if x and y and y < getdis(pos) then
        pcall(function ()
            if _G.TweenCache then
                _G.TweenCache:Cancel()
            end
        end)
        
        if typeof(x) == "Vector3" 
            and x.X == 3024.1709 and x.Y == 2280.69434 and x.Z == -7325.12793
            and ReplicatedStorage.Remotes.CommF_:InvokeServer("RaceV4Progress", "Check") >= 2 then
            totopofgreattree()
            wait(1)
        elseif y < getdis(pos) then
            local requestPos = typeof(x) == "Vector3" and x or x.Position
            ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", requestPos)
            wait(1)
        end
    end
end

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
    
    pcall(function()
        if CanBypassTeleport(gg) then
            BypassTP(gg)
            task.wait(0.5)
        end
    end)
    
    pcall(function()
        requestentrance(target)
    end)
    
    if sea3 and getdis(gg.Position, newdao.Position) < 2000 then
        local hrp = plr.Character.HumanoidRootPart
        if math.abs(newdao.Position.Y - hrp.CFrame.Y) > 1000 then
            repeat
                task.wait()
                old_tp(cframenpc)
                if getdis(cframenpc) < 10 then
                    local net = ReplicatedStorage.Modules.Net
                    net["RF/SubmarineWorkerSpeak"]:InvokeServer("AskKilledTikiBoss")
                    task.wait(0.5)
                    net["RF/SubmarineWorkerSpeak"]:InvokeServer("TravelToSubmergedIsland")
                end
            until getdis(gg.Position) < 2000
            task.wait(0.6)
            pcall(function()
                if hrp:FindFirstChild("BodyClip") then
                    hrp.BodyClip:Destroy()
                end
            end)
        end
    end
    
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

function StopTween(state)
    if state == false then
        if _G.TweenCache then
            _G.TweenCache:Cancel()
            _G.TweenCache = nil
        end
    end
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

function AutoHaki()
    if Boud then
        pcall(function()
            if not plr.Character:FindFirstChild("HasBuso") then
                replicated.Remotes.CommF_:InvokeServer("Buso")
            end
        end)
    end
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
            -- Leviathan
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
            
            -- Sea Beast
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
            
            -- Terror Shark
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
            
            -- Fish Boat
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
            
            -- Pirate Grand Brigade
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
            
            -- Haunted Crew Member
            if _G.HCM then
                for _, hcm in pairs(workspace.Enemies:GetChildren()) do
                    if hcm.Name == "Haunted Crew Member" and Attack.Alive(hcm) then
                        repeat
                            wait(0.2)
                            Attack.KillSea(hcm, _G.HCM)
                        until not _G.HCM 
                            or not hcm.Parent 
                            or hcm.Humanoid.Health <= 0
                    end
                end
            end
            
            -- Fish Crew Member
            if _G.MobCrew then
                for _, crew in pairs(workspace.Enemies:GetChildren()) do
                    if crew.Name == "Fish Crew Member" and Attack.Alive(crew) then
                        repeat
                            wait(0.2)
                            Attack.KillSea(crew, _G.MobCrew)
                        until not _G.MobCrew 
                            or not crew.Parent 
                            or crew.Humanoid.Health <= 0
                    end
                end
            end
            
            -- Shark
            if _G.Shark then
                for _, shark in pairs(workspace.Enemies:GetChildren()) do
                    if shark.Name == "Shark" and Attack.Alive(shark) then
                        repeat
                            wait(0.2)
                            Attack.KillSea(shark, _G.Shark)
                        until not _G.Shark 
                            or not shark.Parent 
                            or shark.Humanoid.Health <= 0
                    end
                end
            end
            
            -- Piranha
            if _G.Piranha then
                for _, piranha in pairs(workspace.Enemies:GetChildren()) do
                    if piranha.Name == "Piranha" and Attack.Alive(piranha) then
                        repeat
                            wait(0.2)
                            Attack.KillSea(piranha, _G.Piranha)
                        until not _G.Piranha 
                            or not piranha.Parent 
                            or piranha.Humanoid.Health <= 0
                    end
                end
            end
        end)
    end
end)

-- =================== SAIL BOAT LOOP ===================
spawn(function()
    while wait() do
        if _G.SailBoats then 
            pcall(function()        
                local myBoat = CheckBoat()
                if not myBoat and not(CheckShark() and _G.Shark or CheckTerrorShark() and _G.TerrorShark or CheckFishCrew() and _G.MobCrew or CheckPiranha() and _G.Piranha) and not(CheckEnemiesBoat() and _G.FishBoat) and not(CheckSeaBeast() and _G.SeaBeast1) and not(_G.PGB and CheckPirateGrandBrigade()) and not(_G.HCM and CheckHauntedCrew()) and not(_G.Leviathan1 and CheckLeviathan()) then
                    local buyBoatCFrame = CFrame.new(-16927.451, 9.086, 433.864)
                    TeleportToTarget(buyBoatCFrame)
                    if (buyBoatCFrame.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 then 
                        replicated.Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat) 
                    end
                elseif myBoat and not(CheckShark() and _G.Shark or CheckTerrorShark() and _G.TerrorShark or CheckFishCrew() and _G.MobCrew or CheckPiranha() and _G.Piranha) and not(CheckEnemiesBoat() and _G.FishBoat) and not(CheckSeaBeast() and _G.SeaBeast1) and not(_G.PGB and CheckPirateGrandBrigade()) and not(_G.HCM and CheckHauntedCrew()) and not(_G.Leviathan1 and CheckLeviathan()) then
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
                        until _G.SailBoats == false or (CheckShark() and _G.Shark or CheckTerrorShark() and _G.TerrorShark or CheckFishCrew() and _G.MobCrew or CheckPiranha() and _G.Piranha) or CheckSeaBeast() and _G.SeaBeast1 or CheckEnemiesBoat() and _G.FishBoat or _G.Leviathan1 and CheckLeviathan() or _G.HCM and CheckHauntedCrew() or _G.PGB and CheckPirateGrandBrigade() or plr.Character:WaitForChild("Humanoid").Sit == false
                        plr.Character.Humanoid.Sit = false
                    end
                end
            end)
        end
    end
end)

-- =================== FARM LEVEL LOOP ===================
local alreadyTeleported = false
local teleporting = false

local function IsInSubmergedIsland()
    local char = plr.Character
    if not char then return false end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end

    local islandXZ = Vector3.new(11520.8017578125, 0, 9829.513671875)
    local playerXZ = Vector3.new(hrp.Position.X, 0, hrp.Position.Z)
    return (playerXZ - islandXZ).Magnitude < 2000
end

task.spawn(function()
    while task.wait(Sec) do
        if _G.Level then
            pcall(function()
                local char = plr.Character or plr.CharacterAdded:Wait()
                local Root = char:WaitForChild("HumanoidRootPart")
                if not Root then return end

                local level = plr.Data.Level.Value
                local inSub = IsInSubmergedIsland()
                local questUI = plr.PlayerGui.Main.Quest
                local QuestTitle = questUI.Visible and questUI.Container.QuestTitle.Title.Text or ""

                if level >= 2600 and not inSub and not teleporting and not alreadyTeleported then
                    teleporting = true
                    
                    local npcPos = CFrame.new(-16269.7041, 25.2288494, 1373.65955)
                    local teleportAttempts = 0
                    
                    repeat 
                        task.wait(Sec)
                        _tp(npcPos)
                        teleportAttempts = teleportAttempts + 1
                    until not _G.Level or (Root.Position - npcPos.Position).Magnitude <= 8 or teleportAttempts > 20

                    if not _G.Level then 
                        teleporting = false
                        return 
                    end

                    task.wait(1)
                    
                    pcall(function()
                        local args = {"TravelToSubmergedIsland"} 
                        game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/SubmarineWorkerSpeak"):InvokeServer(unpack(args))
                    end)

                    local timeout = tick()
                    repeat 
                        task.wait(0.5)
                        local currentInSub = IsInSubmergedIsland()
                        local farFromNPC = (Root.Position - npcPos.Position).Magnitude > 50
                        
                        if currentInSub or farFromNPC then
                            break
                        end
                    until not _G.Level or tick() - timeout > 15

                    task.wait(2)
                    alreadyTeleported = true
                    teleporting = false
                    
                elseif inSub or level < 2600 then
                    alreadyTeleported = true
                    teleporting = false

                    local questData = QuestNeta()
                    
                    if not questData or not questData[1] then
                        task.wait(1)
                        return
                    end
                    
                    if questUI.Visible and not string.find(QuestTitle, questData[1]) then
                        replicated.Remotes.CommF_:InvokeServer("AbandonQuest")
                        task.wait(0.2)
                        return
                    end

                    if not questUI.Visible then
                        local questPos = questData[6]
                        if questPos then
                            _tp(questPos)
                            task.wait(2)
                            
                            if (Root.Position - questPos.Position).Magnitude <= 10 then
                                pcall(function()
                                    replicated.Remotes.CommF_:InvokeServer("StartQuest", questData[3], questData[2])
                                end)
                                task.wait(1)
                            end
                        else
                            pcall(function()
                                replicated.Remotes.CommF_:InvokeServer("StartQuest", questData[3], questData[2])
                            end)
                            task.wait(1)
                        end
                        return
                    end

                    local enemyName = questData[1]
                    
                    local foundMob = false
                    for _, v in pairs(workspace.Enemies:GetChildren()) do
                        if v.Name == enemyName and Attack.Alive(v) then
                            foundMob = true
                            repeat
                                task.wait(Sec)
                                _tp(v.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))
                                Attack.Kill(v, _G.Level)
                                
                                if not questUI.Visible then
                                    break
                                end
                            until not _G.Level or not v.Parent or v.Humanoid.Health <= 0
                            task.wait(2) 
                        end
                    end
                    
                    if not foundMob then
                        for _, v in pairs(replicated:GetChildren()) do
                            if v.Name == enemyName and Attack.Alive(v) then
                                foundMob = true
                                _tp(v.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))
                                break
                            end
                        end
                    end
                    
                    if not foundMob then
                        for _, spawnPoint in pairs(workspace["_WorldOrigin"].EnemySpawns:GetChildren()) do
                            if string.find(spawnPoint.Name, enemyName) then
                                _tp(spawnPoint.CFrame * CFrame.new(0, 20, 0))
                                break
                            end
                        end
                    end
                end
            end)
        else
            teleporting = false
            alreadyTeleported = false
        end
    end
end)

-- =================== QUEST FUNCTIONS ===================
QuestB = function()
    if World1 then
        if _G.FindBoss == "The Gorilla King" then
            bMon = "The Gorilla King"
            Qname = "JungleQuest"
            Qdata = 3;
            PosQBoss = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102)
            PosB = CFrame.new(-1088.75977, 8.13463783, -488.559906, -0.707134247, 0, 0.707079291, 0, 1, 0, -0.707079291, 0, -0.707134247)
        elseif _G.FindBoss == "Bobby" then
            bMon = "Bobby"
            Qname = "BuggyQuest1"
            Qdata = 3;
            PosQBoss = CFrame.new(-1140.1761474609, 4.752049446106, 3827.4057617188)
            PosB = CFrame.new(-1087.3760986328, 46.949409484863, 4040.1462402344)
        elseif _G.FindBoss == "The Saw" then
            bMon = "The Saw"
            PosB = CFrame.new(-784.89715576172, 72.427383422852, 1603.5822753906)
        elseif _G.FindBoss == "Yeti" then
            bMon = "Yeti"
            Qname = "SnowQuest"
            Qdata = 3;
            PosQBoss = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156)
            PosB = CFrame.new(1218.7956542969, 138.01184082031, -1488.0262451172)
        elseif _G.FindBoss == "Mob Leader" then
            bMon = "Mob Leader"
            PosB = CFrame.new(-2844.7307128906, 7.4180502891541, 5356.6723632813)
        elseif _G.FindBoss == "Vice Admiral" then
            bMon = "Vice Admiral"
            Qname = "MarineQuest2"
            Qdata = 2;
            PosQBoss = CFrame.new(-5036.2465820313, 28.677835464478, 4324.56640625)
            PosB = CFrame.new(-5006.5454101563, 88.032081604004, 4353.162109375)
        elseif _G.FindBoss == "Saber Expert" then
            bMon = "Saber Expert"
            PosB = CFrame.new(-1458.89502, 29.8870335, -50.633564)
        elseif _G.FindBoss == "Warden" then
            bMon = "Warden"
            Qname = "ImpelQuest"
            Qdata = 1;
            PosB = CFrame.new(5278.04932, 2.15167475, 944.101929, 0.220546961, -4.49946401e-06, 0.975376427, -1.95412576e-05, 1, 9.03162072e-06, -0.975376427, -2.10519756e-05, 0.220546961)
            PosQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, 0.681965172, 0, 1, 0, -0.681965172, 0, -0.731384635)
        elseif _G.FindBoss == "Chief Warden" then
            bMon = "Chief Warden"
            Qname = "ImpelQuest"
            Qdata = 2;
            PosB = CFrame.new(5206.92578, 0.997753382, 814.976746, 0.342041343, -0.00062915677, 0.939684749, 0.00191645394, 0.999998152, -2.80422337e-05, -0.939682961, 0.00181045406, 0.342041939)
            PosQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, 0.681965172, 0, 1, 0, -0.681965172, 0, -0.731384635)
        elseif _G.FindBoss == "Swan" then
            bMon = "Swan"
            Qname = "ImpelQuest"
            Qdata = 3;
            PosB = CFrame.new(5325.09619, 7.03906584, 719.570679, -0.309060812, 0, 0.951042235, 0, 1, 0, -0.951042235, 0, -0.309060812)
            PosQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, 0.681965172, 0, 1, 0, -0.681965172, 0, -0.731384635)
        elseif _G.FindBoss == "Magma Admiral" then
            bMon = "Magma Admiral"
            Qname = "MagmaQuest"
            Qdata = 3;
            PosQBoss = CFrame.new(-5314.6220703125, 12.262420654297, 8517.279296875)
            PosB = CFrame.new(-5765.8969726563, 82.92064666748, 8718.3046875)
        elseif _G.FindBoss == "Fishman Lord" then
            bMon = "Fishman Lord"
            Qname = "FishmanQuest"
            Qdata = 3;
            PosQBoss = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
            PosB = CFrame.new(61260.15234375, 30.950881958008, 1193.4329833984)
        elseif _G.FindBoss == "Wysper" then
            bMon = "Wysper"
            Qname = "SkyExp1Quest"
            Qdata = 3;
            PosQBoss = CFrame.new(-7861.947265625, 5545.517578125, -379.85974121094)
            PosB = CFrame.new(-7866.1333007813, 5576.4311523438, -546.74816894531)
        elseif _G.FindBoss == "Thunder God" then
            bMon = "Thunder God"
            Qname = "SkyExp2Quest"
            Qdata = 3;
            PosQBoss = CFrame.new(-7903.3828125, 5635.9897460938, -1410.923828125)
            PosB = CFrame.new(-7994.984375, 5761.025390625, -2088.6479492188)
        elseif _G.FindBoss == "Cyborg" then
            bMon = "Cyborg"
            Qname = "FountainQuest"
            Qdata = 3;
            PosQBoss = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)
            PosB = CFrame.new(6094.0249023438, 73.770050048828, 3825.7348632813)
        elseif _G.FindBoss == "Ice Admiral" then
            bMon = "Ice Admiral"
            Qdata = nil;
            PosQBoss = CFrame.new(1266.08948, 26.1757946, -1399.57678, -0.573599219, 0, -0.81913656, 0, 1, 0, 0.81913656, 0, -0.573599219)
            PosB = CFrame.new(1266.08948, 26.1757946, -1399.57678, -0.573599219, 0, -0.81913656, 0, 1, 0, 0.81913656, 0, -0.573599219)
        elseif _G.FindBoss == "Greybeard" then
            bMon = "Greybeard"
            Qdata = nil;
            PosQBoss = CFrame.new(-5081.3452148438, 85.221641540527, 4257.3588867188)
            PosB = CFrame.new(-5081.3452148438, 85.221641540527, 4257.3588867188)
        end
    end;
    if World2 then
        if _G.FindBoss == "Diamond" then
            bMon = "Diamond"
            Qname = "Area1Quest"
            Qdata = 3;
            PosQBoss = CFrame.new(-427.5666809082, 73.313781738281, 1835.4208984375)
            PosB = CFrame.new(-1576.7166748047, 198.59265136719, 13.724286079407)
        elseif _G.FindBoss == "Jeremy" then
            bMon = "Jeremy"
            Qname = "Area2Quest"
            Qdata = 3;
            PosQBoss = CFrame.new(636.79943847656, 73.413787841797, 918.00415039063)
            PosB = CFrame.new(2006.9261474609, 448.95666503906, 853.98284912109)
        elseif _G.FindBoss == "Orbitus" then
            bMon = "Orbitus"
            Qname = "MarineQuest3"
            Qdata = 3;
            PosQBoss = CFrame.new(-2441.986328125, 73.359344482422, -3217.5324707031)
            PosB = CFrame.new(-2172.7399902344, 103.32216644287, -4015.025390625)
        elseif _G.FindBoss == "Don Swan" then
            bMon = "Don Swan"
            PosB = CFrame.new(2286.2004394531, 15.177839279175, 863.8388671875)
        elseif _G.FindBoss == "Smoke Admiral" then
            bMon = "Smoke Admiral"
            Qname = "IceSideQuest"
            Qdata = 3;
            PosQBoss = CFrame.new(-5429.0473632813, 15.977565765381, -5297.9614257813)
            PosB = CFrame.new(-5275.1987304688, 20.757257461548, -5260.6669921875)
        elseif _G.FindBoss == "Awakened Ice Admiral" then
            bMon = "Awakened Ice Admiral"
            Qname = "FrostQuest"
            Qdata = 3;
            PosQBoss = CFrame.new(5668.9780273438, 28.519989013672, -6483.3520507813)
            PosB = CFrame.new(6403.5439453125, 340.29766845703, -6894.5595703125)
        elseif _G.FindBoss == "Tide Keeper" then
            bMon = "Tide Keeper"
            Qname = "ForgottenQuest"
            Qdata = 3;
            PosQBoss = CFrame.new(-3053.9814453125, 237.18954467773, -10145.0390625)
            PosB = CFrame.new(-3795.6423339844, 105.88877105713, -11421.307617188)
        elseif _G.FindBoss == "Darkbeard" then
            bMon = "Darkbeard"
            Qdata = nil;
            PosQBoss = CFrame.new(3677.08203125, 62.751937866211, -3144.8332519531)
            PosB = CFrame.new(3677.08203125, 62.751937866211, -3144.8332519531)
        elseif _G.FindBoss == "Cursed Captain" then
            bMon = "Cursed Captain"
            Qdata = nil;
            PosQBoss = CFrame.new(916.928589, 181.092773, 33422)
            PosB = CFrame.new(916.928589, 181.092773, 33422)
        elseif _G.FindBoss == "Order" then
            bMon = "Order"
            Qdata = nil;
            PosQBoss = CFrame.new(-6217.2021484375, 28.047645568848, -5053.1357421875)
            PosB = CFrame.new(-6217.2021484375, 28.047645568848, -5053.1357421875)
        end
    end;
    if World3 then
        if _G.FindBoss == "Stone" then
            bMon = "Stone"
            Qname = "PiratePortQuest"
            Qdata = 3;
            PosQBoss = CFrame.new(-289.76705932617, 43.819011688232, 5579.9384765625)
            PosB = CFrame.new(-1027.6512451172, 92.404174804688, 6578.8530273438)
        elseif _G.FindBoss == "Hydra Leader" then
            bMon = "Hydra Leader"
            Qname = "VenomCrewQuest"
            Qdata = 3;
            PosQBoss = CFrame.new(5211.021484375, 1004.35778859375, 758.1847534179688)
            PosB = CFrame.new(5821.89794921875, 1019.0950927734375, -73.71923065185547)
        elseif _G.FindBoss == "Kilo Admiral" then
            bMon = "Kilo Admiral"
            Qname = "MarineTreeIsland"
            Qdata = 3;
            PosQBoss = CFrame.new(2179.3010253906, 28.731239318848, -6739.9741210938)
            PosB = CFrame.new(2764.2233886719, 432.46154785156, -7144.4580078125)
        elseif _G.FindBoss == "Captain Elephant" then
            bMon = "Captain Elephant"
            Qname = "DeepForestIsland"
            Qdata = 3;
            PosQBoss = CFrame.new(-13232.682617188, 332.40396118164, -7626.01171875)
            PosB = CFrame.new(-13376.7578125, 433.28689575195, -8071.392578125)
        elseif _G.FindBoss == "Beautiful Pirate" then
            bMon = "Beautiful Pirate"
            Qname = "DeepForestIsland2"
            Qdata = 3;
            PosQBoss = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375)
            PosB = CFrame.new(5283.609375, 22.56223487854, -110.78285217285)
        elseif _G.FindBoss == "Cake Queen" then
            bMon = "Cake Queen"
            Qname = "IceCreamIslandQuest"
            Qdata = 3;
            PosQBoss = CFrame.new(-819.376709, 64.9259796, -10967.2832, -0.766061664, 0, 0.642767608, 0, 1, 0, -0.642767608, 0, -0.766061664)
            PosB = CFrame.new(-678.648804, 381.353943, -11114.2012, -0.908641815, 0.00149294338, 0.41757378, 0.00837114919, 0.999857843, 0.0146408929, -0.417492568, 0.0167988986, -0.90852499)
        elseif _G.FindBoss == "Longma" then
            bMon = "Longma"
            Qdata = nil;
            PosQBoss = CFrame.new(-10238.875976563, 389.7912902832, -9549.7939453125)
            PosB = CFrame.new(-10238.875976563, 389.7912902832, -9549.7939453125)
        elseif _G.FindBoss == "Soul Reaper" then
            bMon = "Soul Reaper"
            Qdata = nil;
            PosQBoss = CFrame.new(-9524.7890625, 315.80429077148, 6655.7192382813)
            PosB = CFrame.new(-9524.7890625, 315.80429077148, 6655.7192382813)
        end
    end
end

QuestBeta = function()
    local Neta = QuestB()
    return {
        [0] = _G.FindBoss,
        [1] = bMon,
        [2] = Qdata,
        [3] = Qname,
        [4] = PosB,
        [5] = PosQBoss,
    }  
end

local Quests = require(game:GetService("ReplicatedStorage"):WaitForChild("Quests"))
local GuideModule = require(game:GetService("ReplicatedStorage"):WaitForChild("GuideModule"))

local blacklistquest = {
    "MarineQuest",
    "BartiloQuest",
    "CitizenQuest",
    "Trainees"
}

CheckSea = function(b)
    if (game.PlaceId == 2753915549 or game.PlaceId == 85211729168715) and b == 1 then
        return true
    elseif (game.PlaceId == 4442272183 or game.PlaceId == 79091703265657) and b == 2 then
        return true
    elseif (game.PlaceId == 7449423635 or game.PlaceId == 100117331123089) and b == 3 then
        return true
    end
    return false
end

GetQuestPointFromNPC = function(npcName)
    for _, npc in pairs(workspace.NPCs:GetChildren()) do
        if npc.Name == npcName and npc:FindFirstChild("HumanoidRootPart") then
            return npc.HumanoidRootPart.CFrame
        end
    end
    for _, npc in pairs(replicated.NPCs:GetChildren()) do
        if npc.Name == npcName and npc:FindFirstChild("HumanoidRootPart") then
            return npc.HumanoidRootPart.CFrame
        end
    end
    return nil
end

GetQuests = function()
    local lvl = plr.Data.Level.Value
    local LevelReq = 0
    local mmb = {}
    
    if lvl >= 700 and CheckSea(1) then
        mmb["Mob"] = "Galley Captain"
        mmb["NameQuest"] = "FountainQuest"
        mmb["ID"] = 2
        mmb["LevelReq"] = 700
    elseif lvl >= 1500 and CheckSea(2) then
        mmb["Mob"] = "Water Fighter"
        mmb["NameQuest"] = "ForgottenQuest"
        mmb["ID"] = 2
        mmb["LevelReq"] = 1450
    else
        for r, v in pairs(Quests) do
            for id, v1 in pairs(v) do
                local LvReq = v1.LevelReq
                for nguoi, tinh in pairs(v1.Task) do
                    if lvl >= LvReq and LevelReq <= LvReq and v1.Task[nguoi] > 1 and not table.find(blacklistquest, r) then
                        LevelReq = LvReq
                        mmb["Mob"] = nguoi
                        mmb["NameQuest"] = r
                        mmb["ID"] = id
                        mmb["LevelReq"] = LvReq
                    end
                end
            end
        end
    end
    
    return mmb
end

GetQuestPoint = function()
    if GuideModule and GuideModule.Data and GuideModule.Data.LastClosestNPC then
        return GetQuestPointFromNPC(GuideModule.Data.LastClosestNPC)
    end
    return nil
end

QuestNeta = function()
    local questData = GetQuests()
    return {
        [1] = questData.Mob,           
        [2] = questData.ID,             
        [3] = questData.NameQuest,      
        [4] = questData.LevelReq,       
        [5] = questData.Mob,             
        [6] = GetQuestPoint()            
    }
end

-- =================== THÔNG BÁO ===================
Window:Notify({
    Title = "Tay Hub",
    Content = "Tay hub da comeback!",
    Duration = 5
})

-- =================== LƯU SETTINGS ===================
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})

InterfaceManager:SetFolder("TayHub")
SaveManager:SetFolder("TayHub/saves")

InterfaceManager:BuildInterfaceSection(Tabs.Info)
SaveManager:BuildConfigSection(Tabs.Info)

Window:SelectTab(Tabs.Info)

-- =================== UI BUILDING (TẤT CẢ CÁC TAB) ===================
-- TAB INFO
Tabs.Info:AddSection("Information")
Tabs.Info:AddParagraph("Tay Hub | Community", "A community for Tay hub Users - official scripts, updates, and support in one place.")

local TimeZone = Tabs.Info:AddParagraph("Time Zone", "")
function UpdateOS()
    local date = os.date("*t")
    local hour = (date.hour) % 24
    local ampm = hour < 12 and "AM" or "PM"
    local timezone = string.format("%02i:%02i:%02i %s", ((hour - 1) % 12) + 1, date.min, date.sec, ampm)
    local datetime = string.format("%02d/%02d/%04d", date.day, date.month, date.year)    
    TimeZone:SetContent(datetime.." - "..timezone)
end
spawn(function() while true do UpdateOS() wait(1) end end)

local GameTime = Tabs.Info:AddParagraph("Game Time", "")
function UpdateGameTime()
    local GameTimeValue = math.floor(workspace.DistributedGameTime + 0.5)
    local Hour = math.floor(GameTimeValue / (60^2)) % 24
    local Minute = math.floor(GameTimeValue / (60^1)) % 60
    local Second = math.floor(GameTimeValue / (60^0)) % 60
    GameTime:SetContent(Hour.."h "..Minute.."m "..Second.."s")
end
spawn(function() while true do UpdateGameTime() wait(1) end end)

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

local FullMoonCheck = Tabs.Info:AddParagraph("Full Moon", "")
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

-- =================== TAB MAIN ===================
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
        if not Value then
            alreadyTeleported = false
            teleporting = false
        end
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
end

if World2 then
    Tabs.Main:AddDropdown("Select Mob", {
        Title = "Select Mob",
        Options = {"Raider", "Mercenary", "Swan Pirate", "Factory Staff", "Marine Lieutenant", "Marine Captain", "Zombie", "Vampire", "Snow Trooper", "Winter Warrior", "Lab Subordinate", "Horned Warrior", "Magma Ninja", "Lava Pirate", "Ship Deckhand", "Ship Engineer", "Ship Steward", "Ship Officer", "Arctic Warrior", "Snow Lurker", "Sea Soldier", "Water Fighter"},
        Default = "Raider",
        Callback = function(Value)
            getgenv().SelectMob = Value
        end
    })
end

if World3 then
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

Tabs.Main:AddSection("Farm All Island")

if World1 then
    Tabs.Main:AddDropdown("Select Island", {
        Title = "Select Island",
        Options = {"Pirates", "Marine", "Jungle", "Pirate Village", "Desert", "Frozen Village", "Marine Fortress", "Skylands Lower", "Prison", "Colosseum", "Magma Village", "Underwater City", "Skylands Upper"},
        Default = "Pirates",
        Callback = function(Value)
            _G.SelectIsland = Value
        end
    })
elseif World2 then
    Tabs.Main:AddDropdown("Select Island", {
        Title = "Select Island",
        Options = {"Kingdom of Rose", "Green Zone", "Graveyard Island", "Snow Mountain", "Hot and Cold (Cold)", "Hot and Cold (Hot)", "Cursed Ship", "Ice Castle", "Forgotten Island"},
        Default = "Kingdom of Rose",
        Callback = function(Value)
            _G.SelectIsland = Value
        end
    })
elseif World3 then
    Tabs.Main:AddDropdown("Select Island", {
        Title = "Select Island",
        Options = {"Port Town", "Hydra Island", "Great Tree", "Floating Turtle", "Haunted Castle", "Sea of Treats", "Tiki Outpost", "Submerged Island"},
        Default = "Port Town",
        Callback = function(Value)
            _G.SelectIsland = Value
        end
    })
end

Tabs.Main:AddToggle("Auto Farm All Island", {
    Title = "Auto Farm All Island",
    Default = false,
    Callback = function(Value)
        _G.AutoFarmIsland = Value
    end
})

-- Farm All Island Loop
task.spawn(function()
    while task.wait(0.2) do
        if not _G.AutoFarmIsland then continue end
        if not _G.SelectIsland then continue end
        if not IslandData then continue end

        local island = IslandData[_G.SelectIsland]
        if not island then continue end

        local islandPos = island.CFrame
        local mobs = island.Mobs

        local MobMap = {}
        for _, name in ipairs(mobs) do
            MobMap[name] = true
        end

        local found = false

        for _, v in pairs(workspace.Enemies:GetChildren()) do
            if MobMap[v.Name]
            and v:FindFirstChild("Humanoid")
            and v:FindFirstChild("HumanoidRootPart")
            and v.Humanoid.Health > 0 then

                found = true
                repeat
                    task.wait()
                    _tp(v.HumanoidRootPart.CFrame * CFrame.new(0,10,0))
                    Attack.Kill(v, true)
                until not _G.AutoFarmIsland
                   or not v.Parent
                   or v.Humanoid.Health <= 0
            end
        end

        if not found then
            _tp(islandPos)
        end
    end
end)

Tabs.Main:AddSection("Farm Elite Hunter")

local Process = Tabs.Main:AddParagraph("Elites Process", "")
spawn(function()
    while wait(Sec) do
        pcall(function()    
            Process:SetContent("Elite Progress: " .. replicated.Remotes.CommF_:InvokeServer("EliteHunter", "Progress"))
        end)
    end
end)

Tabs.Main:AddToggle("Auto Farm Elite", {
    Title = "Auto Farm Elite",
    Default = false,
    Callback = function(Value)
        _G.FarmEliteHunt = Value
    end
})

Tabs.Main:AddToggle("Auto Farm Elite + Hop", {
    Title = "Auto Farm Elite + Hop",
    Default = false,
    Callback = function(Value)
        _G.FarmEliteH = Value
    end
})

Tabs.Main:AddSection("Farm Rip Indra")

Tabs.Main:AddToggle("Auto Attack Rip Indra", {
    Title = "Auto Attack Rip Indra",
    Default = false,
    Callback = function(Value)
        _G.AutoRipIngay = Value
    end
})

Tabs.Main:AddToggle("Auto Unlocked Haki", {
    Title = "Auto Unlocked Haki",
    Default = false,
    Callback = function(Value)
        _G.AutoUnHaki = Value
    end
})

Tabs.Main:AddSection("Farming Cake")

Tabs.Main:AddToggle("Auto Farm Cake Prince", {
    Title = "Auto Farm Cake Prince",
    Default = false,
    Callback = function(Value)
        _G.Auto_Cake_Prince = Value
    end
})

Tabs.Main:AddToggle("Accept Quests", {
    Title = "Accept Quests",
    Default = false,
    Callback = function(Value)
        _G.AcceptQuestC = Value
    end
})

Tabs.Main:AddToggle("Auto Summon Cake Prince", {
    Title = "Auto Summon Cake Prince",
    Default = false,
    Callback = function(Value)
        _G.AutoSpawnCP = Value
    end
})

Tabs.Main:AddToggle("Auto Dough King [Fully]", {
    Title = "Auto Dough King [Fully]",
    Default = false,
    Callback = function(Value)
        _G.AutoDoughKing = Value
    end
})

Tabs.Main:AddToggle("Auto Farm Dough King", {
    Title = "Auto Farm Dough King",
    Default = false,
    Callback = function(Value)
        _G.AutoAttackDoughKing = Value
    end
})

Tabs.Main:AddToggle("Auto Farm Dough King + Hop", {
    Title = "Auto Farm Dough King + Hop",
    Default = false,
    Callback = function(Value)
        _G.AutoHop_Dough = Value
    end
})

Tabs.Main:AddSection("Farming Bone")

Tabs.Main:AddToggle("Auto Farm Bone", {
    Title = "Auto Farm Bone",
    Default = false,
    Callback = function(Value)
        _G.AutoFarm_Bone = Value
    end
})

Tabs.Main:AddToggle("Accept Quests", {
    Title = "Accept Quests",
    Default = false,
    Callback = function(Value)
        _G.AcceptQuestB = Value
    end
})

Tabs.Main:AddToggle("Auto Soul Reaper", {
    Title = "Auto Soul Reaper",
    Default = false,
    Callback = function(Value)
        _G.AutoHytHallow = Value
    end
})

Tabs.Main:AddToggle("Auto Random Bones", {
    Title = "Auto Random Bones",
    Default = false,
    Callback = function(Value)
        _G.Auto_Random_Bone = Value
    end
})

Tabs.Main:AddToggle("Auto Try Luck Gravestone", {
    Title = "Auto Try Luck Gravestone",
    Default = false,
    Callback = function(Value)
        _G.TryLucky = Value
    end
})

Tabs.Main:AddToggle("Auto Pray Gravestone", {
    Title = "Auto Pray Gravestone",
    Default = false,
    Callback = function(Value)
        _G.Praying = Value
    end
})

Tabs.Main:AddSection("Tyrant of the Skies")

Tabs.Main:AddToggle("Auto Farm Boss TOTS", {
    Title = "Auto Farm Boss TOTS",
    Default = false,
    Callback = function(Value)
        _G.FarmTyrant = Value
    end
})

Tabs.Main:AddToggle("Auto Summon Boss", {
    Title = "Auto Summon Boss",
    Default = false,
    Callback = function(Value)
        _G.FarmPhaBinh = Value
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

Tabs.Main:AddToggle("Accept Quests", {
    Title = "Accept Quests",
    Default = true,
    Callback = function(Value)
        _G.AcceptQuestBoss = Value
    end
})

Tabs.Main:AddToggle("Auto Farm All Boss", {
    Title = "Auto Farm All Boss",
    Default = false,
    Callback = function(Value)
        _G.AutoFarmAllBoss = Value
    end
})

Tabs.Main:AddSection("Farming Mastery")

Tabs.Main:AddDropdown("Choose Island", {
    Title = "Choose Island",
    Options = {"Cake", "Bone"},
    Default = "Bone",
    Callback = function(Value)
        SelectIsland = Value
    end
})

Tabs.Main:AddToggle("Auto Mastery Fruits", {
    Title = "Auto Mastery Fruits",
    Default = false,
    Callback = function(Value)
        _G.FarmMastery_Dev = Value
    end
})

Tabs.Main:AddToggle("Auto Mastery Gun", {
    Title = "Auto Mastery Gun",
    Default = false,
    Callback = function(Value)
        _G.FarmMastery_G = Value
    end
})

Tabs.Main:AddToggle("Auto Mastery All Sword", {
    Title = "Auto Mastery All Sword",
    Default = false,
    Callback = function(Value)
        _G.FarmMastery_S = Value
    end
})

-- =================== TAB SETTINGS ===================
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

Tabs.Settings:AddToggle("Auto Hop Server with time", {
    Title = "Auto Hop Server with time",
    Default = false,
    Callback = function(Value)
        _G.AutoHopServer = Value
        if not Value then
            _G.HopTimer = nil
        end
    end
})

Tabs.Settings:AddSlider("Hop Delay (Minutes)", {
    Title = "Hop Delay (Minutes)",
    Min = 5,
    Max = 120,
    Default = 30,
    Callback = function(Value)
        _G.HopDelay = Value * 60
    end
})

Tabs.Settings:AddToggle("Auto Set Spawn Point", {
    Title = "Auto Set Spawn Point",
    Default = false,
    Callback = function(Value)
        getgenv().Set = Value
        if Value then
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
            end)
        end
    end
})

Tabs.Settings:AddToggle("Auto Turn on Buso", {
    Title = "Auto Turn on Buso",
    Default = true,
    Callback = function(Value)
        Boud = Value
    end
})

Tabs.Settings:AddToggle("Auto Haki Observation", {
    Title = "Auto Haki Observation",
    Default = false,
    Callback = function(Value)
        getgenv().Observation = Value
    end
})

Tabs.Settings:AddToggle("Auto Turn on Race V3", {
    Title = "Auto Turn on Race V3",
    Default = false,
    Callback = function(Value)
        _G.RaceClickAutov3 = Value
    end
})

Tabs.Settings:AddToggle("Auto Turn on Race V4", {
    Title = "Auto Turn on Race V4",
    Default = false,
    Callback = function(Value)
        _G.RaceClickAutov4 = Value
    end
})

Tabs.Settings:AddToggle("Auto Turn on Spin xyz", {
    Title = "Auto Turn on Spin xyz",
    Default = false,
    Callback = function(Value)
        RandomCFrame = Value
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

Tabs.Settings:AddToggle("Remove Death & Respawned VFX", {
    Title = "Remove Death & Respawned VFX",
    Default = false,
    Callback = function(Value)
        RDeath = Value
    end
})

Tabs.Settings:AddToggle("Disable Notify", {
    Title = "Disable Notify",
    Default = false,
    Callback = function(Value)
        RemoveDamage = Value
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

Tabs.Settings:AddToggle("Auto Anti - Admin Join Server", {
    Title = "Auto Anti - Admin Join Server",
    Default = true,
    Callback = function(Value)
        getgenv().HopServerAdmin = Value
    end
})

Tabs.Settings:AddToggle("No Clip", {
    Title = "No Clip",
    Default = false,
    Callback = function(Value)
        getgenv().NoClip = Value
    end
})

-- =================== TAB ESP ===================
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

Tabs.Esp:AddToggle("Esp Flower", {
    Title = "Esp Flower",
    Default = false,
    Callback = function(Value)
        FlowerESP = Value
    end
})

Tabs.Esp:AddToggle("Esp Legendary Sword", {
    Title = "Esp Legendary Sword",
    Default = false,
    Callback = function(Value)
        LegenS = Value
    end
})

Tabs.Esp:AddToggle("Esp Haki Color", {
    Title = "Esp Haki Color",
    Default = false,
    Callback = function(Value)
        ColorEsp = Value
    end
})

Tabs.Esp:AddToggle("Esp Gear", {
    Title = "Esp Gear",
    Default = false,
    Callback = function(Value)
        ESPGear = Value
    end
})

Tabs.Esp:AddToggle("Esp SeaEvent Island", {
    Title = "Esp SeaEvent Island",
    Default = false,
    Callback = function(Value)
        EspEventIsland = Value
    end
})

Tabs.Esp:AddToggle("Esp Advanced Dealer", {
    Title = "Esp Advanced Dealer",
    Default = false,
    Callback = function(Value)
        advanEsp = Value
    end
})

Tabs.Esp:AddToggle("Esp Berry", {
    Title = "Esp Berry",
    Default = false,
    Callback = function(Value)
        BerryEsp = Value
    end
})

-- =================== TAB COMBAT ===================
Tabs.Combat:AddSection("Combat / AimBot")

Tabs.Combat:AddToggle("Teleport To Select Players", {
    Title = "Teleport To Select Players",
    Default = false,
    Callback = function(Value)
        _G.TpPly = Value
    end
})

Tabs.Combat:AddToggle("Spectate Select Players", {
    Title = "Spectate Select Players",
    Default = false,
    Callback = function(Value)
        SpectatePlys = Value
    end
})

Tabs.Combat:AddToggle("Aimbot Method Skills", {
    Title = "Aimbot Method Skills",
    Default = false,
    Callback = function(Value)
        _G.AimMethod = Value
    end
})

Tabs.Combat:AddToggle("Aimbot Camera Closet Players", {
    Title = "Aimbot Camera Closet Players",
    Default = false,
    Callback = function(Value)
        _G.AimCam = Value
    end
})

Tabs.Combat:AddSection("Quests Players")

Tabs.Combat:AddButton("Get player quests", {
    Title = "Get player quests",
    Callback = function()
        pcall(function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PlayerHunter")
        end)
    end
})

Tabs.Combat:AddToggle("Auto Get PlayerQuest", {
    Title = "Auto Get PlayerQuest",
    Default = false,
    Callback = function(Value)
        _G.AutoReceivePlayerQuest = Value
    end
})

Tabs.Combat:AddToggle("Auto Kill Player Quest", {
    Title = "Auto Kill Player Quest",
    Default = false,
    Callback = function(Value)
        _G.AutoPlayerHunter = Value
    end
})

Tabs.Combat:AddToggle("Auto Enable PvP", {
    Title = "Auto Enable PvP",
    Default = false,
    Callback = function(Value)
        _G.AutoPvP = Value
    end
})

Tabs.Combat:AddToggle("Auto Safe Mode", {
    Title = "Auto Safe Mode",
    Default = false,
    Callback = function(Value)
        _G.SafeMode = Value
    end
})

Tabs.Combat:AddSection("LocalPlayer Settings")

Tabs.Combat:AddToggle("Enable Fly", {
    Title = "Enable Fly",
    Default = false,
    Callback = function(Value)
        toggleFly(Value)
    end
})

Tabs.Combat:AddSlider("Speed Fly Mode", {
    Title = "Speed Fly Mode",
    Min = 10,
    Max = 200,
    Default = 50,
    Callback = function(Value)
        flySpeed = Value
    end
})

Tabs.Combat:AddToggle("Dash No Cooldown", {
    Title = "Dash No Cooldown",
    Default = false,
    Callback = function(Value)
        getgenv().DodgeNoCD = Value
    end
})

Tabs.Combat:AddToggle("Instance Mink V3 [ INF ]", {
    Title = "Instance Mink V3 [ INF ]",
    Default = false,
    Callback = function(Value)
        InfAblities = Value
    end
})

Tabs.Combat:AddToggle("Instance Energy [ INF ]", {
    Title = "Instance Energy [ INF ]",
    Default = false,
    Callback = function(Value)
        infEnergy = Value
    end
})

Tabs.Combat:AddToggle("Instance Soru [ INF ]", {
    Title = "Instance Soru [ INF ]",
    Default = false,
    Callback = function(Value)
        _G.InfSoru = Value
    end
})

Tabs.Combat:AddToggle("Instance Observation Range [ INF ]", {
    Title = "Instance Observation Range [ INF ]",
    Default = false,
    Callback = function(Value)
        _G.InfiniteObRange = Value
    end
})

Tabs.Combat:AddToggle("Ignore Same Teams", {
    Title = "Ignore Same Teams",
    Default = false,
    Callback = function(Value)
        _G.NoAimTeam = Value
    end
})

Tabs.Combat:AddToggle("Accept Allies", {
    Title = "Accept Allies",
    Default = false,
    Callback = function(Value)
        _G.AcceptAlly = Value
    end
})

-- =================== TAB SHOP ===================
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

Tabs.Shop:AddButton("Buy Ken", {
    Title = "Buy Ken",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("KenTalk","Buy")
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

Tabs.Shop:AddButton("Buy Fishman Karate", {
    Title = "Buy Fishman Karate",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuyFishmanKarate")
    end
})

Tabs.Shop:AddButton("Buy DragonClaw", {
    Title = "Buy DragonClaw",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","2")
    end
})

Tabs.Shop:AddButton("Buy Superhuman", {
    Title = "Buy Superhuman",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuySuperhuman")
    end
})

Tabs.Shop:AddButton("Buy Death Step", {
    Title = "Buy Death Step",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuyDeathStep")
    end
})

Tabs.Shop:AddButton("Buy Sharkman Karate", {
    Title = "Buy Sharkman Karate",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuySharkmanKarate")
    end
})

Tabs.Shop:AddButton("Buy ElectricClaw", {
    Title = "Buy ElectricClaw",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuyElectricClaw")
    end
})

Tabs.Shop:AddButton("Buy DragonTalon", {
    Title = "Buy DragonTalon",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuyDragonTalon")
    end
})

Tabs.Shop:AddButton("Buy Godhuman", {
    Title = "Buy Godhuman",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuyGodhuman")
    end
})

Tabs.Shop:AddButton("Buy SanguineArt", {
    Title = "Buy SanguineArt",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuySanguineArt")
    end
})

Tabs.Shop:AddSection("Accessory")

Tabs.Shop:AddButton("Buy Tomoe Ring", {
    Title = "Buy Tomoe Ring",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuyItem","Tomoe Ring")
    end
})

Tabs.Shop:AddButton("Buy Black Cape", {
    Title = "Buy Black Cape",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuyItem","Black Cape")
    end
})

Tabs.Shop:AddButton("Buy Swordsman Hat", {
    Title = "Buy Swordsman Hat",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuyItem","Swordsman Hat")
    end
})

Tabs.Shop:AddButton("Buy Bizarre Rifle", {
    Title = "Buy Bizarre Rifle",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("Ectoplasm","Buy", 1)
    end
})

Tabs.Shop:AddButton("Buy Ghoul Mask", {
    Title = "Buy Ghoul Mask",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("Ectoplasm","Buy", 2)
    end
})

Tabs.Shop:AddSection("Fragments shop")

Tabs.Shop:AddButton("Buy Refund Stats", {
    Title = "Buy Refund Stats",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BlackbeardReward","Refund","2")
    end
})

Tabs.Shop:AddButton("Buy Reroll Race", {
    Title = "Buy Reroll Race",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BlackbeardReward","Reroll","2")
    end
})

Tabs.Shop:AddButton("Buy Ghoul Race", {
    Title = "Buy Ghoul Race",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("Ectoplasm"," Change", 4)
    end
})

Tabs.Shop:AddButton("Buy Cyborg Race (2.5k)", {
    Title = "Buy Cyborg Race (2.5k)",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("CyborgTrainer"," Buy")
    end
})

Tabs.Shop:AddButton("Buy Draco Race", {
    Title = "Buy Draco Race",
    Callback = function()
        _tp(CFrame.new(5814.42724609375, 1208.3267822265625, 884.5785522460938))
        local targetPosition = Vector3.new(5814.42724609375, 1208.3267822265625, 884.5785522460938)
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        repeat wait() until (character.HumanoidRootPart.Position - targetPosition).Magnitude < 1
        local args = { [1] = { ["NPC"] = "Dragon Wizard", ["Command"] = "DragonRace" } }
        game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/InteractDragonQuest"):InvokeServer(unpack(args))
    end
})

-- =================== TAB MISC ===================
Tabs.Misc:AddSection("Server - Function")

Tabs.Misc:AddButton("Redeem All Codes", {
    Title = "Redeem All Codes",
    Callback = function()
        local codes = {
            "LIGHTNINGABUSE","1LOSTADMIN","ADMINFIGHT","GIFTING_HOURS","NOMOREHACK",
            "BANEXPLOIT","WildDares","BossBuild","GetPranked","EARN_FRUITS",
            "SUB2GAMERROBOT_RESET1","KITT_RESET","Bignews","CHANDLER","Fudd10",
            "fudd10_v2","Sub2UncleKizaru","FIGHT4FRUIT","kittgaming","TRIPLEABUSE",
            "Sub2CaptainMaui","Sub2Fer999","Enyu_is_Pro","Magicbus","JCWK",
            "Starcodeheo","Bluxxy","SUB2GAMERROBOT_EXP1","Sub2NoobMaster123",
            "Sub2Daigrock","Axiore","TantaiGaming","StrawHatMaine","Sub2OfficialNoobie",
            "TheGreatAce","JULYUPDATE_RESET","ADMINHACKED","SEATROLLING","24NOADMIN",
            "ADMIN_TROLL","NEWTROLL","SECRET_ADMIN","staffbattle","NOEXPLOIT",
            "NOOB2ADMIN","CODESLIDE","fruitconcepts","krazydares"
        }
        local RedeemRemote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):FindFirstChild("Redeem")
        if not RedeemRemote then return end
        for _, code in ipairs(codes) do
            task.wait(0)
            pcall(function()
                if RedeemRemote.InvokeServer then
                    RedeemRemote:InvokeServer(code)
                else
                    RedeemRemote:FireServer(code)
                end
            end)
        end
    end
})

Tabs.Misc:AddButton("Rejoin Server", {
    Title = "Rejoin Server",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
    end
})

Tabs.Misc:AddButton("Hop Server", {
    Title = "Hop Server",
    Callback = function()
        task.spawn(function()
            local HttpService = game:GetService("HttpService")
            local TeleportService = game:GetService("TeleportService")
            local PlaceId = game.PlaceId
            local Players = game:GetService("Players")
            local success, servers = pcall(function()
                local url = "https://games.roblox.com/v1/games/"..PlaceId.."/servers/Public?sortOrder=Asc&limit=100"
                local response = game:HttpGet(url)
                return HttpService:JSONDecode(response).data
            end)
            if success and servers then
                local targetServer
                for _, s in pairs(servers) do
                    if s.playing < s.maxPlayers then
                        targetServer = s.id
                        break
                    end
                end
                if targetServer then
                    pcall(function()
                        TeleportService:TeleportToPlaceInstance(PlaceId, targetServer, Players.LocalPlayer)
                    end)
                end
            end
        end)
    end
})

Tabs.Misc:AddButton("Copy JobID", {
    Title = "Copy JobID",
    Callback = function()
        setclipboard(tostring(game.JobId))
    end
})

Tabs.Misc:AddSection("Player Gui / Others")

Tabs.Misc:AddButton("Open Awakenings Expert", {
    Title = "Open Awakenings Expert",
    Callback = function()
        plr.PlayerGui.Main.AwakeningToggler.Visible = true
    end
})

Tabs.Misc:AddButton("Open Title Selection", {
    Title = "Open Title Selection",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("getTitles",true)
        plr.PlayerGui.Main.Titles.Visible = true
    end
})

Tabs.Misc:AddToggle("Disable Chat GUI", {
    Title = "Disable Chat GUI",
    Default = false,
    Callback = function(Value)
        _G.Rechat = Value
        if Value then
            game:GetService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
        else
            game:GetService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
        end
    end
})

Tabs.Misc:AddToggle("Disable Leader Board GUI", {
    Title = "Disable Leader Board GUI",
    Default = false,
    Callback = function(Value)
        if Value then
            game:GetService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
        else
            game:GetService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
        end
    end
})

Tabs.Misc:AddButton("Set Pirate Team", {
    Title = "Set Pirate Team",
    Callback = function()
        Pirates()
    end
})

Tabs.Misc:AddButton("Set Marine Team", {
    Title = "Set Marine Team",
    Callback = function()
        Marines()
    end
})

Tabs.Misc:AddToggle("Unlock All Portals", {
    Title = "Unlock All Portals",
    Default = false,
    Callback = function(Value)
        _G.PortalUnLock = Value
    end
})

Tabs.Misc:AddSection("Graphics / Haki Stats")

Tabs.Misc:AddDropdown("Select Haki States", {
    Title = "Select Haki States",
    Options = {"State 0", "State 1", "State 2", "State 3", "State 4", "State 5"},
    Default = "State 0",
    Callback = function(Value)
        _G.SelectStateHaki = Value
    end
})

Tabs.Misc:AddButton("ChangeBusoStage", {
    Title = "ChangeBusoStage",
    Callback = function()
        local stages = {["State 0"]=0, ["State 1"]=1, ["State 2"]=2, ["State 3"]=3, ["State 4"]=4, ["State 5"]=5}
        replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage", stages[_G.SelectStateHaki] or 0)
    end
})

Tabs.Misc:AddToggle("Turn on RTX Mode", {
    Title = "Turn on RTX Mode",
    Default = false,
    Callback = function(Value)
        _G.RTXMode = Value
        local a = game.Lighting
        local c = Instance.new("ColorCorrectionEffect", a)
        local e = Instance.new("ColorCorrectionEffect", a)
        OldAmbient = a.Ambient
        OldBrightness = a.Brightness
        OldColorShift_Top = a.ColorShift_Top
        OldBrightnessc = c.Brightness
        OldContrastc = c.Contrast
        OldTintColorc = c.TintColor
        OldTintColore = e.TintColor
        if not _G.RTXMode then return end
        while _G.RTXMode do wait()
            a.Ambient = Color3.fromRGB(33, 33, 33)
            a.Brightness = 0.3
            c.Brightness = 0.176
            c.Contrast = 0.39
            c.TintColor = Color3.fromRGB(217, 145, 57)
            game.Lighting.FogEnd = 999
            if not plr.Character.HumanoidRootPart:FindFirstChild("PointLight") then
                local a2 = Instance.new("PointLight")
                a2.Parent = plr.Character.HumanoidRootPart
                a2.Range = 15
                a2.Color = Color3.fromRGB(217, 145, 57)
            end
            if not _G.RTXMode then
                a.Ambient = OldAmbient
                a.Brightness = OldBrightness
                a.ColorShift_Top = OldColorShift_Top
                c.Contrast = OldContrastc
                c.Brightness = OldBrightnessc
                c.TintColor = OldTintColorc
                e.TintColor = OldTintColore
                game.Lighting.FogEnd = 2500
                if plr.Character and plr.Character.HumanoidRootPart:FindFirstChild("PointLight") then
                    plr.Character.HumanoidRootPart:FindFirstChild("PointLight"):Destroy()
                end
            end
        end
    end
})

Tabs.Misc:AddButton("Turn on Fast Mode", {
    Title = "Turn on Fast Mode",
    Callback = function()
        for _, zx in next, workspace:GetDescendants() do
            if table.find({"Part","SpawnLocation","Terrain","WedgePart","MeshPart"}, zx.ClassName) then
                zx.Material = "Plastic"
            end
        end
    end
})

Tabs.Misc:AddButton("Turn on Low CPU", {
    Title = "Turn on Low CPU",
    Callback = function()
        LowCpu()
    end
})

Tabs.Misc:AddButton("Remove Sky Fog", {
    Title = "Remove Sky Fog",
    Callback = function()
        if Lighting:FindFirstChild("LightingLayers") then Lighting.LightingLayers:Destroy() end
        if Lighting:FindFirstChild("SeaTerrorCC") then Lighting.SeaTerrorCC:Destroy() end
        if Lighting:FindFirstChild("FantasySky") then Lighting.FantasySky:Destroy() end
    end
})

Tabs.Misc:AddSection("Configure - God")

Tabs.Misc:AddButton("Rain Fruits (Client)", {
    Title = "Rain Fruits (Client)",
    Callback = function()
        for i, v in pairs(game:GetObjects("rbxassetid://14759368201")[1]:GetChildren()) do
            v.Parent = game.Workspace.Map
            v:MoveTo(plr.Character.PrimaryPart.Position + Vector3.new(math.random(-50, 50), 100, math.random(-50, 50)))
            if v.Fruit:FindFirstChild("AnimationController") then
                v.Fruit:FindFirstChild("AnimationController"):LoadAnimation(v.Fruit:FindFirstChild("Idle")):Play()
            end
            v.Handle.Touched:Connect(function(otherPart)
                if otherPart.Parent == plr.Character then
                    v.Parent = plr.Backpack
                    plr.Character.Humanoid:EquipTool(v)
                end
            end)
        end
    end
})

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

Tabs.Misc:AddDropdown("Select Time", {
    Title = "Select Time",
    Options = {"Day", "Night"},
    Default = "Day",
    Callback = function(Value)
        _G.SelectDN = Value
    end
})

Tabs.Misc:AddToggle("Turn on Time", {
    Title = "Turn on Time",
    Default = false,
    Callback = function(Value)
        _G.daylightN = Value
    end
})

Tabs.Misc:AddToggle("Turn on Walk on Water", {
    Title = "Turn on Walk on Water",
    Default = true,
    Callback = function(Value)
        _G.WalkWater_Part = Value
        if Value then
            game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 112, 1000)
        else
            game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 80, 1000)
        end
    end
})

Tabs.Misc:AddToggle("Turn on Ice Walk", {
    Title = "Turn on Ice Walk",
    Default = false,
    Callback = function(Value)
        _G.WalkWater = Value
    end
})

-- =================== TAB TRAVEL ===================
Tabs.Travel:AddSection("Travel - Worlds")

Tabs.Travel:AddButton("Travel East Blue (World 1)", {
    Title = "Travel East Blue (World 1)",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("TravelMain")
    end
})

Tabs.Travel:AddButton("Travel Dressrosa (World 2)", {
    Title = "Travel Dressrosa (World 2)",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("TravelDressrosa")
    end
})

Tabs.Travel:AddButton("Travel Zou (World 3)", {
    Title = "Travel Zou (World 3)",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("TravelZou")
    end
})

Tabs.Travel:AddSection("Travel - Island")

local Location = {}
for i, v in pairs(workspace["_WorldOrigin"].Locations:GetChildren()) do
    table.insert(Location, v.Name)
end

Tabs.Travel:AddDropdown("Select Travelling", {
    Title = "Select Travelling",
    Options = Location,
    Default = Location[1] or "",
    Callback = function(Value)
        _G.Island = Value
    end
})

Tabs.Travel:AddToggle("Auto Travel", {
    Title = "Auto Travel",
    Default = false,
    Callback = function(Value)
        _G.Teleport = Value
    end
})

Tabs.Travel:AddSection("Travel - Portal")

local Location_Portal = {}
if World1 then
    Location_Portal = {"Sky", "UnderWater"}
elseif World2 then
    Location_Portal = {"SwanRoom", "Cursed Ship"}
elseif World3 then
    Location_Portal = {"Castle On The Sea", "Mansion Cafe", "Hydra Teleport", "Canvendish Room", "Temple of Time"}
end

Tabs.Travel:AddDropdown("Select Portal", {
    Title = "Select Portal",
    Options = Location_Portal,
    Default = Location_Portal[1] or "",
    Callback = function(Value)
        _G.Island_PT = Value
    end
})

Tabs.Travel:AddButton("requestEntrance", {
    Title = "requestEntrance",
    Callback = function()
        local portals = {
            ["Sky"] = Vector3.new(-7894, 5547, -380),
            ["UnderWater"] = Vector3.new(61163, 11, 1819),
            ["SwanRoom"] = Vector3.new(2285, 15, 905),
            ["Cursed Ship"] = Vector3.new(923, 126, 32852),
            ["Castle On The Sea"] = Vector3.new(-5097.93164, 316.447021, -3142.66602),
            ["Mansion Cafe"] = Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375),
            ["Hydra Teleport"] = Vector3.new(5643.45263671875, 1013.0858154296875, -340.51025390625),
            ["Canvendish Room"] = Vector3.new(5314.54638671875, 22.562219619750977, -127.06755065917969),
            ["Temple of Time"] = Vector3.new(28310.0234, 14895.1123, 109.456741)
        }
        if portals[_G.Island_PT] then
            replicated.Remotes.CommF_:InvokeServer("requestEntrance", portals[_G.Island_PT])
        end
    end
})

Tabs.Travel:AddSection("Travel - NPCs")

local NPCList = {}
for _, v in pairs(replicated.NPCs:GetChildren()) do
    table.insert(NPCList, v.Name)
end

Tabs.Travel:AddDropdown("Select NPCs", {
    Title = "Select NPCs",
    Options = NPCList,
    Default = NPCList[1] or "",
    Callback = function(Value)
        NPClist = Value
    end
})

Tabs.Travel:AddToggle("Auto Tween to NPC", {
    Title = "Auto Tween to NPC",
    Default = false,
    Callback = function(Value)
        _G.TPNpc = Value
    end
})

-- =================== TAB FISH ===================
Tabs.Fish:AddSection("Fishing")

Tabs.Fish:AddDropdown("Select Fishing Rod", {
    Title = "Select Fishing Rod",
    Options = {"Fishing Rod", "Gold Rod", "Shark Rod", "Shell Rod", "Treasure Rod"},
    Default = "Fishing Rod",
    Callback = function(Value)
        _G.SelectedRod = Value
    end
})

Tabs.Fish:AddDropdown("Select Bait", {
    Title = "Select Bait",
    Options = {"Basic Bait", "Kelp Bait", "Good Bait", "Abyssal Bait", "Frozen Bait", "Epic Bait", "Carnivore Bait"},
    Default = "Basic Bait",
    Callback = function(Value)
        _G.SelectedBait = Value
        if _G.AutoBuyBait then
            pcall(function()
                Remotes.RFCraft:InvokeServer("Craft", _G.SelectedBait, {})
            end)
        end
    end
})

Tabs.Fish:AddToggle("Auto Buy Bait", {
    Title = "Auto Buy Bait",
    Default = false,
    Callback = function(Value)
        _G.AutoBuyBait = Value
        if Value then
            pcall(function()
                Remotes.RFCraft:InvokeServer("Craft", _G.SelectedBait, {})
            end)
        end
    end
})

Tabs.Fish:AddToggle("Auto Fishing", {
    Title = "Auto Fishing",
    Default = false,
    Callback = function(Value)
        _G.AutoFishing = Value
    end
})

Tabs.Fish:AddToggle("Auto Quest Fishing", {
    Title = "Auto Quest Fishing",
    Default = false,
    Callback = function(Value)
        _G.AutoFishingQuest = Value
    end
})

Tabs.Fish:AddToggle("Auto Complete Quest", {
    Title = "Auto Complete Quest",
    Default = false,
    Callback = function(Value)
        _G.AutoQuestComplete = Value
        if Value then
            pcall(function()
                Remotes.RFJobsRemoteFunction:InvokeServer("FishingNPC", "FinishQuest")
            end)
        end
    end
})

Tabs.Fish:AddToggle("Auto Sell Fish", {
    Title = "Auto Sell Fish",
    Default = false,
    Callback = function(Value)
        _G.AutoSellFish = Value
        if Value then
            pcall(function()
                Remotes.RFJobsRemoteFunction:InvokeServer("FishingNPC", "SellFish")
            end)
        end
    end
})

Tabs.Fish:AddToggle("Auto Spam Skill Z", {
    Title = "Auto Spam Skill Z",
    Default = false,
    Callback = function(Value)
        _G.AutoSkillZ = Value
    end
})

-- =================== TAB QUESTS ===================
Tabs.Quests:AddSection("Misc Quests")

Tabs.Quests:AddToggle("Auto Quest Sea 2", {
    Title = "Auto Quest Sea 2",
    Default = false,
    Callback = function(Value)
        _G.TravelDres = Value
    end
})

Tabs.Quests:AddToggle("Auto Quest Sea 3", {
    Title = "Auto Quest Sea 3",
    Default = false,
    Callback = function(Value)
        _G.AutoZou = Value
    end
})

Tabs.Quests:AddToggle("Auto Done Bartilo Quest", {
    Title = "Auto Done Bartilo Quest",
    Default = false,
    Callback = function(Value)
        _G.Bartilo_Quest = Value
    end
})

Tabs.Quests:AddToggle("Auto Done Citizen Quest", {
    Title = "Auto Done Citizen Quest",
    Default = false,
    Callback = function(Value)
        _G.CitizenQuest = Value
    end
})

Tabs.Quests:AddToggle("Auto Training Dummy", {
    Title = "Auto Training Dummy",
    Default = false,
    Callback = function(Value)
        _G.DummyMan = Value
    end
})

Tabs.Quests:AddSection("Tushita + Yama")

Tabs.Quests:AddToggle("Auto Tushita Sword", {
    Title = "Auto Tushita Sword",
    Default = false,
    Callback = function(Value)
        _G.Auto_Tushita = Value
    end
})

Tabs.Quests:AddToggle("Auto Yama Sword", {
    Title = "Auto Yama Sword",
    Default = false,
    Callback = function(Value)
        _G.Auto_Yama = Value
    end
})

Tabs.Quests:AddSection("Skull Guitars / Misc")

Tabs.Quests:AddToggle("Auto Skull Guitar", {
    Title = "Auto Skull Guitar",
    Default = false,
    Callback = function(Value)
        _G.Auto_Soul_Guitar = Value
    end
})

Tabs.Quests:AddToggle("Auto Farm Material Skull Guitar", {
    Title = "Auto Farm Material Skull Guitar",
    Default = false,
    Callback = function(Value)
        _G.AutoMatSoul = Value
    end
})

Tabs.Quests:AddSection("Cursed Dual Katana")

Tabs.Quests:AddToggle("Auto Get CDK [ Last Quest ]", {
    Title = "Auto Get CDK [ Last Quest ]",
    Default = false,
    Callback = function(Value)
        _G.CDK = Value
    end
})

Tabs.Quests:AddToggle("Auto Yama CDK", {
    Title = "Auto Yama CDK",
    Default = false,
    Callback = function(Value)
        _G.CDK_YM = Value
    end
})

Tabs.Quests:AddToggle("Auto Tushita CDK", {
    Title = "Auto Tushita CDK",
    Default = false,
    Callback = function(Value)
        _G.CDK_TS = Value
    end
})

Tabs.Quests:AddSection("True Triple Katana Sword")

Tabs.Quests:AddButton("Buy Legendary Sword", {
    Title = "Buy Legendary Sword",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("LegendarySwordDealer","1")
        replicated.Remotes.CommF_:InvokeServer("LegendarySwordDealer","2")
        replicated.Remotes.CommF_:InvokeServer("LegendarySwordDealer","3")
    end
})

Tabs.Quests:AddButton("Buy True Triple Katana Sword", {
    Title = "Buy True Triple Katana Sword",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("MysteriousMan","2")
    end
})

Tabs.Quests:AddToggle("Tween to Legendary Sword Dealer", {
    Title = "Tween to Legendary Sword Dealer",
    Default = false,
    Callback = function(Value)
        _G.Tp_LgS = Value
    end
})

Tabs.Quests:AddSection("Pole / God Enal's")

Tabs.Quests:AddToggle("Auto Pole V1", {
    Title = "Auto Pole V1",
    Default = false,
    Callback = function(Value)
        _G.AutoPole = Value
    end
})

Tabs.Quests:AddToggle("Auto Pole V2 [Beta]", {
    Title = "Auto Pole V2 [Beta]",
    Default = false,
    Callback = function(Value)
        _G.AutoPoleV2 = Value
    end
})

Tabs.Quests:AddToggle("Auto Saw Sword", {
    Title = "Auto Saw Sword",
    Default = false,
    Callback = function(Value)
        _G.AutoSaw = Value
    end
})

Tabs.Quests:AddToggle("Auto Saber Sword", {
    Title = "Auto Saber Sword",
    Default = false,
    Callback = function(Value)
        _G.AutoSaber = Value
    end
})

Tabs.Quests:AddToggle("Auto Cybrog", {
    Title = "Auto Cybrog",
    Default = false,
    Callback = function(Value)
        _G.AutoColShad = Value
    end
})

Tabs.Quests:AddToggle("Auto Usoap's Hat", {
    Title = "Auto Usoap's Hat",
    Default = false,
    Callback = function(Value)
        _G.AutoGetUsoap = Value
    end
})

Tabs.Quests:AddToggle("Auto Bisento V2", {
    Title = "Auto Bisento V2",
    Default = false,
    Callback = function(Value)
        _G.Greybeard = Value
    end
})

Tabs.Quests:AddToggle("Auto Warden Sword", {
    Title = "Auto Warden Sword",
    Default = false,
    Callback = function(Value)
        _G.WardenBoss = Value
    end
})

Tabs.Quests:AddToggle("Auto Marine Coat", {
    Title = "Auto Marine Coat",
    Default = false,
    Callback = function(Value)
        _G.MarinesCoat = Value
    end
})

Tabs.Quests:AddToggle("Auto Swan Coat", {
    Title = "Auto Swan Coat",
    Default = false,
    Callback = function(Value)
        _G.SwanCoat = Value
    end
})

Tabs.Quests:AddSection("Rengoku Sword")

Tabs.Quests:AddToggle("Auto Rengoku Sword", {
    Title = "Auto Rengoku Sword",
    Default = false,
    Callback = function(Value)
        _G.IceBossRen = Value
    end
})

Tabs.Quests:AddToggle("Auto Key Rengoku", {
    Title = "Auto Key Rengoku",
    Default = false,
    Callback = function(Value)
        _G.KeysRen = Value
    end
})

Tabs.Quests:AddToggle("Auto Dragon Trident", {
    Title = "Auto Dragon Trident",
    Default = false,
    Callback = function(Value)
        _G.AutoTridentW2 = Value
    end
})

Tabs.Quests:AddToggle("Auto Long Sword", {
    Title = "Auto Long Sword",
    Default = false,
    Callback = function(Value)
        _G.LongsWord = Value
    end
})

Tabs.Quests:AddToggle("Auto Black Spikey", {
    Title = "Auto Black Spikey",
    Default = false,
    Callback = function(Value)
        _G.BlackSpikey = Value
    end
})

Tabs.Quests:AddToggle("Auto Dark Blade V3", {
    Title = "Auto Dark Blade V3",
    Default = false,
    Callback = function(Value)
        _G.DarkBladev3 = Value
    end
})

Tabs.Quests:AddToggle("Auto Midnight Blade", {
    Title = "Auto Midnight Blade",
    Default = false,
    Callback = function(Value)
        _G.AutoEcBoss = Value
    end
})

Tabs.Quests:AddToggle("Auto Darkbeard", {
    Title = "Auto Darkbeard",
    Default = false,
    Callback = function(Value)
        _G.Auto_Def_DarkCoat = Value
    end
})

Tabs.Quests:AddToggle("Auto Unlocked DonSwan", {
    Title = "Auto Unlocked DonSwan",
    Default = false,
    Callback = function(Value)
        _G.Auto_DonAcces = Value
    end
})

Tabs.Quests:AddToggle("Auto Swan Glasses", {
    Title = "Auto Swan Glasses",
    Default = false,
    Callback = function(Value)
        _G.Auto_SwanGG = Value
    end
})

Tabs.Quests:AddSection("Cavender + Twin Hooks + Bigmom")

Tabs.Quests:AddToggle("Auto Bigmom", {
    Title = "Auto Bigmom",
    Default = false,
    Callback = function(Value)
        _G.AutoBigmom = Value
    end
})

Tabs.Quests:AddToggle("Auto Canvendish Sword", {
    Title = "Auto Canvendish Sword",
    Default = false,
    Callback = function(Value)
        _G.Auto_Cavender = Value
    end
})

Tabs.Quests:AddToggle("Auto Twin Hooks", {
    Title = "Auto Twin Hooks",
    Default = false,
    Callback = function(Value)
        _G.TwinHook = Value
    end
})

Tabs.Quests:AddToggle("Auto Serpent Bow", {
    Title = "Auto Serpent Bow",
    Default = false,
    Callback = function(Value)
        _G.AutoSerpentBow = Value
    end
})

Tabs.Quests:AddToggle("Auto Lei Accessory", {
    Title = "Auto Lei Accessory",
    Default = false,
    Callback = function(Value)
        _G.AutoKilo = Value
    end
})

Tabs.Quests:AddSection("Buso/Aura Colours")

Tabs.Quests:AddToggle("Auto Teleport Barista Cousin", {
    Title = "Auto Teleport Barista Cousin",
    Default = false,
    Callback = function(Value)
        _G.Tp_MasterA = Value
    end
})

Tabs.Quests:AddButton("Buy Buso Colors", {
    Title = "Buy Buso Colors",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("ColorsDealer","2")
    end
})

Tabs.Quests:AddToggle("Auto Rainbow Colors", {
    Title = "Auto Rainbow Colors",
    Default = false,
    Callback = function(Value)
        _G.Auto_Rainbow_Haki = Value
    end
})

Tabs.Quests:AddToggle("Accept Rainbow Quest Faster", {
    Title = "Accept Rainbow Quest Faster",
    Default = false,
    Callback = function(Value)
        _G.GetQFast = Value
    end
})

Tabs.Quests:AddSection("Instinct / Observation")

Tabs.Quests:AddToggle("Auto Farm Observation", {
    Title = "Auto Farm Observation",
    Default = false,
    Callback = function(Value)
        _G.obsFarm = Value
    end
})

Tabs.Quests:AddToggle("Auto Observation V2", {
    Title = "Auto Observation V2",
    Default = false,
    Callback = function(Value)
        _G.AutoKenVTWO = Value
    end
})

Tabs.Quests:AddSection("Fighting Melee Styles")

Tabs.Quests:AddToggle("Auto Superhuman", {
    Title = "Auto Superhuman",
    Default = false,
    Callback = function(Value)
        _G.Auto_SuperHuman = Value
    end
})

Tabs.Quests:AddToggle("Auto DeathStep", {
    Title = "Auto DeathStep",
    Default = false,
    Callback = function(Value)
        _G.AutoDeathStep = Value
    end
})

Tabs.Quests:AddToggle("Auto Sharkman Karate", {
    Title = "Auto Sharkman Karate",
    Default = false,
    Callback = function(Value)
        _G.Auto_SharkMan_Karate = Value
    end
})

Tabs.Quests:AddToggle("Auto ElectricClaw", {
    Title = "Auto ElectricClaw",
    Default = false,
    Callback = function(Value)
        _G.Auto_Electric_Claw = Value
    end
})

Tabs.Quests:AddToggle("Auto DragonTalon", {
    Title = "Auto DragonTalon",
    Default = false,
    Callback = function(Value)
        _G.AutoDragonTalon = Value
    end
})

Tabs.Quests:AddToggle("Auto Godhuman", {
    Title = "Auto Godhuman",
    Default = false,
    Callback = function(Value)
        _G.Auto_God_Human = Value
    end
})

Tabs.Quests:AddToggle("Auto SanguineArt", {
    Title = "Auto SanguineArt",
    Default = false,
    Callback = function(Value)
        _G.Snaguine = Value
    end
})

-- =================== TAB RACE ===================
Tabs.Race:AddSection("Mystic Island / Full Moon")

Tabs.Race:AddToggle("Auto Find Mirage Island", {
    Title = "Auto Find Mirage Island",
    Default = false,
    Callback = function(Value)
        _G.FindMirage = Value
    end
})

Tabs.Race:AddToggle("Esp Mirage Island", {
    Title = "Esp Mirage Island",
    Default = false,
    Callback = function(Value)
        MirageIslandESP = Value
    end
})

Tabs.Race:AddToggle("Auto Tween To Mirage Island", {
    Title = "Auto Tween To Mirage Island",
    Default = false,
    Callback = function(Value)
        _G.AutoMysticIsland = Value
    end
})

Tabs.Race:AddToggle("Auto Tween To Highest Point", {
    Title = "Auto Tween To Highest Point",
    Default = false,
    Callback = function(Value)
        _G.HighestMirage = Value
    end
})

Tabs.Race:AddToggle("Auto Collect Gear", {
    Title = "Auto Collect Gear",
    Default = false,
    Callback = function(Value)
        _G.TPGEAR = Value
    end
})

Tabs.Race:AddToggle("Change Transparency can see", {
    Title = "Change Transparency can see",
    Default = false,
    Callback = function(Value)
        _G.can = Value
    end
})

Tabs.Race:AddToggle("Auto Tween Advanced Fruit Dealer", {
    Title = "Auto Tween Advanced Fruit Dealer",
    Default = false,
    Callback = function(Value)
        _G.Addealer = Value
    end
})

Tabs.Race:AddToggle("Auto Collect Mirage Chest", {
    Title = "Auto Collect Mirage Chest",
    Default = false,
    Callback = function(Value)
        _G.FarmChestM = Value
    end
})

Tabs.Race:AddButton("Talk With Stone", {
    Title = "Talk With Stone",
    Callback = function()
        replicated:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("RaceV4Progress","Begin")
        replicated:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("RaceV4Progress","Check")
        replicated:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("RaceV4Progress","Teleport")
        replicated:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("RaceV4Progress","Continue")
    end
})

Tabs.Race:AddToggle("Auto Look At Moon", {
    Title = "Auto Look At Moon",
    Default = false,
    Callback = function(Value)
        LookM = Value
    end
})

Tabs.Race:AddToggle("Look Moon + Auto V3", {
    Title = "Look Moon + Auto V3",
    Default = false,
    Callback = function(Value)
        LookMV3 = Value
    end
})

Tabs.Race:AddSection("Upgrade Races V2 And V3")

Tabs.Race:AddToggle("Auto Upgrade Mink", {
    Title = "Auto Upgrade Mink",
    Default = false,
    Callback = function(Value)
        _G.Auto_Mink = Value
    end
})

Tabs.Race:AddToggle("Auto Upgrade Human", {
    Title = "Auto Upgrade Human",
    Default = false,
    Callback = function(Value)
        _G.Auto_Human = Value
    end
})

Tabs.Race:AddToggle("Auto Upgrade Angel", {
    Title = "Auto Upgrade Angel",
    Default = false,
    Callback = function(Value)
        _G.Auto_Skypiea = Value
    end
})

Tabs.Race:AddToggle("Auto Upgrade FishMan", {
    Title = "Auto Upgrade FishMan",
    Default = false,
    Callback = function(Value)
        _G.Auto_Fish = Value
    end
})

Tabs.Race:AddSection("Trials Quest V4")

Tabs.Race:AddToggle("Auto Pull Lever", {
    Title = "Auto Pull Lever",
    Default = false,
    Callback = function(Value)
        _G.Lver = Value
    end
})

Tabs.Race:AddToggle("Auto Train V4", {
    Title = "Auto Train V4",
    Default = false,
    Callback = function(Value)
        _G.AcientOne = Value
    end
})

Tabs.Race:AddButton("Teleport to Temple of Time", {
    Title = "Teleport to Temple of Time",
    Callback = function()
        local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875)
        end
        if not workspace.Map:FindFirstChild("Temple of Time") and World3 then
            local stash = game:GetService("ReplicatedStorage"):FindFirstChild("MapStash")
            if stash and stash:FindFirstChild("Temple of Time") then
                stash["Temple of Time"].Parent = workspace.Map
            end
        end
    end
})

Tabs.Race:AddButton("Teleport to Ancient One", {
    Title = "Teleport to Ancient One",
    Callback = function()
        local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875)
        end
        if not workspace.Map:FindFirstChild("Temple of Time") and World3 then
            local stash = game:GetService("ReplicatedStorage"):FindFirstChild("MapStash")
            if stash and stash:FindFirstChild("Temple of Time") then
                stash["Temple of Time"].Parent = workspace.Map
            end
        end
        task.wait(2)
        _tp(CFrame.new(28981.552734375, 14888.4267578125, -120.245849609375))
    end
})

Tabs.Race:AddButton("Teleport to Ancient Clock", {
    Title = "Teleport to Ancient Clock",
    Callback = function()
        local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875)
        end
        task.delay(2, function()
            _tp(CFrame.new(29549, 15069, -88))
        end)
        if not workspace.Map:FindFirstChild("Temple of Time") and World3 then
            local stash = game:GetService("ReplicatedStorage"):FindFirstChild("MapStash")
            if stash and stash:FindFirstChild("Temple of Time") then
                stash["Temple of Time"].Parent = workspace.Map
            end
        end
    end
})

Tabs.Race:AddToggle("Auto Teleport to Race Doors", {
    Title = "Auto Teleport to Race Doors",
    Default = false,
    Callback = function(Value)
        _G.TPDoor = Value
    end
})

Tabs.Race:AddToggle("Auto Complete Trial Race", {
    Title = "Auto Complete Trial Race",
    Default = false,
    Callback = function(Value)
        _G.Complete_Trials = Value
    end
})

Tabs.Race:AddToggle("Auto Kill Player After Trial", {
    Title = "Auto Kill Player After Trial",
    Default = false,
    Callback = function(Value)
        _G.Defeating = Value
    end
})

-- =================== TAB PREHISTORIC ===================
Tabs.Prehistoric:AddSection("Dojo Quest")

Tabs.Prehistoric:AddButton("Teleport To Dragon Dojo", {
    Title = "Teleport To Dragon Dojo",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5661.5322265625, 1013.0907592773438, -334.9649963378906))
        _tp(CFrame.new(5814.42724609375, 1208.3267822265625, 884.5785522460938))
    end
})

Tabs.Prehistoric:AddToggle("Auto Dojo Trainer", {
    Title = "Auto Dojo Trainer",
    Default = false,
    Callback = function(Value)
        _G.Dojoo = Value
    end
})

Tabs.Prehistoric:AddToggle("Auto Dragon Hunter", {
    Title = "Auto Dragon Hunter",
    Default = false,
    Callback = function(Value)
        _G.FarmBlazeEM = Value
    end
})

Tabs.Prehistoric:AddSection("Drago Trial")

Tabs.Prehistoric:AddToggle("Tween To Upgrade Droco Trial", {
    Title = "Tween To Upgrade Droco Trial",
    Default = false,
    Callback = function(Value)
        _G.UPGDrago = Value
    end
})

Tabs.Prehistoric:AddToggle("Auto Drago (V1)", {
    Title = "Auto Drago (V1)",
    Default = false,
    Callback = function(Value)
        _G.DragoV1 = Value
    end
})

Tabs.Prehistoric:AddToggle("Auto Drago (V2)", {
    Title = "Auto Drago (V2)",
    Default = false,
    Callback = function(Value)
        _G.AutoFireFlowers = Value
    end
})

Tabs.Prehistoric:AddToggle("Auto Drago (V3)", {
    Title = "Auto Drago (V3)",
    Default = false,
    Callback = function(Value)
        _G.DragoV3 = Value
    end
})

Tabs.Prehistoric:AddToggle("Auto Relic Drago Trial [Beta]", {
    Title = "Auto Relic Drago Trial [Beta]",
    Default = false,
    Callback = function(Value)
        _G.Relic123 = Value
    end
})

Tabs.Prehistoric:AddToggle("Auto Train Drago v4", {
    Title = "Auto Train Drago v4",
    Default = false,
    Callback = function(Value)
        _G.TrainDrago = Value
    end
})

Tabs.Prehistoric:AddToggle("Tween to Drago Trials", {
    Title = "Tween to Drago Trials",
    Default = false,
    Callback = function(Value)
        _G.TpDrago_Prehis = Value
    end
})

Tabs.Prehistoric:AddToggle("Swap Drago Race", {
    Title = "Swap Drago Race",
    Default = false,
    Callback = function(Value)
        _G.BuyDrago = Value
    end
})

Tabs.Prehistoric:AddToggle("Upgrade Dragon Talon With Uzoth", {
    Title = "Upgrade Dragon Talon With Uzoth",
    Default = false,
    Callback = function(Value)
        _G.DT_Uzoth = Value
    end
})

Tabs.Prehistoric:AddSection("Volcanic Crafting")

Tabs.Prehistoric:AddButton("Craft Dragonheart", {
    Title = "Craft Dragonheart",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "Dragonheart")
    end
})

Tabs.Prehistoric:AddButton("Craft Dragonstorm", {
    Title = "Craft Dragonstorm",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "Dragonstorm")
    end
})

Tabs.Prehistoric:AddButton("Craft Dino Hood", {
    Title = "Craft Dino Hood",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "DinoHood")
    end
})

Tabs.Prehistoric:AddButton("Craft T-Rex Skull", {
    Title = "Craft T-Rex Skull",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "TRexSkull")
    end
})

Tabs.Prehistoric:AddButton("Craft Volcanic Magnet", {
    Title = "Craft Volcanic Magnet",
    Callback = function()
        game:GetService("ReplicatedStorage").Modules.Net["RF/Craft"]:InvokeServer("PossibleHardcode", "Volcanic Magnet")
    end
})

Tabs.Prehistoric:AddToggle("Craft Volcanic Magnet", {
    Title = "Craft Volcanic Magnet",
    Default = false,
    Callback = function(Value)
        getgenv().AutoCraftVolcanic = Value
    end
})

Tabs.Prehistoric:AddSection("Prehistoric Island")

Tabs.Prehistoric:AddToggle("Auto Find Prehistoric Island", {
    Title = "Auto Find Prehistoric Island",
    Default = false,
    Callback = function(Value)
        _G.Prehis_Find = Value
    end
})

Tabs.Prehistoric:AddToggle("Auto Start Prehistoric Event", {
    Title = "Auto Start Prehistoric Event",
    Default = false,
    Callback = function(Value)
        _G.AutoStartPrehistoric = Value
    end
})

Tabs.Prehistoric:AddToggle("Auto Patch Prehistoric Event", {
    Title = "Auto Patch Prehistoric Event",
    Default = false,
    Callback = function(Value)
        _G.Prehis_Skills = Value
    end
})

Tabs.Prehistoric:AddToggle("Kill Aura", {
    Title = "Kill Aura",
    Default = false,
    Callback = function(Value)
        _G.KillAuraFull = Value
    end
})

Tabs.Prehistoric:AddToggle("Auto Collect Dino Bones", {
    Title = "Auto Collect Dino Bones",
    Default = false,
    Callback = function(Value)
        _G.Prehis_DB = Value
    end
})

Tabs.Prehistoric:AddToggle("Auto Collect Dragon Eggs", {
    Title = "Auto Collect Dragon Eggs",
    Default = false,
    Callback = function(Value)
        _G.Prehis_DE = Value
    end
})

Tabs.Prehistoric:AddToggle("Auto Reset When Complete Volcano", {
    Title = "Auto Reset When Complete Volcano",
    Default = false,
    Callback = function(Value)
        _G.ResetPH = Value
    end
})

-- =================== TAB SEA EVENT ===================
Tabs.SeaEvent:AddSection("Sea Event / Setting Sail")

local ListSeaBoat = {"Guardian","PirateGrandBrigade","MarineGrandBrigade","PirateBrigade","MarineBrigade","PirateSloop","MarineSloop","Beast Hunter"}
local ListSeaZone = {"Lv 1","Lv 2","Lv 3","Lv 4","Lv 5","Lv 6","Lv Infinite"}

Tabs.SeaEvent:AddButton("Remove Lighting Effect", {
    Title = "Remove Lighting Effect",
    Callback = function()
        game:GetService("Lighting").BaseAtmosphere:Destroy()
    end
})

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

Tabs.SeaEvent:AddSection("Crafting Items")

Tabs.SeaEvent:AddButton("Craft SharkTooth", {
    Title = "Craft SharkTooth",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "SharkTooth")
    end
})

Tabs.SeaEvent:AddButton("Craft TerrorJaw", {
    Title = "Craft TerrorJaw",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "TerrorJaw")
    end
})

Tabs.SeaEvent:AddButton("Craft SharkAnchor", {
    Title = "Craft SharkAnchor",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "SharkAnchor")
    end
})

Tabs.SeaEvent:AddButton("Craft LeviathanCrown", {
    Title = "Craft LeviathanCrown",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "LeviathanCrown")
    end
})

Tabs.SeaEvent:AddButton("Craft LeviathanShield", {
    Title = "Craft LeviathanShield",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "LeviathanShield")
    end
})

Tabs.SeaEvent:AddButton("Craft LeviathanBoat", {
    Title = "Craft LeviathanBoat",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "LeviathanBoat")
    end
})

Tabs.SeaEvent:AddButton("Craft LegendaryScroll", {
    Title = "Craft LegendaryScroll",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "LegendaryScroll")
    end
})

Tabs.SeaEvent:AddButton("Craft MythicalScroll", {
    Title = "Craft MythicalScroll",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "MythicalScroll")
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

Tabs.SeaEvent:AddButton("Buy Boats", {
    Title = "Buy Boats",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuyBoat",_G.SelectedBoat)
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

Tabs.SeaEvent:AddToggle("Auto Piranha", {
    Title = "Auto Piranha",
    Default = false,
    Callback = function(Value)
        _G.Piranha = Value
    end
})

Tabs.SeaEvent:AddToggle("Auto Terror Shark", {
    Title = "Auto Terror Shark",
    Default = false,
    Callback = function(Value)
        _G.TerrorShark = Value
    end
})

Tabs.SeaEvent:AddToggle("Auto Fish Crew Member", {
    Title = "Auto Fish Crew Member",
    Default = false,
    Callback = function(Value)
        _G.MobCrew = Value
    end
})

Tabs.SeaEvent:AddToggle("Auto Haunted Crew Member", {
    Title = "Auto Haunted Crew Member",
    Default = false,
    Callback = function(Value)
        _G.HCM = Value
    end
})

Tabs.SeaEvent:AddToggle("Auto Attack PirateGrandBrigade", {
    Title = "Auto Attack PirateGrandBrigade",
    Default = false,
    Callback = function(Value)
        _G.PGB = Value
    end
})

Tabs.SeaEvent:AddToggle("Auto Attack Fish Boat", {
    Title = "Auto Attack Fish Boat",
    Default = false,
    Callback = function(Value)
        _G.FishBoat = Value
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

Tabs.SeaEvent:AddToggle("Auto Drive To Hydra Island", {
    Title = "Auto Drive To Hydra Island",
    Default = false,
    Callback = function(Value)
        _G.SailBoat_Hydra = Value
    end
})

Tabs.SeaEvent:AddSection("Kitsune Island / Event")

Tabs.SeaEvent:AddToggle("Auto Find Kitsune Island", {
    Title = "Auto Find Kitsune Island",
    Default = false,
    Callback = function(Value)
        _G.AutofindKitIs = Value
    end
})

Tabs.SeaEvent:AddToggle("Auto Teleport to Shrine Actived", {
    Title = "Auto Teleport to Shrine Actived",
    Default = false,
    Callback = function(Value)
        _G.tweenShrine = Value
    end
})

Tabs.SeaEvent:AddToggle("Auto Collect Azure Ember", {
    Title = "Auto Collect Azure Ember",
    Default = false,
    Callback = function(Value)
        _G.Collect_Ember = Value
    end
})

Tabs.SeaEvent:AddToggle("Auto Trade Azure Ember", {
    Title = "Auto Trade Azure Ember",
    Default = false,
    Callback = function(Value)
        _G.Trade_Ember = Value
    end
})

Tabs.SeaEvent:AddButton("Trade Items Azure", {
    Title = "Trade Items Azure",
    Callback = function()
        replicated.Modules.Net:FindFirstChild("RF/KitsuneStatuePray"):InvokeServer()
    end
})

Tabs.SeaEvent:AddButton("Talk with kitsune statue", {
    Title = "Talk with kitsune statue",
    Callback = function()
        replicated.Modules.Net:FindFirstChild("RE/TouchKitsuneStatue"):FireServer()
    end
})

Tabs.SeaEvent:AddSection("Frozen Dimension Event")

Tabs.SeaEvent:AddButton("Buy Spy", {
    Title = "Buy Spy",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("InfoLeviathan", "2")
    end
})

Tabs.SeaEvent:AddToggle("Auto Teleport Frozen Dimension", {
    Title = "Auto Teleport Frozen Dimension",
    Default = false,
    Callback = function(Value)
        _G.FrozenTP = Value
    end
})

-- =================== TAB RAIDS ===================
Tabs.Raids:AddSection("Fruits Options")

Tabs.Raids:AddToggle("Auto Random Fruit", {
    Title = "Auto Random Fruit",
    Default = false,
    Callback = function(Value)
        _G.Random_Auto = Value
    end
})

Tabs.Raids:AddToggle("Auto Drop Fruit", {
    Title = "Auto Drop Fruit",
    Default = false,
    Callback = function(Value)
        _G.DropFruit = Value
    end
})

Tabs.Raids:AddToggle("Auto Store Fruit", {
    Title = "Auto Store Fruit",
    Default = false,
    Callback = function(Value)
        _G.StoreF = Value
    end
})

Tabs.Raids:AddToggle("Auto Tween to Fruit", {
    Title = "Auto Tween to Fruit",
    Default = false,
    Callback = function(Value)
        _G.TwFruits = Value
    end
})

Tabs.Raids:AddToggle("Auto Collect Fruit", {
    Title = "Auto Collect Fruit",
    Default = false,
    Callback = function(Value)
        _G.InstanceF = Value
    end
})

Tabs.Raids:AddDropdown("Select Fruit Shop", {
    Title = "Select Fruit Shop",
    Options = {"Rocket-Rocket","Spin-Spin","Blade-Blade","Spring-Spring","Bomb-Bomb","Smoke-Smoke","Spike-Spike","Flame-Flame","Ice-Ice","Sand-Sand","Dark-Dark","Eagle-Eagle","Diamond-Diamond","Light-Light","Rubber-Rubber","Ghost-Ghost","Magma-Magma","Quake-Quake","Buddha-Buddha","Love-Love","Creation-Creation","Spider-Spider","Sound-Sound","Phoenix-Phoenix","Portal-Portal","Lightning-Lightning","Pain-Pain","Blizzard-Blizzard","Gravity-Gravity","T-Rex-T-Rex","Mammoth-Mammoth","Dough-Dough","Shadow-Shadow","Venom-Venom","Gas-Gas","Control-Control","Spirit-Spirit","Leopard-Leopard","Yeti-Yeti","Kitsune-Kitsune","Dragon-Dragon"},
    Default = "Rocket-Rocket",
    Callback = function(Value)
        getgenv().SelectFruit = Value
    end
})

Tabs.Raids:AddToggle("Auto Buy Fruit Shop", {
    Title = "Auto Buy Fruit Shop",
    Default = false,
    Callback = function(Value)
        getgenv().AutoBuyFruitSniper = Value
    end
})

Tabs.Raids:AddToggle("Get Fruit In Inventory Below 1M", {
    Title = "Get Fruit In Inventory Below 1M",
    Default = false,
    Callback = function(Value)
        getgenv().AutoGetFruit = Value
    end
})

Tabs.Raids:AddSection("Dungeon Event / Raiding")

Tabs.Raids:AddDropdown("Select Chip", {
    Title = "Select Chip",
    Options = DungeonTables,
    Default = DungeonTables[1],
    Callback = function(Value)
        _G.SelectChip = Value
    end
})

Tabs.Raids:AddToggle("Auto Select Dungeon Chip", {
    Title = "Auto Select Dungeon Chip",
    Default = false,
    Callback = function(Value)
        _G.AutoSelectDungeon = Value
    end
})

Tabs.Raids:AddButton("Buy Dungeon Chips [Beli]", {
    Title = "Buy Dungeon Chips [Beli]",
    Callback = function()
        if not GetBP("Special Microchip") then
            replicated.Remotes.CommF_:InvokeServer("RaidsNpc","Select",_G.SelectChip)
        end
    end
})

Tabs.Raids:AddButton("Buy Dungeon Chips [Devil Fruit]", {
    Title = "Buy Dungeon Chips [Devil Fruit]",
    Callback = function()
        if GetBP("Special Microchip") then return end
        local FruitPrice = {}
        local FruitStore = {}
        for i,v in next,replicated:WaitForChild("Remotes").CommF_:InvokeServer("GetFruits") do
            if v.Price <= 490000 then table.insert(FruitPrice,v.Name) end 
        end    
        for _,y in pairs(FruitPrice) do    
            for i,v in pairs(DungeonTables) do 
                if not GetBP("Special Microchip") then     
                    replicated.Remotes.CommF_:InvokeServer("LoadFruit",tostring(y))	      
                    replicated.Remotes.CommF_:InvokeServer("RaidsNpc","Select",_G.SelectChip)	
                end            
            end    
        end
    end
})

Tabs.Raids:AddToggle("Auto Buy Chip [Beli]", {
    Title = "Auto Buy Chip [Beli]",
    Default = false,
    Callback = function(Value)
        _G.AutoChipBeli = Value
    end
})

Tabs.Raids:AddToggle("Auto Buy Chip [Devil Fruit]", {
    Title = "Auto Buy Chip [Devil Fruit]",
    Default = false,
    Callback = function(Value)
        _G.AutoChipFruit = Value
    end
})

Tabs.Raids:AddToggle("Auto Start Raid", {
    Title = "Auto Start Raid",
    Default = false,
    Callback = function(Value)
        _G.Auto_StartRaid = Value
    end
})

Tabs.Raids:AddToggle("Auto Raid + Next Island", {
    Title = "Auto Raid + Next Island",
    Default = false,
    Callback = function(Value)
        _G.Raiding = Value
    end
})

Tabs.Raids:AddToggle("Auto Awakening", {
    Title = "Auto Awakening",
    Default = false,
    Callback = function(Value)
        _G.Auto_Awakener = Value
    end
})

Tabs.Raids:AddToggle("Auto Teleport To Lab", {
    Title = "Auto Teleport To Lab",
    Default = false,
    Callback = function(Value)
        _G.TpLab = Value
    end
})

Tabs.Raids:AddSection("Items Law/Order Sword")

Tabs.Raids:AddButton("Buy Microchip Law", {
    Title = "Buy Microchip Law",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BlackbeardReward","Microchip","2")
    end
})

Tabs.Raids:AddButton("Start Law Raids", {
    Title = "Start Law Raids",
    Callback = function()
        fireclickdetector(workspace.Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
    end
})

Tabs.Raids:AddToggle("Auto Buy Microchip Law", {
    Title = "Auto Buy Microchip Law",
    Default = false,
    Callback = function(Value)
        getgenv().AutoBuyMicrochipLaw = Value
    end
})

Tabs.Raids:AddToggle("Auto Start Law Raids", {
    Title = "Auto Start Law Raids",
    Default = false,
    Callback = function(Value)
        getgenv().AutoStartLawRaids = Value
    end
})

Tabs.Raids:AddToggle("Auto Kill Law", {
    Title = "Auto Kill Law",
    Default = false,
    Callback = function(Value)
        _G.AutoLawKak = Value
    end
})

Tabs.Raids:AddSection("Raids Dungeons")

Tabs.Raids:AddToggle("Auto Farm Dungeon", {
    Title = "Auto Farm Dungeon",
    Default = false,
    Callback = function(Value)
        _G.AutoFarmDungeon = Value
    end
})

Tabs.Raids:AddToggle("TP Exit (1)", {
    Title = "TP Exit (1)",
    Default = false,
    Callback = function(Value)
        _G.TPFloor1 = Value
    end
})

Tabs.Raids:AddToggle("TP Exit (2)", {
    Title = "TP Exit (2)",
    Default = false,
    Callback = function(Value)
        _G.TPFloor2 = Value
    end
})

Tabs.Raids:AddToggle("TP Exit (3)", {
    Title = "TP Exit (3)",
    Default = false,
    Callback = function(Value)
        _G.TPFloor3 = Value
    end
})

Tabs.Raids:AddToggle("TP Exit (4)", {
    Title = "TP Exit (4)",
    Default = false,
    Callback = function(Value)
        _G.TPFloor4 = Value
    end
})

-- =================== TAB HOP ===================
Tabs.Hop:AddSection("Server Browser")

local IsHopping = false
local HopToggle

HopToggle = Tabs.Hop:AddToggle("Auto Hop Full Moon", {
    Title = "Auto Hop Full Moon",
    Default = false,
    Callback = function(Value)
        IsHopping = Value
        if IsHopping then
            task.spawn(function()
                local visited = _G.VisitedFullMoonServers or {}
                _G.VisitedFullMoonServers = visited
                while IsHopping do
                    local HttpService = game:GetService("HttpService")
                    local TeleportService = game:GetService("TeleportService")
                    local TeleportRemote = replicated:WaitForChild("__ServerBrowser")
                    local request_fn = (syn and syn.request) or http_request or request or (fluxus and fluxus.request) or (http and http.request)
                    if not request_fn then
                        warn("[Hop] Executor không hỗ trợ request!")
                        IsHopping = false
                        if HopToggle and HopToggle.Set then HopToggle:Set(false) end
                        break
                    end
                    local API = "https://api-server-clig.onrender.com/"
                    local ok, res = pcall(function()
                        return request_fn({ Url = API, Method = "GET", Headers = {["User-Agent"] = "Roblox"} })
                    end)
                    if ok and res then
                        local success, body = pcall(function() return HttpService:JSONDecode(res.Body) end)
                        if success and body then
                            local server_list = body.all_servers or body.moon_data or body.servers
                            if server_list and type(server_list) == "table" then
                                local full_moon_servers = {}
                                for _, v in ipairs(server_list) do
                                    local job = tostring(v.jobid or v.jobId or v.id or "")
                                    local isFullMoon = v.type == "FullMoon" or (v.name and string.find(v.name, "FullMoon"))
                                    if #job > 10 and job ~= game.JobId and not visited[job] and isFullMoon then
                                        table.insert(full_moon_servers, job)
                                    end
                                end
                                if #full_moon_servers > 0 then
                                    local selected = full_moon_servers[math.random(1, #full_moon_servers)]
                                    print("[Hop] Chọn server Full Moon:", selected)
                                    visited[selected] = true
                                    Window:Notify({
                                        Title = "Tay Hub",
                                        Content = "Đã vào server: " .. selected,
                                        Duration = 5
                                    })
                                    local teleport_ok = pcall(function()
                                        TeleportRemote:InvokeServer("teleport", selected)
                                    end)
                                    if not teleport_ok then
                                        pcall(function()
                                            TeleportService:TeleportToPlaceInstance(game.PlaceId, selected, game.Players.LocalPlayer)
                                        end)
                                    end
                                end
                            end
                        end
                    end
                    task.wait(0.1)
                end
                if HopToggle and HopToggle.Set then HopToggle:Set(false) end
            end)
        end
    end
})

-- =================== FLY FUNCTIONS ===================
local flying = false
local flySpeed = 50
local flyConnection
local ctrl = {f = 0, b = 0, l = 0, r = 0}
local bg, bv

local function toggleFly(value)
    flying = value
    
    if flying then
        if not plr.Character then return end
        
        local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
        local rootPart = plr.Character:FindFirstChild("Torso") or plr.Character:FindFirstChild("UpperTorso")
        
        if not humanoid or not rootPart then return end
        
        for _, part in ipairs(plr.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
                part.Massless = true
            end
        end
        
        bg = Instance.new("BodyGyro", rootPart)
        bg.P = 9e4
        bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.cframe = rootPart.CFrame
        
        bv = Instance.new("BodyVelocity", rootPart)
        bv.velocity = Vector3.new(0, 0, 0)
        bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
        
        humanoid.PlatformStand = true
        
        flyConnection = RunService.Heartbeat:Connect(function()
            if not flying or not plr.Character then return end
            
            for _, part in ipairs(plr.Character:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
            
            if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
                bv.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f + ctrl.b)) + 
                              ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l + ctrl.r, (ctrl.f + ctrl.b) * 0.2, 0).p) - 
                              workspace.CurrentCamera.CoordinateFrame.p)) * flySpeed
            else
                bv.velocity = Vector3.new(0, 0, 0)
            end
            
            bg.cframe = workspace.CurrentCamera.CoordinateFrame
        end)
    else
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
        
        if plr.Character then
            local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.PlatformStand = false
            end
            
            for _, part in ipairs(plr.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                    part.Massless = false
                end
            end
            
            if bg then bg:Destroy() end
            if bv then bv:Destroy() end
        end
        
        ctrl = {f = 0, b = 0, l = 0, r = 0}
    end
end

plr.CharacterAdded:Connect(function(character)
    wait(1)
    if flying then
        toggleFly(false)
        wait(0.1)
        toggleFly(true)
    end
end)

-- =================== ESP FUNCTIONS ===================
function isnil(thing)
    return (thing == nil)
end

local function round(n)
    return math.floor(tonumber(n) + 0.5)
end

Number = math.random(1, 1000000)

EspPly = function()
    for _,v in next, game.Players:GetChildren() do
        pcall(function()
            if not isnil(v.Character) then
                if PlayerEsp then
                    if not isnil(v.Character.Head) and not v.Character.Head:FindFirstChild('NameEsp'..Number) then
                        local bill = Instance.new('BillboardGui',v.Character.Head)
                        bill.Name = 'NameEsp'..Number
                        bill.ExtentsOffset = Vector3.new(0, 1, 0)
                        bill.Size = UDim2.new(1,200,1,30)
                        bill.Adornee = v.Character.Head
                        bill.AlwaysOnTop = true
                        local name = Instance.new('TextLabel',bill)
                        name.Font = Enum.Font.Code
                        name.TextSize = 14
                        name.TextWrapped = true
                        name.Text = (v.Name ..' \n'.. round((plr.Character.Head.Position - v.Character.Head.Position).Magnitude/3) ..' M')
                        name.Size = UDim2.new(1,0,1,0)
                        name.TextYAlignment = 'Top'
                        name.BackgroundTransparency = 1
                        name.TextStrokeTransparency = 0.5
                        if v.Team == TeamSelf then
                            name.TextColor3 = Color3.new(0,0,254)
                        else
                            name.TextColor3 = Color3.new(255,0,0)
                        end
                    else
                        if v.Character.Head:FindFirstChild('NameEsp'..Number) then
                            v.Character.Head['NameEsp'..Number].TextLabel.Text = (v.Name ..' | '.. round((plr.Character.Head.Position - v.Character.Head.Position).Magnitude/3) ..' M\nHealth : ' .. round(v.Character.Humanoid.Health*100/v.Character.Humanoid.MaxHealth) .. '%')
                        end
                    end
                else
                    if v.Character.Head:FindFirstChild('NameEsp'..Number) then
                        v.Character.Head:FindFirstChild('NameEsp'..Number):Destroy()
                    end
                end
            end
        end)
    end
end

LocationEsp = function() 
    for _,v in next, workspace["_WorldOrigin"].Locations:GetChildren() do
        pcall(function()
            if IslandESP then 
                if (v.Name ~= "Sea") then
                    if not v:FindFirstChild('NameEsp') then
                        local bill = Instance.new('BillboardGui',v)
                        bill.Name = 'NameEsp'
                        bill.ExtentsOffset = Vector3.new(0, 1, 0)
                        bill.Size = UDim2.new(1,200,1,30)
                        bill.Adornee = v
                        bill.AlwaysOnTop = true
                        local name = Instance.new('TextLabel',bill)
                        name.Font = Enum.Font.Code
                        name.TextSize = 14
                        name.TextWrapped = true
                        name.Size = UDim2.new(1,0,1,0)
                        name.TextYAlignment = 'Top'
                        name.BackgroundTransparency = 1
                        name.TextStrokeTransparency = 0.5
                        name.TextColor3 = Color3.fromRGB(98,252,252)
                        name.Text = (v.Name ..'   \n'.. round((plr.Character.Head.Position - v.Position).Magnitude/3) ..' M')
                    else
                        v['NameEsp'].TextLabel.Text = (v.Name ..'   \n'.. round((plr.Character.Head.Position - v.Position).Magnitude/3) ..' M')
                    end
                end
            else
                if v:FindFirstChild('NameEsp') then
                    v:FindFirstChild('NameEsp'):Destroy()
                end
            end
        end)
    end
end

DevEsp = function()
    for i,v in next, workspace:GetChildren() do
        pcall(function()
            if DevilFruitESP then
                if string.find(v.Name, "Fruit") then   
                    if not v.Handle:FindFirstChild('NameEsp'..Number) then
                        local bill = Instance.new('BillboardGui',v.Handle)
                        bill.Name = 'NameEsp'..Number
                        bill.ExtentsOffset = Vector3.new(0, 1, 0)
                        bill.Size = UDim2.new(1,200,1,30)
                        bill.Adornee = v.Handle
                        bill.AlwaysOnTop = true
                        local name = Instance.new('TextLabel',bill)
                        name.Font = Enum.Font.Code
                        name.TextSize = 14
                        name.TextWrapped = true
                        name.Size = UDim2.new(1,0,1,0)
                        name.TextYAlignment = 'Top'
                        name.BackgroundTransparency = 1
                        name.TextStrokeTransparency = 0.5
                        name.TextColor3 = Color3.fromRGB(255,255,255)
                        name.Text = (v.Name ..' \n'.. round((plr.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' M')
                    else
                        v.Handle['NameEsp'..Number].TextLabel.Text = ('[' ..v.Name ..']' ..'   \n'.. round((plr.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' M')
                    end
                end
            else
                if v:FindFirstChild('Handle') and v.Handle:FindFirstChild('NameEsp'..Number) then
                    v.Handle:FindFirstChild('NameEsp'..Number):Destroy()
                end
            end
        end)
    end
end

flowerEsp = function()
    for i,v in pairs(workspace:GetChildren()) do
        pcall(function()
            if v.Name == "Flower2" or v.Name == "Flower1" then
                if FlowerESP then 
                    if not v:FindFirstChild('NameEsp'..Number) then
                        local bill = Instance.new('BillboardGui',v)
                        bill.Name = 'NameEsp'..Number
                        bill.ExtentsOffset = Vector3.new(0, 1, 0)
                        bill.Size = UDim2.new(1,200,1,30)
                        bill.Adornee = v
                        bill.AlwaysOnTop = true
                        local name = Instance.new('TextLabel',bill)
                        name.Font = Enum.Font.Code
                        name.TextSize = 14
                        name.TextWrapped = true
                        name.Size = UDim2.new(1,0,1,0)
                        name.TextYAlignment = 'Top'
                        name.BackgroundTransparency = 1
                        name.TextStrokeTransparency = 0.5
                        name.TextColor3 = Color3.fromRGB(88, 214, 252)
                        if v.Name == "Flower1" then 
                            name.Text = ("Blue Flower" ..' \n'.. round((plr.Character.Head.Position - v.Position).Magnitude/3) ..' M')
                        elseif v.Name == "Flower2" then
                            name.Text = ("Red Flower" ..' \n'.. round((plr.Character.Head.Position - v.Position).Magnitude/3) ..' M')
                        end
                    else
                        v['NameEsp'..Number].TextLabel.Text = (v.Name ..'   \n'.. round((plr.Character.Head.Position - v.Position).Magnitude/3) ..' M')
                    end
                else
                    if v:FindFirstChild('NameEsp'..Number) then
                        v:FindFirstChild('NameEsp'..Number):Destroy()
                    end
                end
            end   
        end)
    end
end

EventIslandEsp = function()
    for i, v in pairs(workspace._WorldOrigin.Locations:GetChildren()) do
        pcall(function()
            if EspEventIsland then
                if (v.Name == "Mirage Island" or v.Name =="Prehistoric Island" or v.Name =="Kitsune Island") then
                    if not v:FindFirstChild("NameEsp") then
                        local bill = Instance.new("BillboardGui", v)
                        bill.Name = "NameEsp"
                        bill.ExtentsOffset = Vector3.new(0, 1, 0)
                        bill.Size = UDim2.new(1, 200, 1, 30)
                        bill.Adornee = v
                        bill.AlwaysOnTop = true
                        local name = Instance.new("TextLabel", bill)
                        name.Font = "Code"
                        name.TextSize = 14
                        name.TextWrapped = true
                        name.Size = UDim2.new(1, 0, 1, 0)
                        name.TextYAlignment = "Top"
                        name.BackgroundTransparency = 1
                        name.TextStrokeTransparency = 0.5
                        name.TextColor3 = Color3.fromRGB(80, 245, 245)
                        name.Text = (v.Name .. "   \n" .. round((plr.Character.Head.Position - v.Position).Magnitude / 3) .. " M")
                    else
                        v.NameEsp.TextLabel.Text = v.Name .. "   \n" .. round((plr.Character.Head.Position - v.Position).Magnitude / 3) .. " M"
                    end
                end
            else
                if v:FindFirstChild("NameEsp") then
                    v:FindFirstChild("NameEsp"):Destroy()
                end
            end
        end)
    end
end

gearEsp = function()
    for _,v in pairs(workspace.Map.MysticIsland:GetDescendants()) do
        pcall(function()
            if ESPGear then
                if v.Name == "Part" and v.Material == Enum.Material.Neon then
                    if not v:FindFirstChild("NameEsp") then
                        local bill = Instance.new("BillboardGui", v)
                        bill.Name = "NameEsp"
                        bill.ExtentsOffset = Vector3.new(0, 1, 0)
                        bill.Size = UDim2.new(1, 200, 1, 30)
                        bill.Adornee = v
                        bill.AlwaysOnTop = true
                        local name = Instance.new("TextLabel", bill)
                        name.Font = "Code"
                        name.TextSize = 14
                        name.TextWrapped = true
                        name.Size = UDim2.new(1, 0, 1, 0)
                        name.TextYAlignment = "Top"
                        name.BackgroundTransparency = 1
                        name.TextStrokeTransparency = 0.5
                        name.TextColor3 = Color3.fromRGB(80, 245, 245)
                        name.Text = ("Gear" .."   \n" .. round((plr.Character.Head.Position - v.Position).Magnitude / 3).. " M")
                    else
                        v["NameEsp"].TextLabel.Text =("Gear" .."   \n" .. round((plr.Character.Head.Position - v.Position).Magnitude / 3).. " M")
                    end
                end
            else
                if v:FindFirstChild("NameEsp") then
                    v:FindFirstChild("NameEsp"):Destroy()
                end
            end
        end)
    end
end

AdvanFruitEsp = function()
    if advanEsp then     
        for _,v in pairs(replicated.NPCs:GetChildren()) do
            if v.Name == "Advanced Fruit Dealer" then
                if not workspace:FindFirstChild("Adv") then
                    Adv = Instance.new("Part")
                    Adv.Name = "Adv"
                    Adv.Transparency = 1
                    Adv.Size = Vector3.new(1,1,1)
                    Adv.Anchored = true
                    Adv.CanCollide = false
                    Adv.Parent = workspace
                    Adv.CFrame = v.HumanoidRootPart.CFrame    
                elseif workspace:FindFirstChild("Adv") then
                    if not Adv:FindFirstChild("NameEsp") then
                        local bill = Instance.new("BillboardGui", Adv)
                        bill.Name = "NameEsp"
                        bill.ExtentsOffset = Vector3.new(0, 1, 0)
                        bill.Size = UDim2.new(1, 200, 1, 30)
                        bill.Adornee = Adv
                        bill.AlwaysOnTop = true
                        local name = Instance.new("TextLabel", bill)
                        name.Font = "Code"
                        name.TextSize = 14
                        name.TextWrapped = true
                        name.Size = UDim2.new(1, 0, 1, 0)
                        name.TextYAlignment = "Top"
                        name.BackgroundTransparency = 1
                        name.TextStrokeTransparency = 0.5
                        name.TextColor3 = Color3.fromRGB(80, 245, 245)
                        name.Text = (v.Name .."   \n" ..round((plr.Character.Head.Position - v.HumanoidRootPart.Position).Magnitude /3) .." M")
                    else
                        Adv["NameEsp"].TextLabel.Text = (v.Name .."   \n" ..round((plr.Character.Head.Position - v.HumanoidRootPart.Position).Magnitude /3) .." M")    
                    end                              
                end
            end
        end
    else
        if workspace:FindFirstChild("Adv") then
            workspace:FindFirstChild("Adv"):Destroy()
        end    
    end
end

HakiClorEsp = function()
    if ColorEsp then     
        for _,v in pairs(replicated.NPCs:GetChildren()) do
            if v.Name == "Barista Cousin" then
                if not workspace:FindFirstChild("Gay") then
                    Gay = Instance.new("Part")
                    Gay.Name = "Gay"
                    Gay.Transparency = 1
                    Gay.Size = Vector3.new(1,1,1)
                    Gay.Anchored = true
                    Gay.CanCollide = false
                    Gay.Parent = workspace
                    Gay.CFrame = v.HumanoidRootPart.CFrame    
                elseif workspace:FindFirstChild("Gay") then
                    if not Gay:FindFirstChild("NameEsp") then
                        local bill = Instance.new("BillboardGui", Gay)
                        bill.Name = "NameEsp"
                        bill.ExtentsOffset = Vector3.new(0, 1, 0)
                        bill.Size = UDim2.new(1, 200, 1, 30)
                        bill.Adornee = Gay
                        bill.AlwaysOnTop = true
                        local name = Instance.new("TextLabel", bill)
                        name.Font = "Code"
                        name.TextSize = 14
                        name.TextWrapped = true
                        name.Size = UDim2.new(1, 0, 1, 0)
                        name.TextYAlignment = "Top"
                        name.BackgroundTransparency = 1
                        name.TextStrokeTransparency = 0.5
                        name.TextColor3 = Color3.fromRGB(80, 245, 245)
                        name.Text = (v.Name .."   \n" ..round((plr.Character.Head.Position - v.HumanoidRootPart.Position).Magnitude /3) .." M")
                    else
                        Gay["NameEsp"].TextLabel.Text = (v.Name .."   \n" ..round((plr.Character.Head.Position - v.HumanoidRootPart.Position).Magnitude /3) .." M")    
                    end                              
                end
            end
        end
    else
        if workspace:FindFirstChild("Gay") then
            workspace:FindFirstChild("Gay"):Destroy()
        end    
    end
end

LegenSword = function()
    if LegenS then     
        for _,v in pairs(replicated.NPCs:GetChildren()) do
            if v.Name == "Legendary Sword Dealer" then
                if not workspace:FindFirstChild("Lgd") then
                    Lgd = Instance.new("Part")
                    Lgd.Name = "Lgd"
                    Lgd.Transparency = 1
                    Lgd.Size = Vector3.new(1,1,1)
                    Lgd.Anchored = true
                    Lgd.CanCollide = false
                    Lgd.Parent = workspace
                    Lgd.CFrame = v.HumanoidRootPart.CFrame    
                elseif workspace:FindFirstChild("Lgd") then
                    if not Lgd:FindFirstChild("NameEsp") then
                        local bill = Instance.new("BillboardGui", Lgd)
                        bill.Name = "NameEsp"
                        bill.ExtentsOffset = Vector3.new(0, 1, 0)
                        bill.Size = UDim2.new(1, 200, 1, 30)
                        bill.Adornee = Lgd
                        bill.AlwaysOnTop = true
                        local name = Instance.new("TextLabel", bill)
                        name.Font = "Code"
                        name.TextSize = 14
                        name.TextWrapped = true
                        name.Size = UDim2.new(1, 0, 1, 0)
                        name.TextYAlignment = "Top"
                        name.BackgroundTransparency = 1
                        name.TextStrokeTransparency = 0.5
                        name.TextColor3 = Color3.fromRGB(80, 245, 245)
                        name.Text = (v.Name .."   \n" ..round((plr.Character.Head.Position - v.HumanoidRootPart.Position).Magnitude /3) .." M")
                    else
                        Lgd["NameEsp"].TextLabel.Text = (v.Name .."   \n" ..round((plr.Character.Head.Position - v.HumanoidRootPart.Position).Magnitude /3) .." M")    
                    end                              
                end
            end
        end
    else
        if workspace:FindFirstChild("Lgd") then
            workspace:FindFirstChild("Lgd"):Destroy()
        end    
    end
end

ChestEsp = function()
    if ChestESP then
        local CollectionService = game:GetService("CollectionService")
        local Chests = CollectionService:GetTagged("_ChestTagged")        
        for _, Chest in ipairs(Chests) do
            pcall(function()
                local chestPos = Chest:GetPivot().Position
                local distanceMagnitude = (chestPos - plr.Character.Head.Position).Magnitude
                local sanitizedFullName = Chest:GetFullName():gsub("[^%w_]", "_")
                local existingEsp = Chest:FindFirstChild("ChestEspAttachment")                    
                
                if not existingEsp then
                    local attachment = Instance.new("Attachment")
                    attachment.Name = "ChestEspAttachment"
                    attachment.Parent = Chest
                    attachment.Position = Vector3.new(0, 3, 0)                     
                    
                    local nameEsp = Instance.new("BillboardGui")
                    nameEsp.Name = "NameEsp"
                    nameEsp.Size = UDim2.new(0, 200, 0, 30)
                    nameEsp.Adornee = attachment
                    nameEsp.ExtentsOffset = Vector3.new(0, 1, 0)
                    nameEsp.AlwaysOnTop = true
                    nameEsp.Parent = attachment                        
                    
                    local nameLabel = Instance.new("TextLabel")
                    nameLabel.Font = Enum.Font.Code
                    nameLabel.TextSize = 14
                    nameLabel.TextWrapped = true
                    nameLabel.Size = UDim2.new(1, 0, 1, 0)
                    nameLabel.TextYAlignment = Enum.TextYAlignment.Top
                    nameLabel.BackgroundTransparency = 1
                    nameLabel.TextStrokeTransparency = 0.5
                    nameLabel.TextColor3 = Color3.fromRGB(80, 245, 245)
                    nameLabel.Parent = nameEsp
                end
                
                local nameEsp = existingEsp and existingEsp:FindFirstChild("NameEsp")
                if nameEsp then
                    local displayDistance = math.floor(distanceMagnitude / 3)
                    local chestName = Chest.Name:gsub("Label", "")
                    nameEsp.TextLabel.Text = string.format("[%s] %d M", chestName, displayDistance)
                end
            end)
        end
    else
        for _, Chest in ipairs(game:GetService("CollectionService"):GetTagged("_ChestTagged")) do
            local espAttachment = Chest:FindFirstChild("ChestEspAttachment")
            if espAttachment then
                espAttachment:Destroy()
            end
        end
    end
end

berriesEsp = function()
    if BerryEsp then
        local CollectionService = game:GetService("CollectionService")
        local BerryBushes = CollectionService:GetTagged("BerryBush")
        for _, Bush in ipairs(BerryBushes) do
            pcall(function()
                local bushPosition = Bush.Parent:GetPivot().Position
                for _, BerryName in pairs(Bush:GetAttributes()) do
                    if BerryName then
                        local espPartName = "BerryEspPart_" .. BerryName .. "_" .. tostring(bushPosition)
                        local existingEsp = workspace:FindFirstChild(espPartName)
                        
                        if not existingEsp then
                            existingEsp = Instance.new("Part")
                            existingEsp.Name = espPartName
                            existingEsp.Transparency = 1
                            existingEsp.Size = Vector3.new(1, 1, 1)
                            existingEsp.Anchored = true
                            existingEsp.CanCollide = false
                            existingEsp.Parent = workspace
                            existingEsp.CFrame = CFrame.new(bushPosition)
                        end
                        
                        if not existingEsp:FindFirstChild("NameEsp") then
                            local nameEsp = Instance.new("BillboardGui", existingEsp)
                            nameEsp.Name = "NameEsp"
                            nameEsp.ExtentsOffset = Vector3.new(0, 1, 0)
                            nameEsp.Size = UDim2.new(0, 200, 0, 30)
                            nameEsp.Adornee = existingEsp
                            nameEsp.AlwaysOnTop = true
                            
                            local nameLabel = Instance.new("TextLabel", nameEsp)
                            nameLabel.Font = Enum.Font.Code
                            nameLabel.TextSize = 14
                            nameLabel.TextWrapped = true
                            nameLabel.Size = UDim2.new(1, 0, 1, 0)
                            nameLabel.TextYAlignment = Enum.TextYAlignment.Top
                            nameLabel.BackgroundTransparency = 1
                            nameLabel.TextStrokeTransparency = 0.5
                            nameLabel.TextColor3 = Color3.fromRGB(80, 245, 245)
                        end
                        
                        local nameEsp = existingEsp:FindFirstChild("NameEsp")
                        local distance = (plr.Character.Head.Position - bushPosition).Magnitude / 3
                        if nameEsp then
                            nameEsp.TextLabel.Text = ('[' .. BerryName .. ']' .. " " .. math.round(distance) .. " M")
                        end
                    end
                end
            end)
        end
    else
        for _, v in ipairs(workspace:GetChildren()) do
            if v:IsA("Part") and v.Name:match("BerryEspPart_.*") then
                v:Destroy()
            end
        end
    end
end

-- =================== ESP LOOPS ===================
task.spawn(function()
    while PlayerEsp do
        EspPly()
        task.wait()
    end
end)

task.spawn(function()
    while IslandESP do
        LocationEsp()
        task.wait()
    end
end)

task.spawn(function()
    while DevilFruitESP do
        DevEsp()
        task.wait()
    end
end)

task.spawn(function()
    while FlowerESP do
        flowerEsp()
        task.wait()
    end
end)

task.spawn(function()
    while EspEventIsland do
        EventIslandEsp()
        task.wait()
    end
end)

task.spawn(function()
    while ESPGear do
        gearEsp()
        task.wait()
    end
end)

task.spawn(function()
    while advanEsp do
        AdvanFruitEsp()
        task.wait()
    end
end)

task.spawn(function()
    while ColorEsp do
        HakiClorEsp()
        task.wait()
    end
end)

task.spawn(function()
    while LegenS do
        LegenSword()
        task.wait()
    end
end)

task.spawn(function()
    while ChestESP do
        ChestEsp()
        task.wait()
    end
end)

task.spawn(function()
    while BerryEsp do
        berriesEsp()
        task.wait()
    end
end)

-- =================== FAST ATTACK ===================
local function IsEntityAlive(entity)
    if not entity then return false end
    local humanoid = entity:FindFirstChild("Humanoid")
    return humanoid and humanoid.Health > 0
end

local function GetEnemiesInRange(character, range)
    local enemies = game:GetService("Workspace").Enemies:GetChildren()
    local players = game:GetService("Players"):GetPlayers()
    local targets = {}
    local playerPos = character:GetPivot().Position
    for _, enemy in ipairs(enemies) do
        local rootPart = enemy:FindFirstChild("HumanoidRootPart")
        if rootPart and IsEntityAlive(enemy) then
            local distance = (rootPart.Position - playerPos).Magnitude
            if distance <= range then
                table.insert(targets, enemy)
            end
        end
    end
    for _, otherPlayer in ipairs(players) do
        if otherPlayer ~= player and otherPlayer.Character then
            local rootPart = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
            if rootPart and IsEntityAlive(otherPlayer.Character) then
                local distance = (rootPart.Position - playerPos).Magnitude
                if distance <= range then
                    table.insert(targets, otherPlayer.Character)
                end
            end
        end
    end
    return targets
end

function AttackNoCoolDown()
    local player = game:GetService("Players").LocalPlayer
    local character = player.Character
    if not character then return end
    local equippedWeapon = nil
    for _, item in ipairs(character:GetChildren()) do
        if item:IsA("Tool") then
            equippedWeapon = item
            break
        end
    end
    if not equippedWeapon then return end
    local enemiesInRange = GetEnemiesInRange(character, 60)
    if #enemiesInRange == 0 then return end
    local storage = game:GetService("ReplicatedStorage")
    local modules = storage:FindFirstChild("Modules")
    if not modules then return end
    local attackEvent = storage:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/RegisterAttack")
    local hitEvent = storage:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/RegisterHit")
    if not attackEvent or not hitEvent then return end
    local targets, mainTarget = {}, nil
    for _, enemy in ipairs(enemiesInRange) do
        if not enemy:GetAttribute("IsBoat") then
            local HitboxLimbs = {"RightLowerArm", "RightUpperArm", "LeftLowerArm", "LeftUpperArm", "RightHand", "LeftHand"}
            local head = enemy:FindFirstChild(HitboxLimbs[math.random(#HitboxLimbs)]) or enemy.PrimaryPart
            if head then
                table.insert(targets, { enemy, head })
                mainTarget = head
            end
        end
    end
    if not mainTarget then return end
    attackEvent:FireServer(0)
    local playerScripts = player:FindFirstChild("PlayerScripts")
    if not playerScripts then return end
    local localScript = playerScripts:FindFirstChildOfClass("LocalScript")
    while not localScript do
        playerScripts.ChildAdded:Wait()
        localScript = playerScripts:FindFirstChildOfClass("LocalScript")
    end
    local hitFunction
    if getsenv then
        local success, scriptEnv = pcall(getsenv, localScript)
        if success and scriptEnv then
            hitFunction = scriptEnv._G.SendHitsToServer
        end
    end
    local successFlags, combatRemoteThread = pcall(function()
        return require(modules.Flags).COMBAT_REMOTE_THREAD or false
    end)
    if successFlags and combatRemoteThread and hitFunction then
        hitFunction(mainTarget, targets)
    elseif successFlags and not combatRemoteThread then
        hitEvent:FireServer(mainTarget, targets)
    end
end

CameraShakerR = require(game.ReplicatedStorage.Util.CameraShaker)
CameraShakerR:Stop()

get_Monster = function()
    for a,b in pairs(workspace.Enemies:GetChildren()) do 
        local c = b:FindFirstChild("UpperTorso") or b:FindFirstChild("Head")
        if b:FindFirstChild("HumanoidRootPart", true) and c then 
            if (b.Head.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 50 then 
                return true, c.Position 
            end 
        end 
    end
    for a,d in pairs(workspace.SeaBeasts:GetChildren()) do 
        if d:FindFirstChild("HumanoidRootPart") and d:FindFirstChild("Health") and d.Health.Value > 0 then 
            return true, d.HumanoidRootPart.Position 
        end 
    end
    for a,d in pairs(workspace.Enemies:GetChildren()) do 
        if d:FindFirstChild("Health") and d.Health.Value > 0 and d:FindFirstChild("VehicleSeat") then 
            return true, d.Engine.Position 
        end 
    end
end

Actived = function()
    local a = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
    for b,c in next, getconnections(a.Activated) do
        if typeof(c.Function) == 'function' then
            getupvalues(c.Function)
        end
    end
end

task.spawn(function()
    RunSer.Heartbeat:Connect(function()
        pcall(function()      
            if not _G.Seriality then return end      
            AttackNoCoolDown() 
            local Pretool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
            local ToolTip = Pretool.ToolTip
            local MobAura, Mon = get_Monster()      
            if ToolTip == "Blox Fruit" then
                if MobAura then           
                    local LeftClickRemote = Pretool:FindFirstChild('LeftClickRemote')
                    if LeftClickRemote then 
                        Actived() 
                        LeftClickRemote:FireServer(Vector3.new(0.01,-500,0.01),1,true)
                        LeftClickRemote:FireServer(false)
                    end
                end     
            end      
        end)
    end)
end)

-- =================== KẾT THÚC ===================
print("Tay Hub đã tải thành công!")