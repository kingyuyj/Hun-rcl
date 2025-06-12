
--[[
██████╗░░█████╗░██╗░░░░░  ██╗██╗░░░░░██╗░░██╗
██╔══██╗██╔══██╗██║░░░░░  ██║██║░░░░░██║░██╔╝
██████╔╝███████║██║░░░░░  ██║██║░░░░░█████═╝░
██╔═══╝░██╔══██║██║░░░░░  ██║██║░░░░░██╔═██╗░
██║░░░░░██║░░██║███████╗  ██║███████╗██║░╚██╗
╚═╝░░░░░╚═╝░░╚═╝╚══════╝  ╚═╝╚══════╝╚═╝░░╚═╝

👑 Rcl Hub | Orion UI Version | Full Features Script for Blox Fruits
--]]

-- Load Orion UI
-- Removed duplicate OrionLib

-- Initialize UI
-- Removed duplicate Window

-- Functions
local function AutoFarm() -- AutoFarm Full Logic
    -- Placeholder for full Auto Farm logic
end

local function AutoBoss() -- Auto Boss Logic
    -- Placeholder for boss detection and auto kill
end

local function AutoRaids() -- Auto Raids
    -- Placeholder for auto raid system
end

local function FruitESP() -- Fruit ESP
    -- Placeholder for showing fruits on map
end

local function FPSBoost() -- FPS Boost
    -- Placeholder for performance optimization
end

local function ServerHop() -- Server Hopping
    -- Placeholder for hopping logic
end

-- Tabs
local HomeTab = Window:MakeTab({Name = "🏠 Home", Icon = "rbxassetid://7734053495", PremiumOnly = false})
HomeTab:AddParagraph("Welcome to Rcl Hub!", "Best Orion-based Blox Fruits Script.
Join our Discord for support.")

local FarmTab = Window:MakeTab({Name = "⚔️ Auto Farm", Icon = "rbxassetid://7733960981", PremiumOnly = false})
FarmTab:AddToggle({Name = "Enable Auto Farm", Default = false, Callback = AutoFarm})

local BossTab = Window:MakeTab({Name = "👹 Boss Farm", Icon = "rbxassetid://7734053495", PremiumOnly = false})
BossTab:AddToggle({Name = "Enable Auto Boss", Default = false, Callback = AutoBoss})

local RaidsTab = Window:MakeTab({Name = "🌋 Raids", Icon = "rbxassetid://7734053495", PremiumOnly = false})
RaidsTab:AddToggle({Name = "Enable Auto Raids", Default = false, Callback = AutoRaids})

local ESPTab = Window:MakeTab({Name = "🍇 Fruit ESP", Icon = "rbxassetid://7734053495", PremiumOnly = false})
ESPTab:AddToggle({Name = "Enable Fruit ESP", Default = false, Callback = FruitESP})

local UtilityTab = Window:MakeTab({Name = "⚙️ Utilities", Icon = "rbxassetid://7734053495", PremiumOnly = false})
UtilityTab:AddButton({Name = "FPS Boost", Callback = FPSBoost})
UtilityTab:AddButton({Name = "Server Hop", Callback = ServerHop})

-- Init UI
OrionLib:Init()


-- [Auto Farm Code Start]

-- Auto Farm Logic (Complete)

local autofarming = false
local selectedWeapon = "Melee" -- default weapon type, can be changed from UI
local autoIsland = true -- auto detect island

local function getCurrentLevel()
    return game.Players.LocalPlayer.Data.Level.Value
end

local function getWeapon()
    for _,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v:IsA("Tool") and v.ToolTip == selectedWeapon then
            return v
        end
    end
    return nil
end

local function getNearestEnemy()
    local enemies = workspace.Enemies:GetChildren()
    local closest, distance = nil, math.huge
    for _, enemy in pairs(enemies) do
        if enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
            local dist = (enemy.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if dist < distance then
                closest = enemy
                distance = dist
            end
        end
    end
    return closest
end

local function equipWeapon()
    local tool = getWeapon()
    if tool then
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
    end
end

local function farmLoop()
    while autofarming do
        pcall(function()
            equipWeapon()
            local target = getNearestEnemy()
            if target and target:FindFirstChild("HumanoidRootPart") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0)
                if getWeapon() then
                    getWeapon():Activate()
                end
            end
        end)
        task.wait(0.1)
    end
end

function AutoFarm(state)
    autofarming = state
    if state then
        farmLoop()
    end
end

-- [Auto Farm Code End]


-- [Auto Boss Code Start]

-- Auto Boss Logic (Complete)

local autoboss = false

local bossNames = {
    "Mob Leader", "Vice Admiral", "Warden", "Swan", "Magma Admiral", "Fishman Lord",
    "Wysper", "Thunder God", "Ice Admiral", "Smoke Admiral", "Flamingo", "Fajita", "Don Swan"
}

local function findBoss()
    for _,v in pairs(workspace.Enemies:GetChildren()) do
        if table.find(bossNames, v.Name) and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
            return v
        end
    end
    return nil
end

local function killBossLoop()
    while autoboss do
        pcall(function()
            local boss = findBoss()
            if boss then
                equipWeapon()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0)
                if getWeapon() then
                    getWeapon():Activate()
                end
            end
        end)
        task.wait(0.1)
    end
end

function AutoBoss(state)
    autoboss = state
    if state then
        killBossLoop()
    end
end

-- [Auto Boss Code End]


-- [Auto Raids Code Start]

-- Auto Raids Logic (Complete)

local autoraid = false
local raidType = "Flame" -- default, can be changed later

local function teleportToNPC(name)
    for _,v in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
        if v.Name == name and v:FindFirstChild("HumanoidRootPart") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
            break
        end
    end
end

local function startRaid()
    local args = {
        [1] = "RaidsNpc",
        [2] = "Select",
        [3] = raidType
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end

local function enterRaid()
    local args = {
        [1] = "RaidsNpc",
        [2] = "Start"
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end

local function attackRaidEnemies()
    for _, enemy in pairs(workspace.Enemies:GetChildren()) do
        if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 and enemy:FindFirstChild("HumanoidRootPart") then
            equipWeapon()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0)
            if getWeapon() then
                getWeapon():Activate()
            end
            task.wait(0.1)
        end
    end
end

local function raidLoop()
    while autoraid do
        pcall(function()
            teleportToNPC("Raid Entrance")
            startRaid()
            task.wait(1)
            enterRaid()
            task.wait(5)
            attackRaidEnemies()
        end)
        task.wait(3)
    end
end

function AutoRaids(state)
    autoraid = state
    if state then
        raidLoop()
    end
end

-- [Auto Raids Code End]


-- [Fruit ESP Code Start]

-- Fruit ESP + Auto Store

local fruitesp = false
local autostorefruit = true

local function highlightFruit(fruit)
    local esp = Instance.new("BillboardGui")
    esp.Name = "FruitESP"
    esp.Adornee = fruit
    esp.Size = UDim2.new(0, 100, 0, 40)
    esp.StudsOffset = Vector3.new(0, 2, 0)
    esp.AlwaysOnTop = true

    local text = Instance.new("TextLabel", esp)
    text.Size = UDim2.new(1, 0, 1, 0)
    text.Text = fruit.Name
    text.BackgroundTransparency = 1
    text.TextColor3 = Color3.fromRGB(255, 255, 0)
    text.TextStrokeTransparency = 0
    text.Font = Enum.Font.GothamBold
    text.TextScaled = true

    esp.Parent = fruit
end

local function storeFruit(fruit)
    local args = {
        [1] = "StoreFruit",
        [2] = fruit.Name
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end

local function fruitESP_Loop()
    while fruitesp do
        pcall(function()
            for _,v in pairs(workspace:GetChildren()) do
                if string.find(v.Name:lower(), "fruit") and not v:FindFirstChild("FruitESP") then
                    highlightFruit(v)
                    if autostorefruit then
                        storeFruit(v)
                    end
                end
            end
        end)
        task.wait(5)
    end
end

function FruitESP(state)
    fruitesp = state
    if state then
        fruitESP_Loop()
    end
end

-- [Fruit ESP Code End]


-- [FPS Boost Code Start]

-- FPS Boost

function FPSBoost()
    for _, obj in pairs(game:GetDescendants()) do
        if obj:IsA("Part") or obj:IsA("MeshPart") then
            obj.Material = Enum.Material.SmoothPlastic
            obj.Reflectance = 0
        elseif obj:IsA("Decal") or obj:IsA("Texture") then
            obj:Destroy()
        end
    end

    for _, effect in pairs(workspace:GetDescendants()) do
        if effect:IsA("ParticleEmitter") or effect:IsA("Trail") or effect:IsA("Smoke") or effect:IsA("Fire") or effect:IsA("Explosion") then
            effect:Destroy()
        end
    end

    sethiddenproperty(game.Lighting, "Technology", Enum.Technology.Compatibility)
    game.Lighting.GlobalShadows = false
    game.Lighting.FogEnd = 9e9
    game.Lighting.Brightness = 1
    game.Lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)

    if settings().Rendering then
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    end
end

-- [FPS Boost Code End]


-- [Server Hop Code Start]

-- Server Hop (Public & Private Codes)

local HttpService = game:GetService("HttpService")
local TPService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

function ServerHop()
    local servers = {}
    local req = syn and syn.request or http_request or request
    local gameId = tostring(game.PlaceId)
    local api = "https://games.roblox.com/v1/games/" .. gameId .. "/servers/Public?sortOrder=Asc&limit=100"

    local body = req({Url = api}).Body
    local data = HttpService:JSONDecode(body)

    for _,v in pairs(data.data) do
        if type(v) == "table" and v.playing < v.maxPlayers and v.id ~= game.JobId then
            table.insert(servers, v.id)
        end
    end

    if #servers > 0 then
        TPService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], player)
    end
end

function PrivateServerHop(code)
    if code and code ~= "" then
        TPService:TeleportToPrivateServer(game.PlaceId, code, {player})
    end
end

-- [Server Hop Code End]


-- [Orion UI GUI Code Start]

-- Orion UI Interface Setup with Kill Aura and Weapon Selection

-- Removed duplicate OrionLib
-- Removed duplicate Window

local weaponSelected = ""
local killaura = false

-- Tabs
local FarmTab = Window:MakeTab({Name = "Auto Farm", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local BossTab = Window:MakeTab({Name = "Boss & Raids", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local UtilityTab = Window:MakeTab({Name = "Utilities", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local SettingsTab = Window:MakeTab({Name = "Settings", Icon = "rbxassetid://4483345998", PremiumOnly = false})

-- Kill Aura
FarmTab:AddToggle({
    Name = "Kill Aura",
    Default = false,
    Callback = function(Value)
        killaura = Value
    end
})

-- Weapon Selection
local weapons = {}
for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
    if v:IsA("Tool") then
        table.insert(weapons, v.Name)
    end
end

FarmTab:AddDropdown({
    Name = "Select Weapon",
    Default = "",
    Options = weapons,
    Callback = function(Value)
        weaponSelected = Value
    end    
})

-- Functions for weapon & attack
function getWeapon()
    for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v:IsA("Tool") and v.Name == weaponSelected then
            return v
        end
    end
    return nil
end

function equipWeapon()
    local tool = getWeapon()
    if tool then
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
    end
end

-- Kill Aura Loop
task.spawn(function()
    while true do
        if killaura then
            pcall(function()
                for _,enemy in pairs(workspace.Enemies:GetChildren()) do
                    if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                        equipWeapon()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0)
                        getWeapon():Activate()
                        task.wait(0.1)
                    end
                end
            end)
        end
        task.wait(0.5)
    end
end)

-- [Orion UI GUI Code End]


-- [Orion UI Code Start]

-- Orion UI Setup

local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Window = OrionLib:MakeWindow({Name = "Rcl Hub | Blox Fruits", HidePremium = false, SaveConfig = true, ConfigFolder = "RclHub"})

-- Tabs
local MainTab = Window:MakeTab({Name = "Main", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local TeleportTab = Window:MakeTab({Name = "Teleport", Icon = "rbxassetid://6035192847", PremiumOnly = false})
local MiscTab = Window:MakeTab({Name = "Misc", Icon = "rbxassetid://6034509993", PremiumOnly = false})

-- Kill Aura Toggle
MainTab:AddToggle({
	Name = "Kill Aura",
	Default = false,
	Callback = function(Value)
        getgenv().killaura = Value
        spawn(function()
            while getgenv().killaura do
                pcall(function()
                    for _,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            equipWeapon()
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,20,0)
                            if getWeapon() then
                                getWeapon():Activate()
                            end
                        end
                    end
                end)
                task.wait(0.1)
            end
        end)
	end    
})

-- Weapon Picker
MainTab:AddDropdown({
	Name = "Select Weapon",
	Default = "Melee",
	Options = {"Melee", "Sword", "Gun"},
	Callback = function(Value)
		getgenv().selectedWeapon = Value
	end    
})

-- FPS Boost Button
MiscTab:AddButton({
	Name = "Apply FPS Boost",
	Callback = function()
        FPSBoost()
  	end    
})

-- Server Hop Button
MiscTab:AddButton({
	Name = "Server Hop",
	Callback = function()
        ServerHop()
  	end    
})

-- Private Server Hop Input
MiscTab:AddTextbox({
	Name = "Join Private Server Code",
	Default = "",
	TextDisappear = true,
	Callback = function(Value)
        PrivateServerHop(Value)
	end	  
})

-- Auto Boss Toggle
MainTab:AddToggle({
	Name = "Auto Boss",
	Default = false,
	Callback = function(Value)
        AutoBoss(Value)
	end    
})

-- Auto Raids Toggle
MainTab:AddToggle({
	Name = "Auto Raids",
	Default = false,
	Callback = function(Value)
        AutoRaids(Value)
	end    
})

-- Fruit ESP Toggle
MainTab:AddToggle({
	Name = "Fruit ESP + Auto Store",
	Default = false,
	Callback = function(Value)
        FruitESP(Value)
	end    
})

-- Load UI
OrionLib:Init()

-- [Orion UI Code End]


-- [Teleport by Sea System Start]

-- Teleport System by Sea

local islandLocations = {
    ["First Sea"] = {
        ["Starter Island"] = CFrame.new(1021, 17, 1432),
        ["Jungle"] = CFrame.new(-1249, 11, 340),
        ["Pirate Village"] = CFrame.new(-1120, 5, 3894),
        ["Desert"] = CFrame.new(1156, 6, 4350),
        ["Snow Island"] = CFrame.new(1346, 87, -1326),
        ["Marine Fortress"] = CFrame.new(-4505, 424, 4268),
        ["Sky Island"] = CFrame.new(-4949, 717, -2622),
        ["Prison"] = CFrame.new(4873, 5, 738),
        ["Magma Village"] = CFrame.new(-5478, 15, 8466),
        ["Underwater City"] = CFrame.new(61163, 38, 1547),
        ["Fountain City"] = CFrame.new(5139, 4, 4037)
    },
    ["Second Sea"] = {
        ["Kingdom of Rose"] = CFrame.new(-394, 358, 1153),
        ["Green Zone"] = CFrame.new(-2317, 72, -721),
        ["Graveyard"] = CFrame.new(-5375, 8, -472),
        ["Dark Arena"] = CFrame.new(4776, 5, -1986),
        ["Snow Mountain"] = CFrame.new(1408, 449, -2687),
        ["Hot and Cold"] = CFrame.new(-5998, 16, -5046),
        ["Cursed Ship"] = CFrame.new(923, 124, 32888),
        ["Ice Castle"] = CFrame.new(5409, 40, -6236),
        ["Forgotten Island"] = CFrame.new(-3052, 238, -10192)
    },
    ["Third Sea"] = {
        ["Port Town"] = CFrame.new(-285, 44, 5454),
        ["Hydra Island"] = CFrame.new(5228, 604, 345),
        ["Great Tree"] = CFrame.new(2282, 25, -6454),
        ["Castle on the Sea"] = CFrame.new(-5499, 313, -3013),
        ["Haunted Castle"] = CFrame.new(-9515, 142, 5814),
        ["Sea of Treats"] = CFrame.new(-11368, 342, -8716),
        ["Tiki Outpost"] = CFrame.new(-16679, 381, -176)
    }
}

function TeleportToIsland(sea, islandName)
    if islandLocations[sea] and islandLocations[sea][islandName] then
        game.Players.LocalPlayer.Character:PivotTo(islandLocations[sea][islandName])
    end
end

-- Example UI integration for teleport (you can place in TeleportTab)
-- Adds dropdowns to TeleportTab to select sea and island

local selectedSea = "First Sea"
local selectedIsland = "Starter Island"

TeleportTab:AddDropdown({
	Name = "Select Sea",
	Default = "First Sea",
	Options = {"First Sea", "Second Sea", "Third Sea"},
	Callback = function(Value)
		selectedSea = Value
	end
})

TeleportTab:AddDropdown({
	Name = "Select Island",
	Default = "Starter Island",
	Options = (function()
        local list = {}
        for island in pairs(islandLocations["First Sea"]) do
            table.insert(list, island)
        end
        return list
    end)(),
	Callback = function(Value)
		selectedIsland = Value
	end
})

TeleportTab:AddButton({
	Name = "Teleport to Island",
	Callback = function()
        TeleportToIsland(selectedSea, selectedIsland)
	end
})

-- [Teleport by Sea System End]


-- [Discord Webhook Alert System Start]

-- Discord Webhook Alert System

local HttpService = game:GetService("HttpService")

getgenv().WebhookURL = "" -- ضع رابط الويب هوك هنا

function sendWebhook(message)
    if getgenv().WebhookURL and getgenv().WebhookURL ~= "" then
        local data = {
            ["content"] = message
        }
        local headers = {
            ["Content-Type"] = "application/json"
        }

        local body = HttpService:JSONEncode(data)
        local request = http_request or request or syn.request
        if request then
            request({
                Url = getgenv().WebhookURL,
                Method = "POST",
                Headers = headers,
                Body = body
            })
        end
    end
end

-- تنبيه عند ظهور فاكهة
function WatchForFruits()
    spawn(function()
        while true do
            for _,v in pairs(game.Workspace:GetDescendants()) do
                if v:IsA("Tool") and string.find(v.Name:lower(), "fruit") then
                    sendWebhook("🍍 **فاكهة ظهرت**: `" .. v.Name .. "` | مكانها: " .. tostring(v.Parent))
                end
            end
            task.wait(10)
        end
    end)
end

-- تنبيه عند ظهور بوس
function WatchForBosses()
    local enemies = game:GetService("Workspace"):WaitForChild("Enemies")
    spawn(function()
        while true do
            for _,v in pairs(enemies:GetChildren()) do
                if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and string.find(v.Name:lower(), "boss") then
                    sendWebhook("👹 **بوس ظهر**: `" .. v.Name .. "` | HP: " .. math.floor(v.Humanoid.Health))
                end
            end
            task.wait(10)
        end
    end)
end

-- إدخال رابط الويب هوك من الواجهة
MiscTab:AddTextbox({
	Name = "Discord Webhook URL",
	Default = "",
	TextDisappear = false,
	Callback = function(Value)
		getgenv().WebhookURL = Value
        sendWebhook("✅ تم ربط Rcl Hub بنجاح! سيتم إرسال التنبيهات هنا.")
	end
})

-- زر تفعيل تنبيهات
MiscTab:AddButton({
	Name = "تفعيل تنبيهات الفواكه والبوس",
	Callback = function()
        WatchForFruits()
        WatchForBosses()
	end
})

-- [Discord Webhook Alert System End]


-- [Final Utility Features Start]

-- Anti-AFK System
local VirtualUser = game:service("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

-- Auto Haki Activation
function AutoHaki()
    spawn(function()
        while task.wait(1) do
            pcall(function()
                if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
                end
            end)
        end
    end)
end

-- Auto Ken (Observation Haki)
function AutoKen()
    spawn(function()
        while task.wait(1) do
            pcall(function()
                if game.Players.LocalPlayer.PlayerGui:FindFirstChild("ScreenGui") and not game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("Ken") then
                    keypress(0x4A) -- J key for Ken Haki (Observation)
                    task.wait(0.5)
                    keyrelease(0x4A)
                end
            end)
        end
    end)
end

-- Auto Fruit Sniper (collects visible fruits automatically)
function AutoFruitSniper()
    spawn(function()
        while true do
            for _,v in pairs(game.Workspace:GetDescendants()) do
                if v:IsA("Tool") and string.find(v.Name:lower(), "fruit") then
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Handle, 0)
                    task.wait(0.2)
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Handle, 1)
                end
            end
            task.wait(5)
        end
    end)
end

-- UI Toggles
MiscTab:AddToggle({
	Name = "Auto Haki",
	Default = false,
	Callback = function(Value)
        if Value then AutoHaki() end
	end    
})

MiscTab:AddToggle({
	Name = "Auto Ken (Observation)",
	Default = false,
	Callback = function(Value)
        if Value then AutoKen() end
	end    
})

MiscTab:AddToggle({
	Name = "Auto Fruit Sniper",
	Default = false,
	Callback = function(Value)
        if Value then AutoFruitSniper() end
	end    
})

-- [Final Utility Features End]


-- [Redz-Style Home UI Start]

-- Redz-style Home UI
local HomeTab = Window:MakeTab({
	Name = "🏠 Home",
	Icon = "rbxassetid://7733675069",
	PremiumOnly = false
})

HomeTab:AddParagraph("Rcl Hub", "سكربت احترافي مستوحى من Redz و WooHo بواجهة Orion UI")

HomeTab:AddLabel("🛠️ المميزات الرئيسية:")
HomeTab:AddLabel("⚔️ Auto Farm + Kill Aura")
HomeTab:AddLabel("👹 Auto Boss + Auto Raids")
HomeTab:AddLabel("🌍 Teleport للجزر حسب البحر")
HomeTab:AddLabel("🍍 Fruit ESP + Sniper + Store")
HomeTab:AddLabel("📬 Discord Webhook للتنبيهات")
HomeTab:AddLabel("🧠 Auto Haki + Ken + Anti-AFK")
HomeTab:AddLabel("🚀 FPS Boost + Server Hop + Private Join")

HomeTab:AddParagraph("🎮 تم تطوير السكربت بواسطة Rcl Team", "انضم إلى ديسكوردنا لمزيد من الأدوات والتحديثات")
HomeTab:AddButton({
	Name = "📂 نسخ رابط سكربت Rcl Hub",
	Callback = function()
        setclipboard("https://rclhub.xyz") -- رابط تخيلي لسكربت/موقعك
	end
})

-- [Redz-Style Home UI End]


-- [UI Enhancements: Logo + Themes Start]

-- شعار داخل الواجهة باستخدام صورة
HomeTab:AddParagraph("🌟 Rcl Hub", "أفضل سكربت مستوحى من Redz/WooHo")
HomeTab:AddLabel(" ")

HomeTab:AddLabel("🖼️ شعار Rcl Hub:")
HomeTab:AddLabel(" ")
HomeTab:AddLabel("📷 https://i.imgur.com/UO6C2nX.png") -- رابط صورة تخيلي يمكنك تغييره

-- ثيمات جاهزة لتغيير ألوان Orion UI
local Themes = {
    ["Default"] = {
        SchemeColor = Color3.fromRGB(0, 150, 255),
        Background = Color3.fromRGB(24, 24, 24),
        Header = Color3.fromRGB(20, 20, 20),
        TextColor = Color3.fromRGB(255, 255, 255),
        ElementColor = Color3.fromRGB(32, 32, 32)
    },
    ["Redz Style"] = {
        SchemeColor = Color3.fromRGB(255, 50, 50),
        Background = Color3.fromRGB(30, 30, 30),
        Header = Color3.fromRGB(25, 25, 25),
        TextColor = Color3.fromRGB(255, 255, 255),
        ElementColor = Color3.fromRGB(40, 40, 40)
    },
    ["Dark Purple"] = {
        SchemeColor = Color3.fromRGB(170, 0, 255),
        Background = Color3.fromRGB(20, 0, 30),
        Header = Color3.fromRGB(25, 0, 30),
        TextColor = Color3.fromRGB(255, 255, 255),
        ElementColor = Color3.fromRGB(50, 0, 60)
    }
}

HomeTab:AddDropdown({
	Name = "🎨 اختر ثيم",
	Default = "Default",
	Options = {"Default", "Redz Style", "Dark Purple"},
	Callback = function(Value)
        OrionLib:SetTheme(Themes[Value])
	end
})

-- [UI Enhancements: Logo + Themes End]

