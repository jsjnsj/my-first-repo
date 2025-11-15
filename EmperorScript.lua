-- 完整流程甩飞版工具箱 - 完整版
if _G.UniversalUITool and _G.UniversalUITool.MainWindow then
    print("🔧 检测到已存在的UI，正在清理...")
    pcall(function()
        _G.UniversalUITool.MainWindow:Destroy()
    end)
    
    if _G.UniversalUITool.Connections then
        for _, conn in pairs(_G.UniversalUITool.Connections) do
            pcall(function() conn:Disconnect() end)
        end
    end
    
    _G.UniversalUITool = nil
    wait(0.5)
end

_G.UniversalUITool = {
    Connections = {},
    Enabled = true,
    Version = "完整流程甩飞版"
}

local OrionLib = loadstring(game:HttpGet("https://pastebin.com/raw/VeaMSRZK"))()

-- 创建主窗口
local MainWindow = OrionLib:MakeWindow({
    Name = "通用工具箱 - 完整流程甩飞版",
    HidePremium = false,
    SaveConfig = true,
    IntroText = "加载完成 - 瞬移+粘附+冲撞+甩飞+返回",
    ConfigFolder = "MyTools"
})

_G.UniversalUITool.MainWindow = MainWindow

-- 创建标签页
local tabs = {
    ["主功能"] = MainWindow:MakeTab({
        Name = "主功能",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    }),
    ["帅飞"] = MainWindow:MakeTab({
        Name = "帅飞",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    }),
    ["旋转"] = MainWindow:MakeTab({
        Name = "旋转",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    }),
    ["飞行"] = MainWindow:MakeTab({
        Name = "？？？",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    }),
    ["设置"] = MainWindow:MakeTab({
        Name = "设置",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })
}

-- 主功能页面
tabs["主功能"]:AddLabel("=== 核心功能 ===")

-- 无限跳跃功能
local InfiniteJumpEnabled = false
local JumpConnection

tabs["主功能"]:AddToggle({
    Name = "无限跳跃",
    Default = false,
    Callback = function(v)
        if v then
            InfiniteJumpEnabled = true
            JumpConnection = game:GetService("UserInputService").JumpRequest:Connect(function()
                if InfiniteJumpEnabled then
                    local character = game.Players.LocalPlayer.Character
                    if character and character:FindFirstChildOfClass("Humanoid") then
                        character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end
            end)
        else
            InfiniteJumpEnabled = false
            if JumpConnection then
                JumpConnection:Disconnect()
            end
        end
    end
})

-- 移动速度设置
tabs["主功能"]:AddTextbox({
    Name = "设置移动速度",
    Default = "",
    PlaceholderText = "输入速度值（16-200）",
    Callback = function(speedText)
        if speedText ~= "" then
            local speed = tonumber(speedText)
            if speed and speed >= 16 and speed <= 200 then
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChildOfClass("Humanoid") then
                    char.Humanoid.WalkSpeed = speed
                end
            end
        end
    end
})

-- ==================== 【真实摩擦摸78道具】 ====================
tabs["主功能"]:AddLabel("")
tabs["主功能"]:AddLabel("=== 真实摩擦摸78 ===")

-- 创建真实摩擦摸78道具
local function CreateRealFriction78Tool()
    local player = game.Players.LocalPlayer
    local backpack = player:FindFirstChild("Backpack")
    local character = player.Character
    
    -- 移除旧道具
    if backpack then
        for _, tool in pairs(backpack:GetChildren()) do
            if tool.Name == "真实摩擦摸78神器" then
                tool:Destroy()
            end
        end
    end
    
    if character then
        for _, tool in pairs(character:GetChildren()) do
            if tool.Name == "真实摩擦摸78神器" then
                tool:Destroy()
            end
        end
    end
    
    -- 创建新道具
    local tool = Instance.new("Tool")
    tool.Name = "真实摩擦摸78神器"
    tool.ToolTip = "拿在手上真实摩擦摸78，放下停止"
    
    -- 设置道具外观
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(0.8, 1.5, 0.8)
    handle.BrickColor = BrickColor.new("Bright red")
    handle.Material = Enum.Material.Neon
    handle.Parent = tool
    
    -- 添加特效
    local particle = Instance.new("ParticleEmitter")
    particle.Texture = "rbxassetid://242019912"
    particle.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0))
    particle.Size = NumberSequence.new(0.3)
    particle.Lifetime = NumberRange.new(1, 2)
    particle.Rate = 15
    particle.Parent = handle
    
    -- 存储动画状态
    local isFrictionActive = false
    local frictionConnection = nil
    
    -- 装备事件 - 开始真实摩擦摸78
    tool.Equipped:Connect(function()
        OrionLib:MakeNotification({
            Name = "摩擦摸78开始",
            Content = "真实摩擦摸78模式已启动！",
            Time = 3
        })
        
        local character = player.Character
        if not character then return end
        
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        local rightArm = character:FindFirstChild("RightArm") or character:FindFirstChild("RightHand")
        
        if not humanoid or not rootPart or not rightArm then return end
        
        isFrictionActive = true
        
        -- 开始真实摩擦摸78动画
        local animationTime = 0
        frictionConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if not isFrictionActive then
                frictionConnection:Disconnect()
                return
            end
            
            animationTime = animationTime + 0.1
            
            -- 真实摩擦摸78动画 - 手在中下部位来回摩擦
            local frictionOffset = math.sin(animationTime * 6) * 0.4  -- 左右摩擦幅度
            local verticalOffset = math.sin(animationTime * 12) * 0.1 -- 轻微上下运动
            
            -- 计算中下部位的位置（腰部以下）
            local lowerBodyPosition = rootPart.Position - Vector3.new(0, 1.5, 0)
            
            -- 设置手的位置到中下部位并来回摩擦
            rightArm.CFrame = CFrame.new(
                lowerBodyPosition.X + frictionOffset,  -- X轴左右摩擦
                lowerBodyPosition.Y + verticalOffset,  -- Y轴轻微上下
                lowerBodyPosition.Z                   -- Z轴保持
            ) * CFrame.Angles(0, 0, math.rad(90))    -- 手部旋转
            
            -- 道具发光效果
            if tool:FindFirstChild("Handle") then
                local brightness = math.sin(animationTime * 4) * 0.3 + 0.7
                tool.Handle.BrickColor = BrickColor.new(Color3.new(brightness, 0, 0))
            end
        end)
    end)
    
    -- 卸下事件 - 停止摩擦摸78
    tool.Unequipped:Connect(function()
        isFrictionActive = false
        
        if frictionConnection then
            frictionConnection:Disconnect()
            frictionConnection = nil
        end
        
        -- 恢复手臂位置
        local character = player.Character
        if character then
            local rightArm = character:FindFirstChild("RightArm") or character:FindFirstChild("RightHand")
            if rightArm then
                -- 让手臂自然下垂
                rightArm.CFrame = CFrame.new(rightArm.Position) * CFrame.Angles(0, 0, 0)
            end
        end
        
        OrionLib:MakeNotification({
            Name = "摩擦摸78停止",
            Content = "真实摩擦摸78已停止",
            Time = 2
        })
    end)
    
    -- 将道具添加到背包
    tool.Parent = backpack
    
    OrionLib:MakeNotification({
        Name = "道具生成",
        Content = "真实摩擦摸78神器已添加到背包！",
        Time = 3
    })
    
    return tool
end

-- 生成真实摩擦摸78道具按钮
tabs["主功能"]:AddButton({
    Name = "🔄 生成真实摩擦摸78神器",
    Callback = function()
        local success, errorMsg = pcall(function()
            CreateRealFriction78Tool()
        end)
        
        if not success then
            OrionLib:MakeNotification({
                Name = "生成失败",
                Content = "错误: " .. tostring(errorMsg),
                Time = 4
            })
        end
    end
})

-- 自动装备功能
tabs["主功能"]:AddToggle({
    Name = "⚡ 自动装备摩擦神器",
    Default = false,
    Callback = function(v)
        if v then
            OrionLib:MakeNotification({
                Name = "自动装备",
                Content = "自动装备功能已开启",
                Time = 2
            })
            
            local player = game.Players.LocalPlayer
            local backpack = player:FindFirstChild("Backpack")
            
            if backpack then
                local function AutoEquipFrictionTool()
                    for _, tool in pairs(backpack:GetChildren()) do
                        if tool.Name == "真实摩擦摸78神器" and tool:IsA("Tool") then
                            pcall(function()
                                if player.Character then
                                    tool.Parent = player.Character
                                end
                            end)
                        end
                    end
                end
                
                -- 初始检查
                AutoEquipFrictionTool()
                
                -- 监听背包变化
                _G.AutoFrictionEquipConnection = backpack.ChildAdded:Connect(function(child)
                    if child.Name == "真实摩擦摸78神器" and child:IsA("Tool") then
                        wait(0.5)
                        AutoEquipFrictionTool()
                    end
                end)
            end
        else
            if _G.AutoFrictionEquipConnection then
                _G.AutoFrictionEquipConnection:Disconnect()
            end
            OrionLib:MakeNotification({
                Name = "自动装备",
                Content = "自动装备功能已关闭",
                Time = 2
            })
        end
    end
})

-- 移除所有摩擦道具
tabs["主功能"]:AddButton({
    Name = "🗑️ 移除摩擦摸78道具",
    Callback = function()
        local player = game.Players.LocalPlayer
        
        -- 从背包移除
        local backpack = player:FindFirstChild("Backpack")
        if backpack then
            for _, tool in pairs(backpack:GetChildren()) do
                if tool.Name == "真实摩擦摸78神器" then
                    tool:Destroy()
                end
            end
        end
        
        -- 从角色移除
        local character = player.Character
        if character then
            for _, tool in pairs(character:GetChildren()) do
                if tool.Name == "真实摩擦摸78神器" then
                    tool:Destroy()
                end
            end
        end
        
        OrionLib:MakeNotification({
            Name = "清理完成",
            Content = "摩擦摸78道具已移除",
            Time = 3
        })
    end
})

-- ==================== 【完整流程甩飞功能】 ====================
tabs["帅飞"]:AddLabel("=== 完整流程甩飞 ===")

-- 获取所有玩家列表
local function GetPlayerList()
    local players = {}
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            table.insert(players, player)
        end
    end
    return players
end

-- 随机选择玩家
local function GetRandomPlayer()
    local players = GetPlayerList()
    if #players > 0 then
        return players[math.random(1, #players)]
    else
        return nil
    end
end

-- 强力甩飞功能
local function SuperLaunchPlayer(targetPlayer, launchPower)
    if not targetPlayer or not targetPlayer.Character then
        return false
    end
    
    local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not targetRoot then
        return false
    end
    
    -- 先移除可能存在的物理效果
    for _, obj in pairs(targetRoot:GetChildren()) do
        if obj:IsA("BodyVelocity") or obj:IsA("BodyForce") or obj:IsA("BodyThrust") then
            obj:Destroy()
        end
    end
    
    -- 禁用碰撞，防止被地面阻挡
    for _, part in pairs(targetPlayer.Character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
    
    -- 使用多种物理效果组合确保能甩飞
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0, launchPower, 0)
    bodyVelocity.MaxForce = Vector3.new(0, math.huge, 0)
    bodyVelocity.P = 10000
    bodyVelocity.Parent = targetRoot
    
    local bodyForce = Instance.new("BodyForce")
    bodyForce.Force = Vector3.new(0, launchPower * 200, 0)
    bodyForce.Parent = targetRoot
    
    local bodyThrust = Instance.new("BodyThrust")
    bodyThrust.Force = Vector3.new(0, launchPower * 100, 0)
    bodyThrust.Location = Vector3.new(0, 0, 0)
    bodyThrust.Parent = targetRoot
    
    local spinVelocity = Instance.new("BodyAngularVelocity")
    spinVelocity.AngularVelocity = Vector3.new(math.random(-10, 10), math.random(-10, 10), math.random(-10, 10))
    spinVelocity.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    spinVelocity.Parent = targetRoot
    
    -- 5秒后清理效果并恢复碰撞
    delay(5, function()
        -- 恢复碰撞
        for _, part in pairs(targetPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
        -- 清理物理效果
        if bodyVelocity and bodyVelocity.Parent then bodyVelocity:Destroy() end
        if bodyForce and bodyForce.Parent then bodyForce:Destroy() end
        if bodyThrust and bodyThrust.Parent then bodyThrust:Destroy() end
        if spinVelocity and spinVelocity.Parent then spinVelocity:Destroy() end
    end)
    
    return true
end

-- 完整流程甩飞的核心功能
local function CompleteLaunchProcess(targetPlayer, attachTime, collisionSpeed, launchPower)
    if not targetPlayer or not targetPlayer.Character then
        return false
    end
    
    local myCharacter = game.Players.LocalPlayer.Character
    if not myCharacter then
        return false
    end
    
    local myRoot = myCharacter:FindFirstChild("HumanoidRootPart")
    local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
    
    if not myRoot or not targetRoot then
        return false
    end
    
    -- 保存原始位置
    local originalPosition = myRoot.Position
    local originalCFrame = myRoot.CFrame
    
    -- 步骤1: 瞬移到玩家面前
    OrionLib:MakeNotification({
        Name = "开始流程",
        Content = "瞬移到 " .. targetPlayer.Name .. " 面前，开始粘附",
        Time = 3
    })
    
    -- 瞬移到目标玩家面前
    local targetPosition = targetRoot.Position
    local targetLookVector = targetRoot.CFrame.LookVector
    local spawnPosition = targetPosition - (targetLookVector * (_G.AttachDistance or 3))
    
    myRoot.CFrame = CFrame.new(spawnPosition, targetPosition)
    
    -- 步骤2: 开始粘附（跟随目标）
    local isAttached = true
    local attachConnection
    
    attachConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not isAttached or not targetPlayer.Character or not myCharacter then
            if attachConnection then
                attachConnection:Disconnect()
            end
            return
        end
        
        -- 持续跟随目标玩家
        local currentTargetPosition = targetRoot.Position
        local currentTargetLookVector = targetRoot.CFrame.LookVector
        local followPosition = currentTargetPosition - (currentTargetLookVector * (_G.AttachDistance or 3))
        
        -- 平滑移动到目标位置
        myRoot.CFrame = myRoot.CFrame:Lerp(CFrame.new(followPosition, currentTargetPosition), 0.3)
    end)
    
    -- 步骤3: 粘附结束后开始高速冲撞
    delay(attachTime, function()
        isAttached = false -- 停止粘附
        
        if attachConnection then
            attachConnection:Disconnect()
        end
        
        if targetPlayer.Character and targetRoot then
            -- 开始高速冲撞
            OrionLib:MakeNotification({
                Name = "开始冲撞",
                Content = "粘附结束，开始高速冲撞！",
                Time = 2
            })
            
            -- 保存原始速度
            local originalSpeed = myCharacter.Humanoid.WalkSpeed
            
            -- 设置高速
            myCharacter.Humanoid.WalkSpeed = collisionSpeed
            
            -- 计算冲向目标的方向
            local chargeVelocity = Instance.new("BodyVelocity")
            chargeVelocity.Velocity = (targetRoot.Position - myRoot.Position).Unit * collisionSpeed
            chargeVelocity.MaxForce = Vector3.new(math.huge, 0, math.huge)
            chargeVelocity.Parent = myRoot
            
            -- 监听碰撞
            local collisionConnection
            collisionConnection = game:GetService("RunService").Heartbeat:Connect(function()
                if not targetPlayer.Character or not myCharacter then
                    if collisionConnection then
                        collisionConnection:Disconnect()
                    end
                    return
                end
                
                local myPos = myRoot.Position
                local targetPos = targetRoot.Position
                local distance = (myPos - targetPos).Magnitude
                
                -- 当距离很近时，触发碰撞效果
                if distance < 5 then
                    if collisionConnection then
                        collisionConnection:Disconnect()
                    end
                    
                    -- 步骤4: 碰撞后把目标玩家强力甩飞上天
                    OrionLib:MakeNotification({
                        Name = "碰撞成功",
                        Content = "撞到 " .. targetPlayer.Name .. "，强力甩飞！",
                        Time = 2
                    })
                    
                    -- 移除冲撞力
                    if chargeVelocity then
                        chargeVelocity:Destroy()
                    end
                    
                    -- 恢复自己的速度
                    myCharacter.Humanoid.WalkSpeed = originalSpeed
                    
                    -- 使用强力甩飞方法
                    SuperLaunchPlayer(targetPlayer, launchPower)
                    
                    -- 步骤5: 2秒后返回原位置
                    delay(2, function()
                        -- 返回原始位置
                        OrionLib:MakeNotification({
                            Name = "返回原位",
                            Content = "甩飞完成，正在返回原位置",
                            Time = 2
                        })
                        
                        -- 瞬移回原始位置
                        myRoot.CFrame = originalCFrame
                        
                        OrionLib:MakeNotification({
                            Name = "流程完成",
                            Content = "完整流程执行完毕！",
                            Time = 3
                        })
                    end)
                end
            end)
            
            -- 超时保护（10秒后自动停止）
            delay(10, function()
                if collisionConnection then
                    collisionConnection:Disconnect()
                end
                if chargeVelocity and chargeVelocity.Parent then
                    chargeVelocity:Destroy()
                end
                myCharacter.Humanoid.WalkSpeed = originalSpeed
                
                -- 超时也返回原位置
                myRoot.CFrame = originalCFrame
            end)
        end
    end)
    
    return true
end

-- 功能1: 完整流程甩飞
tabs["帅飞"]:AddButton({
    Name = "🎯 随机完整流程甩飞",
    Callback = function()
        local randomPlayer = GetRandomPlayer()
        if randomPlayer then
            local success = CompleteLaunchProcess(
                randomPlayer, 
                _G.AttachTime or 3, 
                _G.CollisionSpeed or 100, 
                _G.LaunchPower or 200
            )
            if success then
                OrionLib:MakeNotification({
                    Name = "流程开始",
                    Content = "开始对 " .. randomPlayer.Name .. " 执行完整流程",
                    Time = 3
                })
            end
        else
            OrionLib:MakeNotification({
                Name = "没有玩家",
                Content = "没有找到其他玩家",
                Time = 3
            })
        end
    end
})

-- 功能2: 单独测试甩飞
tabs["帅飞"]:AddButton({
    Name = "💥 单独测试强力甩飞",
    Callback = function()
        local randomPlayer = GetRandomPlayer()
        if randomPlayer then
            local success = SuperLaunchPlayer(randomPlayer, _G.LaunchPower or 200)
            if success then
                OrionLib:MakeNotification({
                    Name = "甩飞测试",
                    Content = "正在强力甩飞 " .. randomPlayer.Name,
                    Time = 3
                })
            end
        end
    end
})

-- 功能3: 设置参数
tabs["帅飞"]:AddTextbox({
    Name = "粘附时间（秒）",
    Default = "3",
    PlaceholderText = "输入粘附时间（1-5秒）",
    Callback = function(timeText)
        if timeText ~= "" then
            local time = tonumber(timeText)
            if time and time >= 1 and time <= 5 then
                _G.AttachTime = time
                OrionLib:MakeNotification({
                    Name = "粘附时间",
                    Content = "粘附时间已设置为: " .. time .. "秒",
                    Time = 3
                })
            end
        end
    end
})

tabs["帅飞"]:AddTextbox({
    Name = "冲撞速度",
    Default = "100",
    PlaceholderText = "输入冲撞速度（50-300）",
    Callback = function(speedText)
        if speedText ~= "" then
            local speed = tonumber(speedText)
            if speed and speed >= 50 and speed <= 300 then
                _G.CollisionSpeed = speed
                OrionLib:MakeNotification({
                    Name = "冲撞速度",
                    Content = "冲撞速度已设置为: " .. speed,
                    Time = 3
                })
            end
        end
    end
})

tabs["帅飞"]:AddTextbox({
    Name = "甩飞力度",
    Default = "200",
    PlaceholderText = "输入甩飞力度（100-1000）",
    Callback = function(powerText)
        if powerText ~= "" then
            local power = tonumber(powerText)
            if power and power >= 100 and power <= 1000 then
                _G.LaunchPower = power
                OrionLib:MakeNotification({
                    Name = "甩飞力度",
                    Content = "甩飞力度已设置为: " .. power,
                    Time = 3
                })
            end
        end
    end
})

tabs["帅飞"]:AddTextbox({
    Name = "粘附距离",
    Default = "3",
    PlaceholderText = "输入粘附距离（1-10）",
    Callback = function(distanceText)
        if distanceText ~= "" then
            local distance = tonumber(distanceText)
            if distance and distance >= 1 and distance <= 10 then
                _G.AttachDistance = distance
                OrionLib:MakeNotification({
                    Name = "粘附距离",
                    Content = "粘附距离已设置为: " .. distance,
                    Time = 3
                })
            end
        end
    end
})

-- 旋转功能页面
tabs["旋转"]:AddLabel("=== 旋转功能 ===")

-- 旋转速度输入框
tabs["旋转"]:AddTextbox({
    Name = "设置旋转速度",
    Default = "",
    PlaceholderText = "输入旋转速度（1-300）",
    Callback = function(speedText)
        if speedText ~= "" then
            local speed = tonumber(speedText)
            if speed then
                if speed >= 1 and speed <= 300 then
                    -- 如果已经开启旋转，更新速度
                    if _G.SpinEffect and _G.SpinEffect.Parent then
                        _G.SpinEffect.AngularVelocity = Vector3.new(0, speed, 0)
                        OrionLib:MakeNotification({
                            Name = "旋转速度",
                            Content = "旋转速度已更新为: " .. speed,
                            Time = 3
                        })
                    else
                        OrionLib:MakeNotification({
                            Name = "提示",
                            Content = "请先开启旋转功能",
                            Time = 3
                        })
                    end
                else
                    OrionLib:MakeNotification({
                        Name = "输入错误",
                        Content = "旋转速度应在1-300之间",
                        Time = 3
                    })
                end
            else
                OrionLib:MakeNotification({
                    Name = "输入错误",
                    Content = "请输入有效的数字",
                    Time = 3
                })
            end
        end
    end
})

-- 旋转开关
tabs["旋转"]:AddToggle({
    Name = "💫 开启/关闭旋转",
    Default = false,
    Callback = function(v)
        if v then
            -- 开启旋转
            local character = game.Players.LocalPlayer.Character
            if character then
                local rootPart = character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    -- 先移除旧的旋转效果
                    if _G.SpinEffect then
                        _G.SpinEffect:Destroy()
                    end
                    
                    -- 创建新的旋转效果
                    local spin = Instance.new("BodyAngularVelocity")
                    spin.AngularVelocity = Vector3.new(0, _G.CurrentSpinSpeed or 20, 0)
                    spin.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                    spin.Parent = rootPart
                    _G.SpinEffect = spin
                    
                    OrionLib:MakeNotification({
                        Name = "旋转开启",
                        Content = "旋转已开启，速度: " .. (_G.CurrentSpinSpeed or 20),
                        Time = 3
                    })
                end
            end
        else
            -- 关闭旋转
            if _G.SpinEffect then
                _G.SpinEffect:Destroy()
                _G.SpinEffect = nil
                OrionLib:MakeNotification({
                    Name = "旋转关闭",
                    Content = "旋转已关闭",
                    Time = 2
                })
            end
        end
    end
})

-- 快速预设按钮
tabs["旋转"]:AddLabel("=== 快速预设 ===")

local spinPresets = {
    {"慢速旋转 (10)", 10},
    {"中速旋转 (50)", 50},
    {"快速旋转 (100)", 100},
    {"极速旋转 (200)", 200},
    {"超速旋转 (300)", 300}
}

for i, preset in ipairs(spinPresets) do
    tabs["旋转"]:AddButton({
        Name = preset[1],
        Callback = function()
            _G.CurrentSpinSpeed = preset[2]
            if _G.SpinEffect and _G.SpinEffect.Parent then
                _G.SpinEffect.AngularVelocity = Vector3.new(0, preset[2], 0)
                OrionLib:MakeNotification({
                    Name = "旋转速度",
                    Content = "旋转速度已设置为: " .. preset[2],
                    Time = 2
                })
            else
                OrionLib:MakeNotification({
                    Name = "提示",
                    Content = "预设已保存，请先开启旋转功能",
                    Time = 3
                })
            end
        end
    })
end

-- 设置页面
tabs["设置"]:AddLabel("=== 系统设置 ===")

tabs["设置"]:AddButton({
    Name = "重新加载UI",
    Callback = function()
        OrionLib:MakeNotification({
            Name = "重新加载",
            Content = "3秒后重新加载...",
            Time = 3
        })
        wait(3)
        pcall(function() MainWindow:Destroy() end)
        for _, conn in pairs(_G.UniversalUITool.Connections) do
            pcall(function() conn:Disconnect() end)
        end
        _G.UniversalUITool = nil
    end
})

-- 初始化参数
_G.AttachTime = 3
_G.AttachDistance = 3
_G.CollisionSpeed = 100
_G.LaunchPower = 200
_G.CurrentSpinSpeed = 20
_G.FlySpeed = 50

-- 添加快捷键
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.F9 then
        MainWindow:ToggleUI()
    end
end)

OrionLib:MakeNotification({
    Name = "✅ 完整工具箱加载成功",
    Content = "包含：甩飞+旋转+飞行+摸78功能！",
    Time = 4
})

print("=== 完整工具箱加载完成 ===")
