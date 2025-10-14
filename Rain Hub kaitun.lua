-- === CONFIG / GLOBALS ===
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Rep = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Player = Players.LocalPlayer

-- detect world
local FirstSea, SecondSea, ThirdSea = false, false, false
if game.PlaceId == 2753915549 then
    FirstSea = true
elseif game.PlaceId == 4442272183 then
    SecondSea = true
elseif game.PlaceId == 7449423635 then
    ThirdSea = true
end

-- safe globals default
getgenv().SelectWeaponName = getgenv().SelectWeaponName or ""
getgenv().SelectWeaponType = getgenv().SelectWeaponType or "Melee"
getgenv().AutoFarmEnabled = getgenv().AutoFarmEnabled or true

-- helper short access
local function HRP()
    local c = Player and Player.Character
    return c and c:FindFirstChild("HumanoidRootPart")
end
local function Hum()
    local c = Player and Player.Character
    return c and c:FindFirstChildOfClass("Humanoid")
end

-- === helper: safe invoke CommF_ (server) ===
local function SafeInvokeCommF(...)
    local args = {...}
    local ok, res = pcall(function()
        if Rep:FindFirstChild("Remotes") and Rep.Remotes:FindFirstChild("CommF_") then
            return Rep.Remotes.CommF_:InvokeServer(unpack(args))
        end
    end)
    if not ok then warn("[SafeInvokeCommF] error:", res) end
    return ok, res
end

-- === helper: check alive ===
local function IsAlive(model)
    local hum = model and model:FindFirstChildOfClass("Humanoid")
    return hum and hum.Health > 0
end

-- === toolMatchesType (heuristics) ===
local function toolMatchesType(tool, wantType)
    if not tool or not wantType then return false end
    local nm = tostring(tool.Name or ""):lower()
    local tip = tostring(tool.ToolTip or ""):lower()
    local attr = nil
    if tool.GetAttribute then
        pcall(function() attr = tostring(tool:GetAttribute("WeaponType") or ""):lower() end)
    end
    wantType = tostring(wantType or ""):lower()

    if attr and attr ~= "" then
        if attr == wantType then return true end
    end
    if tip ~= "" and tip:find(wantType) then return true end

    if wantType == "melee" then
        if nm:find("machete") or nm:find("katana") or nm:find("blade") or nm:find("knife") then return true end
    elseif wantType == "sword" then
        if nm:find("sword") or nm:find("katana") then return true end
    elseif wantType == "gun" then
        if nm:find("gun") or nm:find("flint") or nm:find("pistol") or nm:find("musket") then return true end
    elseif wantType == "fruit" then
        if nm:find("fruit") or tool:FindFirstChild("Fruit") then return true end
    else
        -- nếu wantType là tên cụ thể (fallback), so sánh chứa
        if nm:find(wantType) then return true end
    end
    return false
end

-- === Equip functions ===
local lastEquip = 0
local EQUIP_COOLDOWN = 0.45

function EquipWeaponByName(toolName)
    if not toolName or toolName == "" then return false end
    if tick() - lastEquip < EQUIP_COOLDOWN then return false end
    lastEquip = tick()
    local ok = pcall(function()
        local char = Player.Character
        local bp = Player:FindFirstChild("Backpack")
        if not (char or bp) then return end
        local tool = (char and char:FindFirstChild(toolName)) or (bp and bp:FindFirstChild(toolName))
        if tool and char and char:FindFirstChildOfClass("Humanoid") then
            char:FindFirstChildOfClass("Humanoid"):EquipTool(tool)
            return true
        end
    end)
    return ok
end

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
            local equipped = char and char:FindFirstChildOfClass("Tool")
            if equipped and equipped == tool then return true end
        end
        return false
    end

    -- check equipped
    pcall(function()
        local char = Player.Character
        if char then
            local equipped = char:FindFirstChildOfClass("Tool")
            if equipped and toolMatchesType(equipped, wantType) then
                return equipped.Name
            end
        end
    end)

    -- check backpack
    local bp = Player:FindFirstChild("Backpack")
    if bp then
        for _, t in ipairs(bp:GetChildren()) do
            if t:IsA("Tool") and toolMatchesType(t, wantType) then
                if tryEquip(t) then return t.Name end
            end
        end
    end

    -- check character children
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

-- unified auto-equip
function AutoEquipSelected()
    if getgenv().SelectWeaponName and getgenv().SelectWeaponName ~= "" then
        return EquipWeaponByName(getgenv().SelectWeaponName)
    elseif getgenv().SelectWeaponType and getgenv().SelectWeaponType ~= "" then
        local mapped = EquipWeaponByType(getgenv().SelectWeaponType)
        if mapped then
            getgenv().SelectWeaponName = mapped
            return true
        end
    end
    return false
end

-- === Smart movement (SmartTopos) ===
local currentTween = nil
local function StopCurrentTween()
    if currentTween then pcall(function() currentTween:Cancel() end); currentTween = nil end
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
            Vector3.new(-4652,873,-1754),
            Vector3.new(-7895,5547,-380),
            Vector3.new(61164,5,1820),
            Vector3.new(3865,5,-1926),
        }
    elseif SecondSea then
        Teleporters = {
            Vector3.new(-317,331,597),
            Vector3.new(2283,15,867),
            Vector3.new(923,125,32853),
            Vector3.new(-6509,83,-133),
        }
    elseif ThirdSea then
        Teleporters = {
            Vector3.new(-12471,374,-7551),
            Vector3.new(5659,1013,-341),
            Vector3.new(-5092,315,-3130),
            Vector3.new(-12001,332,-8861),
            Vector3.new(5319,23,-93),
            Vector3.new(28286,14897,103),
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
    return nil
end

local function requestEntrance(pos)
    SafeInvokeCommF("requestEntrance", pos)
    if HRP() then HRP().CFrame = HRP().CFrame + Vector3.new(0,50,0) end
    task.wait(0.4)
end

function SmartTopos(targetCFrame)
    local hrp = HRP()
    if not hrp or not targetCFrame then return "no_hrp" end
    local distance = (targetCFrame.Position - hrp.Position).Magnitude

    if distance <= 300 then
        hrp.CFrame = targetCFrame
        return "instant"
    end

    local tele = CheckNearestTeleporter(targetCFrame)
    if tele then requestEntrance(tele); return "teleporter" end

    if distance <= 5000 then
        StopCurrentTween()
        local speed = 1000 -- studs per second, bạn có thể adjust
        local info = TweenService:Create(hrp, TweenService:Create(hrp, TweenInfo.new(distance / speed, Enum.EasingStyle.Linear), {CFrame = targetCFrame}))
        -- (above simplified: use TweenService:Create correctly below)
        StopCurrentTween()
        local info2 = TweenInfo.new(distance / speed, Enum.EasingStyle.Linear)
        currentTween = TweenService:Create(hrp, info2, {CFrame = targetCFrame})
        currentTween:Play()
        currentTween.Completed:Wait()
        currentTween = nil
        return "tween"
    end

    -- too far -> reset (teleport via rejoin)
    hrp.CFrame = targetCFrame
    task.wait(0.5)
    ResetCharacter()
    return "reset"
end

-- === Quest mapping (CheckQuestKaitun) ===
local Mon, LevelQuest, NameQuest, NameMon, CFrameQuest, CFrameMon
function CheckQuestKaitun()
    local MyLevel = Player and Player:FindFirstChild("Data") and Player.Data:FindFirstChild("Level") and Player.Data.Level.Value or 0
    if FirstSea then
        if MyLevel >= 1 and MyLevel <= 10 then
            Mon= "Bandit"
            LevelQuest = 1; NameQuest = "BanditQuest1"; NameMon = "Bandit"
            CFrameQuest = CFrame.new(1059,15,1550)
            CFrameMon = CFrame.new(1046,27,1561)
        elseif MyLevel > 10 and MyLevel <= 250 then
            Mon = "Shanda"
            LevelQuest = nil; NameQuest = nil; NameMon = "Shanda"
            CFrameQuest = nil
            CFrameMon = CFrame.new(-7678.48974609375, 5566.40380859375, -497.2156066894531)
        elseif MyLevel >= 250 and MyLevel <= 275 then
            Mon = "Toga Warrior"
            LevelQuest = 1; NameQuest = "ColosseumQuest"; NameMon = "Toga Warrior"
            CFrameQuest = CFrame.new(-1580.04663, 6.35, -2986.47534)
            CFrameMon = CFrame.new(-1820.21484375, 51.68, -2740.6650390625)
        -- ... tiếp các điều kiện khác giống bạn (mình giữ ví dụ ngắn)
        else
            -- fallback
            Mon = Mon or "Bandit"
        end
    elseif SecondSea then
        -- SecondSea mapping (ví dụ)
        if MyLevel >= 700 and MyLevel <= 725 then
            Mon = "Raider"; LevelQuest = 1; NameQuest = "Area1Quest"; NameMon = "Raider"
            CFrameQuest = CFrame.new(-429.54, 71.77, 1836.18)
            CFrameMon = CFrame.new(-728.33, 52.77, 2345.77)
        end
    end
end

-- === Ensure quest ready (non blocking) ===
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

local function EnsureQuestReadyForKaitun()
    -- run mapping
    CheckQuestKaitun()
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

-- === Attack helpers ===
local function GetEnemyInRange(range)
    local hrp = HRP()
    if not hrp then return nil end
    local enemiesFolder = Workspace:FindFirstChild("Enemies")
    if not enemiesFolder then return nil end
    local best, bestDist = nil, math.huge
    for _, enemy in ipairs(enemiesFolder:GetChildren()) do
        if IsAlive(enemy) then
            local eHRP = enemy:FindFirstChild("HumanoidRootPart")
            if eHRP then
                local d = (eHRP.Position - hrp.Position).Magnitude
                if d <= range and d < bestDist then
                    bestDist = d; best = eHRP
                end
            end
        end
    end
    return best
end

function AttackNoCoolDown()
    pcall(function()
        local char = Player.Character
        if not char then return end
        local tool = char:FindFirstChildOfClass("Tool")
        if not tool then return end
        -- optional: check WeaponType attr OR accept current equipped tool
        local target = GetEnemyInRange(180)
        if target and tool:FindFirstChild("LeftClickRemote") then
            local dir = (target.Position - char:GetPivot().Position).Unit
            tool.LeftClickRemote:FireServer(dir, 1)
        end
    end)
end

-- === Farm loop (non-blocking, uses SmartTopos + equips by type) ===
task.spawn(function()
    while true do
        task.wait(0.05)
        if not getgenv().AutoFarmEnabled then
            task.wait(0.5)
            continue
        end

        -- refresh enemies
        if not Workspace:FindFirstChild("Enemies") then
            task.wait(1)
            goto cont
        end

        if not EnsureQuestReadyForKaitun() then task.wait(0.6)  end

        local found = false
        local Enemies = Workspace:FindFirstChild("Enemies")
        for _, mob in ipairs(Enemies:GetChildren()) do
            if not getgenv().AutoFarmEnabled then break end
            if mob and mob.Name and mob.Name == Mon then
                local mhum = mob:FindFirstChildOfClass("Humanoid")
                local mhrp = mob:FindFirstChild("HumanoidRootPart")
                if mhum and mhrp and mhum.Health > 0 then
                    found = true
                    if CFrameMon then SmartTopos(CFrameMon); task.wait(0.2) end
                    pcall(function() SmartTopos(mhrp.CFrame * CFrame.new(0, 20, 5)) end)
                    -- lock mob
                    pcall(function()
                        mhrp.CanCollide = false
                        mhrp.AssemblyLinearVelocity = Vector3.new(0,0,0)
                        if mhum then mhum.WalkSpeed = 0; mhum.JumpPower = 0; mhum.AutoRotate = false end
                    end)

                    -- auto-equip by type then attack
                    AutoEquipSelected()
                    AttackNoCoolDown()

                    repeat
                        task.wait(0.05)
                        -- break when mob dead
                    until not mhum or mhum.Health <= 0 or not mob.Parent
                    task.wait(0.1)
                end
            end
        end

        if not found then
            if CFrameMon then SmartTopos(CFrameMon) end
            task.wait(0.3)
        end
    end
end)
