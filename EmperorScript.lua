-- ==========================================================
--  皇帝脚本 完整复刻版（卡密+滑动+隐藏）
-- ==========================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local UI = Instance.new("Frame")
UI.Name = "这里是卡密系统的名字"
UI.Parent = ScreenGui
UI.Active = true
UI.BackgroundColor3 = Color3.new(0, 0, 0)
UI.BorderSizePixel = 3
UI.Position = UDim2.new(0.5, -150, 0.5, -67)
UI.Size = UDim2.new(0, 260, 0, 250)
UI.Draggable = true

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = UI
Title.BackgroundTransparency = 1
Title.BorderSizePixel = 2
Title.Position = UDim2.new(0, 0, 0.02, 0)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Font = Enum.Font.SourceSans
Title.Text = "密钥系统"
Title.TextColor3 = Color3.new(0, 0, 255)
Title.TextScaled = true

local bar = Instance.new("Frame")
bar.Parent = Title
bar.BackgroundColor3 = Color3.new(0, 0, 255)
bar.BorderSizePixel = 0
bar.Position = UDim2.new(0.07, 0, 0.9, 0)
bar.Size = UDim2.new(0.85, 0, 0, 6)

local Key = Instance.new("TextBox")
Key.Name = "Key"
Key.Parent = UI
Key.BackgroundColor3 = Color3.new(1, 1, 1)
Key.BorderSizePixel = 0
Key.Position = UDim2.new(0.1, 0, 0.31, 0)
Key.Size = UDim2.new(0.8, 0, 0, 50)
Key.Font = Enum.Font.SourceSans
Key.PlaceholderText = "输入钥密"
Key.Text = ""
Key.TextColor3 = Color3.new(0, 0, 0)
Key.TextScaled = true

local Start = Instance.new("TextButton")
Start.Name = "Start"
Start.Parent = UI
Start.BackgroundColor3 = Color3.new(0, 0, 255)
Start.BorderSizePixel = 2
Start.Position = UDim2.new(0.25, 0, 0.65, 0)
Start.Size = UDim2.new(0.5, 0, 0, 45)
Start.Font = Enum.Font.Gotham
Start.Text = "检查卡密"
Start.TextColor3 = Color3.new(0, 0, 0)
Start.TextScaled = true

-- ==========================================================
--  卡密验证 → 欢迎语 → 主脚本
-- ==========================================================
Start.MouseButton1Click:Connect(function()
    if Key.Text == "皇帝最帅" then
        UI.Visible = false
        local Welcome = Instance.new("ScreenGui")
        Welcome.Name = "WelcomeGui"
        Welcome.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
        Welcome.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

        local W = Instance.new("ImageLabel")
        W.Name = "W"
        W.Parent = Welcome
        W.AnchorPoint = Vector2.new(0.5, 0.5)
        W.Position = UDim2.new(0.5, 0, 0.5, 0)
        W.Size = UDim2.new(0, 0, 0, 0)
        W.BackgroundTransparency = 1
        W.Image = "rbxassetid://4641149554"
        W.ScaleType = Enum.ScaleType.Slice
        W.SliceCenter = Rect.new(128, 128, 128, 128)
        W.ImageColor3 = Color3.fromRGB(60, 60, 60)

        local T = Instance.new("TextLabel")
        T.Name = "T"
        T.Parent = W
        T.Size = UDim2.new(1, 0, 0.6, 0)
        T.Position = UDim2.new(0, 0, 0.1, 0)
        T.BackgroundTransparency = 1
        T.Text = "欢迎使用皇帝脚本！"
        T.Font = Enum.Font.GothamBold
        T.TextColor3 = Color3.new(1, 1, 1)
        T.TextScaled = true

        local B = Instance.new("TextButton")
        B.Name = "B"
        B.Parent = W
        B.Size = UDim2.new(0.4, 0, 0.2, 0)
        B.Position = UDim2.new(0.5, 0, 0.75, 0)
        B.AnchorPoint = Vector2.new(0.5, 0.5)
        B.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        B.BorderSizePixel = 0
        B.Font = Enum.Font.Gotham
        B.Text = "进入脚本"
        B.TextColor3 = Color3.new(1, 1, 1)
        B.TextScaled = true

        W:TweenSize(UDim2.new(0, 350, 0, 200),
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Back,
                    0.6, true)

        local autoEnter = task.delay(5, function()
            if Welcome.Parent then Welcome:Destroy() end
            loadMainScript()
        end)

        B.MouseButton1Click:Connect(function()
            task.cancel(autoEnter)
            Welcome:Destroy()
            loadMainScript()
        end)
    else
        game.Players.LocalPlayer:Kick("卡密不对你就受着呗😂")
    end
end)

-- ==========================================================
--  主脚本（滑动按钮区 + 所有功能）
-- ==========================================================
function loadMainScript()
    local Players = game:GetService("Players")
    local Run = game:GetService("RunService")
    local LP = Players.LocalPlayer

    if LP.PlayerGui:FindFirstChild("MainGUI") then LP.PlayerGui.MainGUI:Destroy() end

    local gui = Instance.new("ScreenGui")
    gui.Name = "MainGUI"
    gui.Parent = LP.PlayerGui
    gui.ResetOnSpawn = false

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 280, 0, 420)
    frame.Position = UDim2.new(0.02, 0, 0.15, 0)
    frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Parent = gui

    local top = Instance.new("Frame")
    top.Size = UDim2.new(1, 0, 0, 30)
    top.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    top.BorderSizePixel = 0
    top.Parent = frame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 1, 0)
    title.BackgroundTransparency = 1
    title.Text = "皇帝脚本 作者不想玩墨水"
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 18
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Parent = top

    local timeLab = Instance.new("TextLabel")
    timeLab.Size = UDim2.new(1, 0, 0, 25)
    timeLab.Position = UDim2.new(0, 0, 0, 30)
    timeLab.BackgroundTransparency = 1
    timeLab.Text = "北京时间：--:--:--"
    timeLab.Font = Enum.Font.SourceSans
    timeLab.TextSize = 16
    timeLab.TextColor3 = Color3.new(1, 1, 1)
    timeLab.Parent = frame
    Run.Heartbeat:Connect(function()
        timeLab.Text = "北京时间：" .. os.date("%H时%M分%S")
    end)

    -- ****** 滑动按钮区 ******
    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, 0, 1, -80)
    scroll.Position = UDim2.new(0, 0, 0, 55)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 6
    scroll.ScrollingDirection = Enum.ScrollingDirection.Y
    scroll.Parent = frame

    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 5)
    layout.Parent = scroll

    local function btn(txt, y, callback)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(0, 260, 0, 30)
        b.Position = UDim2.new(0.5, 0, 0, y)
        b.AnchorPoint = Vector2.new(0.5, 0)
        b.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        b.BorderSizePixel = 0
        b.Font = Enum.Font.Gotham
        b.TextSize = 16
        b.TextColor3 = Color3.new(1, 1, 1)
        b.Text = txt
        b.Parent = scroll
        b.MouseButton1Click:Connect(callback)
        return b
    end

    btn("视野 +20", 70, function() workspace.CurrentCamera.FieldOfView += 20 end)
    btn("缩放距离 50", 105, function() LP.CameraMaxZoomDistance = 50 end)
    btn("步行速度 32", 140, function()
        local char = LP.Character or LP.CharacterAdded:Wait()
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = 32 end
    end)
    btn("跳跃高度 100", 175, function()
        local char = LP.Character or LP.CharacterAdded:Wait()
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.UseJumpPower = true; hum.JumpPower = 100 end
    end)
    btn("重力 50", 210, function() workspace.Gravity = 50 end)

    btn("无敌少侠飞行", 245, function()
        local UserInputService = game:GetService("UserInputService")
        local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
        local ok, err = pcall(function()
            if isMobile then
                loadstring(game:HttpGet("https://raw.githubusercontent.com/396abc/Script/refs/heads/main/MobileFly.lua"))()
            else
                loadstring(game:HttpGet("https://raw.githubusercontent.com/396abc/Script/refs/heads/main/FlyR15.lua"))()
            end
        end)
        game.StarterGui:SetCore("SendNotification", {
            Title = "飞行",
            Text = ok and (isMobile and "已启动 MobileFly" or "已启动 FlyR15") or "加载失败：" .. tostring(err),
            Duration = 3
        })
    end)

    btn("力量 2x", 280, function()
        local char = LP.Character or LP.CharacterAdded:Wait()
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.NameDisplayDistance = 100 end
    end)

    local fpsLbl, fpsCon = nil, nil
    btn("FPS 显示 开关", 315, function()
        if fpsLbl and fpsLbl.Parent then
            fpsLbl:Destroy()
            if fpsCon then fpsCon:Disconnect(); fpsCon = nil end
            return
        end
        fpsLbl = Instance.new("TextLabel")
        fpsLbl.Size = UDim2.new(0, 120, 0, 25)
        fpsLbl.Position = UDim2.new(1, -125, 1, -30)
        fpsLbl.BackgroundTransparency = 1
        fpsLbl.TextColor3 = Color3.new(1, 1, 1)
        fpsLbl.Font = Enum.Font.SourceSans
        fpsLbl.TextSize = 16
        fpsLbl.Parent = gui
        local st, cnt = tick(), 0
        fpsCon = Run.Heartbeat:Connect(function()
            cnt = cnt + 1
            if tick() - st >= 1 then
                fpsLbl.Text = "FPS: " .. cnt
                cnt, st = 0, tick()
            end
        end)
    end)

    btn("Infinite Yield FE", 350, function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end)

    -- 右下角隐藏/显示开关
    local switchGUI = Instance.new("ScreenGui")
    switchGUI.Name = "SwitchGUI"
    switchGUI.Parent = LP.PlayerGui
    switchGUI.ResetOnSpawn = false

    local switchBtn = Instance.new("TextButton")
    switchBtn.Size = UDim2.new(0, 120, 0, 35)
    switchBtn.Position = UDim2.new(1, -130, 1, -45)
    switchBtn.AnchorPoint = Vector2.new(1, 1)
    switchBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    switchBtn.BorderSizePixel = 0
    switchBtn.Font = Enum.Font.SourceSansBold
    switchBtn.TextSize = 16
    switchBtn.TextColor3 = Color3.new(1, 1, 1)
    switchBtn.Text = "隐藏 UI"
    switchBtn.Parent = switchGUI

    local uiVisible = true
    switchBtn.MouseButton1Click:Connect(function()
        uiVisible = not uiVisible
        gui.Enabled = uiVisible
        switchBtn.Text = uiVisible and "隐藏 UI" or "显示 UI"
        switchBtn.BackgroundColor3 = uiVisible and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 0, 0)
    end)
end
-- ==========================================================
--  到此全部结束，直接复制进 Executor 运行即可
-- ==========================================================
