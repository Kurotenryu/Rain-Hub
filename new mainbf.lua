if game.PlaceId == 2753915549 or game.PlaceId == 85211729168715 then
  FirstSea = true
elseif game.PlaceId == 4442272183  or game.PlaceId == 79091703265657 then
  SecondSea = true
elseif game.PlaceId == 7449423635 or game.PlaceId == 100117331123089 then
  ThirdSea = true
end

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

local Tabs = {
  Shop = Window:AddTab({ Title = "Shops", Icon = ""}),
  Main = Window:AddTab({ Title = "Main", Icon = ""}),
  Farming = Window:AddTab({ Title = "Farming", Icon = ""}),
  Status = Window:AddTab({ Title = "Status", Icon = ""}),
  LP = Window:AddTab({ Title = "Local Player", Icon = ""}),
  FR = Window:AddTab({ Title = "Fruits-Raids", Icon = ""}),
  IM = Window:AddTab({ Title = "Items-Materials", Icon= ""}),
  FO = Window:AddTab({Title = "Farms Othor", Icon = ""}),
  Offshore = Window:AddTab({ Title = "Offshore", Icon = ""}),
  SE = Window:AddTab({ Title = "Sea Events", Icon = ""}),
  RA = Window:AddTab({ Title = "Race Awakening", Icon = ""}),
  Setting = WindowTab({ Title = "Setting", Icon = ""}),
  
}

local Options = Fluent.Options

Fluent:Notify({
    Title = "Rain Hub | Community",
    Content = "Sub Load",
    Duration = 8
})

--TabsShop
Tabs.Shop:AddSection("F.Styles")
Tabs.Shop:AddToggle("MyToggle", {
  Title = "Tween Buy Superhuman", 
  Default = false
}):OnChanged(function(Value)
  _G.BuySuperhuman = Value
end

Tabs.Shop:AddToggle("MyToggle", {
  Title = "Tween Buy Death Step", 
  Default = false
}):OnChanged(function(Value)
  _G.BuyDeathStep = Value
end

Tabs.Shop:AddToggle("MyToggle", {
  Title = "Tween Buy Sharkman Karate", 
  Default = false
}):OnChanged(function(Value)
  _G.BuySharkmanKarate = Value
end

Tabs.Shop:AddToggle("MyToggle", {
  Title = "Tween Buy Electric Claw", 
  Default = false
}):OnChanged(function(Value)
  _G.BuyElectricClaw = Value
end

Tabs.Shop:AddToggle("MyToggle", {
  Title = "Tween Buy DragonTalon", 
  Default = false
}):OnChanged(function(Value)
  _G.BuyDragonTalon = Value
end

Tabs.Shop:AddToggle("MyToggle", {
  Title = "Tween Buy Godhuman", 
  Default = false
}):OnChanged(function(Value)
  _G.BuyGodhuman = Value
end

Tabs.Shop:AddToggle("MyToggle", {
  Title = "Tween Buy Sanguine Art", 
  Default = false
}):OnChanged(function(Value)
  _G.BuySanguineArt = Value
end
--TabMain
Tabs.Main:AddSection("Farms")
Tabs.Main:AddToggle("MyToggle", {
  Title = "Auto Level",
  Default = false
}):OnChanged(function(Value)
  _G.AutoLevel = Value
end)

Tabs.Main:AddToggle("MyToggle", {
  Title = "Auto Dismiss Cake Prince",
  Default = false
}):OnChanged(function(Value)
  _G.AutoDismissCakePrince = Value
end)

Tabs.Main:AddToggle("MyToggle", {
  Title = "Auto Cake Prince",
  Default = false
}):OnChanged(function(Value)
  _G.AutoCakePrince = Value
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

Tabs.Main:AddToggle("MyToggle", {
  Title = "Auto Dismiss Tyrant of the Skies",
  Default = false
}):OnChanged(function(Value)
  _G.AutoDismissTS = Value
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
  
  Tabs.Farming:AddToggle("MyToggle", {
    Title = "Auto Elite",
    Default = false
  }):OnChanged(function()
    _G.AutoElite = Value
  end)
  
  Tabs.Farming:AddToggle("MyToggle", {
    Title = "Auto Elite Hop",
    Default = false
  }):OnChanged(function()
    _G.AutoEliteHop = Value
  end)
  
  Tabs.Farming:AddToggle("MyToggle", {
    Title = "Pirate Raid",
    Default = false
  }):OnChanged(function()
    _G.PirateRaid = Value
  end)
end

if SecondSea then
  Tabs.Farming:AddToggle("MyToggle", {
    Title = "Auto Core",
    Default = false
  }):OnChanged(function()
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
  
  Tabs.Farming:AddToggle("MyToggle", {
    Title = "Equip To Press The Buttons",
    Default = false
  }):OnChanged(function()
    _G.AutoEPB = Value
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
  
  Tabs.Farming:AddToggle("MyToggle", {
    Title = "Auto Spawn rip_indra True Form",
    Default = false
  }):OnChanged(function()
    _G.SpawnRip = Value
  end)
  
  Tabs.Farming:AddToggle("MyToggle", {
    Title = "Auto rip_indra True Form",
    Default = false
  }):OnChanged(function()
    _G.AutoRip = Value
  end)
  
  Tabs.Farming:AddToggle("MyToggle", {
    Title = "Auto rip_indra True Form Hop",
    Default = false
  }):OnChanged(function()
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
  Tabs.Farming:AddToggle("MyToggle", {
    Title = "Auto Spawn Darkbeard",
    Default = false
  }):OnChanged(function()
    _G.SpawnDarkbeard = Value
  end)
  
  Tabs.Farming:AddToggle("MyToggle", {
    Title = "Auto Darkbeard",
    Default = false
  }):OnChanged(function()
    _G.AutoDarkbeard = Value
  end)
  
  Tabs.Farming:AddToggle("MyToggle", {
    Title = "Auto Darkbeard Hop",
    Default = false
  }):OnChanged(function()
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
  
  Tabs.Farming:AddToggle("MyToggle", {
    Title = "Auto Cursed Captain",
    Default = false
  }):OnChanged(function()
    _G.AutoCursedCaptain = Value
  end)
  
  Tabs.Farming:AddToggle("MyToggle", {
    Title = "Auto Cursed Captain Hop",
    Default = false
  }):OnChanged(function()
    _G.AutoCursedCaptainHop = Value
  end)
end

if ThirdSea then
  local SoulReaperStatus = Tabs.Farming:AddParagraph({
    Title = "Soul Reaper: ",
    Content = ""
  })
  
  task.spawn(function()
    pcall(function()
      while task.wait() do
        if game:GetService("ReplicatedStorage"):FindFirstChild("Soul Reaper") or game:GetService("Workspace").Enemies:FindFirstChild("Soul Reaper") then
          SoulReaperStatus:SetTitle("Soul Reaper: 🟢")
        else
          SoulReaperStatus:SetTitle("Soul Reaper: 🔴")
        end
      end
    end)
  end)
  
  Tabs.Farming:AddToggle("MyToggle", {
    Title = "Auto Spawn Soul Reaper",
    Default = false
  }):OnChanged(function()
    _G.AutoSpawnSoulReaper = Value
  end)
  
  Tabs.Farming:AddToggle("MyToggle", {
    Title = "Auto Soul Reaper",
    Default = false
  }):OnChanged(function()
    _G.AutoSoulReaper = Value
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

Tabs.Status:AddParagraph({
  Title = "PlaceId: " .. tostring(game.PlaceId),
  Content = ""
})

local InputJoin = Tabs.Status:AddInput("Input", {
  Title = "Input Join Server",
  Default = "",
  Placeholder = "",
  Numeric = false, 
  Finished = false,
  Callback = function(Value)
    _G.InputJoin=Value
  end
})

Tabs.Status:AddButton({
  Title = "Delete Jobid",
  Description = "",
  Callback = function()
    _G.DeleteJobid = Value
  end
})

Tabs.Status:AddButton({
  Title = "Join JobId",
  Description = "",
  Callback = function()
    _G.JoinJobId = Value
  end
})

Tabs.Status:AddButton({
  Title = "Copy JobId",
  Description = "",
  Callback = function()
    setclipboard(tostring(game.JobId))
  end
})

Tabs.Status:AddButton({
  Title = "Hop Server",
  Description = "",
  Callback = function()
    _G.HopServer = Value
  end
})

--TabLocalPlayer
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

local NPCList = {}
for i, v in ipairs(game:GetService("ReplicatedStorage").NPCs:GetChildren) do
  if v:IsA("Model") and v:FindFirstChild("Humnanoid") then
    table.insert(NPCList, v.Name)
  end
end
Tabs.LP:AddDropdown("Dropdown", {
  Title = "Select NPC",
  Values = NPCList,
  Multi = false,
  Default = 1,
}):OnChanged(function(Value)
  _G.SelectNPC = Value
end)

Tabs.LP:AddToggle("MyToggle", {
  Title = "Tween NPC",
  Default = false
}):OnChanged(function()
  _G.TweenNPC = Value
end)

local IslandList = {}
for i, v ipairs(game:GetService.workspace.Map:GetChildren()) do
  if v:IsA("Model") then
    table.insert(IslandList, v.Name)
  end
end

Tabs.LP:AddDropdown("Dropdown", {
  Title = "Select Island",
  Values = IslandList,
  Multi = false,
  Default = 1,
}):OnChanged(function(Value)
  _G.SelectIsland = Value
end

Tabs.LP:AddToggle("MyToggle", {
  Title = "Tween Island",
  Default = false
}):OnChanged(function()
  _G.TweenIsland = Value
end)
--TabFruitsRaid
local FruitsStatus = Tabs.RF:AddParagraph({
  Title = "Fruits: ",
  Content = ""
})

task.spawn(function()
  while task.wait() do
    pcall(function()
      FruitsStatus:SetTitle("Fruits:" .. tostring(game.Players.LocalPlayer.Data.DevilFruit.Value))
    end)
  end
end)

Tabs.FR:AddButton({
  Title = "Open Blox Fruit Dealer",
  Description = "",
  Callback = function()
    _G.OpenBlox = Value
  end
})
  
Tabs.FR:AddButton({
  Title = "Open Advanced Fruit Dealer",
  Description = "Can't Buy",
  Callback = function()
    _G.OpenAdvanced = Value
  end
})

Tabs.FR:AddToggle("MyToggle", {
  Title = "Picked Fruits",
  Default = false
}):OnChanged(function()
  _G.PickedFruits = Value
end)

Tabs.FR:AddToggle("MyToggle", {
  Title = "Picked Fruits Hop",
  Default = false
}):OnChanged(function()
  _G.PickedFruitsHop = Value
end)

Tabs.FR:AddToggle("MyToggle", {
  Title = "Auto Gacha Fruits",
  Default = false
}):OnChanged(function()
  _G.AutoGachaFruits = Value
end)

Tabs.FR:AddToggle("MyToggle", {
  Title = "Auto Store Fruits",
  Default = false
}):OnChanged(function()
  _G.AutoStoreFruits = Value
end)

Tabs.FR:AddDropdown("Dropdown", {
  Title = "Select Blox Fruit Dealer",
  Values = ,
  Multi = false,
  Default = 1,
}):OnChanged(function(Value)
  _G.SelectBloxFruitDealer = Value
end

Tabs.FR:AddToggle("MyToggle", {
  Title = "Buy Blox Fruit Dealer",
  Default = false
}):OnChanged(function()
  _G.BuyBloxFruitDealer = Value
end)

Tabs.FR:AddDropdown("Dropdown", {
  Title = "Select Advanced Fruit Dealer",
  Values = ,
  Multi = false,
  Default = 1,
}):OnChanged(function(Value)
  _G.SelectAdvancedFruitDealer = Value
end

Tabs.FR:AddToggle("MyToggle", {
  Title = "Buy Blox Fruit Dealer",
  Default = false
}):OnChanged(function()
  _G.BuyAdvancedFruitDealer = Value
end)

Tabs.FR:AddSection("Raids")
Tabs.FR:AddDropdown("Dropdown", {
  Title = "Select Map Raids",
  Values = ,
  Multi = false,
  Default = 1,
}):OnChanged(function(Value)
  _G.SelectMapRaids = Value
end

Tabs.FR:AddToggle("MyToggle", {
  Title = "Auto Raids",
  Default = false
}):OnChanged(function()
  _G.AutoRaids = Value
end)

Tabs.FR:AddToggle("MyToggle", {
  Title = "Take Fruits From The Warehouse",
  Default = false
}):OnChanged(function()
  _G.TFTW = Value
end)

Tabs.FR:AddToggle("MyToggle", {
  Title = "Auto Raids Hop",
  Default = false
}):OnChanged(function()
  _G.AutoRaidsHop = Value
end)

Tabs.FR:AddToggle("MyToggle", {
  Title = "Auto Awakening Fruits",
  Default = false
}):OnChanged(function()
  _G.AwakeningFruits = Value
end)

Tabs.FR:AddSection("Raids Mutis")
local PlayerRaid = {}
for _, v in pairs(game.Players:GetPlayers()) do
    if v ~= game.Players.LocalPlayer then
        table.insert(PlayerRaid, v.Name)
    end
end
Tabs.FR:AddDropdown("Dropdown", {
  Title = "Select Helps Raid",
  Values = PlayerRaid,
  Multi = true,
  Default = 1,
}):OnChanged(function(Value)
  _G.SelectHelpRaids = Value
end

Tabs.FR:AddToggle("MyToggle", {
  Title = "Chip Buy Account",
  Default = false
}):OnChanged(function()
  _G.ChipBuyAccount = Value
end)

Tabs.FR:AddToggle("MyToggle", {
  Title = "Account Follow Raid",
  Default = false
}):OnChanged(function()
  _G.AccountFollow = Value
end)

Tabs.FR:AddToggle("MyToggle", {
  Title = "Account Muti Raids",
  Default = false
}):OnChanged(function()
  _G.AccountMutiRaids = Value
end)

--TabItemsMateriry
Tabs.IM:AddSection("Materials")
Tabs.IM:AddDropdown("Dropdown", {
  Title = "Select Materials",
  Values = {"Angel Wings","Leather","Scrap Metal","Yeti Fur","Fish Tail","Ectoplasm","Radioactive Material","Vampire Fang","Mystic Droplet","Magma Ore","Meteorite","Wooden Plank","Blaze Ember","Gunpowder","Dragon Scale","Volt Capsule","Conjured Cocoa ","Mini Tusk"},
  Multi = false,
  Default = 1,
}):OnChanged(function(Value)
  _G.SelectMaterials = Value
end

Tabs.IM:AddToggle("MyToggle", {
  Title = "AutobMaterials",
  Default = false
}):OnChanged(function()
  _G.AutoMaterials = Value
end)

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("Rain Hub")
SaveManager:SetFolder("Rain Hub")
SaveManager:LoadAutoloadConfig()