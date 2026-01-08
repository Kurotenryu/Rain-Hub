_G.IsTweening = false

if game.PlaceId == 2753915549 or game.PlaceId == 85211729168715 then
  FirstSea = true
elseif game.PlaceId == 4442272183  or game.PlaceId == 79091703265657 then
  SecondSea = true
elseif game.PlaceId == 7449423635 or game.PlaceId == 100117331123089 then
  ThirdSea = true
end

local function SetupCharacter(char)
	local hum = char:WaitForChild("Humanoid")
	local hrp = char:WaitForChild("HumanoidRootPart")
	if char:FindFirstChild("Root") then
		char.Root:Destroy()
	end
	local root = Instance.new("Part")
	root.Name = "Root"
	root.Size = Vector3.new(1,1,1)
	root.Transparency = 1
	root.CanCollide = false
	root.Anchored = true
	root.CFrame = hrp.CFrame
	root.Parent = char
end

task.spawn(function()
	game:GetService("Players").LocalPlayer.CharacterAdded:Connect(SetupCharacter)
	if game:GetService("Players").LocalPlayer.Character then
		SetupCharacter(game:GetService("Players").LocalPlayer.Character)
	end
end)

function TP(Pos)
    task.spawn(function()
        local char = game:GetService("Players").LocalPlayer.Character
        if not char then repeat task.wait() until char end

        local hum = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local root = char:FindFirstChild("Root")

        if not hum or not hrp or not root then repeat task.wait() until hum and hrp and root end
        hum.Sit = false
        local dist = (hrp.Position - Pos.Position).Magnitude
        local tween = game:GetService("TweenService"):Create(
            root,
            TweenInfo.new(dist / 350, Enum.EasingStyle.Linear),
            {CFrame = Pos}
        )
			if hum.Health > 0 then
		_G.IsTweening = true	
        tween:Play()
    	tween.Completed:Wait()	
			else
				tween:Cancel()
			end
    end)
end

task.spawn(function()
    while task.wait() do
			if _G.IsTweening then
        local char = game:GetService("Players").LocalPlayer.Character
        if not char then task.wait() end
    	    local hrp = char:FindFirstChild("HumanoidRootPart")
        local root = char:FindFirstChild("Root")

        if hrp and root then
            hrp.CFrame = root.CFrame
        end
			end
    end
end)

function CancelTween()
    if _G.TweenBeta then
        _G.TweenBeta:Cancel()
        _G.TweenBeta = nil
    end

    _G.IsTweening = false
    for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
          if v:IsA("BasePart") or v:IsA("Part") then
            v.CanCollide = true
          end
	end
end

function AutoHaki()
  if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("HasBuso") then
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
  end
end

function EquipTool(ToolSe)
  if game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe) then
    local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe)
    task.wait(0.3)
    game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
  end
end

task.spawn(function()
  while task.wait(1.5) do
    pcall(function()
      if _G.AutoTS then
        _G.IsTweening = true
        local BodyVelocityClip = game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyAntiVelocityClip") or Instance.new("BodyVelocity", game.Players.LocalPlayer.Character.HumanoidRootPart)
        BodyVelocityClip.Name = "BodyAntiVelocityClip"
        BodyVelocityClip.MaxForce = Vector3.new(0, math.huge, 0)
        BodyVelocityClip.Velocity = Vector3.new(0, 0, 0)
        for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
          if v:IsA("BasePart") or v:IsA("Part") then
            v.CanCollide = false
          end
        end
      end
    end)
  end
end)

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
                task.wait(0.05)
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


local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
--Maindev
local Window = Fluent:CreateWindow({
	Title = "Rain Hub | Communuty",
	SubTitle = "discord.com/rainhub",
	TabWidth = 160,
	Size = UDim2.fromOffset(525, 330),
	Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
	Theme = "Dark",
	MinimizeKey = Enum.KeyCode.LeftControl 
})

local Tabs = {
  Shop = Window:AddTab({ Title = "Shops", Icon = ""}),
  Main = Window:AddTab({ Title = "Main", Icon = ""}),
  Farming = Window:AddTab({ Title = "Farming", Icon = ""}),
  Status = Window:AddTab({ Title = "Status", Icon = ""}),
  LP = Window:AddTab({ Title = "Local Player", Icon = ""}),
  FE = Window:AddTab({ Title = "Fruits Event", Icon = ""}),
  RD = Window:AddTab({ Title = "Raids Awakening", Icon = ""}),
  IM = Window:AddTab({ Title = "Items-Materials", Icon= ""}),
  FO = Window:AddTab({Title = "Farms Other", Icon = ""}),
  Offshore = Window:AddTab({ Title = "Offshore", Icon = ""}),
  SE = Window:AddTab({ Title = "Sea Events", Icon = ""}),
  RA = Window:AddTab({ Title = "Race Awakening", Icon = ""}),
  Setting = Window:AddTab({ Title = "Setting", Icon = ""}),
  
}

local Options = Fluent.Options

Fluent:Notify({
    Title = "Rain Hub | Community",
    Content = "Sub Load",
    Duration = 8
})

--TabsShop
Tabs.Shop:AddSection("Styles")
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

--TabMain
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
	
task.spawn(function()
  while task.wait(1.3) do
    if _G.AutoTS then
      pcall(function()
        if ThirdSea then
          for i, v in ipairs(game:GetService("Workspace").Enemies:GetChildren()) do
            if v.Name == "Isle Outlaw" or v.Name == "Island Boy" or v.Name == "Sun-kissed Warrior" or v.Name == "Isle Champion" or v.Name == "Skull Slayer" or v.Name == "Serpent Hunter" then
              if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                repeat
                  task.wait(0.8)
                  TP(v.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))
                  AutoHaki()
                  v.Humanoid.AutoJumpEnabled = false
                  v.Humanoid.JumpPower = false
                  v.Humanoid.UseJumpPower = false
                  v.HumanoidRootPart.CanCollide = false
                  v.HumanoidRootPart.Anchored = true
                  task.wait(0.05 + math.random() * 0.005)
                  AttackNoCoolDown()
                until v.Humanoid.Health <= 0
              end
            end
          end
        else
          game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
        end
      end)
    end
  end
end)

Tabs.Main:AddToggle("ToggleHS", {
  Title = "Holding Sword",
  Default = false
}):OnChanged(function(Value)
  _G.HoldingSword = Value
end)

Tabs.Main:AddToggle("ToggleCF", {
  Title = "Click Fruits",
  Default = false
}):OnChanged(function(Value)
  _G.ClickFruits = Value
end)

Tabs.Main:AddSection("Mastery")
Tabs.Main:AddDropdown("DropdownMethodMastery", {
  Title = "Method Mastery",
  Values = {"Fruits", "Guns"},
  Multi = false,
  Default = 1,
}):OnChanged(function(Value)
  _G.MethodMastery = Value
end)

Tabs.Main:AddSlider("SliderPercentMastery", {
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

Tabs.Main:AddToggle("ToggleAutoMastery", {
  Title = "Auto Mastery",
  Description = "",
  Default = false
}):OnChanged(function(Value)
  _G.AutoMastery = Value
end)

--TabFarm
if ThirdSea then
  local EliteStatus = Tabs.Farming:AddParagraph({
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
  
  Tabs.Farming:AddToggle("ToggleAutoElite", {
    Title = "Auto Elite",
    Default = false
  }):OnChanged(function(Value)
    _G.AutoElite = Value
  end)
  
  Tabs.Farming:AddToggle("ToggleAutoEliteHop", {
    Title = "Auto Elite Hop",
    Default = false
  }):OnChanged(function(Value)
    _G.AutoEliteHop = Value
  end)
  
  Tabs.Farming:AddToggle("TogglePirateRaid", {
    Title = "Pirate Raid",
    Default = false
  }):OnChanged(function(Value)
    _G.PirateRaid = Value
  end)
end

if SecondSea then
  Tabs.Farming:AddToggle("ToggleCore", {
    Title = "Auto Core",
    Default = false
  }):OnChanged(function(Value)
    _G.AutoCore = Value
  end)
end

if ThirdSea then
  local DoughKingStatus = Tabs.Farming:AddParagraph({
    Title = "Dough King: ",
    Content = ""
  })
  
  task.spawn(function()
    pcall(function()
      while task.wait() do
        if game:GetService("ReplicatedStorage"):FindFirstChild("Dough King") or game:GetService("Workspace").Enemies:FindFirstChild("Dough King") then
          DoughKingStatus:SetTitle("Dough King: 🟢")
        else
          DoughKingStatus:SetTitle("Dough King: 🔴")
        end
      end
    end)
  end)

  Tabs.Farming:AddToggle("ToggleAutoDoughKing", {
    Title = "Auto Dough King",
    Default = false
  }):OnChanged(function(Value)
    _G.AutoDoughKing = Value
  end)

Tabs.Farming:AddToggle("ToggleAutoDoughKingHop", {
    Title = "Auto Dough King Hop",
    Default = false
  }):OnChanged(function(Value)
    _G.AutoDoughKingHop = Value
  end)
	
  
  local RipIndraStatus = Tabs.Farming:AddParagraph({
    Title = "rip_indra True Form: ",
    Content = ""
  })
  
  task.spawn(function()
    pcall(function()
      while task.wait() do
        if game:GetService("ReplicatedStorage"):FindFirstChild("rip_indra True Form") or game:GetService("Workspace").Enemies:FindFirstChild("rip_indra True Form") then
          RipIndraStatus:SetTitle("rip_indra True Form: 🟢")
        else
          RipIndraStatus:SetTitle("rip_indra True Form: 🔴")
        end
      end
    end)
  end)

Tabs.Farming:AddToggle("ToggleEPB", {
    Title = "Equip To Press The Buttons",
    Default = false
  }):OnChanged(function(Value)
    _G.AutoEPB = Value
  end)	
  
  Tabs.Farming:AddToggle("ToggleSpawnRip", {
    Title = "Auto Spawn rip_indra True Form",
    Default = false
  }):OnChanged(function(Value)
    _G.SpawnRip = Value
  end)
  
  Tabs.Farming:AddToggle("ToggleAutoRip", {
    Title = "Auto rip_indra True Form",
    Default = false
  }):OnChanged(function(Value)
    _G.AutoRip = Value
  end)
  
  Tabs.Farming:AddToggle("ToggleAutoRipHop", {
    Title = "Auto rip_indra True Form Hop",
    Default = false
  }):OnChanged(function(Value)
    _G.AutoRipHop = Value
  end)
end

if SecondSea then
  local DarkbeardStatus = Tabs.Farming:AddParagraph({
    Title = "Darkbeard: ",
    Content = ""
  })
  
  task.spawn(function()
    pcall(function()
      while task.wait() do
        if game:GetService("ReplicatedStorage"):FindFirstChild("Darkbeard") or game:GetService("Workspace").Enemies:FindFirstChild("Darkbeard") then
          DarkbeardStatus:SetTitle("Darkbeard: 🟢")
        else
          DarkbeardStatus:SetTitle("Darkbeard: 🔴")
        end
      end
    end)
  end)
  Tabs.Farming:AddToggle("ToggleSpawmDark", {
    Title = "Auto Spawn Darkbeard",
    Default = false
  }):OnChanged(function(Value)
    _G.SpawnDarkbeard = Value
  end)
  
  Tabs.Farming:AddToggle("ToggleAutoDark", {
    Title = "Auto Darkbeard",
    Default = false
  }):OnChanged(function(Value)
    _G.AutoDarkbeard = Value
  end)
  
  Tabs.Farming:AddToggle("ToggleDarkHop", {
    Title = "Auto Darkbeard Hop",
    Default = false
  }):OnChanged(function(Value)
    _G.AutoDarkbeardHop = Value
  end)
  
  local CursedCaptainStatus = Tabs.Farming:AddParagraph({
    Title = "Cursed Captain: ",
    Content = ""
  })
  
  task.spawn(function()
    pcall(function()
      while task.wait() do
        if game:GetService("ReplicatedStorage"):FindFirstChild("Cursed Captain") or game:GetService("Workspace").Enemies:FindFirstChild("Cursed Captain") then
          CursedCaptainStatus:SetTitle("Cursed Captain: 🟢")
        else
          CursedCaptainStatus:SetTitle("Cursed Captain: 🔴")
        end
      end
    end)
  end)
  
  Tabs.Farming:AddToggle("ToggleAutoCC", {
    Title = "Auto Cursed Captain",
    Default = false
  }):OnChanged(function(Value)
    _G.AutoCursedCaptain = Value
  end)
  
  Tabs.Farming:AddToggle("ToggleAutoCCH", {
    Title = "Auto Cursed Captain Hop",
    Default = false
  }):OnChanged(function(Value)
    _G.AutoCursedCaptainHop = Value
  end)
end

if ThirdSea then
  local SoulReaperStatus = Tabs.Farming:AddParagraph({
    Title = "Soul Reaper: ",
    Content = ""
  })
  
  task.spawn(function()
    while task.wait() do
      pcall(function()
        if game:GetService("ReplicatedStorage"):FindFirstChild("Soul Reaper") or game:GetService("Workspace").Enemies:FindFirstChild("Soul Reaper") then
          SoulReaperStatus:SetTitle("Soul Reaper: 🟢")
        else
          SoulReaperStatus:SetTitle("Soul Reaper: 🔴")
        end
      end)
    end
  end)
  
  Tabs.Farming:AddToggle("ToggleAutoSpawnSR", {
    Title = "Auto Spawn Soul Reaper",
    Default = false
  }):OnChanged(function(Value)
    _G.AutoSpawnSoulReaper = Value
  end)
  
  Tabs.Farming:AddToggle("ToggleAutoSR", {
    Title = "Auto Soul Reaper",
    Default = false
  }):OnChanged(function(Value)
    _G.AutoSoulReaper = Value
  end)

	Tabs.Farming:AddToggle("ToggleAutoSR", {
    Title = "Auto Soul Reaper Hop",
    Default = false
  }):OnChanged(function(Value)
    _G.AutoSoulReaperHop = Value
  end)
end

--TabStatus
local ServerRunTimePara = Tabs.Status:AddParagraph({
    Title = "Timer: 00 H-00 M-00 S",
    Content = ""
})

local function UpdateServerRuntime()
    local GameTime = math.floor(workspace.DistributedGameTime + 0.5)

    local Hour = math.floor(GameTime / (60^2)) % 24
    local Minute = math.floor(GameTime / 60) % 60
    local Second = GameTime % 60

    ServerRunTimePara:SetTitle(
        "Timer: " ..
        string.format("%02d h %02d m %02d s", Hour, Minute, Second)
    )
end

task.spawn(function()
    while task.wait() do
        pcall(UpdateServerRuntime)
    end
end)

local CountdownPara = Tabs.Status:AddParagraph({
	Title = "CountDown: ",
	Content = ""
})

task.spawn(function()
    while task.wait() do
		local textLabel = workspace.Countdown.SurfaceGui.TextLabel	
        if textLabel and textLabel.Parent then
            CountdownPara:SetTitle("Countdown: " .. tostring(textLabel.Text))
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

task.spawn(function()
  while task.wait() do
    pcall(function()
      if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("InfoLeviathan","1") == -1 then
        SpyStatus:SetTitle("Bribery Information: " .. "I don't know anything yet")
      elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("InfoLeviathan","1") == 5 then
        SpyStatus:SetTitle("Bribery Information: " .. "The Leviathan is out there")
      elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("InfoLeviathan","1") == -2 then
        SpyStatus:SetTitle("Bribery Information: " .. "I heard it's been a bit chilly outside")
      end
    end)
  end
end)

Tabs.Status:AddParagraph({
  Title = "PlaceId: " .. tostring(game.PlaceId),
  Content = ""
})

local InputJoin = Tabs.Status:AddInput("InputJoinServer", {
  Title = "Input Join Server",
  Default = "",
  Placeholder = "",
  Numeric = false, 
  Finished = false,
  Callback = function(Value)
    _G.InputJoin =Value
  end
})

Tabs.Status:AddButton({
  Title = "Delete Jobid",
  Description = "",
  Callback = function()
    _G.InputJoin = ""
    InputJoin:SetValue("")
  end
})

Tabs.Status:AddButton({
  Title = "Join JobId",
  Description = "",
  Callback = function()
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, _G.InputJoin, game:GetService("Players").LocalPlayer)
  end
})

Tabs.Status:AddButton({
  Title = "Copy JobId",
  Description = "",
  Callback = function()
    setclipboard(tostring(game.JobId))
  end
})

function Hop()
  local HttpService = game:GetService("HttpService")
  local TeleportService = game:GetService("TeleportService")
  local Players = game:GetService("Players")
  local PlaceID = game.PlaceId
  local VisitedServers = {}
  local Cursor = nil
  local LastHour = os.date("!*t").hour
  local function ResetIfNewHour()
    local hour = os.date("!*t").hour
    if hour ~= LastHour then
      VisitedServers = {}
      LastHour = hour
    end
  end
  
  local function GetServer()
    local url = "https://games.roblox.com/v1/games/" .. PlaceID .. "/servers/Public?limit=100"
    if Cursor then
      url = url .. "&cursor=" .. Cursor
    end
    
    local data = HttpService:JSONDecode(game:HttpGet(url))
    Cursor = data.nextPageCursor
    for _, server in pairs(data.data) do
      if server.playing < server.maxPlayers and not VisitedServers[server.id] then
        return server.id
      end
    end
  end
  
  task.spawn(function()
    while task.wait(0.5) do
      pcall(function()
        ResetIfNewHour()
        local ServerID = GetServer()
        if ServerID then
          VisitedServers[ServerID] = true
          task.wait(1)
          TeleportService:TeleportToPlaceInstance(PlaceID, ServerID, Players.LocalPlayer)
        end
      end)
    end
  end)
end

Tabs.Status:AddButton({
  Title = "Hop Server",
  Description = "",
  Callback = function()
    Hop()
  end
})

--TabLocalPlayer
Tabs.LP:AddButton({
  Title = "Cancel Tween",
  Description = "",
  Callback = function()
         CancelTween()
  end    
    })
Tabs.LP:AddButton({
  Title = "Shift First Sea",
  Description = "",
  Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain")
  end
})

Tabs.LP:AddButton({
  Title = "Shift Seacond Sea",
  Description = "",
  Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
  end
})

Tabs.LP:AddButton({
  Title = "Shift Third Sea",
  Description = "",
  Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
  end
})

Tabs.LP:AddButton({
  Title = "Open Titles Specialist",
  Description = "",
  Callback = function()
    game:GetService("Players").LocalPlayer.PlayerGui.Main.Titles.Visible = true
  end
})

Tabs.LP:AddButton({
  Title = "Open Awakenings Expert",
  Description = "",
  Callback = function()
    game:GetService("Players").LocalPlayer.PlayerGui.Main.AwakeningToggler.Visible = true
  end
})

Tabs.LP:AddDropdown("DropdownSelectTeams", {
  Title = "Select Teams",
  Values = {"Pirates","Marines"},
  Multi = false,
  Default = 1,
}):OnChanged(function(Value)
  _G.SelectTeams = Value
local CommF = game:GetService("ReplicatedStorage").Remotes.CommF_
 if Value == "Pirates" then
    CommF:InvokeServer("SetTeam", "Pirates")
 elseif Value == "Marines" then
    CommF:InvokeServer("SetTeam", "Marines")
 end
end)

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
		}
elseif SecondSea then
		IslandList = {
			"Green Zone",
			"KingDon Of Rose1",
			"KingDon Of Rose2",
			"The Cafe",
			"Don Swan Mansion",
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
			
		}
elseif ThirdSea then
		IslandList = {
			"Port Town",
			"Hydra Island1",
			"Hydra Island2",
			"Dragon Dojo",
			"Castle on the Sea",
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
		}
end

Tabs.LP:AddDropdown("DropdownSelectIsland", {
  Title = "Select Island",
  Values = IslandList,
  Multi = false,
  Default = 1,
}):OnChanged(function(Value)
  _G.SelectIsland = Value
end)
											
Tabs.LP:AddToggle("ToggleTweenIsland", {
  Title = "Tween Island",
  Default = false
}):OnChanged(function(Value)
  _G.TweenIsland = Value
end)											

task.spawn(function()
		while task.wait(1) do
    pcall(function()
      if _G.TweenIsland then
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
          elseif _G.SelectIsland == "Castle on the Sea" then
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
        end
      end)
    end
end)											

Tabs.LP:AddButton({
		Title = "Open Blox Fruits Deal",
		Description= "",
		Callback = function()
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits")
	        game:GetService("Players").LocalPlayer.PlayerGui.Main.FruitShop.Visible = true
		end
})

--TabFruitsRaid
local FruitsStatus = Tabs.FE:AddParagraph({
  Title = "Fruits: ",
  Content = ""
})

task.spawn(function()
  while task.wait() do
    pcall(function()
      FruitsStatus:SetTitle("Fruits:" .. tostring(game:GetService("Players").LocalPlayer.Data.DevilFruit.Value))
    end)
  end
end)

Tabs.FE:AddToggle("TogglePickFruits", {
  Title = "Picked Fruits",
  Default = false
}):OnChanged(function(Value)
  _G.PickedFruits = Value
end)

Tabs.FE:AddToggle("TogglePFH", {
  Title = "Picked Fruits Hop",
  Default = false
}):OnChanged(function(Value)
  _G.PickedFruitsHop = Value
end)

Tabs.FE:AddToggle("ToggleAutoGachaFruits", {
  Title = "Auto Gacha Fruits",
  Default = false
}):OnChanged(function(Value)
  _G.AutoGachaFruits = Value
end)

task.spawn(function()
	while task.wait(0.5) do
		if _G.AutoGachaFruits then
			pcall(function()
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin", "Buy")
			end)
		end
	end
end)

Tabs.FE:AddToggle("ToggleAutoGachaEvent", {
	Title = "Auto Gacha Candy",
	Default = false
}):OnChanged(function(Value)
	_G.AutoGachaEvent = Value
end)	

task.spawn(function()
	while task.wait(0.5) do
		if _G.AutoGachaEvent then
			pcall(function()
				local args = {
	"Cousin",
	"F2PXmasWeek2Gacha25"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
				end)
		end
	end
end)
						

Tabs.FE:AddToggle("ToggleAutoStoreFruits", {
  Title = "Auto Store Fruits",
  Default = false
}):OnChanged(function(Value)
  _G.AutoStoreFruits = Value
end)

spawn(function()
	while task.wait(1.5) do
		if _G.AutoStoreFruits then
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local Backpack = LP:WaitForChild("Backpack")
local CommF = game.ReplicatedStorage.Remotes.CommF_
local MAX_TRY = 3
local tried = {}

Backpack.ChildAdded:Connect(function(tool)
	if not (tool:IsA("Tool") and string.match(tool.Name, " Fruit$")) then return end

	local fruitName = tool.Name:gsub(" Fruit", "")
	tried[fruitName] = 0

	while tried[fruitName] < MAX_TRY do
		tried[fruitName] += 1
		pcall(function()
			CommF:InvokeServer(
				"StoreFruit",
				fruitName .. "-" .. fruitName,
				tool
			)
		end)
		task.wait(1.5)
	end
end)
     	end
	end
end)

Tabs.FE:AddToggle("ToggleAutoStoreHoliday", {
  Title = "Auto Store Holiday",
  Default = false
}):OnChanged(function(Value)
  _G.AutoStoreHoliday = Value
end)

task.spawn(function()
	while task.wait() do
		if _G.AutoStoreHoliday then
				pcall(function()
					local args = {"StoreHolidayGift"}
						game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
				end)
		end
	end
end)
						

local Remote_GetFruits = game.ReplicatedStorage:FindFirstChild("Remotes").CommF_:InvokeServer("GetFruits")
local Table_DevilFruitSniper = {}
local ShopDevilSell = {}
for i, v in next, Remote_GetFruits do
    table.insert(Table_DevilFruitSniper, v.Name)
    if v.OnSale then 
        table.insert(ShopDevilSell, v.Name)
    end
end
Tabs.FE:AddDropdown("DropdownSelectBFD", {
  Title = "Select Blox Fruit Dealer",
  Values = Table_DevilFruitSniper,
  Multi = false,
  Default = 1,
}):OnChanged(function(Value)
  _G.SelectBloxFruitDealer = Value
end)

Tabs.FE:AddToggle("ToggleBuyBFD", {
  Title = "Buy Blox Fruit Dealer",
  Default = false
}):OnChanged(function(Value)
  _G.BuyBloxFruitDealer = Value
end)

task.spawn(function()
  while task.wait() do
    pcall(function()
      if _G.BuyBloxFruitDealer then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits")
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PurchaseRawFruit", _G.SelectBloxFruitDealer, false)
      end
    end)
  end
end)
--Raid
Tabs.RD:AddSection("Raids")
Tabs.RD:AddDropdown("DropdownSelectMapRaids", {
  Title = "Select Map Raids",
  Values = {"Flame","Ice","Quake","Light","Dark","Spider","Magma","Buddha","Sand","Phoenix","Dough"},
  Multi = false,
  Default = 1,
}):OnChanged(function(Value)
  _G.SelectMapRaids = Value
end)

Tabs.RD:AddToggle("ToggleAutoRaids", {
  Title = "Auto Raids",
  Default = false
}):OnChanged(function(Value)
  _G.AutoRaids = Value
end)

Tabs.RD:AddToggle("ToggleTFFTW", {
  Title = "Take Fruits From The Warehouse",
  Default = false
}):OnChanged(function(Value)
  _G.TFTW = Value
end)

Tabs.RD:AddToggle("ToggleAutoRaidHop", {
  Title = "Auto Raids Hop",
  Default = false
}):OnChanged(function(Value)
  _G.AutoRaidsHop = Value
end)

Tabs.RD:AddToggle("ToggleAutoAwakeninhFruits", {
  Title = "Auto Awakening Fruits",
  Default = false
}):OnChanged(function(Value)
  _G.AwakeningFruits = Value
end)

Tabs.RD:AddSection("Raids Mutis")
local SelectPlayer = {}
for _, v in pairs(game:GetService("Players"):GetChildren()) do
    if v ~= game:GetService("Players").LocalPlayer then
        table.insert(SelectPlayer, v.Name)
    end
end
Tabs.RD:AddDropdown("DropdownSelectHelpsRaid", {
  Title = "Select Helps Raid",
  Values = SelectPlayer,
  Multi = false,
  Default = nil,
}):OnChanged(function(Value)
  _G.SelectHelpRaids = Value
end)

Tabs.RD:AddToggle("ToggleChipBuyAccount", {
  Title = "Chip Buy Account",
  Default = false
}):OnChanged(function(Value)
  _G.ChipBuyAccount = Value
end)

Tabs.RD:AddToggle("ToggleAFR", {
  Title = "Account Follow Raid",
  Default = false
}):OnChanged(function(Value)
  _G.AccountFollow = Value
end)

Tabs.RD:AddToggle("ToggleAMR", {
  Title = "Account Muti Raids",
  Default = false
}):OnChanged(function(Value)
  _G.AccountMutiRaids = Value
end)

Tabs.RD:AddSection("Dungeons")
Tabs.RD:AddDropdown("DropdownSelectDifficulty", {
  Title = "Select Difficulty",
  Values = {"Normal","Hard","Challenge"},
  Multi = false,
  Default = nil,
}):OnChanged(function(Value)
  _G.SelectDifficulty = Value
end)

Tabs.RD:AddDropdown("DropdownSelectPlayerDungeon", {
  Title = "Select Player Dungeon",
  Values = SelectPlayer,
  Multi = false,
  Default = nil,
}):OnChanged(function(Value)
  _G.SelectPlayerDungeons = Value
end)

Tabs.RD:AddToggle("ToggleAutoJoinDifficulty", {
  Title = "Auto Join Difficulty",
  Default = false
}):OnChanged(function(Value)
  _G.AutoDungeonDifficulty = Value
end)

Tabs.RD:AddToggle("ToggleAutoDungeonOtherPlayer", {
  Title = "Auto Dungeon With Other Player",
  Default = false
}):OnChanged(function(Value)
  _G.AutoDungeonOtherPlayer = Value
end)

Tabs.RD:AddToggle("ToggleAutoDungeons", {
  Title = "Auto Dungeons",
  Default = false
}):OnChanged(function(Value)
  _G.AutoDungeons = Value
end)

--TabItemsMateriry
Tabs.IM:AddSection("Materials")
Tabs.IM:AddDropdown("DropdownSelectMaterials", {
  Title = "Select Materials",
  Values = {"Angel Wings","Leather","Scrap Metal","Yeti Fur","Fish Tail","Ectoplasm","Radioactive Material","Vampire Fang","Mystic Droplet","Magma Ore","Meteorite","Wooden Plank","Blaze Ember","Gunpowder","Dragon Scale","Volt Capsule","Conjured Cocoa","Mini Tusk"},
  Multi = false,
  Default = 1,
}):OnChanged(function(Value)
  _G.SelectMaterials = Value
end)

Tabs.IM:AddToggle("ToggleAutoMaterials", {
  Title = "Auto Materials",
  Default = false
}):OnChanged(function(Value)
  _G.AutoMaterials = Value
end)

--FarmOther
Tabs.FO:AddToggle("ToggleTradeBone", {
  Title = "Auto Trade Bones", 
  Default = false
}):OnChanged(function(Value)
  _G.TradeBones = Value
end)

local SavedCFrame = nil
Tabs.FO:AddButton({
  Title = "Save Cordinates",
  Description = "",
  Callback = function()
    local char = game:GetService("Players").LocalPlayer.Character
    local hrp = char:FindFirstChild("HumanoidRootPart")
    SavedCFrame = hrp.CFrame
  end
})

Tabs.FO:AddDropdown("DropdownSelectBaits", {
  Title = "Select Baits",
  Values = {"Basic Bait","Kelp Bait","Good Bait","Abyssal Bait","Frozen Bait","Epic Bait","Carnivore Bait"},
  Multi = false,
  Default = 1,
}):OnChanged(function(Value)
  _G.SelectBait = Value
end)

Tabs.FO:AddToggle("ToggleAcceptAngler", {
  Title = "Auto Accept Angler", 
  Default = false
}):OnChanged(function(Value)
  _G.AutoAcceptAngler = Value
end)

Tabs.FO:AddToggle("ToggleBuyBait", {
  Title = "Auto Buy Baits", 
  Default = false
}):OnChanged(function(Value)
  _G.AutoBuyBait = Value
end)

Tabs.FO:AddToggle("ToggleFarmChest", {
  Title = "Auto Farm Chest", 
  Default = false
}):OnChanged(function(Value)
  _G.AutoFarmChest = Value
end)

Tabs.FO:AddToggle("ToggleFarmChestHop", {
  Title = "Auto Farm Chest Hop", 
  Default = false
}):OnChanged(function(Value)
  _G.AutoFarmChestHop = Value
end)
--SeaEvent
Tabs.SE:AddDropdown("DropdownSelectSeaDangerLevel", {
  Title = "Select Sea Danger Level",
  Values = {"Sea Danger Level 1","Sea Danger Level 2","Sea Danger Level 3","Sea Danger Level 4","Sea Danger Level 5","Sea Danger Level 6"},
  Multi = false,
  Default = 6,
}):OnChanged(function(Value)
  _G.SelectSeaDanger = Value
	end)
	
Tabs.SE:AddDropdown("DropdownSelectBoat", {
  Title = "Select Boat",
  Values = {"Dinghy","Sloop","Brigade","Grand Brigade","Miracle","The Sentinel","Guardian","Lantern","Sleigh","Beast Hunter"},
  Multi = false,
  Default = 7,
}):OnChanged(function(Value)
  _G.SelectBoat = Value
		end)

local SeaEventList = {}
if SecondSea then
  SeaEventList = {
    "Piranha",
    "Ship Raid",
    "Shark",
    "Sea Beast",
  }
elseif ThirdSea then
  SeaEventList = {
    "Piranhaa",
    "Ship Raid",
    "Sea Beast",
    "Terrorshark",
    "Haunted Ship Raid",
  }
end

Tabs.SE:AddDropdown("DropdownSelectSeaEvent", {
  Title = "Select Sea Events",
  Values = SeaEventList,
  Multi = true,
  Default = {},
}):OnChanged(function(Value)
  _G.SelectSeaEvents = Value
	end)

Tabs.SE:AddToggle("ToggleAutoDodgeSeaBeast", {
  Title = "Auto Dodge Skill Sea Beast",
  Default = false
}):OnChanged(function(Value)
  _G.AutoDodgeSeaBeast = Value
end)


Tabs.SE:AddToggle("ToggleAutoDodgeTerrorshark", {
  Title = "Auto Dodge Skill Terrorshark",
  Default = false
}):OnChanged(function(Value)
  _G.AutoDodgeTerrorshark = Value
end)

Tabs.SE:AddToggle("ToggleAutoMoveAwayRoughSea", {
  Title = "Auto Move Away From Rough Sea",
  Default = false
}):OnChanged(function(Value)
  _G.AutoMoveAwayRoughSea = Value
end)

Tabs.SE:AddDropdown("DropdownSelectPlayerSeaEvent", {
  Title = "Select Player Go Sea Event",
  Values = SelectPlayer,
  Multi = false,
  Default = nil,
}):OnChanged(function(Value)
  _G.SelectPlayerGoSeaEvent = Value
	end)

Tabs.SE:AddToggle("ToggleAutoSeaEventWOP", {
  Title = "Auto Sea Event With Other Players",
  Default = false
}):OnChanged(function(Value)
  _G.AutoSeaEventWOP = Value
end)

Tabs.SE:AddToggle("ToggleAutoRepairBoat", {
  Title = "Auto Repair Boat",
  Default = false
}):OnChanged(function(Value)
  _G.AutoRepairBoat = Value
end)

Tabs.SE:AddToggle("ToggleAutoSeaEvent", {
  Title = "Auto Sea Events",
  Default = false
}):OnChanged(function(Value)
  _G.AutoSeaEvent = Value
end)

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
