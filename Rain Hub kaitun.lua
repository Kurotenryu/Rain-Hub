if game.PlaceId == 2753915549 then
    FirstSea = true
elseif game.PlaceId == 4442272183 then
    SecondSea = true
elseif game.PlaceId == 7449423635 then
    ThirdSea = true
end

local function HRP()
    local c = Player.Character
    return c and c:FindFirstChild("HumanoidRootPart")
end

local function Hum()
    local c = Player.Character
    return c and c:FindFirstChildOfClass("Humanoid")
end

--tween
local currentTween

local function StopCurrentTween()
    if currentTween then pcall(function() currentTween:Cancel() end) ; currentTween = nil end
end

local function ResetCharacter()
    local h = Hum()
    if h then h.Health = 0 end
end

local function CheckNearestTeleporter(targetCFrame)
    local pos = targetCFrame.Position
    local Teleporters = {}

    if FirstSea then
        Teleporters = {
            Vector3.new(-4652,873,-1754),   -- Sky Island 1
            Vector3.new(-7895,5547,-380),   -- Sky Island 2
            Vector3.new(61164,5,1820),      -- Under Water Island
            Vector3.new(3865,5,-1926),      -- Under Water Entrance
        }
    elseif SecondSea then
        Teleporters = {
            Vector3.new(-317,331,597),      -- Flamingo Mansion
            Vector3.new(2283,15,867),       -- Flamingo Room
            Vector3.new(923,125,32853),     -- Cursed Ship
            Vector3.new(-6509,83,-133),     -- Zombie Island
        }
    elseif ThirdSea then
        Teleporters = {
            Vector3.new(-12471,374,-7551),  -- Mansion
            Vector3.new(5659,1013,-341),    -- Hydra
            Vector3.new(-5092,315,-3130),   -- Castle On The Sea
            Vector3.new(-12001,332,-8861),  -- Floating Turtle
            Vector3.new(5319,23,-93),       -- Beautiful Pirate
            Vector3.new(28286,14897,103),   -- Temple Of Time
        }
    end

    local closest, minDist = nil, math.huge
    for _,v in ipairs(Teleporters) do
        local d = (v - pos).Magnitude
        if d < minDist then minDist = d; closest = v end
    end

    if closest and HRP() then
        local direct = (HRP().Position - pos).Magnitude
        if minDist <= direct then return closest end
    end
end

local function requestEntrance(pos)
    SafeInvokeCommF("requestEntrance", pos)
    if HRP() then HRP().CFrame = HRP().CFrame + Vector3.new(0,50,0) end -- tránh kẹt
    task.wait(0.4)
end

function SmartTopos(targetCFrame)
    local hrp = HRP(); if not hrp or not targetCFrame then return "no_hrp" end
    local distance = (targetCFrame.Position - hrp.Position).Magnitude

    if distance <= 300 then
        hrp.CFrame = targetCFrame
        return "instant"
    end

    local tele = CheckNearestTeleporter(targetCFrame)
    if tele then requestEntrance(tele); return "teleporter" end

    if distance <= 5000 then
        StopCurrentTween()
        local info = TweenInfo.new(distance / 1000, Enum.EasingStyle.Linear)
        currentTween = TweenService:Create(hrp, info, {CFrame = targetCFrame})
        currentTween:Play()
        currentTween.Completed:Wait()
        currentTween = nil
        return "tween"
    end

    if hrp then
    hrp.CFrame = targetCFrame 
    task.wait(0.5)           
    ResetCharacter()          
end
return "reset"
end

-- Weapon selector: by name OR by type (Tool attribute / ToolTip / heuristics)
_G.SelectWeaponName = ""
_G.SelectWeaponType = "Melle"  -- ex: "Melee", "Sword", "Gun", "Fruit"

local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local lastEquip = 0
local EQUIP_COOLDOWN = 0.45

local function safeFindAttribute(obj, attr)
    if not obj or not obj.GetAttribute then return nil end
    local ok, val = pcall(function() return obj:GetAttribute(attr) end)
    if ok then return val end
    return nil
end


-- try to equip tool by its name (returns true if success)
function EquipWeaponByName(toolName)
    if not toolName then return false end
    if tick() - lastEquip < EQUIP_COOLDOWN then return false end
    lastEquip = tick()
    pcall(function()
        local char = Player.Character
        local bp = Player:FindFirstChild("Backpack")
        if not char and not bp then return end
        local tool = (char and char:FindFirstChild(toolName)) or (bp and bp:FindFirstChild(toolName))
        if tool and char and char:FindFirstChildOfClass("Humanoid") then
            char.Humanoid:EquipTool(tool)
            return true
        end
    end)
    return false
end

-- try to equip a tool matching the requested type (returns name if found/equipped)
function EquipWeaponByType(wantType)
    if not wantType then return nil end
    if tick() - lastEquip < EQUIP_COOLDOWN then return nil end
    lastEquip = tick()

    local function tryEquip(tool)
        if not tool then return false end
        local char = Player.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then
            pcall(function() hum:EquipTool(tool) end)
            task.wait(0.12)
            -- confirm equipped
            local equipped = char and char:FindFirstChildOfClass("Tool")
            if equipped and equipped == tool then
                return true
            end
        end
        return false
    end

    -- 1) check currently equipped first
    pcall(function()
        local char = Player.Character
        if char then
            local equipped = char:FindFirstChildOfClass("Tool")
            if equipped and toolMatchesType(equipped, wantType) then
                return equipped.Name
            end
        end
    end)

    -- 2) check backpack for matching tools
    local bp = Player:FindFirstChild("Backpack")
    if bp then
        for _, t in ipairs(bp:GetChildren()) do
            if t:IsA("Tool") and toolMatchesType(t, wantType) then
                if tryEquip(t) then return t.Name end
            end
        end
    end

    -- 3) check character children (maybe in arms)
    local char = Player.Character
    if char then
        for _, t in ipairs(char:GetChildren()) do
            if t:IsA("Tool") and toolMatchesType(t, wantType) then
                return t.Name
            end
        end
    end

    return nil
end

-- background loop: if SelectWeaponType set -> map to actual tool name and store in SelectWeaponName
task.spawn(function()
    local lastType = nil
    while task.wait(0.5) do
        pcall(function()
            -- if user explicitly set a name, don't override it
            if _G.SelectWeaponName and _G.SelectWeaponName ~= "" then
                -- If they also set a Type and it changed, attempt mapping but don't clobber manual name
                if _G.SelectWeaponType and _G.SelectWeaponType ~= lastType then
                    lastType = _G.SelectWeaponType
                    local mapped = EquipWeaponByType(lastType)
                    if mapped then
                        -- only set name if SelectWeaponName is nil or empty
                        if not _G.SelectWeaponName or _G.SelectWeaponName == "" then
                            _G.SelectWeaponName = mapped
                        end
                    end
                end
            else
                -- no explicit name -> if SelectWeaponType provided, try find and set name
                if _G.SelectWeaponType and _G.SelectWeaponType ~= lastType then
                    lastType = _G.SelectWeaponType
                    local mapped = EquipWeaponByType(lastType)
                    if mapped then
                        _G.SelectWeaponName = mapped
                    end
                elseif _G.SelectWeaponType then
                    -- try periodically to find a tool if previously failed
                    local mapped = EquipWeaponByType(_G.SelectWeaponType)
                    if mapped then _G.SelectWeaponName = mapped end
                end
            end
        end)
    end
end)

-- helper: public equip function that respects SelectWeaponName/Type order
function AutoEquipSelected()
    if _G.SelectWeaponName and _G.SelectWeaponName ~= "" then
        return EquipWeaponByName(_G.SelectWeaponName)
    elseif _G.SelectWeaponType and _G.SelectWeaponType ~= "" then
        local mapped = EquipWeaponByType(_G.SelectWeaponType)
        if mapped then
            _G.SelectWeaponName = mapped
            return true
        end
    end
    return false
end

--autohaki
local function AutoHaki()
    while task.wait(2) do
    pcall(function()
        if not Char:FindFirstChild("HasBuso") then
            Rep.Remotes.CommF_:InvokeServer("Buso")
        end
    end)
    end
end

--fastattck
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local function IsAlive(model)
    local hum = model and model:FindFirstChildOfClass("Humanoid")
    return hum and hum.Health > 0
end

local function GetEnemy()
    for _, enemy in ipairs(workspace.Enemies:GetChildren()) do
        local hrp = enemy:FindFirstChild("HumanoidRootPart")
        if hrp and IsAlive(enemy) and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            if (hrp.Position - Player.Character.HumanoidRootPart.Position).Magnitude <= 120 then
                return hrp
            end
        end
    end
    return nil
end

function AttackNoCoolDown()
    pcall(function()
    local char = Player.Character
    if not char then return end
    local tool = char:FindFirstChildOfClass("Tool")
    if tool and (tool:GetAttribute("WeaponType") == "Melee" or tool:GetAttribute("WeaponType") == "Sword") then
        local target = GetEnemy()
        if target and tool:FindFirstChild("LeftClickRemote") then
            tool.LeftClickRemote:FireServer((target.Position - char:GetPivot().Position).Unit, 1)
        end
    end
    end)
end


--fastattckloop
task.spawn(function()
    while task.wait(0.05 + math.random() * 0.005) do
        pcall(function()
            AttackNoCoolDown()
        end)
    end
end)
--questkaitun
function CheckQuestKaitun()
  MyLevel = game:GetService("Players").LocalPlayer.Data.Level.Value
  if FirstSea then
    if MyLevel >= 1 and MyLevel <= 10 then
      Mon= "Bandit"
      LevelQuest = 1
      NameQuest = "BanditQuest1"
      NameMon = "Bandit"
      CFrameQuest = CFrame.new(1059,15,1550)
      CFrameMon = CFrame.new(1046,27,1561)
    elseif MyLevel >= 10 and MyLevel <= 250 then
      Mon = "Shanda"
      LevelQuest = nil
      NameQuest = nil
      NameMon = "Shanda"
      CFrameQuest = nil
      CFrameMon = CFrame.new(-7678.48974609375, 5566.40380859375, -497.2156066894531)
    elseif MyLevel >= 250 and MyLevel <= 275 then
      Mon = "Toga Warrior"
      LevelQuest = 1
      NameQuest = "ColosseumQuest"
      NameMon = "Toga Warrior"
      CFrameQuest = CFrame.new(-1580.04663, 6.35000277, -2986.47534, -0.515037298, 0, -0.857167721, 0, 1, 0, 0.857167721, 0, -0.515037298)
      CFrameMon = CFrame.new(-1820.21484375, 51.68385696411133, -2740.6650390625)
    elseif MyLevel >= 275 and MyLevel <= 300 then
      Mon = "Gladiator"
      LevelQuest = 2
      NameQuest = "ColosseumQuest"
      NameMon = "Gladiator"
      CFrameQuest = CFrame.new(-1580.04663, 6.35000277, -2986.47534, -0.515037298, 0, -0.857167721, 0, 1, 0, 0.857167721, 0, -0.515037298)
      CFrameMon = CFrame.new(-1292.838134765625, 56.380882263183594, -3339.031494140625)
    elseif MyLevel >= 300 and MyLevel <= 325 then
      Mon = "Military Soldier"
      LevelQuest = 1
      NameQuest = "MagmaQuest"
      NameMon = "Military Soldier"
      CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395, -0.499959469, 0, 0.866048813, 0, 1, 0, -0.866048813, 0, -0.499959469)
      CFrameMon = CFrame.new(-5411.16455078125, 11.081554412841797, 8454.29296875)
    elseif MyLevel >= 325 and MyLevel <= 375 then
      Mon = "Military Spy"
      LevelQuest = 2
      NameQuest = "MagmaQuest"
      NameMon = "Military Spy"
      CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395, -0.499959469, 0, 0.866048813, 0, 1, 0, -0.866048813, 0, -0.499959469)
      CFrameMon = CFrame.new(-5802.8681640625, 86.26241302490234, 8828.859375)
    elseif MyLevel >= 375 and MyLevel <= 400 then
      Mon = "Fishman Warrior"
      LevelQuest = 1
      NameQuest = "FishmanQuest"
      NameMon = "Fishman Warrior"
      CFrameQuest = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
      CFrameMon = CFrame.new(60878.30078125, 18.482830047607422, 1543.7574462890625)
    elseif MyLevel >= 400 and MyLevel <= 450 then
      Mon = "Fishman Commando"
      LevelQuest = 2
      NameQuest = "FishmanQuest"
      NameMon = "Fishman Commando"
      CFrameQuest = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
      CFrameMon = CFrame.new(61922.6328125, 18.482830047607422, 1493.934326171875)
    elseif MyLevel >= 450 and MyLevel <= 475 then
      Mon = "God's Guard"
      LevelQuest = 1
      NameQuest = "SkyExp1Quest"
      NameMon = "God's Guard"
      CFrameQuest = CFrame.new(-4721.88867, 843.874695, -1949.96643, 0.996191859, -0, -0.0871884301, 0, 1, -0, 0.0871884301, 0, 0.996191859)
      CFrameMon = CFrame.new(-4710.04296875, 845.2769775390625, -1927.3079833984375)
    elseif MyLevel >= 475 and MyLevel <= 525 then
      Mon = "Shanda"
      LevelQuest = 2
      NameQuest = "SkyExp1Quest"
      NameMon = "Shanda"
      CFrameQuest = CFrame.new(-7859.09814, 5544.19043, -381.476196, -0.422592998, 0, 0.906319618, 0, 1, 0, -0.906319618, 0, -0.422592998)
      CFrameMon = CFrame.new(-7678.48974609375, 5566.40380859375, -497.2156066894531)
    elseif MyLevel >= 525 and MyLevel <= 549 then
      Mon = "Royal Squad"
      LevelQuest = 1
      NameQuest = "SkyExp2Quest"
      NameMon = "Royal Squad"
      CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194, 0, 0, -1, 0, 1, 0, 1, 0, 0)
      CFrameMon = CFrame.new(-7624.25244140625, 5658.13330078125, -1467.354248046875)
    elseif MyLevel >= 550 and MyLevel <= 624 then
      Mon = "Royal Soldier"
      LevelQuest = 2
      NameQuest = "SkyExp2Quest"
      NameMon = "Royal Soldier"
      CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194, 0, 0, -1, 0, 1, 0, 1, 0, 0)
      CFrameMon = CFrame.new(-7836.75341796875, 5645.6640625, -1790.6236572265625)
    elseif MyLevel >= 625 and MyLevel <= 649 then
      Mon = "Galley Pirate"
      LevelQuest = 1
      NameQuest = "FountainQuest"
      NameMon = "Galley Pirate"
      CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293, 0.087131381, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, 0.087131381)
      CFrameMon = CFrame.new(5551.02197265625, 78.90135192871094, 3930.412841796875)
    elseif MyLevel >= 650 then
      Mon = "Galley Captain"
      LevelQuest = 2
      NameQuest = "FountainQuest"
      NameMon = "Galley Captain"
      CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293, 0.087131381, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, 0.087131381)
      CFrameMon = CFrame.new(5441.95166015625, 42.50205993652344, 4950.09375)
      elseif SecondSea then
        if MyLevel >= 700 and MyLevel <= 725 then
          Mon = "Raider"
          LevelQuest = 1
          NameQuest = "Area1Quest"
          NameMon = "Raider"
          CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188, -0.22495985, 0, -0.974368095, 0, 1, 0, 0.974368095, 0, -0.22495985)
          CFrameMon = CFrame.new(-728.3267211914062, 52.779319763183594, 2345.7705078125)
        end
      end
  end
    
--kaitunquest    
local function EnsureQuestReadyForKaitun()
    if NameQuest and LevelQuest then
        local current = GetQuestTitle()
        if not current or (NameMon and not string.find(current, NameMon)) then
            if CFrameQuest then SmartTopos(CFrameQuest) end
            task.wait(0.3)
            pcall(function() SafeInvokeCommF("StartQuest", NameQuest, LevelQuest) end)
            local t0 = tick()
            repeat
                task.wait(0.25)
                current = GetQuestTitle()
            until (current and (not NameMon or string.find(current, NameMon))) or tick() - t0 > 6
            if not (current and (not NameMon or string.find(current, NameMon))) then
                warn("[AutoFarm] Failed to confirm quest accept (timeout).")
                return false
            end
        end
    end
    return true
end

task.spawn(function()
    while true do
        task.wait(0.05)
        if not Enemies or not Enemies.Parent then
            Enemies = Workspace:FindFirstChild("Enemies") or Workspace:WaitForChild("Enemies", 5)
            if not Enemies then task.wait(1) goto cont end
        end
        if not EnsureQuestReadyForKaitun() then task.wait(0.6) goto cont end
        local found = false
        for _, mob in ipairs(Enemies:GetChildren()) do
            if mob and mob.Name and mob.Name == Mon then
                local mhum = mob:FindFirstChildOfClass("Humanoid")
                local mhrp = mob:FindFirstChild("HumanoidRootPart")
                if mhum and mhrp and mhum.Health > 0 then
                    found = true
                    if CFrameMon then
                        SmartTopos(CFrameMon)
                        task.wait(0.2)
                    end
                    pcall(function()
                        SmartTopos(mhrp.CFrame * CFrame.new(0, 20, 5))
                    end)
                    pcall(function()
                        mhrp.CanCollide = false
                        mhrp.AssemblyLinearVelocity = Vector3.new(0,0,0)
                        if mhum then
                            mhum.WalkSpeed = 0
                            mhum.JumpPower = 0
                            mhum.AutoRotate = false
                        end
                        if bp then bp.Position = mhrp.Position + Vector3.new(0,10,0) end
                        if bg and HRP() then bg.CFrame = CFrame.new(HRP().Position, mhrp.Position) end
                    end)
                    AutoHaki()
                    EquipWeaponByType(_G.SelectWeaponType)
                    AttackNoCoolDown()
                    repeat
                        task.wait(0.05)
                        local t = GetQuestTitle()
                        if NameQuest and NameMon and (not t or not string.find(t, NameMon)) then break end
                    until not mhum or mhum.Health <= 0 or not mob.Parent
                    task.wait(0.1)
                end
            end
        end

        if not found then
            if CFrameMon then 
                SmartTopos(CFrameMon) 
            end
            task.wait(0.3)
        end

        ::cont::
    end
end)
      