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
            local char = game.Players.LocalPlayer.Character
            if not char then return end
          local hrp = char:FindFirstChild("HumanoidRootPart")
            local root = char:FindFirstChild("Root")
            if not hrp or not root then return end
          hrp.CFrame = root.CFrame
          if (root.Position - hrp.Position).Magnitude >= 1 then
                root.CFrame = hrp.CFrame
            end
        end)
    end
end)

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

function StartFastAttack()
    task.spawn(function()
        pcall(function()
            local Players = game:GetService("Players")
            local RunService = game:GetService("RunService")
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local Player = Players.LocalPlayer
            local EXTENDED_RANGE = 180
            local WINDUP_TIME = 0.4
            local MIN_LOOP = 0.05
            local JITTER = 0.005
            local SAFE_CALLS = 20
            local calls, window_t = 0, tick()
            local function can_call()
            local now = tick()
            if now - window_t >= 1 then
                window_t, calls = now, 0
            end
            if calls < SAFE_CALLS then
                calls += 1
                return true
            end
                return false
            end
            local function HRP()
                return Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
            end
            local function IsAlive(m)
                local h = m and m:FindFirstChildOfClass("Humanoid")
                return h and h.Health > 0
            end
            local function GetEnemyInRange(r)
    local hrp = HRP()
    if not hrp then return nil end

    local folder = workspace:FindFirstChild("Enemies") or workspace:FindFirstChild("Monsters")
    if not folder then return nil end

    local best = nil
    local bestD = math.huge

    for _, e in ipairs(folder:GetChildren()) do
        if IsAlive(e) and e:FindFirstChild("HumanoidRootPart") then
            local d = (e.HumanoidRootPart.Position - hrp.Position).Magnitude
            if d <= r and d < bestD then
                best = e
                bestD = d
            end
        end
    end

    if not best then return nil end

    return best:FindFirstChild("Head") or best.HumanoidRootPart
end
            local function PlayToolAnim(tool)
                local hum = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
                if not hum then return end
                local anim = tool:FindFirstChildWhichIsA("Animation")
                if anim then
                local ok, track = pcall(function() return hum:LoadAnimation(anim) end)
                    if ok and track then pcall(function() track:Play() end) end
                    
                end
            end
            local function FireAttack(tool, target, count)
                if not can_call() then return end
                local click = tool:FindFirstChild("LeftClickRemote")
                if click then
                    pcall(function()
                    local hrp = HRP()
                    local dir = (target.Position - hrp.Position).Unit
                        click:FireServer(dir, count)
                    end)
                    return
                end
                local Net = ReplicatedStorage:FindFirstChild("Modules") and ReplicatedStorage.Modules:FindFirstChild("Net")
                if Net then
                    pcall(function()
                        Net["RE/RegisterAttack"]:FireServer(0.1)
                        Net["RE/RegisterHit"]:FireServer(target, {{target.Parent, target}})
                        
                    end)
                end
            end
            local counter = 1
            while task.wait() do
                task.wait(MIN_LOOP + math.random() * JITTER)
                local char = Player.Character
                if not char then continue end
                local tool = char:FindFirstChildOfClass("Tool")
                if not tool then continue end
                local typ = (tool:GetAttribute("WeaponType") or ""):lower()
                if typ ~= "melee" and typ ~= "sword" then continue end
                local target = GetEnemyInRange(EXTENDED_RANGE)
                if not target then continue end
                PlayToolAnim(tool)
                task.wait(WINDUP_TIME)
                FireAttack(tool, target, counter)
                counter += 1
            end
        end)
    end)
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

task.spawn(function()
  if _G.BringMob then
    pcall(function()
      sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
      while task.wait() do
        for _, v in pairs(workspace.Enemies:GetChildren()) do
          pcall(function()
            if v.Name ~= MonFarm then return end
            local hum = v:FindFirstChild("Humanoid")
            local hrp = v:FindFirstChild("HumanoidRootPart")
            local head = v:FindFirstChild("Head")
            if not hum or not hrp or hum.Health <= 0 then return end
            hrp:SetNetworkOwner(game.Players.LocalPlayer)
            hrp.CFrame = FarmPos * CFrame.new(0, 0, -5)
            hrp.Size = Vector3.new(25,25,25)
            hrp.CanCollide = false
            if head then head.CanCollide = false end
            hum.WalkSpeed = 1
            hum.JumpPower = 1
            hum:ChangeState(Enum.HumanoidStateType.Running)
            local animator = hum:FindFirstChild("Animator")
            if animator then animator:Destroy() end
          end)
        end
      end
    end)
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
  Status = Window:AddTab({ Title = "Server Status", Icon = ""}),
  Farming = Window:AddTab({ Title = "Farming", Icon = ""}),
  LPlayer = Window:AddTab({ Title = "Local Player", Icon = ""}),
  FO = Window:AddTab({ Title = "Farm OutSide", Icon = ""}),
  RM = Window:AddTab({ Title = "Raid-Material", Icon = ""}),
  FE = Window:AddTab({ Title = "Fruits-Events", Icon = ""}),
  PI = Window:AddTab({ Title = "Prehistoric Island", Icon = ""}),
  RA = Window:AddTab({ Title = "Race Awakening", Icon = ""}),
  SE = Window:AddTab({ Title = "Sea Events", Icon = ""}),
  Setting = Window:AddTab({ Title = "Seting", Icon = ""}),
}

local Options = Fluent.Options

Fluent:Notify({
    Title = "Rain Hub",
    Content = "Sub Load",
    Duration = 8
})

--TabsShop
Tabs.Shop:AddButton({
        Title = "Shift First Sea",
        Description = "",
        Callback = function()
          game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain")
        end
    })

Tabs.Shop:AddButton({
        Title = "Shift Seacond Sea",
        Description = "",
        Callback = function()
          game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
        end
    })

Tabs.Shop:AddButton({
        Title = "Shift Third Sea",
        Description = "",
        Callback = function()
          game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
        end
    })

Tabs.Shop:AddButton({
  Title = "Changing Race [f 3,000]",
  Description = "",
  Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Reroll", "1")
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Reroll", "2")
  end
})

Tabs.Shop:AddButton({
  Title = "Swith Cyborg [f 2500]",
  Description = "",
  Callback = function()
          local args = {
	"CyborgTrainer",
	"Buy"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))

        end
    })

Tabs.Shop:AddButton({
  Title = "Swith Draco",
  Description = "",
  Callback = function()
    local args = {
	{
		NPC = "Dragon Wizard",
		Command = "DragonRace"
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/InteractDragonQuest"):InvokeServer(unpack(args))
  end
})

Tabs.Shop:AddButton({
  Title = "Swith Ghoul",
  Description = "",
  Callback = function()
    local args = {
	"Ectoplasm",
	"Change",
	4
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
  end
})

--TabsMain
Tabs.Main:AddSection("Farms")
Tabs.Main:AddToggle("MyToggle", {
  Title = "Auto Level",
  Default = false
}):OnChanged(function(Value)
  _G.AutoLevel = Value
end)

Tabs.Main:AddToggle("MyToggle", {
  Title = "Auto Cake Prince",
  Default = false
}):OnChanged(function(Value)
  _G.AutoCakePrince = Value
end)

Tabs.Main:AddToggle("MyToggle", {
  Title = "Auto Dismiss Cake Prince",
  Default = false
}):OnChanged(function(Value)
  _G.AutoDismissCakePrince = Value
end)


Tabs.Main:AddToggle("MyToggle", {
  Title = "Auto Cake Prince Hop",
  Default = false
}):OnChanged(function(Value)
  _G.AutoCakePrinceHop = Value
end)



Tabs.Main:AddToggle("MyToggle", {
  Title = "Auto Bones",
  Default = false
}):OnChanged(function(Value)
  _G.AutoBones = Value
end)

task.spawn(function()
  while task.wait() do
    pcall(function()
      if _G.AutoBones then
        local QuestTitle = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
        if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
          if game:GetService("Players").LocalPlayer.Data.Level.Value >= 1975 and game:GetService("Players").LocalPlayer.Data.Level.Value < 2000 then
            if not string.find(QuestTitle, "Reborn Skeleton") then
              game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
            end
            if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
              TP(CFrame.new(-9479.2168, 141.214996, 5566.09277, 0, 0, 1, 0, 1, 0, -1, 0, 0))
              if (CFrame.new(-9479.2168, 141.214996, 5566.09277, 0, 0, 1, 0, 1, 0, -1, 0, 0).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest","HauntedQuest1",1)
              end
            end
          elseif game:GetService("Players").LocalPlayer.Data.Level.Value >= 2000 and game:GetService("Players").LocalPlayer.Data.Level.Value < 2025 then
            if not string.find(QuestTitle, "Living Zombie") then
              game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
            end
            if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
              TP(CFrame.new(-9479.2168, 141.214996, 5566.09277, 0, 0, 1, 0, 1, 0, -1, 0, 0))
              if (CFrame.new(-9479.2168, 141.214996, 5566.09277, 0, 0, 1, 0, 1, 0, -1, 0, 0).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest","HauntedQuest1",2)
              end
            end
          elseif game:GetService("Players").LocalPlayer.Data.Level.Value >= 2025 and game:GetService("Players").LocalPlayer.Data.Level.Value < 2050 then
            if not string.find(QuestTitle, "Demonic Soul") then
              game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
            end
            if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
              TP(CFrame.new(-9516.99316, 172.016998, 6078.46484, 0, 0, -1, 0, 1, 0, 1, 0, 0))
              if (CFrame.new(-9516.99316, 172.016998, 6078.46484, 0, 0, -1, 0, 1, 0, 1, 0, 0).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest","HauntedQuest2",1)
              end
            end
          elseif game:GetService("Players").LocalPlayer.Data.Level.Value >= 2025 then
            if not string.find(QuestTitle, "Posessed Mummy") then
              game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
            end
            if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
              TP(CFrame.new(-9516.99316, 172.016998, 6078.46484, 0, 0, -1, 0, 1, 0, 1, 0, 0))
              if (CFrame.new(-9516.99316, 172.016998, 6078.46484, 0, 0, -1, 0, 1, 0, 1, 0, 0).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest","HauntedQuest2",2)
              end
            end
          end
        elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
          if game:GetService("Workspace").Enemies:FindFirstChild("Reborn Skeleton") or game:GetService("Workspace").Enemies:FindFirstChild("Living Zombie") or game:GetService("Workspace").Enemies:FindFirstChild("Demonic Soul") or game:GetService("Workspace").Enemies:FindFirstChild("Posessed Mummy") then
            for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
              if v.Name == "Reborn Skeleton" or v.Name == "Living Zombie" or v.Name == "Demonic Soul" or v.Name == "Posessed Mummy" then
                if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                  repeat
					task.wait(2)
                    AutoHaki()
					_G.BringMob = true						
                    TP(v.HumanoidRootPart.CFrame * CFrame.new(0, 25, 0))
					MonFarm = v.Name
					FarmPos = v.HumanoidRootPart.CFrame
                    v.HumanoidRootPart.CanCollide = false
                  until not _G.AutoBones or v.Humanoid.Health <= 0
                end
              else
                TP(CFrame.new(-9498.63574, 172.139816, 6104.71143, 0.999950886, -9.36211251e-08, 0.00991109852, 9.33304989e-08, 1, 2.97860687e-08, -0.00991109852, -2.88595974e-08, 0.999950886))
              end
            end
          end
        end
      end
    end)
  end
end)

Tabs.Main:AddToggle("MyToggle", {
  Title = "Auto Tyrant of the Skies",
  Default = false
}):OnChanged(function(Value)
  _G.AutoTS = Value
end)
    
Tabs.Main:AddToggle("MyToggle", {
  Title = "Accept Quest",
  Description = "For Level/Cake Pirnce/Bones/Tyrant of the Skies",
  Default = true
}):OnChanged(function(Value)
  _G.AcceptQuest = Value
end)

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
        string.format("%02d Hour %02d Minute %02d Second", Hour, Minute, Second)
    )
end

task.spawn(function()
    while task.wait() do
        pcall(UpdateServerRuntime)
    end
end)

local EliteStatus = Tabs.Status:AddParagraph({
  Title = "Elite Hunter: ",
  Content = ""
})

task.spawn(function()
  pcall(function()
    while task.wait() do
      if game:GetService("ReplicatedStorage"):FindFirstChild("Diablo") or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre") or game:GetService("ReplicatedStorage"):FindFirstChild("Urban") or game:GetService("Workspace").Enemies:FindFirstChild("Diablo") or game:GetService("Workspace").Enemies:FindFirstChild("Deandre") or game:GetService("Workspace").Enemies:FindFirstChild("Urban") then
        EliteStatus:SetTitle("Elite Hunter: 🟢")
      else
        EliteStatus:SetTitle("Elite Hunter: 🔴")
      end
    end
  end)
end)

local MirageStatus = Tabs.Status:AddParagraph({
  Title = "Mirage Island: ",
  Content = ""
})

task.spawn(function()
  while task.wait() do
    if game.Workspace.Map:FindFirstChild("MysticIsland") then
      pcall(function()
        MirageStatus:SetTitle("Mirage Island: 🟢")
      end)
    else
      pcall(function()
        MirageStatus:SetTitle("Mirage Island: 🔴")
      end)
    end
  end
end)

local FrozenDimensionStatus = Tabs.Status:AddParagraph({
  Title = "Frozen Dimension: ",
  Content = ""
})

task.spawn(function()
  while task.wait() do
    if game:GetService("Workspace").Map:FindFirstChild("FrozenDimension") then
      pcall(function()
        FrozenDimensionStatus:SetTitle("Frozen Dimension: 🟢")
      end)
    else 
      pcall(function()
        FrozenDimensionStatus:SetTitle("Frozen Dimension: 🔴")
      end)
    end
  end
end)

local PrehistoricIslandStatus = Tabs.Status:AddParagraph({
  Title = "Prehistoric Island: ",
  Content = ""
})

task.spawn(function()
  while task.wait() do
    if game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland") then
      pcall(function()
        PrehistoricIslandStatus:SetTitle("Prehistoric Island: 🟢")
      end)
    else
      pcall(function()
        PrehistoricIslandStatus:SetTitle("Prehistoric Island: 🔴")
      end)
    end
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
Tabs.Farming:AddToggle("MyToggle", {
  Title = "Auto Elite",
  Default = false
}):OnChanged(function()
  _G.AutoElite = Value
end)

task.spawn(function()
  while task.wait() do
    pcall(function()
      if _G.AutoElite then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter")
        if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
          if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,"Diablo") or string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,"Deandre") or string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,"Urban") then
            if game:GetService("Workspace").Enemies:FindFirstChild("Diablo") or game:GetService("Workspace").Enemies:FindFirstChild("Deandre") or game:GetService("Workspace").Enemies:FindFirstChild("Urban") then
              for i,v in ipairs(game:GetService("Workspace").Enemies:GetChildren()) do
                if v.Name == "Diablo" or v.Name == "Deandre" or v.Name == "Urban" then
                  if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                    repeat
                      AutoHaki()
                      TP(v.HumanoidRootPart.CFrame * CFrame.new(0, 25, 0))
                      v.Humanoid.WalkSpeed=0
                      v.HumanoidRootPart.CanCollide=false
                    until not _G.AutoElite or v.Humanoid.Health <= 0
                  end
                end
              end
            else 
              if game:GetService("ReplicatedStorage"):FindFirstChild("Diablo") then
                TP(game:GetService("ReplicatedStorage"):FindFirstChild("Diablo").HumanoidRootPart.CFrame * CFrame.new(0, 25, 0))
              elseif game:GetService("ReplicatedStorage"):FindFirstChild("Deandre") then
                TP(game:GetService("ReplicatedStorage"):FindFirstChild("Deandre").HumanoidRootPart.CFrame * CFrame.new(0, 25, 0))
              elseif game:GetService("ReplicatedStorage"):FindFirstChild("Urban") then
                TP(game:GetService("ReplicatedStorage"):FindFirstChild("Urban").HumanoidRootPart.CFrame * CFrame.new(0, 25, 0))
              end
            end
          end
        end
      end
    end)
  end
end)



--LocalPkayrs
Tabs.LPlayer:AddButton({
  Title = "Fruits Awakening",
  Description = "",
  Callback = function()
    local args = {
	"AwakeningChanger",
	"Check"
}
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
  end
})


--RaceAwkening
Tabs.RA:AddParagraph({
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
