-- Mango Hub (fixed / unified)
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Mango Hub", HidePremium = false, SaveConfig = true, ConfigFolder = "Mango hub"})
local tween

--// Services
local Players = game:GetService("Players")
local Rep = game:GetService("ReplicatedStorage")
local Enemies = workspace:WaitForChild("Enemies")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer

--// Tabs (Main must exist)
local Main = Window:MakeTab({ Name = "Main", Icon = "", PremiumOnly = false })
local Farm = Main:AddSection({ Name = "Farm" })
local Setting = Window:MakeTab({ Name = "Setting", Icon = "", PremiumOnly = false })

-- =========================
-- Flags (use Enabled suffix to avoid name clash with functions)
-- =========================
getgenv().AutoFarmEnabled   = false
getgenv().AutoHakiEnabled   = false
getgenv().FastAttackEnabled = false
getgenv().SelectWeapon      = "Melee"
getgenv().InstantRange      = 300
getgenv().TweenRange        = 5000
getgenv().Speed             = 1000
getgenv().NotAutoEquip      = false
getgenv().StartMagnet       = false

--// Dropdown chọn weapon
Main:AddDropdown({
	Name = "Selected Weapon",
	Default = "Melee",
	Options = {"Melee", "Sword", "Gun", "Fruit"},
	Callback = function(Value)
		getgenv().SelectWeapon = Value
	end    
})

-- NOTE: replace old Main:AddToggle that used getgenv().AutoFarm (collision). Use Enabled flags below.

--// Toggles (use Enabled flags)
Main:AddToggle({
	Name = "Auto Farm",
	Default = false,
	Callback = function(Value)
		getgenv().AutoFarmEnabled = Value
		if Value then
			task.spawn(function()
				if type(AutoFarmLoop) == "function" then AutoFarmLoop() end
			end)
		end
	end    
})

Main:AddToggle({
	Name = "Auto Haki",
	Default = false,
	Callback = function(Value)
		getgenv().AutoHakiEnabled = Value
	end
})

--// Settings sliders
Setting:AddSlider({
	Name = "Instant Range",
	Min = 50, Max = 1000, Default = 300,
	Color = Color3.fromRGB(255,100,100), Increment = 10, ValueName = "studs",
	Callback = function(Value) getgenv().InstantRange = Value end    
})

Setting:AddSlider({
	Name = "Tween Range",
	Min = 500, Max = 10000, Default = 5000,
	Color = Color3.fromRGB(100, 255, 100), Increment = 50, ValueName = "studs",
	Callback = function(Value) getgenv().TweenRange = Value end    
})

Setting:AddSlider({
	Name = "Tween Speed",
	Min = 200, Max = 3000, Default = 1000,
	Color = Color3.fromRGB(100, 100, 255), Increment = 50, ValueName = "studs/s",
	Callback = function(Value) getgenv().Speed = Value end    
})

--// World check
local Sea1, Sea2, Sea3
if game.PlaceId == 2753915549 then 
	Sea1 = true
elseif game.PlaceId == 4442272183 then 
	Sea2 = true
elseif game.PlaceId == 7449423635 then
	Sea3 = true
end

--// Quest (keeps your mapping)
function CheckQuest()
	local ok, level = pcall(function() return Player.Data.Level.Value end)
	if not ok or not level then return end
	local MyLevel = level
	if Sea1 then
		if MyLevel >= 1 and MyLevel <= 10 then
			Mon = "Bandit"
			LevelQuest = 1
			NameQuest = "BanditQuest1"
			NameMon = "Bandit"
			CFrameQuest = CFrame.new(1059, 15, 1550)
			CFrameMon = CFrame.new(1046, 27, 1561)
			elseif MyLevel >= 10 and MyLevel <= 14 then
            Mon= "Monkey"
            LevelQuest = 1
            NameQuest = "JungleQuest"
            NameMon= "Monkey"
            CFrameQuest = CFrame.new(-1598.089,35.55,153.378)
            CFrameMon = CFrame.new(-1448.518,67.853,11.466)
        elseif MyLevel >= 15 and MyLevel <= 29 then
            Mon = "Gorilla"
            LevelQuest = 2
            NameQuest = "JungleQuest"
            NameMon = "Gorilla"
            CFrameQuest = CFrame.new(-1598.089,35.55,153.378)
            CFrameMon = CFrame.new(-1129.884,40.464,-525.424)
        elseif MyLevel >= 30 and MyLevel <= 39 then
            Mon = "Pirate"
            LevelQuest = 1
            NameQuest = "BuggyQuest1"
            NameMon = "Pirate"
            CFrameQuest = CFrame.new(-1141.075,4.1,3831.55)
            CFrameMon = CFrame.new(-1103.513,13.752,3896.091)
        elseif MyLevel >= 40 and MyLevel <= 59 then
            Mon = "Brute"
            LevelQuest = 2
            NameQuest = "BuggyQuest1"
            NameMon = "Brute"
            CFrameQuest = CFrame.new(-1141.075,4.1,3831.55)
            CFrameMon = CFrame.new(-1140.084,14.81,4322.921)
        elseif MyLevel >= 60 and MyLevel <= 74 then
            Mon = "Desert Bandit"
            LevelQuest = 1
            NameQuest = "DesertQuest"
            NameMon = "Desert Bandit"
            CFrameQuest = CFrame.new(894.489,5.14,4392.434)
            CFrameMon = CFrame.new(924.8,6.449,4481.586)
        elseif MyLevel >= 75 and MyLevel <= 89 then
            Mon = "Desert Officer"
            LevelQuest = 2
            NameQuest = "DesertQuest"
            NameMon = "Desert Officer"
            CFrameQuest = CFrame.new(894.489,5.14,4392.434)
            CFrameMon = CFrame.new(1608.282,8.614,4371.007)
        elseif MyLevel >= 90 and MyLevel <= 99 then
            Mon = "Snow Bandit"
            LevelQuest =1
            NameQuest = "SnowQuest"
            NameMon="Snow Bandit"
            CFrameQuest = CFrame.new(1389.745,88.152,-1298.908)
            CFrameMon = CFrame.new(1354.348,87.273,-1393.947)
		end
	end
end

--// Auto Haki (safe)
function AutoHaki()
	local char = Player.Character
	if not char then return end
	if not char:FindFirstChild("HasBuso") and getgenv().AutoHakiEnabled then
		pcall(function() Rep.Remotes.CommF_:InvokeServer("Buso") end)
	end
end
task.spawn(function()
	while task.wait(3) do
		if getgenv().AutoHakiEnabled then pcall(AutoHaki) end
	end
end)

--// HRP shortcut
local function HRP() 
	return Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") 
end

--// Equip / Unequip
local lastUnEquipTime, lastEquipTime = 0, 0
function UnEquipWeapon(Weapon)
	local now = tick()
	if now - lastUnEquipTime >= 1 then
		local char = Player.Character
		if char and char:FindFirstChild(Weapon) then
			getgenv().NotAutoEquip = true
			char[Weapon].Parent = Player.Backpack
			getgenv().NotAutoEquip = false
		end
		lastUnEquipTime = now
	end
end

function EquipWeapon(ToolSe)
	local now = tick()
	if now - lastEquipTime >= 0.5 then        
		if not getgenv().NotAutoEquip then
			local char = Player.Character
			local backpack = Player.Backpack
			if char and backpack then
				local tool = char:FindFirstChild(ToolSe) or backpack:FindFirstChild(ToolSe)
				if tool and char:FindFirstChildOfClass("Humanoid") then
					char.Humanoid:EquipTool(tool)
				end
			end
		end
		lastEquipTime = now
	end
end

--// SmartTP
local function ResetCharacter()
	if Player.Character and Player.Character:FindFirstChild("Humanoid") then
		Player.Character.Humanoid.Health = 0
	end
end

function SmartTP(targetCFrame)
	if not HRP() then return end
	local hrp = HRP()
	local distance = (targetCFrame.Position - hrp.Position).Magnitude

	if distance <= (getgenv().InstantRange or 300) then
		hrp.CFrame = targetCFrame
		return "Instant"
	end
	if distance <= (getgenv().TweenRange or 5000) then
		tween = TweenService:Create(hrp, TweenInfo.new(distance / (getgenv().Speed or 1000), Enum.EasingStyle.Linear), {CFrame = targetCFrame})
		tween:Play()
		tween.Completed:Wait()
		return "Tween"
	end
	ResetCharacter()
	return "Reset"
end

--// StopTween
function StopTween()
	pcall(function()
		getgenv().StopTween = true
		if tween then tween:Cancel(); tween = nil end
		local hrp = HRP()
		if hrp then
			local cf = hrp.CFrame
			hrp.Anchored = true
			task.wait(0.1)
			hrp.CFrame = cf
			hrp.Anchored = false
		end
		getgenv().StopTween, getgenv().Clip = false, false
	end)
end

-- Hàm lấy quest hiện tại (safe)
local function GetQuestTitle()
    local gui = Player:FindFirstChild("PlayerGui")
    if not gui then return nil end
    local main = gui:FindFirstChild("Main")
    if not main then return nil end
    local quest = main:FindFirstChild("Quest")
    if not quest or not quest:FindFirstChild("Container") then return nil end
    local titleFrame = quest.Container:FindFirstChild("QuestTitle")
    if not titleFrame or not titleFrame:FindFirstChild("Title") then return nil end
    if quest.Visible then
        return titleFrame.Title.Text
    end
    return nil
end

-- Hàm nhận quest
local function TakeQuest()
    if not HRP() then return end
    SmartTP(CFrameQuest)
    repeat task.wait() until (HRP().Position - CFrameQuest.Position).Magnitude <= 20
    pcall(function() Rep.Remotes.CommF_:InvokeServer("StartQuest", NameQuest, LevelQuest) end)
end

-- Attack helper (safe)
local function GetEnemiesInRange(character, range)
	local enemies = {}
	local hrp = character and character:FindFirstChild("HumanoidRootPart")
	if not hrp then return enemies end
	for _, mob in ipairs(Enemies:GetChildren()) do
		local mobHRP = mob:FindFirstChild("HumanoidRootPart")
		local hum = mob:FindFirstChildOfClass("Humanoid")
		if mobHRP and hum and (mobHRP.Position - hrp.Position).Magnitude <= range then
			table.insert(enemies, mob)
		end
	end
	return enemies
end

function AttackNoCoolDown()
	pcall(function()
		local character = Player.Character
		if not character then return end
		local equippedWeapon
		for _, item in ipairs(character:GetChildren()) do
			if item:IsA("Tool") then equippedWeapon = item; break end
		end
		if not equippedWeapon then return end

		local enemiesInRange = GetEnemiesInRange(character, 120)
		if equippedWeapon:FindFirstChild("LeftClickRemote") then
			local attackCount = 1
			for _, enemy in ipairs(enemiesInRange) do
				local rootPart = enemy:FindFirstChild("HumanoidRootPart")
				if rootPart then
					local dir = (rootPart.Position - character:GetPivot().Position).Unit
					pcall(function() equippedWeapon.LeftClickRemote:FireServer(dir, attackCount) end)
					attackCount = attackCount + 1
					task.wait(0.03)
				end
			end
		else
			local targets, mainTarget = {}, nil
			for _, enemy in ipairs(enemiesInRange) do
				if not enemy:GetAttribute("IsBoat") then
					local head = enemy:FindFirstChild("Head")
					if head then table.insert(targets, {enemy, head}); mainTarget = head end
				end
			end
			if mainTarget then
				local ok, Net = pcall(function() return Rep.Modules and Rep.Modules.Net end)
				if ok and Net and Net["RE/RegisterAttack"] and Net["RE/RegisterHit"] then
					pcall(function()
						Net["RE/RegisterAttack"]:FireServer(0.1)
						Net["RE/RegisterHit"]:FireServer(mainTarget, targets)
					end)
				end
			end
		end
	end)
end

-- =========================
-- Loops: AutoFarmLoop and FastAttackLoop (use Enabled flags)
-- =========================
local FastAttackThread
local function FastAttackLoop()
	while getgenv().FastAttackEnabled do
		pcall(function()
			-- auto equip selected weapon
			if getgenv().SelectWeapon then EquipWeapon(getgenv().SelectWeapon) end
			if type(AttackNoCoolDown) == "function" then AttackNoCoolDown() end
		end)
		task.wait(0.08)
	end
	FastAttackThread = nil
end

function AutoFarmLoop()
	while getgenv().AutoFarmEnabled do
		task.wait(0.2)
		pcall(function()
			CheckQuest()
			local questTitle = GetQuestTitle()

			-- nếu chưa có quest hoặc quest không khớp thì abandon + take mới
			if not questTitle or not (NameMon and string.find(questTitle, NameMon)) then
				pcall(function() Rep.Remotes.CommF_:InvokeServer("AbandonQuest") end)
				TakeQuest()
				task.wait(0.8)

				-- chờ UI quest xác nhận (timeout an toàn)
				local t0 = tick()
				repeat
					questTitle = GetQuestTitle()
					task.wait(0.15)
				until (questTitle and NameMon and string.find(questTitle, NameMon)) or tick() - t0 > 6
				if not (questTitle and NameMon and string.find(questTitle, NameMon)) then
					warn("[AutoFarm] Failed to confirm quest accept (timeout).")
					return
				end
			end

			-- nếu đã có quest/Mon -> farm
			if Enemies and Enemies.Parent then
				for _, mob in ipairs(Enemies:GetChildren()) do
					if mob and mob.Name == Mon then
						local humanoid = mob:FindFirstChildOfClass("Humanoid")
						local hrp = mob:FindFirstChild("HumanoidRootPart")
						if humanoid and hrp and humanoid.Health > 0 then
							-- tới khu spawn (nếu có)
							if CFrameMon then
								SmartTP(CFrameMon)
								task.wait(0.2)
							end

							-- đứng trên mob
							pcall(function() SmartTP(hrp.CFrame * CFrame.new(0, 20, 5)) end)

							-- cố định mob / neo
							pcall(function()
								hrp.CanCollide = false
								if mob:FindFirstChild("Head") then mob.Head.CanCollide = false end
								humanoid.WalkSpeed = 0
							end)

							-- buff/auto equip/attack
							if getgenv().AutoHakiEnabled then pcall(AutoHaki) end
							if getgenv().SelectWeapon then pcall(function() EquipWeapon(getgenv().SelectWeapon) end) end

							if getgenv().FastAttackEnabled then
								if not FastAttackThread then FastAttackThread = task.spawn(FastAttackLoop) end
							else
								AttackNoCoolDown()
							end

							-- chờ mob chết
							repeat
								task.wait(0.08)
								-- break nếu mob biến mất hoặc chết
							until not getgenv().AutoFarmEnabled or not humanoid or humanoid.Health <= 0 or not mob.Parent

							task.wait(0.2)
						end
					end
				end
			end
		end)
	end
end

--// Button StopTween
Setting:AddButton({
	Name = "Stop Tween",
	Callback = function()
		StopTween()
		pcall(function()
			OrionLib:MakeNotification({
				Name = "Tween Stopped",
				Content = "Đã dừng Tween và reset vị trí.",
				Image = "rbxassetid://4483345998",
				Time = 3
			})
		end)
	end    
})

--// Fast Attack toggle inside Main - replace earlier t3 usage
Main:AddToggle({
	Name = "Fast Attack",
	Default = false,
	Callback = function(Value)
		getgenv().FastAttackEnabled = Value
		if Value then
			if not FastAttackThread then FastAttackThread = task.spawn(FastAttackLoop) end
		end
	end
})

-- done
print("[Mango Hub] Loaded (fixed). Use toggles in GUI. If any console error appears, chụp gửi mình sẽ fix tiếp.")
