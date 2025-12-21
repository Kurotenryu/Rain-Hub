
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
  Setting = Window:AddTab({ Title = "Setting", Icon = ""}),
  
}

local Options = Fluent.Options

Fluent:Notify({
    Title = "Rain Hub | Community",
    Content = "Sub Load",
    Duration = 8
})

--TabsShop
Tabs.Shop:AddSection("F.Styles")
Tabs.Shop:AddToggle("ToggleBuySuperhuman", {
  Title = "Tween Buy Superhuman", 
  Default = false
}):OnChanged(function(Value)
  _G.BuySuperhuman = Value
end

Tabs.Shop:AddToggle("ToggleBuyDeathStep", {
  Title = "Tween Buy Death Step", 
  Default = false
}):OnChanged(function(Value)
  _G.BuyDeathStep = Value
end

Tabs.Shop:AddToggle("ToggleBuySharkmanKarate", {
  Title = "Tween Buy Sharkman Karate", 
  Default = false
}):OnChanged(function(Value)
  _G.BuySharkmanKarate = Value
end

Tabs.Shop:AddToggle("ToggleBuyElectricClaw", {
  Title = "Tween Buy Electric Claw", 
  Default = false
}):OnChanged(function(Value)
  _G.BuyElectricClaw = Value
end

Tabs.Shop:AddToggle("ToggleBuyDragonTalon", {
  Title = "Tween Buy DragonTalon", 
  Default = false
}):OnChanged(function(Value)
  _G.BuyDragonTalon = Value
end

Tabs.Shop:AddToggle("ToggleBuyGodhuman", {
  Title = "Tween Buy Godhuman", 
  Default = false
}):OnChanged(function(Value)
  _G.BuyGodhuman = Value
end

Tabs.Shop:AddToggle("ToggleBuySanguineArt", {
  Title = "Tween Buy Sanguine Art", 
  Default = false
}):OnChanged(function(Value)
  _G.BuySanguineArt = Value
end
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
  
  Tabs.Farming:AddToggle("ToggleEPB", {
    Title = "Equip To Press The Buttons",
    Default = false
  }):OnChanged(function(Value)
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
    while task.wait(1.5) do
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
for i, v in ipairs(game:GetService("ReplicatedStorage").NPCs:GetChildren()) do
  if v:IsA("Model") and v:FindFirstChild("Humanoid") then
    table.insert(NPCList, v.Name)
  end
end
Tabs.LP:AddDropdown("DropdownSelectNpc", {
  Title = "Select NPC",
  Values = NPCList,
  Multi = false,
  Default = 1,
}):OnChanged(function(Value)
  _G.SelectNPC = Value
end)

Tabs.LP:AddToggle("ToggleTweenNpc", {
  Title = "Tween NPC",
  Default = false
}):OnChanged(function(Value)
  _G.TweenNPC = Value
end)

local IslandList = {}
for i, v in ipairs(game:GetService.workspace.Map:GetChildren()) do
  if v:IsA("Model") then
    table.insert(IslandList, v.Name)
  end
end

Tabs.LP:AddDropdown("DropdownSelectIsland", {
  Title = "Select Island",
  Values = IslandList,
  Multi = false,
  Default = 1,
}):OnChanged(function(Value)
  _G.SelectIsland = Value
end

Tabs.LP:AddToggle("ToggleTweenIsland", {
  Title = "Tween Island",
  Default = false
}):OnChanged(function(Value)
  _G.TweenIsland = Value
end)
--TabFruitsRaid
local FruitsStatus = Tabs.FR:AddParagraph({
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

Tabs.FR:AddToggle("TogglePickFruits", {
  Title = "Picked Fruits",
  Default = false
}):OnChanged(function(Value)
  _G.PickedFruits = Value
end)

Tabs.FR:AddToggle("TogglePFH", {
  Title = "Picked Fruits Hop",
  Default = false
}):OnChanged(function(Value)
  _G.PickedFruitsHop = Value
end)

Tabs.FR:AddToggle("ToggleAutoGachaFruits", {
  Title = "Auto Gacha Fruits",
  Default = false
}):OnChanged(function(Value)
  _G.AutoGachaFruits = Value
end)

Tabs.FR:AddToggle("ToggleAutoStoreFruits", {
  Title = "Auto Store Fruits",
  Default = false
}):OnChanged(function(Value)
  _G.AutoStoreFruits = Value
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
Tabs.FR:AddDropdown("DropdownSelectBFD", {
  Title = "Select Blox Fruit Dealer",
  Values = Table_DevilFruitSniper,
  Multi = false,
  Default = 1,
}):OnChanged(function(Value)
  _G.SelectBloxFruitDealer = Value
end

Tabs.FR:AddToggle("ToggleBuyBFD", {
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

Tabs.FR:AddSection("Raids")
Tabs.FR:AddDropdown("DropdownSelectMapRaids", {
  Title = "Select Map Raids",
  Values = {"Flame","Ice","Quake","Light","Dark","Spider","Magma","Buddha","Sand","Phoenix","Dough"},
  Multi = false,
  Default = 1,
}):OnChanged(function(Value)
  _G.SelectMapRaids = Value
end

Tabs.FR:AddToggle("ToggleAutoRaids", {
  Title = "Auto Raids",
  Default = false
}):OnChanged(function(Value)
  _G.AutoRaids = Value
end)

Tabs.FR:AddToggle("ToggleTFFTW", {
  Title = "Take Fruits From The Warehouse",
  Default = false
}):OnChanged(function(Value)
  _G.TFTW = Value
end)

Tabs.FR:AddToggle("ToggleAutoRaidHop", {
  Title = "Auto Raids Hop",
  Default = false
}):OnChanged(function(Value)
  _G.AutoRaidsHop = Value
end)

Tabs.FR:AddToggle("ToggleAutoAwakeninhFruits", {
  Title = "Auto Awakening Fruits",
  Default = false
}):OnChanged(function(Value)
  _G.AwakeningFruits = Value
end)

Tabs.FR:AddSection("Raids Mutis")
local PlayerRaid = {}
for _, v in pairs(game:GetService("Players"):GetPlayers()) do
    if v ~= game:GetService("Players").LocalPlayer then
												table.insert(PlayerRaid, v.Name)
    end
end
Tabs.FR:AddDropdown("DropdownSelectHelpsRaid", {
  Title = "Select Helps Raid",
  Values = PlayerRaid,
  Multi = true,
  Default = 1,
}):OnChanged(function(Value)
  _G.SelectHelpRaids = Value
end

Tabs.FR:AddToggle("ToggleChipBuyAccount", {
  Title = "Chip Buy Account",
  Default = false
}):OnChanged(function(Value)
  _G.ChipBuyAccount = Value
end)

Tabs.FR:AddToggle("ToggleAFR", {
  Title = "Account Follow Raid",
  Default = false
}):OnChanged(function(Value)
  _G.AccountFollow = Value
end)

Tabs.FR:AddToggle("ToggleAMR", {
  Title = "Account Muti Raids",
  Default = false
}):OnChanged(function(Value)
  _G.AccountMutiRaids = Value
end)

--TabItemsMateriry
Tabs.IM:AddSection("Materials")
Tabs.IM:AddDropdown("DropdownSelectMaterials", {
  Title = "Select Materials",
  Values = {"Angel Wings","Leather","Scrap Metal","Yeti Fur","Fish Tail","Ectoplasm","Radioactive Material","Vampire Fang","Mystic Droplet","Magma Ore","Meteorite","Wooden Plank","Blaze Ember","Gunpowder","Dragon Scale","Volt Capsule","Conjured Cocoa ","Mini Tusk"},
  Multi = false,
  Default = 1,
}):OnChanged(function(Value)
  _G.SelectMaterials = Value
end

Tabs.IM:AddToggle("ToggleAutoMaterials", {
  Title = "AutobMaterials",
  Default = false
}):OnChanged(function(Value)
  _G.AutoMaterials = Value
end)

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("Rain Hub")
SaveManager:SetFolder("Rain Hub")
SaveManager:LoadAutoloadConfig()												

										
