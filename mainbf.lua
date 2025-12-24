repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer
_G.NoClip = true
--coder
if game.PlaceId == 2753915549 or game.PlaceId == 85211729168715 then
  FirstSea = true
elseif game.PlaceId == 4442272183  or game.PlaceId == 79091703265657 then
  SecondSea = true
elseif game.PlaceId == 7449423635 or game.PlaceId == 100117331123089 then
  ThirdSea = true
end

task.spawn(function()
  pcall(function()
    while task.wait() do
      if _G.NoClip then
        for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
          if v:IsA("BasePart") or v:IsA("Part") then
            v.CanCollide = false
          end
        end
      end
    end
  end)
end)

function TP(Pos)
  task.spawn(function()
    pcall(function()
      local player = game.Players.LocalPlayer
      local char = player.Character
      if not char then return end
      local hum = char:FindFirstChildOfClass("Humanoid")
      local hrp = char:FindFirstChild("HumanoidRootPart")
      if not hum or not hrp then return end
      if hum.Sit then hum.Sit = false end
      if not char:FindFirstChild("Root") then
        local root = Instance.new("Part")
        root.Size = Vector3.new(1, 1, 1)
        root.Name = "Root"
        root.Transparency = 1
        root.CanCollide = false
        root.Anchored = true
        root.CFrame = hrp.CFrame
        root.Parent = char
      end
      local root = char.Root
      local TweenService = game:GetService("TweenService")
      local dist = (hrp.Position - Pos.Position).Magnitude
      local tweenInfo = TweenInfo.new(dist / 375, Enum.EasingStyle.Linear)
      local tween = TweenService:Create(root, tweenInfo, { CFrame = Pos })
      tween:Play()
      tween.Completed:Wait()
    end)
  end)
end

task.spawn(function()
    while task.wait() do
        pcall(function()
          local char = game:GetService("Players").LocalPlayer.Character
          if not char then return end
          local hrp = char:FindFirstChild("HumanoidRootPart")
            local root = char:FindFirstChild("Root")
            if hrp and root then
              hrp.CFrame = root.CFrame
            end
        end)
    end
end)

function Fly()
  local BodyVelocityClip = game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyAntiVelocityClip") or Instance.new("BodyVelocity", game.Players.LocalPlayer.Character.HumanoidRootPart)
BodyVelocityClip.Name = "BodyAntiVelocityClip"
BodyVelocityClip.MaxForce = Vector3.new(0, math.huge, 0)
BodyVelocityClip.Velocity = Vector3.new(0, 0, 0)
end

function QuestLevel()
  local MyLevel = game:GetService("Players").LocalPlayer.Data.Level.Value
  if FirstSea then
    if MyLevel == 1 and MyLevel < 10 then
      Mon = "Badit"
      LevelQuest = 1
      NameQuest = "BanditQuest1"
      NameMon = "Bandit"
      CFrameQuest = CFrame.new(1058.99231, 16.1369934, 1551.73328, 0.956294656, 0, -0.292404652, 0, 1, 0, 0.292404652, 0, 0.956294656)
      CFrameMon = CFrame.new(1123.51794, 16.6809998, 1665.08899, 0.258864343, -0, -0.965913713, 0, 1, -0, 0.965913713, 0, 0.258864343)
    elseif MyLevel >= 10 and MyLevel < 15 then
      Mon = "Monkey"
      LevelQuest = 1
      NameQuest = "JungleQuest"
      NameMon = "Monkey"
      CFrameQuest = CFrame.new(-1598.08899, 35.5500031, 153.378006, -0.651786327, 0, 0.758402646, 0, 1, 0, -0.758402646, 0, -0.651786327)
      CFrameMon = CFrame.new(-1292.67004, 10.8999939, -4.8500061, -0.707134247, 0, -0.707079291, 0, 1, 0, 0.707079291, 0, -0.707134247)
    elseif MyLevel >= 15 and MyLevel < 30 then
      Mon = "Gorilla"
      LevelQuest = 2
      NameQuest = "JungleQuest"
      NameMon = "Gorilla"
      CFrameQuest = CFrame.new(-1598.08899, 35.5500031, 153.378006, -0.651786327, 0, 0.758402646, 0, 1, 0, -0.758402646, 0, -0.651786327)
      CFrameMon = CFrame.new(-1186.61902, 11.0670013, -650.275024, -0.939700961, 0, 0.341998369, 0, 1, 0, -0.341998369, 0, -0.939700961)
    elseif MyLevel >= 30 and MyLevel < 40 then
      Mon = "Pirate"
      LevelQuest = 1
      NameQuest = "BuggyQuest1"
      NameMon = "Pirate"
      CFrameQuest = CFrame.new(-1141.07495, 4.1000061, 3831.55005, 0.965929627, 0, -0.258804798, 0, 1, 0, 0.258804798, 0, 0.965929627)
      CFrameMon = CFrame.new(-972.432983, 13.6000061, 3939.24707, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
    elseif MyLevel >= 40 and MyLevel < 60 then
      Mon = "Brute"
      LevelQuest = 2
      NameQuest = "BuggyQuest1"
      NameMon = "Brute"
      CFrameQuest = CFrame.new(-1141.07495, 4.1000061, 3831.55005, 0.940088987, -0, -0.34092921, 0, 1, -0, 0.34092921, 0, 0.940088987)
      CFrameMon = CFrame.new(-1048.64294, 15.6000061, 4405.35889, 0.999391913, -0, -0.0348687991, 0, 1, -0, 0.0348687991, 0, 0.999391913)
    elseif MyLevel >= 60 and MyLevel < 75 then
      Mon = "Desert Bandit"
      LevelQuest = 1
      NameQuest = "DesertQuest"
      NameMon = "Desert Bandit"
      CFrameQuest = CFrame.new(894.489014, 5.13999939, 4392.43408, -0.742045283, 0, 0.670349777, 0, 1, 0, -0.670349777, 0, -0.742045283)
      CFrameMon = CFrame.new(931.705017, 7.56500244, 4534.0332, 1, 0, 0, 0, 1, 0, 0, 0, 1)
    elseif MyLevel >= 75 and MyLevel < 90 then
      Mon = "Desert Officer"
      LevelQuest = 2
      NameQuest = "DesertQuest"
      NameMon = "Desert Officer"
      CFrameQuest = CFrame.new(894.489014, 5.13999939, 4392.43408, -0.742045283, 0, 0.670349777, 0, 1, 0, -0.670349777, 0, -0.742045283)
      CFrameMon = CFrame.new(1611.271, 1.31500244, 4465.52979, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
    elseif MyLevel >= 90 and MyLevel < 100 then
      Mon = "Snow Bandit"
      LevelQuest = 1
      NameQuest = "SnowQuest"
      NameMon = "Snow Bandit"
      CFrameQuest = CFrame.new(1387.1886, 86.6210175, -1295.04456, 0.762997091, 0, 0.646402001, 0, 1, 0, -0.646402001, 0, 0.762997091)
      CFrameMon = CFrame.new(1381.32495, 88.7900085, -1464.94299, -0.965929747, 0, 0.258804798, 0, 1, 0, -0.258804798, 0, -0.965929747)
    elseif MyLevel >= 100 and MyLevel < 120 then
      Mon = "Snowman"
      LevelQuest = 2
      NameQuest = "SnowQuest"
      NameMon = "Snowman"
      CFrameQuest = CFrame.new(1387.1886, 86.6210175, -1295.04456, 0.762997091, 0, 0.646402001, 0, 1, 0, -0.646402001, 0, 0.762997091)
      CFrameMon = CFrame.new(1265.48901, 106.809998, -1483.42004, 0, 0, 1, 0, 1, -0, -1, 0, 0)
    elseif MyLevel >= 120 and MyLevel < 150 then
      Mon = "Chief Petty Officer"
      LevelQuest = 1
      NameQuest = "MarineQuest2"
      NameMon = "Chief Petty Officer"
      CFrameQuest = CFrame.new(-5039.58594, 27.3500061, 4324.68018, 0.0909124017, -0, -0.995858967, 0, 1, -0, 0.995858967, 0, 0.0909124017)
      CFrameMon = CFrame.new(-4633.92188, 20.5, 4551.83301, -0.0175019503, 0, 0.999846935, 0, 1, 0, -0.999846935, 0, -0.0175019503)
    elseif MyLevel >= 150 and MyLevel < 175 then
      Mon = "Sky Bandit"
      LevelQuest = 1
      NameQuest = "SkyQuest"
      NameMon = "Sky Bandit"
      CFrameQuest = CFrame.new(-4839.52979, 716.369019, -2619.44189, 0.690136135, 0, 0.723679662, 0, 1, 0, -0.723679662, 0, 0.690136135)
      CFrameMon = CFrame.new(-5119.646, 274.915009, -2809.84106, 0.224959731, -0, -0.974368095, 0, 1, -0, 0.974368095, 0, 0.224959731)
    elseif MyLevel >= 175 and MyLevel < 190 then
      Mon = "Dark Master"
      LevelQuest = 2
      NameQuest = "SkyQuest"
      NameMon = "Dark Master"
      CFrameQuest = CFrame.new(-4839.52979, 716.369019, -2619.44189, 0.690136135, 0, 0.723679662, 0, 1, 0, -0.723679662, 0, 0.690136135)
      CFrameMon = CFrame.new(-5339.18018, 389.5, -2258.01392, 0.642763317, -0, -0.766064942, 0, 1, -0, 0.766064942, 0, 0.642763317)
    elseif MyLevel >= 190 and MyLevel < 210 then
      Mon = "Prisoner"
      LevelQuest = 1
      NameQuest = "PrisonerQuest"
      NameMon = "Prisoner"
      CFrameQuest = CFrame.new(5310.60498, 0.350006104, 474.946991, 0.95864892, 0, 0.284591347, 0, 1, 0, -0.284591347, 0, 0.95864892)
      CFrameMon = CFrame.new(5089.77881, -0.300003052, 423.665009, -0.857151866, 0, -0.515064001, 0, 1, 0, 0.515064001, 0, -0.857151866)
    elseif MyLevel >= 210 and MyLevel < 250 then 
      Mon = "Dangerous Prisoner"
      LevelQuest = 2
      NameQuest = "PrisonerQuest"
      NameMon = "Dangerous Prisoner"
      CFrameQuest = CFrame.new(5310.60498, 0.350006104, 474.946991, 0.95864892, 0, 0.284591347, 0, 1, 0, -0.284591347, 0, 0.95864892)
      CFrameMon = CFrame.new(5561.36621, -0.5, 964.742981, 0.29242152, 0, 0.95628953, 0, 1, 0, -0.95628953, 0, 0.29242152)
    end
  end
end


function AutoHaki()
  if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("HasBuso") then
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
  end
end

local function GetEnemiesInRange(character, range)
    local list = {}
    local Enemies = game:GetService("Workspace"):FindFirstChild("Enemies") or game:GetService("Workspace"):WaitForChild("Enemies")
    if not character then return list end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return list end
    for _, mob in ipairs(Enemies:GetChildren()) do
        local mhrp = mob:FindFirstChild("HumanoidRootPart")
        local mhum = mob:FindFirstChildOfClass("Humanoid")
        if mhrp and mhum and mhum.Health > 0 then
            if (mhrp.Position - hrp.Position).Magnitude <= range then
                table.insert(list, mob)
            end
        end
    end
    return list
end

function AttackNoCoolDown()
    local char = game:GetService("Players").LocalPlayer.Character
  if not char then return end
    local tool = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool")
    for _, it in ipairs(char:GetChildren()) do
        if it:IsA("Tool") then
            tool = it 
            break 
        end
    end
    if not tool then return end
    local targets = GetEnemiesInRange(char, 120)
    if #targets == 0 then return end
    if tool:FindFirstChild("LeftClickRemote") then
        local n = 1
        for _, mob in ipairs(targets) do
            local root = mob:FindFirstChild("HumanoidRootPart")
            if root then
                local dir = (root.Position - char:GetPivot().Position).Unit
                pcall(function()
                    tool.LeftClickRemote:FireServer(dir, n) 
                end)
                n += 1
                task.wait(0.03)
            end
        end
    else
        local mainHead, hitTable
        hitTable = {}
        for _, mob in ipairs(targets) do
            if not mob:GetAttribute("IsBoat") then
                local head = mob:FindFirstChild("Head")
                if head then 
                    table.insert(hitTable, {mob, head})
                    mainHead = mainHead or head 
                end
            end
        end
        if mainHead then
            local ok, Net = pcall(function() return game:GetService("ReplicatedStorage").Modules and game:GetService("ReplicatedStorage").Modules.Net end)
            if ok and Net and Net["RE/RegisterAttack"] and Net["RE/RegisterHit"] then
                pcall(function()
                    Net["RE/RegisterAttack"]:FireServer(0.1)
                    Net["RE/RegisterHit"]:FireServer(mainHead, hitTable)
                end)
            end
        end
    end
end

function FastAttackLoop()
    while task.wait(0.05 + math.random() * 0.005) do
        pcall(function()
            AttackNoCoolDown()
        end)
        task.wait(0.08)
    end
end

function EquipTool(ToolSe)
  if game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe) then
    local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe)
    task.wait()
    game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
  end
end

task.spawn(function()
  while task.wait() do
    if _G.FightingStyles then
      pcall(function()
        for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
          if v.ToolTip == "Melee" then
            local ToolHuman = game.Players.LocalPlayer.Backpack:FindFirstChild(v.Name)
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(ToolHuman)
          end
        end
      end)
    end
  end
end)


--uimain

--Ui
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
--Maindev
local Window = Fluent:CreateWindow({
	Title = "Rain Hub | Communuty",
	SubTitle = "discord.com/rainhub",
	TabWidth = 160,
	Size = UDim2.fromOffset(555, 320),
	Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
	Theme = "Dark",
	MinimizeKey = Enum.KeyCode.LeftControl 
})

--TabdLical 
local Tabs = {
  Shop = Window:AddTab({ Title = "Shops", Icon = "" }),
  Main = Window:AddTab({ Title = "Main", Icon = "" }),
  Farming = Window:AddTab({ Title = "Farming", Icon = ""}),
  Status = Window:AddTab({ Title = "Server Status", Icon = ""}),
  LPlayer = Window:AddTab({ Title = "Local Player", Icon = ""}),
  FruitRaid = Window:AddTab({ Title = "Fruits-Raids", Icon = ""}),
  ItemMaterial = Window:AddTab({ Title = "Items-Materials", Icon = ""}),
  FarmOther = Window:AddTab({ Title = "Farm Other", Icon = ""}),
  Offshore = Window:AddTab({ Title = "Offshore", Icon = ""}),
  SeaEvent = Window:AddTab({ Title = "Sea Events", Icon = ""}),
  RaceAwken = Window:AddTab({ Title = "Race Awakening", Icon = ""}),
  Setting = Window:AddTab({ Title = "Seting", Icon = ""}),
}
local Options = Fluent.Options

Fluent:Notify({
    Title = "Rain Hub",
    Content = "Sub Load",
    Duration = 8
})

--TabsShop
Tabs.Shop:AddSection("Fighting styles")
Tabs.Shop:AddToggle("ToggleBuySuperhuman", {
  Title = "Tween Buy Superhuman", 
  Default = false
}):OnChanged(function(Value)
  _G.BuySuperhuman = Value
end)

Tabs.Shop:AddToggle("ToggleBuyDeathStep", {
  Title = "Tween Buy Death Step", 
  Default = false
}):OnChanged(function(Value)
  _G.BuyDeathStep = Value
end)

Tabs.Shop:AddToggle("ToggleBuySharkmanKarate", {
  Title = "Tween Buy Sharkman Karate", 
  Default = false
}):OnChanged(function(Value)
  _G.BuySharkmanKarate = Value
end)

Tabs.Shop:AddToggle("ToggleBuyElectricClaw", {
  Title = "Tween Buy Electric Claw", 
  Default = false
}):OnChanged(function(Value)
  _G.BuyElectricClaw = Value
end)

Tabs.Shop:AddToggle("ToggleBuyDragonTalon", {
  Title = "Tween Buy DragonTalon", 
  Default = false
}):OnChanged(function(Value)
  _G.BuyDragonTalon = Value
end)

Tabs.Shop:AddToggle("ToggleBuyGodhuman", {
  Title = "Tween Buy Godhuman", 
  Default = false
}):OnChanged(function(Value)
  _G.BuyGodhuman = Value
end)

Tabs.Shop:AddToggle("ToggleBuySanguineArt", {
  Title = "Tween Buy Sanguine Art", 
  Default = false
}):OnChanged(function(Value)
  _G.BuySanguineArt = Value
end)
Tabs.Shop:AddButton({
  Title = "Air Jump",
  Description = "",
  Callback = function()
    local args = {
	"BuyHaki",
	"Geppo"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
  end
})

Tabs.Shop:AddButton({
  Title = "Aura",
  Description = "",
  Callback = function()
    local args = {
	"BuyHaki",
	"Buso"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
  end
})

Tabs.Shop:AddButton({
  Title = "Flash Step",
  Description = "",
  Callback = function()
    local args = {
	"BuyHaki",
	"Soru"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
  end
})

--TabsMain
Tabs.Main:AddSection("Farms")
Tabs.Main:AddToggle("ToggleAutoLevel", {
  Title = "Auto Level",
  Default = false
}):OnChanged(function(Value)
  _G.AutoLevel = Value
end)

Tabs.Main:AddToggle("ToggleAutoDisCK", {
  Title = "Auto Dismiss Cake Prince",
  Default = false
}):OnChanged(function(Value)
  _G.AutoDismissCakePrince = Value
end)

Tabs.Main:AddToggle("ToggleAutoCK", {
  Title = "Auto Cake Prince",
  Default = false
}):OnChanged(function(Value)
  _G.AutoCakePrince = Value
end)

Tabs.Main:AddToggle("ToggleAutoCKH", {
  Title = "Auto Cake Prince Hop",
  Default = false
}):OnChanged(function(Value)
  _G.AutoCakePrinceHop = Value
end)

Tabs.Main:AddToggle("ToggleAutoBones", {
  Title = "Auto Bones",
  Default = false
}):OnChanged(function(Value)
  _G.AutoBones = Value
end)

Tabs.Main:AddToggle("ToggleDisTS", {
  Title = "Auto Dismiss Tyrant of the Skies",
  Default = false
}):OnChanged(function(Value)
  _G.AutoDismissTS = Value
end)

Tabs.Main:AddToggle("ToggleAutoTS", {
  Title = "Auto Tyrant of the Skies",
  Default = false
}):OnChanged(function(Value)
  _G.AutoTS = Value
end)
    
Tabs.Main:AddToggle("ToggleAQ", {
  Title = "Accept Quest",
  Description = "For Level/Cake Pirnce/Bones/Tyrant of the Skies",
  Default = true
}):OnChanged(function(Value)
  _G.AcceptQuest = Value
end)

function QuestBone()
  if game:GetService("Players").LocalPlayer.Data.Level.Value >= 1975 and game:GetService("Players").LocalPlayer.Data.Level.Value < 2000 then
    Mon = "Reborn Skeleton"
    LevelQuest = 1
    NameQuest = "HauntedQuest1"
    NameMon = "Reborn Skeleton"
    CFrameQuest = CFrame.new(-9479.2168, 141.214996, 5566.09277, 0, 0, 1, 0, 1, 0, -1, 0, 0)
  elseif game:GetService("Players").LocalPlayer.Data.Level.Value >= 2000 and game:GetService("Players").LocalPlayer.Data.Level.Value < 2025 then
    Mon = "Living Zombie"
    LevelQuest = 2
    NameQuest = "HauntedQuest1"
    NameMon = "Living Zombie"
    CFrameQuest = CFrame.new(-9479.2168, 141.214996, 5566.09277, 0, 0, 1, 0, 1, 0, -1, 0, 0)
  elseif game:GetService("Players").LocalPlayer.Data.Level.Value >= 2025 and game:GetService("Players").LocalPlayer.Data.Level.Value < 2050 then
    Mon = "Demonic Soul"
    LevelQuest = 1
    NameQuest = "HauntedQuest2"
    CFrameQuest = CFrame.new(-9516.99316, 172.016998, 6078.46484, 0, 0, -1, 0, 1, 0, 1, 0, 0)
  elseif game:GetService("Players").LocalPlayer.Data.Level.Value >= 2025 then
    Mon = "Posessed Mummy"
    LevelQuest = 2
    NameQuest = "HauntedQuest2"
    CFrameQuest = CFrame.new(-9516.99316, 172.016998, 6078.46484, 0, 0, -1, 0, 1, 0, 1, 0, 0)
  end
end

local function GetQuestTitle()
    local gui  = Player:FindFirstChild("PlayerGui")
    local main = gui and gui:FindFirstChild("Main")
    local quest= main and main:FindFirstChild("Quest")
    local cont = quest and quest:FindFirstChild("Container")
    local titf = cont and cont:FindFirstChild("QuestTitle")
    local lab  = titf and titf:FindFirstChild("Title")
    if quest and quest.Visible and lab then return lab.Text end
    return nil
end

local function TakeQuest()
  if not CFrameQuest then return false end

  TP(CFrameQuest)
  task.wait(0.8)

  local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
  if hrp then
    repeat task.wait()
    until (hrp.Position - CFrameQuest.Position).Magnitude <= 3
  end

  game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(
    "StartQuest", NameQuest, LevelQuest
  )

  task.wait(0.5)

  local title = GetQuestTitle()
  return title and NameMon and string.find(title, NameMon)
end

local function EnsureQuest()
  QuestBone()

  if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then
    return true 
  end

  game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
  task.wait(0.2)

  if CFrameQuest then
    TP(CFrameQuest)
    task.wait(0.8)
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(
      "StartQuest", NameQuest, LevelQuest
    )
    task.wait(0.5)
  end

  return game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true
end

local function GetNearestBoneMob()
  local player = game.Players.LocalPlayer
  local char = player.Character
  local hrp = char and char:FindFirstChild("HumanoidRootPart")
  if not hrp then return nil end
  local nearest, shortest = nil, math.huge
  for _, v in ipairs(workspace.Enemies:GetChildren()) do
    if v.Name == "Reborn Skeleton" or v.Name == "Living Zombie" or v.Name == "Demonic Soul" or v.Name == "Posessed Mummy" then
      local hum = v:FindFirstChildOfClass("Humanoid")
      local mobHRP = v:FindFirstChild("HumanoidRootPart")
      if hum and mobHRP and hum.Health > 0 then
        local dist = (mobHRP.Position - hrp.Position).Magnitude
        if dist < shortest then
          shortest = dist
          nearest = v
        end
      end
    end
  end
  return nearest
end

local function FarmNearestMob()
    local mob = GetNearestBoneMob()
    if not mob then return false end

    local hum = mob:FindFirstChildOfClass("Humanoid")
    local hrp = mob:FindFirstChild("HumanoidRootPart")
    if not hum or not hrp then return false end

    repeat
        task.wait(0.25)
		Fly()
        TP(hrp.CFrame * CFrame.new(0, 25, 0))
        AutoHaki()
        FastAttackLoop()
        hrp.CanCollide = false
    until not _G.AutoBones or hum.Health <= 0

    return true
end

task.spawn(function()
    while task.wait(0.1) do
      if _G.AutoBones and _G.AcceptQuest then
        pcall(function()
          EnsureQuest()
          if not FarmNearestMob() then
            TP(CFrame.new(-9498.63574, 172.139816, 6104.71143, 0.999950886, -9.36211251e-08, 0.00991109852, 9.33304989e-08, 1, 2.97860687e-08, -0.00991109852, -2.88595974e-08, 0.999950886))
            task.wait(0.5)
          end
        end)
      end
    end
end)

task.spawn(function()
  while task.wait() do
    if not _G.AcceptQuest and _G.AutoBones then
      pcall(function()
        if game:GetService("Workspace").Enemies:FindFirstChild("Reborn Skeleton") or game:GetService("Workspace").Enemies:FindFirstChild("Living Zombie") or game:GetService("Workspace").Enemies:FindFirstChild("Demonic Soul") or game:GetService("Workspace").Enemies:FindFirstChild("Posessed Mummy") then
          for i, v in ipairs(game:GetService("Workspace").Enemies:GetChildren()) do
            if v.Name == "Reborn Skeleton" or v.Name == "Living Zombie" or v.Name == "Demonic Soul" or v.Name == "Posessed Mummy" then
              if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                repeat
                  task.wait(0.15)
				if not _G.AutoBones or _G.AcceptQuest then break end
                if not v.Parent or hum.Health <= 0 then break end						
                  Fly()
                  v.HumanoidRootPart.CanCollide = false
                  v.Humanoid.WalkSpeed = 0


Tabs.Main:AddToggle("MyToggle", {
  Title = "Holding Sword",
  Default = false
}):OnChanged(function(Value)
  _G.HoldingSword = Value
end)

Tabs.Main:AddToggle("MyToggle", {
  Title = "Click Fruits",
  Default = false
}):OnChanged(function(Value)
  _G.ClickFruits = Value
end)

task.spawn(function()
  while task.wait() do
    if not _G.HoldingSword and not _G.ClickFruits then
      pcall(function()
        _G.FightingStyles = true
      end)
    elseif _G.HoldingSword then
      _G.FightingStyles = false
      _G.ClickFruits = false
      pcall(function()
        for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
          if v.ToolTip == "Sword" then
            local ToolHuman = game.Players.LocalPlayer.Backpack:FindFirstChild(v.Name)
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(ToolHuman)
          end
        end
      end)
    elseif _G.ClickFruits then
      _G.FightingStyles = false
      _G.HoldingSword = false
      pcall(function()
        for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
          if v.ToolTip == "Blox Fruit" then
            local ToolHuman = game.Players.LocalPlayer.Backpack:FindFirstChild(v.Name)
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(ToolHuman)
          end
        end
      end)
    end
  end
end)

Tabs.Main:AddSection("Mastery")
Tabs.Main:AddDropdown("Dropdown", {
  Title = "Method Mastery",
  Values = {"Fruits", "Guns"},
  Multi = false,
  Default = 1,
}):OnChanged(function(Value)
  _G.MethodMastery = Value
end)

Tabs.Main:AddSlider("Slider", {
  Title = "Percent Mastery",
  Description = "",
  Default = 20,
  Min = 0.0,
  Max = 100,
  Rounding = 1,
  Callback = function(Value)
    _G.PercentMastery = Value
  end
})

Tabs.Main:AddToggle("MyToggle", {
  Title = "Auto Mastery",
  Description = "",
  Default = false
}):OnChanged(function(Value)
  _G.AutoMastery = Value
end)

--TabsStatus
local ServerRunTimePara = Tabs.Status:AddParagraph({
    Title = "Timer: 00 Hour-00 Minute-00 Second",
    Content = ""
})

local function UpdateServerRuntime()
    local GameTime = math.floor(workspace.DistributedGameTime + 0.5)

    local Hour = math.floor(GameTime / (60^2)) % 24
    local Minute = math.floor(GameTime / 60) % 60
    local Second = GameTime % 60

    ServerRunTimePara:SetTitle(
        "Timer: " ..
        string.format("%02d H %02d M %02d S", Hour, Minute, Second)
    )
end

task.spawn(function()
    while task.wait() do
        pcall(UpdateServerRuntime)
    end
end)

local CakePrinceStatus = Tabs.Status:AddParagraph({
  Title = "Cake Prince: ",
  Content = ""
})

spawn(function()
  while task.wait() do
    pcall(function()
      local result = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")
      local remaining = string.match(result, "%d+")
      CakePrinceStatus:SetTitle("Cake Prince: " .. remaining .. " Enemy")
    end)
  end
end)

local TSStatus = Tabs.Status:AddParagraph({
  Title = "Tyrant of the Skies: ",
  Content = ""
})

task.spawn(function()
  while task.wait() do
    pcall(function()
      local c = 0
      for i, v in pairs(workspace.Map.TikiOutpost.IslandModel:GetDescendants()) do
        if v.Name:find("Eye") then
          if v.Transparency == 0 then 
            c+=1 
          end
        end
      end
      TSStatus:SetTitle("Tyrant of the Skies: " .. c .. " Eyes Are Glowing")
    end)
  end
end)

local SpyStatus = Tabs.Status:AddParagraph({
  Title = "Bribery Information: ",
  Content = ""
})

--Farming


--LocalPlayers
Tabs.LPlayer:AddButton({
  Title = "Shift First Sea",
  Description = "",
  Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain")
  end
})

Tabs.LPlayer:AddButton({
  Title = "Shift Seacond Sea",
  Description = "",
  Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
  end
})

Tabs.LPlayer:AddButton({
  Title = "Shift Third Sea",
  Description = "",
  Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
  end
})

Tabs.LPlayer:AddButton({
  Title = "Open Titles Specialist",
  Description = "",
  Callback = function()
			game:GetService("Players").LocalPlayer.PlayerGui.Main.Titles.Visible = true
		end
})

Tabs.LPlayer:AddButton({
  Title = "Open Awakenings Expert",
  Description = "",
  Callback = function()
    game:GetService("Players").LocalPlayer.PlayerGui.Main.AwakeningToggler.Visible = true
  end
})

local IslandList = {}
if FirstSea then
		IslandList = {
		"Pirate Starter Island",
		"Marine Starter Island",
		"Middle Town",
		"Jungle",
		"Pirate Village",
		"Desert",
		"Frozen Village",
		"Marine Fortress",
		"Skyland1",
		"Skyland2",
		"Skyland3",
		"Prison",
		"Magma Village",
		"Underwater City",
		"Colosseum",
		"Fountain City",
		},
elseif SecondSea then
		IslandList = {
			"Green Zone",
			"KingDon Of Rose1",
			"KingDon Of Rose2",
			"The Cafe",
			"Don Swan Mansion"
			"Graveyard",
			"Cursed Ship",
			"Hot Island",
			"Cold Island",
			"Forgotten Island",
			"Ice Castle",
			"Snow Mountain",
			"Dark Arena",
			"Secret Laboratory",
			"Raid Lab",
			
		},
elseif ThirdSea then
		IslandList = {
			"Port Town",
			"Hydra Island1",
			"Hydra Island2"
			"Dragon Dojo",
			"Caste on the Sea",
			"Great Tree",
			"Floating Turtle",
			"Mansion",
			"Temple of Time",
			"Haunted Castle",
			"Submerged Island",
			"Tiki Outpost",
			"Peanut Land",
			"Ice Cream Land",
			"Cake Land",
			"Chocolate Land",
			"Candy Cane Land",
		},
end

Tabs.LPlayer:AddDropdown("DropdownSelectIsland", {
  Title = "Select Island",
  Values = IslandList,
  Multi = false,
  Default = 1,
}):OnChanged(function(Value)
  _G.SelectIsland = Value
end)
											
task.spawn(function()
  while task.wait() do
    pcall(function()
      if _G.SelectIsland == "Pirate Starter Island" then
        TP(CFrame.new(1037.63538, 80.6225815, 1594.75391, -0.803820193, 2.38998634e-08, 0.594872296, 3.68290962e-08, 1, 9.58879376e-09, -0.594872296, 2.96162757e-08, -0.803820193))
      elseif _G.SelectIsland == "Marine Starter Island" then
        TP(CFrame.new(-2835.49097, 41.4808655, 2029.42749, -0.234630495, 3.04188781e-08, -0.972084641, -9.81363755e-08, 1, 5.49794379e-08, 0.972084641, 1.08296717e-07, -0.234630495))
      elseif _G.SelectIsland == 	"Middle Town" then
        TP(CFrame.new(-689.856323, 15.0865364, 1582.84546, 0.261085629, 7.73279254e-08, -0.96531564, -4.28698499e-08, 1, 6.85114969e-08, 0.96531564, 2.34955664e-08, 0.261085629))
      elseif _G.SelectIsland == "Jungle" then
        TP(CFrame.new(-1493.78308, 22.8438587, 380.050079, -0.872975945, 6.21927327e-08, -0.487763286, 7.86620191e-08, 1, -1.32796369e-08, 0.487763286, -4.99612476e-08, -0.872975945))
      elseif _G.SelectIsland == "Pirate Village" then
        TP(CFrame.new(-1149.27649, 65.1931534, 4162.57812, 0.958204508, 1.03980781e-07, -0.286084056, -1.1670241e-07, 1, -2.74185012e-08, 0.286084056, 5.96592358e-08, 0.958204508))
      elseif _G.SelectIsland == "Desert" then
        TP(CFrame.new(944.402466, 20.9120159, 4367.8623, -0.978600085, 3.64656252e-08, -0.205771372, 2.3351383e-08, 1, 6.61606165e-08, 0.205771372, 5.99397438e-08, -0.978600085))
      elseif _G.SelectIsland == "Frozen Village" then
        TP(CFrame.new(1398.38843, 87.6798325, -1348.87878, -0.999439061, 1.80932407e-08, -0.0334898271, 1.67280714e-08, 1, 4.10438865e-08, 0.0334898271, 4.04606446e-08, -0.999439061))
      elseif _G.SelectIsland == 	"Marine Fortress" then
        TP(CFrame.new(-4818.18848, 20.6439495, 4372.75635, 0.836107016, 1.52223976e-08, -0.548566401, -5.62457103e-08, 1, -5.79784576e-08, 0.548566401, 7.93306967e-08, 0.836107016))
      elseif _G.SelectIsland == "Skyland1" then
        TP(CFrame.new(-4960.05176, 3.89969921, -2400.67969, -0.238063425, -6.34105568e-09, -0.97124964, 1.56037849e-08, 1, -1.03534106e-08, 0.97124964, -1.76199393e-08, -0.238063425))
      elseif _G.SelectIsland == 	"Skyland2" then
        TP(CFrame.new(-4842.59912, 867.093689, -1839.96863, -0.344263732, -4.36699921e-08, -0.938872993, -4.99862658e-08, 1, -2.81843597e-08, 0.938872993, 3.7227899e-08, -0.344263732))
      elseif _G.SelectIsland == 	"Skyland3" then
        TP(CFrame.new(-8000.49512, 5813.98584, -1938.35303, -0.826513827, 6.07665243e-08, -0.562916458, 3.98148359e-08, 1, 4.94904882e-08, 0.562916458, 1.84921465e-08, -0.826513827))
      elseif _G.SelectIsland == "Prison" then
        TP(CFrame.new(5022.46045, 88.6441879, 737.350647, -0.0183219928, 3.15113233e-08, 0.999832153, 1.06221485e-08, 1, -3.13219637e-08, -0.999832153, 1.00464845e-08, -0.0183219928))
      elseif _G.SelectIsland == "Magma Village" then
        TP(CFrame.new(-5514.2793, 62.7915611, 8577.38672, 0.782042027, 3.03634486e-08, -0.623225689, -2.45559022e-08, 1, 1.79063555e-08, 0.623225689, 1.30034572e-09, 0.782042027))
      elseif _G.SelectIsland == "Underwater City" then
        TP(CFrame.new(61334.0586, 92.7145615, 1281.68799, -0.99927181, -8.84563711e-09, -0.0381552316, -9.1567065e-09, 1, 7.97798361e-09, 0.0381552316, 8.32155056e-09, -0.99927181))
      elseif _G.SelectIsland == "Colosseum" then
        TP(CFrame.new(-1719.22778, 150.323837, -3168.36108, -0.737930298, 7.04111436e-09, -0.674876928, 1.0342772e-08, 1, -8.75908179e-10, 0.674876928, -7.6264568e-09, -0.737930298))
      elseif _G.SelectIsland == "Fountain City" then
        TP(CFrame.new(5777.04297, 579.550476, 4379.62451, 0.33506006, 1.16727632e-08, -0.942196786, 3.49154838e-08, 1, 2.48053791e-08, 0.942196786, -4.12085477e-08, 0.33506006))
      elseif _G.SelectIsland == "Green Zone" then
        TP(CFrame.new(-2455.45117, 90.1054153, -3148.56299, -0.895971894, -1.11538561e-07, -0.444110751, -1.00914697e-07, 1, -4.75598299e-08, 0.444110751, 2.20503149e-09, -0.895971894))
      elseif _G.SelectIsland == "KingDon Of Rose1" then
        TP(CFrame.new(-141.301849, 75.8591385, 2746.67358, -0.18109335, -1.57117057e-08, -0.98346591, -1.24137829e-08, 1, -1.36900038e-08, 0.98346591, 9.72936398e-09, -0.18109335))
      elseif _G.SelectIsland == "KingDon Of Rose2" then
        TP(CFrame.new(-335.976471, 121.381874, 1296.84363, 0.999305665, -3.26305489e-08, 0.0372586064, 3.38490551e-08, 1, -3.20731992e-08, -0.0372586064, 3.3312098e-08, 0.999305665))
      elseif _G.SelectIsland == "The Cafe" then
        TP(CFrame.new(-371.097809, 149.211838, 223.628616, 0.992276549, 1.12928422e-08, 0.124045365, -5.9967844e-09, 1, -4.3067903e-08, -0.124045365, 4.19913952e-08, 0.992276549))
      elseif _G.SelectIsland == "Don Swan Mansion" then
        TP(CFrame.new(-310.079926, 375.452881, 644.331482, -0.0713519603, 2.82691364e-08, 0.997451186, -3.98390121e-08, 1, -3.11912274e-08, -0.997451186, -4.19630233e-08, -0.0713519603))
      elseif _G.SelectIsland == "Graveyard" then
        TP(CFrame.new(-5646.97607, 185.325729, -886.009644, 0.76935333, 4.21680274e-10, 0.638823509, -2.50014143e-08, 1, 2.94498257e-08, -0.638823509, -3.86288121e-08, 0.76935333))
      elseif _G.SelectIsland == "Cursed Ship" then
        TP(CFrame.new(922.56134, 182.649857, 33242.3242, 0.999953091, -4.53051774e-09, -0.00968338363, 4.48791804e-09, 1, -4.42098136e-09, 0.00968338363, 4.37731584e-09, 0.999953091))
      elseif _G.SelectIsland == "Hot Island" then
        TP(CFrame.new(-5111.96387, 188.650177, -5339.42578, -0.268935323, -1.94999412e-08, 0.96315825, -2.65990141e-09, 1, 1.95031298e-08, -0.96315825, 2.68317435e-09, -0.268935323))
      elseif _G.SelectIsland == "Cold Island" then
        TP(CFrame.new(-6149.0083, 315.118561, -4993.97559, 0.288855702, 2.00316794e-08, -0.957372665, 2.09551452e-08, 1, 2.72461236e-08, 0.957372665, -2.79320815e-08, 0.288855702))
      elseif _G.SelectIsland == "Forgotten Island" then
        TP(CFrame.new(-2683.70679, 708.082397, -10967.8828, -0.998628438, 5.40225003e-08, 0.052356869, 5.75173047e-08, 1, 6.52429648e-08, -0.052356869, 6.81649084e-08, -0.998628438))
      elseif _G.SelectIsland == "Ice Castle" then
        TP(CFrame.new(5836.04541, 99.4163589, -6505.72754, -0.850549638, -3.26488738e-08, 0.525894761, -2.23612613e-08, 1, 2.59168029e-08, -0.525894761, 1.02838573e-08, -0.850549638))
      elseif _G.SelectIsland == "Snow Mountain" then
        TP(CFrame.new(1182.48352, 467.612976, -5000.10645, 0.742966235, -9.61186597e-09, 0.669328868, 9.50431289e-09, 1, 3.81050658e-09, -0.669328868, 3.5304335e-09, 0.742966235))
      elseif _G.SelectIsland == "Dark Arena" then
        TP(CFrame.new(3861.64551, 37.690361, -3112.50708, 0.962457478, -7.04189063e-08, 0.271432489, 4.99679871e-08, 1, 8.22556032e-08, -0.271432489, -6.56045884e-08, 0.962457478))
      elseif _G.SelectIsland == "Secret Laboratory" then
        TP(CFrame.new(-5474.74121, 401.944824, -5830.67871, -0.965090394, 7.67189121e-08, -0.261916995, 6.37885762e-08, 1, 5.78701069e-08, 0.261916995, 3.91425736e-08, -0.965090394))
      elseif _G.SelectIsland == "Raid Lab" then
        TP(CFrame.new(-6515.19531, 250.611908, -4479.91211, 0.344380856, -7.30057259e-09, -0.938830018, -1.64662843e-08, 1, -1.38163943e-08, 0.938830018, 2.02171435e-08, 0.344380856))
      elseif _G.SelectIsland == "Port Town" then
        TP(CFrame.new(-332.99823, 20.6029835, 5512.76318, 0.973622024, 1.70947665e-08, -0.228166997, -1.47030894e-08, 1, 1.21819328e-08, 0.228166997, -8.5058387e-09, 0.973622024))
      elseif _G.SelectIsland == "Hydra Island1" then
        TP(CFrame.new(5039.2749, 173.399658, -2009.88977, 0.97077167, -3.42456197e-08, 0.240004972, 3.65463428e-08, 1, -5.1354605e-09, -0.240004972, 1.37566634e-08, 0.97077167))
      elseif _G.SelectIsland == "Hydra Island2" then
        TP(CFrame.new(5564.22168, 1005.5036, 95.1717377, -0.635244727, 1.01565156e-07, 0.772310913, 3.49387328e-08, 1, -1.02770151e-07, -0.772310913, -3.83006302e-08, -0.635244727))
      elseif _G.SelectIsland == "Dragon Dojo" then
        TP(CFrame.new(5721.39062, 1206.81177, 958.388855, 0.35146594, 4.76143533e-08, -0.936200678, -7.6260136e-08, 1, 2.22297558e-08, 0.936200678, 6.35817869e-08, 0.35146594))
      elseif _G.SelectIsland == "Caste on the Sea" then
        TP(CFrame.new(-5125.10547, 314.187622, -2963.05835, -0.473895282, 1.96359711e-08, 0.8805812, 5.72839642e-09, 1, -1.92160705e-08, -0.8805812, -4.06208667e-09, -0.473895282))
      elseif _G.SelectIsland == "Great Tree" then
        TP(CFrame.new(4176.01221, 565.7995, -6311.15039, 0.607411861, 6.50904894e-08, 0.794387102, -1.22795996e-07, 1, 1.19554526e-08, -0.794387102, -1.04809438e-07, 0.607411861))
      elseif _G.SelectIsland == "Floating Turtle" then
        TP(CFrame.new(-10053.6602, 331.754517, -8318.57324, -0.184462786, -4.72932342e-08, 0.982839525, -4.72455035e-08, 1, 3.92517805e-08, -0.982839525, -3.9194255e-08, -0.184462786))
      elseif _G.SelectIsland == "Mansion" then
        TP(CFrame.new(-12549.1973, 459.472931, -7560.86182, 0.999207139, -1.06063762e-08, 0.0398129523, 8.52913828e-09, 1, 5.23447987e-08, -0.0398129523, -5.1963724e-08, 0.999207139))
      elseif _G.SelectIsland == "Temple of Time" then
        TP(CFrame.new(28556.7324, 14890.5449, -87.6962585, 0.122791506, -8.02967648e-08, -0.992432475, 4.79143623e-08, 1, -7.49807043e-08, 0.992432475, -3.83447762e-08, 0.122791506))
      elseif _G.SelectIsland == "Haunted Castle" then
        TP(CFrame.new(-9504.72559, 172.096664, 6034.88721, 0.99913311, 4.78551456e-08, 0.0416297391, -4.78035176e-08, 1, -2.23558549e-09, -0.0416297391, 2.43599418e-10, 0.99913311))
      elseif _G.SelectIsland == "Submerged Island" then
        TP(CFrame.new(11155.8887, -1912.77783, 9796.59668, 0.297251135, -1.80704074e-08, -0.954799354, -2.89712752e-08, 1, -2.79452976e-08, 0.954799354, 3.59685259e-08, 0.297251135))
      elseif _G.SelectIsland == "Tiki Outpost" then
        TP(CFrame.new(-16394.0156, 527.745544, 428.658081, -0.00244545401, -1.17462697e-08, -0.99999702, 4.6226031e-08, 1, -1.18593491e-08, 0.99999702, -4.62548932e-08, -0.00244545401))
      elseif _G.SelectIsland == "Peanut Land" then
        TP(CFrame.new(-2150.43774, 47.7138023, -10015.8799, -0.954429924, -1.97848471e-09, -0.298435152, -1.52040691e-09, 1, -1.76709347e-09, 0.298435152, -1.23282395e-09, -0.954429924))
      elseif _G.SelectIsland == "Ice Cream Land" then
        TP(CFrame.new(-889.874939, 65.8113098, -10894.4619, -0.807582796, 5.22889501e-08, 0.589754164, 5.82707358e-08, 1, -8.86895801e-09, -0.589754164, 2.72029919e-08, -0.807582796))
      elseif _G.SelectIsland == "Cake Land" then
        TP(CFrame.new(-1897.57703, 9.52338028, -11499.2812, -0.955638766, -4.81486069e-08, -0.29454124, -4.60265426e-08, 1, -1.4136762e-08, 0.29454124, 4.70767036e-11, -0.955638766))
      elseif _G.SelectIsland == "Chocolate Land" then
        TP(CFrame.new(207.767883, 126.583794, -12598.5234, -0.39604488, 6.89493174e-09, 0.91823113, -2.20901364e-09, 1, -8.46170423e-09, -0.91823113, -5.37959988e-09, -0.39604488))
      elseif _G.SelectIsland == "Candy Cane Land" then
        TP(CFrame.new(-997.224243, 60.1506805, -14477.9951, 0.12927182, 4.01811562e-09, -0.991609216, 6.05907502e-09, 1, 4.84201168e-09, 0.991609216, -6.63417055e-09, 0.12927182))
      end
    end)
  end
end)
											
Tabs.LPlayer:AddToggle("ToggleTweenIsland", {
  Title = "Tween Island",
  Default = false
}):OnChanged(function(Value)
  _G.TweenIsland = Value
end)											
											
--RaceAwkening
Tabs.RaceAwken:AddParagraph({
  Title = "Race: " .. tostring(game:GetService("Players").LocalPlayer.Data.Race.Value),
  Content = ""
})

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("Rain Hub")
SaveManager:SetFolder("Rain Hub")
SaveManager:LoadAutoloadConfig()
