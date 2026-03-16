-- [ BYPASS ADONIS & ANTI-CHEAT AMAN V2 (Expanded) ]
if not game:IsLoaded() then game.Loaded:Wait() end

local old_identity = getthreadidentity()
setthreadidentity(2) 

-- 1. Hook Garbage Collector (GC)
task.spawn(function()
    local patched = 0
    for _, func in ipairs(getgc(true)) do
        if typeof(func) == "function" and islclosure(func) then
            local ok, consts = pcall(debug.getconstants, func)
            if ok and consts and #consts <= 2 then
                for i, c in ipairs(consts) do
                    if tostring(c):lower():find("script") == nil and tostring(c):lower():find("rbx") == nil then
                        local src = debug.info(func, "s") or ""
                        if src:find("Anti") or src:lower():find("core") then
                            hookfunction(func, function(...) return end)
                            patched += 1
                        end
                    end
                end
            end
        end
    end
    print("🛡️ [Anti-Cheat] Crash loop ditambal:", patched)
end)

task.defer(function()
    for _, v in getgc(true) do
        if typeof(v) == "table" and rawget(v, "Kill") and typeof(v.Kill) == "function" then
            hookfunction(v.Kill, function(...) return end)
        end
    end
end)

-- 2. Spoof debug.info (Metode Overflow yang Sukses)
local old_debug_info = debug.info
hookfunction(debug.info, newcclosure(function(func, what)
    -- Membiarkan stack overflow terjadi secara natural jika Adonis mengecek
    if typeof(func) == "function" and debug.info(func, "s") and debug.info(func, "s"):find("Core.Anti") then
        if what == "n" then return "Detected" end
        if what == "f" then return func end
        if what == "s" then return debug.info(func, "s") end
        if what == "l" then return debug.info(func, "l") end
        if what == "a" then return debug.info(func, "a") end
    end
    return old_debug_info(func, what)
end))

-- 3. [PENGEMBANGAN] Hook Metatable untuk Blokir Remote Kick/Ban
local gm = getrawmetatable(game)
setreadonly(gm, false)
local old_namecall = gm.__namecall

gm.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    -- Jika Adonis mencoba memanggil server untuk kick/ban/crash
    if not checkcaller() and (method == "FireServer" or method == "InvokeServer") then
        for _, arg in ipairs(args) do
            if type(arg) == "string" then
                local lower_arg = arg:lower()
                if lower_arg:find("kick") or lower_arg:find("ban") or lower_arg:find("crash") or lower_arg:find("0xdd24f") then
                    return -- Hentikan pengiriman ke server
                end
            end
        end
    end
    
    return old_namecall(self, ...)
end)
setreadonly(gm, true)

setthreadidentity(old_identity)
print("🛡️ [Bypass Expanded] Namecall Protection Active")
-- [ END BYPASS ADONIS ]

local J = game:GetService("Players")
local q = game:GetService("CoreGui")
local N = game:GetService("UserInputService")
local W = game:GetService("VirtualInputManager")
local v = J.LocalPlayer
local p = game:GetService("TweenService")
local Z = "RAFLYXCILLO_v2"

if q:FindFirstChild("RAFLYXCILLO") then
    print("⛔ RAFLYXCILLO sudah berjalan! Tutup dulu sebelum execute ulang.")
    return
end

local e = true
_G[Z] = function()
    e = false
    if q:FindFirstChild("RAFLYXCILLO") then
        q.RAFLYXCILLO:Destroy()
    end
end

game:GetService("RunService").RenderStepped:Connect(function()
    pcall(function()
        local J = game:GetService("CoreGui").RobloxGui.FocusNavigationCoreScriptsWrapper
        J.Visible = false
    end)
end)

local Q = N.TouchEnabled
local V = Q and 300 or 460
local k = Q and 250 or 310
local g = Q and 85 or 105
local A = Q and 42 or 46
local G = Q and 9 or 11
local B = Q and 32 or 36
local w = Q and 10 or 12
local P = Q and 13 or 15

function isTouchOrMouse(J)
    return J.UserInputType == Enum.UserInputType.MouseButton1 or J.UserInputType == Enum.UserInputType.Touch
end

function isMoveTouchOrMouse(J)
    return J.UserInputType == Enum.UserInputType.MouseMovement or J.UserInputType == Enum.UserInputType.Touch
end

function playClickSound()
    local J = Instance.new("Sound")
    J.SoundId = "rbxassetid://139658322785649"
    J.Volume = .5
    J.Parent = game:GetService("SoundService")
    J:Play()
    game:GetService("Debris"):AddItem(J, 1)
end

local n = {
    {name = "BambuApi", label = "Api", rarity = "Spesial", color = Color3.fromRGB(255, 100, 30)},
    {name = "BambuAwan", label = "Awan", rarity = "Baru", color = Color3.fromRGB(180, 220, 255)},
    {name = "BambuBayang", label = "Bayang", rarity = "Baru", color = Color3.fromRGB(60, 20, 100)},
    {name = "BambuHati", label = "Hati", rarity = "Baru", color = Color3.fromRGB(255, 80, 120)},
    {name = "BambuMetalik", label = "Metalik", rarity = "Spesial", color = Color3.fromRGB(180, 180, 200)},
    {name = "BambuPelangi", label = "Pelangi", rarity = "Spesial", color = Color3.fromRGB(255, 100, 200)}
}

local O = {
    Biasa = Color3.fromRGB(180, 180, 180),
    Langka = Color3.fromRGB(80, 150, 255),
    Spesial = Color3.fromRGB(255, 60, 60),
    Baru = Color3.fromRGB(200, 80, 255)
}

function rewireBeamsInContainer(J)
    local q = {}
    for J, N in ipairs(J:GetDescendants()) do
        if N:IsA("Attachment") and not q[N.Name] then
            q[N.Name] = N
        end
    end
    for J, N in ipairs(J:GetDescendants()) do
        if N:IsA("Beam") then
            local J = N.Attachment0 and N.Attachment0.Name
            local W = N.Attachment1 and N.Attachment1.Name
            if J and q[J] then
                N.Attachment0 = q[J]
            end
            if W and q[W] then
                N.Attachment1 = q[W]
            end
        end
    end
end

function replacePart(J, q, N)
    local W = J:FindFirstChild(N)
    local v = q:FindFirstChild(N)
    if not W or not v then return end
    for J, q in ipairs(W:GetChildren()) do
        if not q:IsA("WeldConstraint") then
            q:Destroy()
        end
    end
    pcall(function()
        W.Color = v.Color
        W.Material = v.Material
        W.Transparency = v.Transparency
        if W:IsA("UnionOperation") then
            W.UsePartColor = true
        end
    end)
    local p = v:Clone()
    p:PivotTo(W:GetPivot())
    for J, q in ipairs(p:GetChildren()) do
        if not q:IsA("WeldConstraint") then
            q.Parent = W
        end
    end
    p:Destroy()
    for J, q in ipairs(W:GetDescendants()) do
        if q:IsA("ParticleEmitter") then
            q.Enabled = true
            q:Clear()
        end
    end
end

function applySupremeSkin(J)
    local q = v.Character
    if not q then return end
    local N = workspace:FindFirstChild("BambuDisplay") and workspace.BambuDisplay:FindFirstChild("Bambu")
    if not N then return end
    local W = N:FindFirstChild(J)
    if not W then return end
    local p = workspace:FindFirstChild(v.Name)
    local Z = p and p:FindFirstChild("BackWeapon")
    if not Z then
        Z = q:FindFirstChild("BackWeapon")
    end
    if not Z then return end
    replacePart(Z, W, "Batang")
    replacePart(Z, W, "Ruas")
    rewireBeamsInContainer(Z)
    print("[Skin] Applied: " .. J)
end

local u = {
    CYBERPUNK = {primary = Color3.fromRGB(100, 30, 220), mid = Color3.fromRGB(65, 15, 160), dark = Color3.fromRGB(30, 10, 100), headerBg = Color3.fromRGB(55, 15, 120), accent = Color3.fromRGB(150, 80, 255), glow = Color3.fromRGB(100, 40, 200), activeTab = Color3.fromRGB(65, 20, 150), logText = Color3.fromRGB(160, 100, 255)},
    CRIMSON = {primary = Color3.fromRGB(200, 20, 40), mid = Color3.fromRGB(150, 15, 30), dark = Color3.fromRGB(80, 8, 16), headerBg = Color3.fromRGB(120, 10, 25), accent = Color3.fromRGB(255, 80, 100), glow = Color3.fromRGB(200, 30, 50), activeTab = Color3.fromRGB(160, 15, 35), logText = Color3.fromRGB(255, 100, 120)},
    MATRIX = {primary = Color3.fromRGB(0, 180, 60), mid = Color3.fromRGB(0, 130, 40), dark = Color3.fromRGB(0, 60, 20), headerBg = Color3.fromRGB(0, 80, 25), accent = Color3.fromRGB(50, 255, 120), glow = Color3.fromRGB(0, 160, 60), activeTab = Color3.fromRGB(0, 110, 40), logText = Color3.fromRGB(80, 255, 140)},
    SAKURA = {primary = Color3.fromRGB(210, 60, 140), mid = Color3.fromRGB(170, 40, 110), dark = Color3.fromRGB(100, 20, 65), headerBg = Color3.fromRGB(130, 30, 85), accent = Color3.fromRGB(255, 130, 200), glow = Color3.fromRGB(210, 70, 150), activeTab = Color3.fromRGB(160, 40, 110), logText = Color3.fromRGB(255, 150, 210)},
    OCEAN = {primary = Color3.fromRGB(0, 100, 220), mid = Color3.fromRGB(0, 70, 170), dark = Color3.fromRGB(0, 35, 100), headerBg = Color3.fromRGB(0, 55, 130), accent = Color3.fromRGB(60, 160, 255), glow = Color3.fromRGB(0, 110, 220), activeTab = Color3.fromRGB(0, 75, 170), logText = Color3.fromRGB(80, 180, 255)},
    FLAME = {primary = Color3.fromRGB(220, 100, 0), mid = Color3.fromRGB(180, 70, 0), dark = Color3.fromRGB(100, 35, 0), headerBg = Color3.fromRGB(140, 55, 0), accent = Color3.fromRGB(255, 160, 50), glow = Color3.fromRGB(220, 110, 0), activeTab = Color3.fromRGB(170, 65, 0), logText = Color3.fromRGB(255, 180, 70)}
}

local X = "CYBERPUNK"
local Y = {}

function applyTheme(J)
    local q = u[J]
    if not q then return end
    X = J
    if Y.Header then Y.Header.BackgroundColor3 = q.headerBg end
    if Y.HeaderGrad then Y.HeaderGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, q.primary), ColorSequenceKeypoint.new(.6, q.mid), ColorSequenceKeypoint.new(1, q.dark)}) end
    if Y.HeaderCover then Y.HeaderCover.BackgroundColor3 = q.headerBg end
    if Y.HeaderLine then Y.HeaderLine.BackgroundColor3 = q.accent end
    if Y.LineGrad then Y.LineGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, q.accent), ColorSequenceKeypoint.new(.5, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, q.accent)}) end
    if Y.HeaderDot then Y.HeaderDot.BackgroundColor3 = q.accent end
    if Y.PremBadge then Y.PremBadge.BackgroundColor3 = q.mid end
    if Y.BadgeGrad then Y.BadgeGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, q.accent), ColorSequenceKeypoint.new(1, q.primary)}) end
    if Y.GlowWrapper then Y.GlowWrapper.BackgroundColor3 = q.glow end
    if Y.SideDivider then Y.SideDivider.BackgroundColor3 = q.mid end
    if Y.DivGrad then Y.DivGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, q.mid), ColorSequenceKeypoint.new(.5, q.accent), ColorSequenceKeypoint.new(1, q.mid)}) end
    if Y.MiniIconStroke then Y.MiniIconStroke.Color = q.accent end
    if Y.MiniIcon then Y.MiniIcon.BackgroundColor3 = q.headerBg end
    if Y.DropMainBtn then Y.DropMainBtn.BackgroundColor3 = q.mid end
    if Y.dropBtnGrad then Y.dropBtnGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, q.primary), ColorSequenceKeypoint.new(1, q.dark)}) end
    if Y.dropStroke then Y.dropStroke.Color = q.mid end
    if Y.logStroke then Y.logStroke.Color = q.mid end
    if Y.LogAwalan then Y.LogAwalan.TextColor3 = q.logText end
    if Y.ScrollBar then Y.ScrollBar.ScrollBarImageColor3 = q.accent end
    for J, N in pairs(Y) do
        if type(N) == "table" and N.fill then
            N.fill.BackgroundColor3 = q.primary
            N.knobMinStroke.Color = q.accent
            N.knobMaxStroke.Color = q.accent
            N.knobMax.BackgroundColor3 = q.accent
            N.valLbl.TextColor3 = q.logText
        end
    end
    if Y.activeTabColor then Y.activeTabColor.value = q.activeTab end
    if Y.SkinDropBtn then Y.SkinDropBtn.BackgroundColor3 = q.mid end
    if Y.SkinDropGrad then Y.SkinDropGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, q.primary), ColorSequenceKeypoint.new(1, q.dark)}) end
    if Y.SkinDropStroke then Y.SkinDropStroke.Color = q.mid end
    if Y.SkinFrameStroke then Y.SkinFrameStroke.Color = q.mid end
    if Y.SkinInfoText then Y.SkinInfoText.TextColor3 = q.logText end
    if Y.ResizeHandle then Y.ResizeHandle.BackgroundColor3 = q.mid end
    if Y.ResizeStroke then Y.ResizeStroke.Color = q.accent end
    if Y.FakeLabel then Y.FakeLabel.TextColor3 = q.accent end
    if Y.FakeNameStroke then Y.FakeNameStroke.Color = q.mid end
    if Y.StreakLabel then Y.StreakLabel.TextColor3 = q.accent end
    if Y.StreakBoxStroke then Y.StreakBoxStroke.Color = q.mid end
    if Y.tuyulStroke then Y.tuyulStroke.Color = q.accent end
    if Y.tuyulHeader then Y.tuyulHeader.TextColor3 = q.accent end
    if Y.tuyulStatus then Y.tuyulStatus.TextColor3 = q.accent end
    if Y.themeBtnStroke then Y.themeBtnStroke.Color = q.accent end
    if Y.themeDFStroke then Y.themeDFStroke.Color = q.mid end
    if Y.UtilScrollBar then Y.UtilScrollBar.ScrollBarImageColor3 = q.accent end
    if Y.pcStroke then Y.pcStroke.Color = q.accent end
    if Y.scStroke then Y.scStroke.Color = q.accent end
    if Y.ncStroke then Y.ncStroke.Color = q.accent end
    if Y.cscStroke then Y.cscStroke.Color = q.accent end
    if Y.vcStroke then Y.vcStroke.Color = q.accent end
    if Y.SetNameBtn then Y.SetNameBtn.BackgroundColor3 = q.primary end
    if Y.sbg then Y.sbg.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, q.accent), ColorSequenceKeypoint.new(1, q.mid)}) end
    if Y.SetStreakBtn then Y.SetStreakBtn.BackgroundColor3 = q.primary end
    if Y.sskgb then Y.sskgb.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, q.accent), ColorSequenceKeypoint.new(1, q.mid)}) end
    if Y.statValRefs then
        for J, q in ipairs(Y.statValRefs) do end
    end
end

local j = Instance.new("ScreenGui")
j.Name = "RAFLYXCILLO"
j.Parent = v:WaitForChild("PlayerGui")
j.ResetOnSpawn = false
j.IgnoreGuiInset = true
j.DisplayOrder = 99999 -- [TAMBAHKAN BARIS INI] Biar UI selalu di paling depani

local f = Instance.new("Frame")
f.Name = "GlowWrapper"
f.Size = UDim2.new(0, V + 4, 0, k + 4)
f.Position = UDim2.new(.5, -(V / 2) - 2, .5, -(k / 2) - 2)
f.BackgroundColor3 = Color3.fromRGB(100, 40, 200)
f.BackgroundTransparency = .6
f.BorderSizePixel = 0
f.ZIndex = 0
f.Parent = j
Instance.new("UICorner", f).CornerRadius = UDim.new(0, 18)

local i = Instance.new("Frame")
i.Name = "MainFrame"
i.Size = UDim2.new(0, V, 0, k)
i.Position = UDim2.new(.5, -V / 2, .5, -k / 2)
i.BackgroundColor3 = Color3.fromRGB(7, 7, 13)
i.BorderSizePixel = 0
i.ClipsDescendants = true
i.Parent = j
Instance.new("UICorner", i).CornerRadius = UDim.new(0, 16)

local E = Instance.new("TextButton")
E.Name = "ResizeHandle"
E.Size = UDim2.new(0, 24, 0, 24)
E.BackgroundColor3 = Color3.fromRGB(65, 15, 160)
E.Text = "↘️"
E.TextColor3 = Color3.fromRGB(200, 160, 255)
E.Font = Enum.Font.GothamBold
E.TextSize = Q and 12 or 14
E.ZIndex = 10
E.Parent = j
Instance.new("UICorner", E).CornerRadius = UDim.new(0, 8)

ResizeStroke = Instance.new("UIStroke", E)
ResizeStroke.Color = Color3.fromRGB(150, 80, 255)
ResizeStroke.Thickness = 1.5
ResizeStroke.Transparency = .1
Y.ResizeHandle = E
Y.ResizeStroke = ResizeStroke

function syncResizeHandle()
    local J = i.Position
    local q = i.Size
    local N = E.Size.X.Offset
    E.Position = UDim2.new(J.X.Scale, (J.X.Offset + q.X.Offset) - N, J.Y.Scale, (J.Y.Offset + q.Y.Offset) - N)
end

game:GetService("RunService").RenderStepped:Connect(function()
    if i.Visible then
        syncResizeHandle()
    end
end)

syncResizeHandle()

local x = false
local I, M, m
function clampWindow(J, q)
    return math.clamp(J, Q and 260 or 300, Q and 500 or 720), math.clamp(q, Q and 200 or 230, Q and 480 or 600)
end

function syncGlowWrapper()
    local J = i.Position
    f.Position = UDim2.new(J.X.Scale, J.X.Offset - 2, J.Y.Scale, J.Y.Offset - 2)
    f.Size = UDim2.new(0, i.Size.X.Offset + 4, 0, i.Size.Y.Offset + 4)
    syncResizeHandle()
end

E.InputBegan:Connect(function(J)
    if not isTouchOrMouse(J) then return end
    x = true
    I = J.Position
    M = i.Size.X.Offset
    m = i.Size.Y.Offset
    J.Changed:Connect(function()
        if J.UserInputState == Enum.UserInputState.End then
            x = false
        end
    end)
end)

local T = Instance.new("Frame")
T.Name = "Header"
T.Size = UDim2.new(1, 0, 0, A)
T.BackgroundColor3 = Color3.fromRGB(55, 15, 120)
T.BorderSizePixel = 0
T.Parent = i
Instance.new("UICorner", T).CornerRadius = UDim.new(0, 16)

HeaderCover = Instance.new("Frame")
HeaderCover.Size = UDim2.new(1, 0, .5, 0)
HeaderCover.Position = UDim2.new(0, 0, .5, 0)
HeaderCover.BackgroundColor3 = Color3.fromRGB(55, 15, 120)
HeaderCover.BorderSizePixel = 0
HeaderCover.Parent = T
HeaderCover.ZIndex = T.ZIndex - 1

HeaderGrad = Instance.new("UIGradient", T)
HeaderGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 30, 220)), ColorSequenceKeypoint.new(.6, Color3.fromRGB(65, 15, 160)), ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 10, 100))})
HeaderGrad.Rotation = 135

HeaderLine = Instance.new("Frame")
HeaderLine.Size = UDim2.new(1, 0, 0, 1)
HeaderLine.Position = UDim2.new(0, 0, 1, -1)
HeaderLine.BackgroundColor3 = Color3.fromRGB(150, 80, 255)
HeaderLine.BorderSizePixel = 0
HeaderLine.Parent = T

LineGrad = Instance.new("UIGradient", HeaderLine)
LineGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 80, 255)), ColorSequenceKeypoint.new(.5, Color3.fromRGB(200, 130, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 80, 255))})

HeaderDot = Instance.new("Frame")
HeaderDot.Size = UDim2.new(0, 7, 0, 7)
HeaderDot.Position = UDim2.new(0, 10, .5, -3.5)
HeaderDot.BackgroundColor3 = Color3.fromRGB(180, 120, 255)
HeaderDot.BorderSizePixel = 0
HeaderDot.Parent = T
Instance.new("UICorner", HeaderDot).CornerRadius = UDim.new(1, 0)

local z = Instance.new("TextLabel")
z.Size = UDim2.new(0, 140, 1, 0)
z.Position = UDim2.new(0, 22, 0, 0)
z.BackgroundTransparency = 1
z.Text = "RAFLYXCILLO"
z.TextColor3 = Color3.new(1, 1, 1)
z.Font = Enum.Font.GothamBold
z.TextSize = P
z.TextXAlignment = Enum.TextXAlignment.Left
z.Parent = T

Y.Header = T
Y.HeaderGrad = HeaderGrad
Y.HeaderCover = HeaderCover
Y.HeaderLine = HeaderLine
Y.LineGrad = LineGrad
Y.HeaderDot = HeaderDot

if not Q then
    local J = Instance.new("Frame")
    J.Size = UDim2.new(0, 64, 0, 17)
    J.Position = UDim2.new(0, 130, .5, -8.5)
    J.BackgroundColor3 = Color3.fromRGB(120, 60, 220)
    J.BorderSizePixel = 0
    J.Parent = T
    Instance.new("UICorner", J).CornerRadius = UDim.new(1, 0)

    BadgeGrad = Instance.new("UIGradient", J)
    BadgeGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(160, 80, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 40, 200))})

    local q = Instance.new("TextLabel")
    q.Size = UDim2.new(1, 0, 1, 0)
    q.BackgroundTransparency = 1
    q.Text = "PREMIUM"
    q.TextColor3 = Color3.new(1, 1, 1)
    q.Font = Enum.Font.GothamBold
    q.TextSize = 9
    q.Parent = J
    Y.PremBadge = J
    Y.BadgeGrad = BadgeGrad
end

Y.GlowWrapper = f
local L = Q and 18 or 26

local b = Instance.new("TextButton")
b.Size = UDim2.new(0, L, 0, L)
b.Position = UDim2.new(1, -(L * 2 + 10), .5, -L / 2)
b.BackgroundColor3 = Color3.fromRGB(250, 190, 0)
b.Text = "➖"
b.TextColor3 = Color3.fromRGB(30, 20, 0)
b.Font = Enum.Font.GothamBold
b.TextSize = Q and 11 or 16
b.Parent = T
Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)

local c = Instance.new("TextButton")
c.Size = UDim2.new(0, L, 0, L)
c.Position = UDim2.new(1, -(L + 6), .5, -L / 2)
c.BackgroundColor3 = Color3.fromRGB(240, 50, 60)
c.Text = "✖️"
c.TextColor3 = Color3.new(1, 1, 1)
c.Font = Enum.Font.GothamBold
c.TextSize = Q and 14 or 11
c.Parent = T
Instance.new("UICorner", c).CornerRadius = UDim.new(1, 0)

local K = Instance.new("Frame")
K.Name = "Sidebar"
K.Size = UDim2.new(0, g, 1, -A)
K.Position = UDim2.new(0, 0, 0, A)
K.BackgroundColor3 = Color3.fromRGB(11, 11, 18)
K.BorderSizePixel = 0
K.Parent = i
Instance.new("UICorner", K).CornerRadius = UDim.new(0, 16)

SideDivider = Instance.new("Frame")
SideDivider.Size = UDim2.new(0, 1, 1, -A)
SideDivider.Position = UDim2.new(0, g, 0, A)
SideDivider.BackgroundColor3 = Color3.fromRGB(70, 30, 140)
SideDivider.BorderSizePixel = 0
SideDivider.Parent = i

DivGrad = Instance.new("UIGradient", SideDivider)
DivGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 30, 140)), ColorSequenceKeypoint.new(.5, Color3.fromRGB(130, 60, 220)), ColorSequenceKeypoint.new(1, Color3.fromRGB(70, 30, 140))})
DivGrad.Rotation = 90
Y.SideDivider = SideDivider
Y.DivGrad = DivGrad

SideLayout = Instance.new("UIListLayout")
SideLayout.Padding = UDim.new(0, Q and 4 or 5)
SideLayout.SortOrder = Enum.SortOrder.LayoutOrder
SideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
SideLayout.Parent = K

SidePad = Instance.new("UIPadding", K)
SidePad.PaddingTop = UDim.new(0, Q and 8 or 12)
SidePad.PaddingLeft = UDim.new(0, Q and 4 or 7)
SidePad.PaddingRight = UDim.new(0, Q and 4 or 7)

local U = {}

function createTabBtn(J, q, N)
    local W = Instance.new("TextButton")
    W.Size = UDim2.new(1, 0, 0, Q and 38 or 40)
    W.LayoutOrder = N
    W.BackgroundColor3 = Color3.fromRGB(20, 18, 32)
    W.Text = Q and q .. ("\n" .. J) or q .. ("  " .. J)
    W.TextColor3 = Color3.fromRGB(120, 110, 150)
    W.Font = Enum.Font.GothamBold
    W.TextSize = G
    W.TextXAlignment = Q and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left
    W.TextWrapped = true
    W.Parent = K
    Instance.new("UICorner", W).CornerRadius = UDim.new(0, 9)

    local v = Instance.new("UIStroke", W)
    v.Color = Color3.fromRGB(50, 30, 90)
    v.Thickness = 1
    v.Transparency = .6

    if not Q then
        local J = Instance.new("UIPadding", W)
        J.PaddingLeft = UDim.new(0, 10)
    end
    table.insert(U, {btn = W, stroke = v})
    return W
end

function setActiveTab(J)
    for J, q in pairs(U) do
        q.btn.BackgroundColor3 = Color3.fromRGB(20, 18, 32)
        q.btn.TextColor3 = Color3.fromRGB(120, 110, 150)
        q.stroke.Color = Color3.fromRGB(50, 30, 90)
        q.stroke.Transparency = .6
    end
    local q = u[X] and u[X].activeTab or Color3.fromRGB(65, 20, 150)
    local N = u[X] and u[X].accent or Color3.fromRGB(150, 80, 255)
    J.BackgroundColor3 = q
    J.TextColor3 = Color3.new(1, 1, 1)
    for q, W in pairs(U) do
        if W.btn == J then
            W.stroke.Color = N
            W.stroke.Transparency = .1
        end
    end
end

local F = createTabBtn("INFO", "📑", 0)
local R = createTabBtn("MAIN", "⚡", 1)
local a = createTabBtn("FAKE", "🎭", 2)
local o = createTabBtn("UTIL", "🛠️", 3)
local d = createTabBtn("SKIN", "🎯", 4)
local l = createTabBtn("NYAWA", "❤️", 5)

local y = g + 7
local r = Instance.new("Frame")
r.Size = UDim2.new(1, -(y + 4), 1, -(A + 6))
r.Position = UDim2.new(0, y, 0, A + 4)
r.BackgroundTransparency = 1
r.Parent = i

local s = Instance.new("ImageButton")
s.Name = "RAFLYMiniIcon"
s.Size = UDim2.new(0, Q and 35 or 52, 0, Q and 35 or 52)
s.Position = UDim2.new(0, 10, .5, -26)
s.BackgroundColor3 = Color3.fromRGB(55, 15, 130)
s.Image = "rbxassetid://9836076474"
s.Visible = false
s.BorderSizePixel = 0
s.Parent = j
Instance.new("UICorner", s).CornerRadius = UDim.new(0, 14)

local D = Instance.new("UIStroke", s)
D.Color = Color3.fromRGB(150, 80, 255)
D.Thickness = 2
D.Transparency = .1
Y.MiniIcon = s
Y.MiniIconStroke = D

local h = 0

b.MouseButton1Click:Connect(function()
    playClickSound()
    i.Visible = false
    f.Visible = false
    E.Visible = false
    s.Visible = true
    h = 0
end)

local C, H, S
s.InputBegan:Connect(function(J)
    if not isTouchOrMouse(J) then return end
    C = true
    h = 0
    H = J.Position
    S = s.Position
    J.Changed:Connect(function()
        if J.UserInputState == Enum.UserInputState.End then
            C = false
        end
    end)
end)

s.InputEnded:Connect(function(J)
    if J.UserInputType == Enum.UserInputType.Touch then
        C = false
        local q = H and (J.Position - H).Magnitude or 999
        if q <= 12 then
            playClickSound()
            i.Visible = true
            f.Visible = true
            E.Visible = true
            s.Visible = false
        end
        h = 0
    end
end)

s.MouseButton1Click:Connect(function()
    if Q then return end
    if h > 10 then
        h = 0
        return
    end
    playClickSound()
    i.Visible = true
    f.Visible = true
    E.Visible = true
    s.Visible = false
    h = 0
end)

function createPage()
    local J = Instance.new("ScrollingFrame")
    J.Size = UDim2.new(1, 0, 1, 0)
    J.BackgroundTransparency = 1
    J.Visible = false
    J.ScrollBarThickness = 0
    J.Parent = r
    return J
end

local t, Jx, qx, Nx, Wx, vx, px, Zx, ex
t = createPage()
t.ScrollingDirection = Enum.ScrollingDirection.Y
t.CanvasSize = UDim2.new(0, 0, 0, 0)
t.AutomaticCanvasSize = Enum.AutomaticSize.Y
t.ScrollBarThickness = Q and 3 or 2
t.ScrollBarImageColor3 = Color3.fromRGB(150, 80, 255)
t.ScrollBarImageTransparency = 0

InfoPad = Instance.new("UIPadding", t)
InfoPad.PaddingLeft = UDim.new(0, 6)
InfoPad.PaddingRight = UDim.new(0, 6)
InfoPad.PaddingTop = UDim.new(0, 8)
InfoPad.PaddingBottom = UDim.new(0, 10)

InfoLayout = Instance.new("UIListLayout")
InfoLayout.Padding = UDim.new(0, 8)
InfoLayout.SortOrder = Enum.SortOrder.LayoutOrder
InfoLayout.Parent = t

local Qx = Instance.new("Frame")
Qx.Size = UDim2.new(1, 0, 0, Q and 80 or 90)
Qx.LayoutOrder = 1
Qx.BackgroundColor3 = Color3.fromRGB(14, 12, 24)
Qx.BorderSizePixel = 0
Qx.Parent = t
Instance.new("UICorner", Qx).CornerRadius = UDim.new(0, 12)

pcStroke = Instance.new("UIStroke", Qx)
pcStroke.Color = Color3.fromRGB(90, 40, 180)
pcStroke.Thickness = 1.5
pcStroke.Transparency = .2
Y.pcStroke = pcStroke

local Vx = Instance.new("Frame")
Vx.Size = UDim2.new(0, Q and 54 or 64, 0, Q and 54 or 64)
Vx.Position = UDim2.new(0, 10, .5, -(Q and 27 or 32))
Vx.BackgroundColor3 = Color3.fromRGB(30, 20, 60)
Vx.BorderSizePixel = 0
Vx.Parent = Qx
Instance.new("UICorner", Vx).CornerRadius = UDim.new(1, 0)

afStroke = Instance.new("UIStroke", Vx)
afStroke.Color = Color3.fromRGB(130, 60, 255)
afStroke.Thickness = 2
afStroke.Transparency = .1

local kx = Instance.new("ImageLabel")
kx.Size = UDim2.new(1, -4, 1, -4)
kx.Position = UDim2.new(0, 2, 0, 2)
kx.BackgroundTransparency = 1
kx.Image = ""
kx.ScaleType = Enum.ScaleType.Crop
kx.Parent = Vx

task.spawn(function()
    local q, N = pcall(function()
        return J:GetUserThumbnailAsync(v.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
    end)
    if q and N then
        kx.Image = N
    end
end)
Instance.new("UICorner", kx).CornerRadius = UDim.new(1, 0)

local gx = (Q and 54 or 64) + 20
local Ax = Instance.new("TextLabel")
Ax.Size = UDim2.new(1, -(gx + 8), 0, 22)
Ax.Position = UDim2.new(0, gx, 0, Q and 14 or 18)
Ax.BackgroundTransparency = 1
Ax.Text = v.DisplayName
Ax.TextColor3 = Color3.new(1, 1, 1)
Ax.Font = Enum.Font.GothamBold
Ax.TextSize = Q and 13 or 15
Ax.TextXAlignment = Enum.TextXAlignment.Left
Ax.Parent = Qx

local Gx = Instance.new("TextLabel")
Gx.Size = UDim2.new(1, -(gx + 8), 0, 18)
Gx.Position = UDim2.new(0, gx, 0, Q and 34 or 40)
Gx.BackgroundTransparency = 1
Gx.Text = "@" .. v.Name
Gx.TextColor3 = Color3.fromRGB(130, 110, 180)
Gx.Font = Enum.Font.Gotham
Gx.TextSize = Q and 10 or 11
Gx.TextXAlignment = Enum.TextXAlignment.Left
Gx.Parent = Qx

local Bx = v.UserId == 10095537384 or v.UserId == 8545681202
local wx = Instance.new("Frame")
wx.Size = UDim2.new(0, 70, 0, 16)
wx.Position = UDim2.new(0, gx, 0, Q and 53 or 60)
wx.BorderSizePixel = 0
wx.Parent = Qx
Instance.new("UICorner", wx).CornerRadius = UDim.new(1, 0)

rbGrad = Instance.new("UIGradient", wx)
if Bx then
    wx.BackgroundColor3 = Color3.fromRGB(80, 30, 180)
    rbGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(130, 50, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 20, 180))})
else
    wx.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
    rbGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 80, 160)), ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 100))})
end

RoleText = Instance.new("TextLabel")
RoleText.Size = UDim2.new(1, 0, 1, 0)
RoleText.BackgroundTransparency = 1
RoleText.Text = Bx and "DEVELOPER" or "MEMBER"
RoleText.TextColor3 = Color3.new(1, 1, 1)
RoleText.Font = Enum.Font.GothamBold
RoleText.TextSize = 9
RoleText.Parent = wx

local Px = Instance.new("Frame")
Px.Size = UDim2.new(1, 0, 0, Q and 108 or 118)
Px.LayoutOrder = 2
Px.BackgroundColor3 = Color3.fromRGB(14, 12, 24)
Px.BorderSizePixel = 0
Px.Parent = t
Instance.new("UICorner", Px).CornerRadius = UDim.new(0, 12)

local nx = Instance.new("UIStroke", Px)
nx.Color = Color3.fromRGB(90, 40, 180)
nx.Thickness = 1.5
nx.Transparency = .2
Y.scStroke = nx

local Ox = Instance.new("TextLabel")
Ox.Size = UDim2.new(1, -24, 0, 20)
Ox.Position = UDim2.new(0, 12, 0, 8)
Ox.BackgroundTransparency = 1
Ox.Text = "📊 STATISTIK"
Ox.TextColor3 = Color3.fromRGB(200, 160, 255)
Ox.Font = Enum.Font.GothamBold
Ox.TextSize = Q and 11 or 12
Ox.TextXAlignment = Enum.TextXAlignment.Center
Ox.Parent = Px

local ux = Instance.new("Frame")
ux.Size = UDim2.new(1, -24, 0, 1)
ux.Position = UDim2.new(0, 12, 0, 30)
ux.BackgroundColor3 = Color3.fromRGB(60, 40, 100)
ux.BorderSizePixel = 0
ux.Parent = Px

local Xx = Q and 34 or 38
local Yx = {
    {
        labelL = "🏆 MENANG",
        labelR = "💀 KALAH",
        fnL = function()
            local J, q = pcall(function() return v.leaderstats.Wins.Value end)
            return J and tostring(q) or "-"
        end,
        fnR = function()
            local J, q = pcall(function() return v.leaderstats.Losses.Value end)
            return J and tostring(q) or "-"
        end,
        colorL = Color3.fromRGB(255, 200, 60),
        colorR = Color3.fromRGB(255, 90, 90)
    },
    {
        labelL = "📈 WIN RATE",
        labelR = "💰 KOIN",
        fnL = function()
            local J, q = pcall(function() return v.leaderstats.Wins.Value end)
            local N, W = pcall(function() return v.leaderstats.Losses.Value end)
            if not J or not N then return "-" end
            return math.floor((q / math.max(q + W, 1)) * 100) .. "%"
        end,
        fnR = function()
            local J, q = pcall(function() return v.leaderstats.Money.Value end)
            if not J then return "-" end
            local N = tostring(math.floor(q))
            local W = #N
            local p = ""
            for J = 1, W, 1 do
                p = p .. N:sub(J, J)
                if (W - J) % 3 == 0 and J ~= W then
                    p = p .. "."
                end
            end
            return "Rp" .. p
        end,
        colorL = Color3.fromRGB(80, 220, 120),
        colorR = Color3.fromRGB(255, 200, 60)
    }
}

local jx = {}
for J = 1, 2, 1 do
    local q = 36 + (J - 1) * Xx
    local N = Yx[J]
    local W = Instance.new("TextLabel")
    W.Size = UDim2.new(.5, 0, 0, 14)
    W.Position = UDim2.new(0, 0, 0, q)
    W.BackgroundTransparency = 1
    W.Text = N.labelL
    W.TextColor3 = Color3.fromRGB(140, 125, 175)
    W.Font = Enum.Font.GothamBold
    W.TextSize = Q and 8 or 9
    W.TextXAlignment = Enum.TextXAlignment.Center
    W.Parent = Px

    local v = Instance.new("TextLabel")
    v.Size = UDim2.new(.5, 0, 0, 20)
    v.Position = UDim2.new(0, 0, 0, q + 15)
    v.BackgroundTransparency = 1
    v.Text = N.fnL()
    v.TextColor3 = N.colorL
    v.Font = Enum.Font.GothamBold
    v.TextSize = Q and 15 or 17
    v.TextXAlignment = Enum.TextXAlignment.Center
    v.Parent = Px

    local p = Instance.new("TextLabel")
    p.Size = UDim2.new(.5, 0, 0, 14)
    p.Position = UDim2.new(.5, 0, 0, q)
    p.BackgroundTransparency = 1
    p.Text = N.labelR
    p.TextColor3 = Color3.fromRGB(140, 125, 175)
    p.Font = Enum.Font.GothamBold
    p.TextSize = Q and 8 or 9
    p.TextXAlignment = Enum.TextXAlignment.Center
    p.Parent = Px

    local Z = Instance.new("TextLabel")
    Z.Size = UDim2.new(.5, 0, 0, 20)
    Z.Position = UDim2.new(.5, 0, 0, q + 15)
    Z.BackgroundTransparency = 1
    Z.Text = N.fnR()
    Z.TextColor3 = N.colorR
    Z.Font = Enum.Font.GothamBold
    Z.TextSize = Q and 15 or 17
    Z.TextXAlignment = Enum.TextXAlignment.Center
    Z.Parent = Px
    table.insert(jx, {vL = v, vR = Z, fnL = N.fnL, fnR = N.fnR})
end

Y.statValRefs = jx

task.spawn(function()
    while task.wait(3) do
        if not e then break end
        pcall(function()
            for J, q in ipairs(jx) do
                q.vL.Text = q.fnL()
                q.vR.Text = q.fnR()
            end
        end)
    end
end)

local fx = Instance.new("Frame")
fx.Size = UDim2.new(1, 0, 0, 0)
fx.AutomaticSize = Enum.AutomaticSize.Y
fx.LayoutOrder = 3
fx.BackgroundColor3 = Color3.fromRGB(14, 12, 24)
fx.BorderSizePixel = 0
fx.Parent = t
Instance.new("UICorner", fx).CornerRadius = UDim.new(0, 12)

ncStroke = Instance.new("UIStroke", fx)
ncStroke.Color = Color3.fromRGB(90, 40, 180)
ncStroke.Thickness = 1.5
ncStroke.Transparency = .2
Y.ncStroke = ncStroke

ncPad = Instance.new("UIPadding", fx)
ncPad.PaddingLeft = UDim.new(0, 12)
ncPad.PaddingRight = UDim.new(0, 12)
ncPad.PaddingTop = UDim.new(0, 10)
ncPad.PaddingBottom = UDim.new(0, 10)

NoteLayout = Instance.new("UIListLayout")
NoteLayout.Padding = UDim.new(0, 6)
NoteLayout.SortOrder = Enum.SortOrder.LayoutOrder
NoteLayout.Parent = fx

NoteTitle = Instance.new("TextLabel")
NoteTitle.Size = UDim2.new(1, 0, 0, 18)
NoteTitle.LayoutOrder = 1
NoteTitle.BackgroundTransparency = 1
NoteTitle.Text = "Selamat datang di RAFLYXCILLO!"
NoteTitle.TextColor3 = Color3.fromRGB(200, 160, 255)
NoteTitle.Font = Enum.Font.GothamBold
NoteTitle.TextSize = Q and 11 or 12
NoteTitle.TextXAlignment = Enum.TextXAlignment.Left
NoteTitle.Parent = fx

NoteDivLine = Instance.new("Frame")
NoteDivLine.Size = UDim2.new(1, 0, 0, 1)
NoteDivLine.LayoutOrder = 2
NoteDivLine.BackgroundColor3 = Color3.fromRGB(60, 40, 100)
NoteDivLine.BorderSizePixel = 0
NoteDivLine.Parent = fx

local ix = {
    {order = 3, text = "⚠️  Gunakan semaksimal mungkin,"},
    {order = 4, text = "     Jangan sampai ketahuan admin."},
    {order = 5, text = "⚠️  Aku ga bertanggung jawab apabila terkena banned."},
    {order = 6, text = "     Jangan Bar2."},
    {order = 7, text = "⚠️  Hati-hati kawan."},
    {order = 8, text = "     SCRIPT INI 100% FREE (UNTUK SAAT INI!)."},
    {order = 9, text = "Bismillahirrahmanirrahim Al-Fatihah."}
}

for J, q in ipairs(ix) do
    local N = Instance.new("TextLabel")
    N.Size = UDim2.new(1, 0, 0, q.text == "" and 4 or Q and 15 or 16)
    N.LayoutOrder = q.order
    N.BackgroundTransparency = 1
    N.Text = q.text
    N.TextColor3 = Color3.fromRGB(170, 155, 200)
    N.Font = Enum.Font.Gotham
    N.TextSize = Q and 9 or 10
    N.TextXAlignment = Enum.TextXAlignment.Left
    N.TextWrapped = true
    N.Parent = fx
end

local Ex = Instance.new("Frame")
Ex.Size = UDim2.new(1, 0, 0, 0)
Ex.AutomaticSize = Enum.AutomaticSize.Y
Ex.LayoutOrder = 4
Ex.BackgroundColor3 = Color3.fromRGB(14, 12, 24)
Ex.BorderSizePixel = 0
Ex.Parent = t
Instance.new("UICorner", Ex).CornerRadius = UDim.new(0, 12)

cscStroke = Instance.new("UIStroke", Ex)
cscStroke.Color = Color3.fromRGB(90, 40, 180)
cscStroke.Thickness = 1.5
cscStroke.Transparency = .2
Y.cscStroke = cscStroke

cscPad = Instance.new("UIPadding", Ex)
cscPad.PaddingLeft = UDim.new(0, 12)
cscPad.PaddingRight = UDim.new(0, 12)
cscPad.PaddingTop = UDim.new(0, 10)
cscPad.PaddingBottom = UDim.new(0, 10)

cscLayout = Instance.new("UIListLayout")
cscLayout.Padding = UDim.new(0, 5)
cscLayout.SortOrder = Enum.SortOrder.LayoutOrder
cscLayout.Parent = Ex

CSTitle = Instance.new("TextLabel")
CSTitle.Size = UDim2.new(1, 0, 0, 18)
CSTitle.LayoutOrder = 1
CSTitle.BackgroundTransparency = 1
CSTitle.Text = "🔥 NEW UPDATE"
CSTitle.TextColor3 = Color3.fromRGB(255, 180, 50)
CSTitle.Font = Enum.Font.GothamBold
CSTitle.TextSize = Q and 11 or 12
CSTitle.TextXAlignment = Enum.TextXAlignment.Left
CSTitle.Parent = Ex

CSDivLine = Instance.new("Frame")
CSDivLine.Size = UDim2.new(1, 0, 0, 1)
CSDivLine.LayoutOrder = 2
CSDivLine.BackgroundColor3 = Color3.fromRGB(80, 60, 20)
CSDivLine.BorderSizePixel = 0
CSDivLine.Parent = Ex

local xx = {
    {order = 3, icon = "👀", text = "INFO — liat profil dan info selanjutnya"},
    {order = 4, icon = "❤️", text = "NYAWA — deteksi sisa nyawa musuh"},
    {order = 5, icon = "👤", text = "ANTI ADMIN — auto exit kalo ada admin datang"},
    {order = 6, icon = "👾", text = "MODE TUYUL — auto mengalah setelah tujuan tercapai"}
}

for J, q in ipairs(xx) do
    local N = Instance.new("Frame")
    N.Size = UDim2.new(1, 0, 0, Q and 20 or 22)
    N.LayoutOrder = q.order
    N.BackgroundTransparency = 1
    N.Parent = Ex

    local W = Instance.new("TextLabel")
    W.Size = UDim2.new(0, 20, 1, 0)
    W.BackgroundTransparency = 1
    W.Text = q.icon
    W.Font = Enum.Font.GothamBold
    W.TextSize = Q and 11 or 12
    W.TextXAlignment = Enum.TextXAlignment.Center
    W.Parent = N

    local v = Instance.new("TextLabel")
    v.Size = UDim2.new(1, -24, 1, 0)
    v.Position = UDim2.new(0, 24, 0, 0)
    v.BackgroundTransparency = 1
    v.Text = q.text
    v.TextColor3 = Color3.fromRGB(170, 155, 200)
    v.Font = Enum.Font.Gotham
    v.TextSize = Q and 9 or 10
    v.TextXAlignment = Enum.TextXAlignment.Left
    v.TextWrapped = true
    v.Parent = N
end

local Ix = Instance.new("Frame")
Ix.Size = UDim2.new(1, 0, 0, Q and 36 or 40)
Ix.LayoutOrder = 5
Ix.BackgroundColor3 = Color3.fromRGB(14, 12, 24)
Ix.BorderSizePixel = 0
Ix.Parent = t
Instance.new("UICorner", Ix).CornerRadius = UDim.new(0, 12)

vcStroke = Instance.new("UIStroke", Ix)
vcStroke.Color = Color3.fromRGB(90, 40, 180)
vcStroke.Thickness = 1.5
vcStroke.Transparency = .2
Y.vcStroke = vcStroke

VerLbl = Instance.new("TextLabel")
VerLbl.Size = UDim2.new(1, -16, 1, 0)
VerLbl.Position = UDim2.new(0, 12, 0, 0)
VerLbl.BackgroundTransparency = 1
VerLbl.Text = "Version: 2.0.2  •  Last update: 11 Mar 2026"
VerLbl.TextColor3 = Color3.fromRGB(100, 90, 140)
VerLbl.Font = Enum.Font.Gotham
VerLbl.TextSize = Q and 9 or 10
VerLbl.TextXAlignment = Enum.TextXAlignment.Left
VerLbl.Parent = Ix
    Jx = createPage()
    Jx.CanvasSize = UDim2.new(0, 0, 0, 0)
    Jx.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Jx.ScrollBarThickness = Q and 3 or 2
    Jx.ScrollBarImageColor3 = Color3.fromRGB(150, 80, 255)
    Jx.ScrollBarImageTransparency = 0
    Jx.ScrollingDirection = Enum.ScrollingDirection.Y

    qx = createPage()
    qx.ScrollingDirection = Enum.ScrollingDirection.Y

    Nx = createPage()
    Nx.CanvasSize = UDim2.new(0, 0, 0, 0)
    Nx.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Nx.ScrollBarThickness = Q and 3 or 2
    Nx.ScrollBarImageColor3 = Color3.fromRGB(150, 80, 255)
    Nx.ScrollBarImageTransparency = 0
    Nx.ScrollingDirection = Enum.ScrollingDirection.Y
    Y.UtilScrollBar = Nx

    Wx = Instance.new("UIListLayout")
    Wx.Padding = UDim.new(0, 8)
    Wx.SortOrder = Enum.SortOrder.LayoutOrder
    Wx.Parent = Nx

    vx = createPage()
    vx.CanvasSize = UDim2.new(0, 0, 0, 0)
    vx.AutomaticCanvasSize = Enum.AutomaticSize.Y
    vx.ScrollBarThickness = Q and 3 or 2
    vx.ScrollBarImageColor3 = Color3.fromRGB(150, 80, 255)
    vx.ScrollBarImageTransparency = 0
    vx.ScrollingDirection = Enum.ScrollingDirection.Y

    px = Instance.new("UIListLayout")
    px.Padding = UDim.new(0, 8)
    px.SortOrder = Enum.SortOrder.LayoutOrder
    px.Parent = vx

    Zx = Instance.new("UIPadding", vx)
    Zx.PaddingLeft = UDim.new(0, 6)
    Zx.PaddingRight = UDim.new(0, 6)
    Zx.PaddingTop = UDim.new(0, 8)
    Zx.PaddingBottom = UDim.new(0, 10)

    ex = createPage()
    ex.CanvasSize = UDim2.new(0, 0, 0, 0)
    ex.AutomaticCanvasSize = Enum.AutomaticSize.Y
    ex.ScrollBarThickness = Q and 3 or 2
    ex.ScrollBarImageColor3 = Color3.fromRGB(255, 80, 80)
    ex.ScrollBarImageTransparency = 0
    ex.ScrollingDirection = Enum.ScrollingDirection.Y

    local Mx = Instance.new("UIPadding", ex)
    Mx.PaddingLeft = UDim.new(0, 6)
    Mx.PaddingRight = UDim.new(0, 6)
    Mx.PaddingTop = UDim.new(0, 8)
    Mx.PaddingBottom = UDim.new(0, 8)

    local mx = Instance.new("UIListLayout")
    mx.Padding = UDim.new(0, 6)
    mx.SortOrder = Enum.SortOrder.LayoutOrder
    mx.Parent = ex

    local Tx = Instance.new("Frame")
    Tx.Size = UDim2.new(1, 0, 0, 24)
    Tx.LayoutOrder = 0
    Tx.BackgroundTransparency = 1
    Tx.Parent = ex

    local zx = Instance.new("TextLabel")
    zx.Size = UDim2.new(1, -80, 1, 0)
    zx.BackgroundTransparency = 1
    zx.Text = "❤️ NYAWA PEMAIN 1 MATCH"
    zx.TextColor3 = Color3.fromRGB(255, 100, 100)
    zx.Font = Enum.Font.GothamBold
    zx.TextSize = 10
    zx.TextXAlignment = Enum.TextXAlignment.Left
    zx.Parent = Tx

    local Lx = Instance.new("TextButton")
    Lx.Size = UDim2.new(0, 72, 1, 0)
    Lx.Position = UDim2.new(1, -72, 0, 0)
    Lx.BackgroundColor3 = Color3.fromRGB(30, 20, 55)
    Lx.Text = "🔄 REFRESH"
    Lx.TextColor3 = Color3.fromRGB(180, 130, 255)
    Lx.Font = Enum.Font.GothamBold
    Lx.TextSize = 9
    Lx.Parent = Tx
    Instance.new("UICorner", Lx).CornerRadius = UDim.new(0, 7)

    local bx = Instance.new("UIStroke", Lx)
    bx.Color = Color3.fromRGB(120, 60, 220)
    bx.Thickness = 1.5
    bx.Transparency = .2

    local cx = {}
    function createNyawaCard(J)
        local q = Instance.new("Frame")
        q.Size = UDim2.new(1, 0, 0, Q and 62 or 68)
        q.LayoutOrder = J
        q.BackgroundColor3 = Color3.fromRGB(14, 12, 24)
        q.BorderSizePixel = 0
        q.Visible = false
        q.Parent = ex
        Instance.new("UICorner", q).CornerRadius = UDim.new(0, 10)
        Instance.new("UIStroke", q).Color = Color3.fromRGB(80, 20, 20)

        local N = Instance.new("TextLabel")
        N.Size = UDim2.new(1, -90, 0, 22)
        N.Position = UDim2.new(0, 10, 0, 6)
        N.BackgroundTransparency = 1
        N.Text = "..."
        N.TextColor3 = Color3.new(1, 1, 1)
        N.Font = Enum.Font.GothamBold
        N.TextSize = Q and 11 or 12
        N.TextXAlignment = Enum.TextXAlignment.Left
        N.TextTruncate = Enum.TextTruncate.AtEnd
        N.Parent = q

        local W = {}
        local v = {-140, -116}
        for J = 1, 2, 1 do
            local N = Instance.new("TextLabel")
            N.Size = UDim2.new(0, 20, 0, 20)
            N.Position = UDim2.new(1, v[J], 0, 8)
            N.BackgroundTransparency = 1
            N.Text = "❤️"
            N.Font = Enum.Font.GothamBold
            N.TextSize = 16
            N.TextColor3 = Color3.new(1, 1, 1)
            N.Parent = q
            W[J] = N
        end

        local p = Instance.new("TextLabel")
        p.Size = UDim2.new(0, 55, 0, 18)
        p.Position = UDim2.new(1, -62, 0, 7)
        p.BackgroundColor3 = Color3.fromRGB(30, 20, 50)
        p.Text = "HIDUP"
        p.TextColor3 = Color3.fromRGB(80, 255, 80)
        p.Font = Enum.Font.GothamBold
        p.TextSize = 9
        p.Parent = q
        Instance.new("UICorner", p).CornerRadius = UDim.new(1, 0)

        local Z = Instance.new("Frame")
        Z.Size = UDim2.new(1, -20, 0, 1)
        Z.Position = UDim2.new(0, 10, 0, 32)
        Z.BackgroundColor3 = Color3.fromRGB(50, 40, 80)
        Z.BorderSizePixel = 0
        Z.Parent = q

        local e = Instance.new("Frame")
        e.Size = UDim2.new(1, 0, 0, 24)
        e.Position = UDim2.new(0, 0, 0, 36)
        e.BackgroundTransparency = 1
        e.Parent = q

        local V = Instance.new("UIListLayout")
        V.FillDirection = Enum.FillDirection.Horizontal
        V.Padding = UDim.new(0, 0)
        V.SortOrder = Enum.SortOrder.LayoutOrder
        V.VerticalAlignment = Enum.VerticalAlignment.Center
        V.HorizontalAlignment = Enum.HorizontalAlignment.Center
        V.Parent = e

        function makeStatLbl(J, q, N)
            local W = Instance.new("TextLabel")
            W.Size = UDim2.new(.25, 0, 1, 0)
            W.BackgroundTransparency = 1
            W.Text = J .. " —"
            W.TextColor3 = q
            W.Font = Enum.Font.GothamBold
            W.TextSize = Q and 9 or 10
            W.TextXAlignment = Enum.TextXAlignment.Center
            W.LayoutOrder = N
            W.Parent = e
            return W
        end

        local k = makeStatLbl("🏆", Color3.fromRGB(255, 210, 60), 1)
        local g = makeStatLbl("💀", Color3.fromRGB(255, 80, 80), 2)
        local A = makeStatLbl("📈", Color3.fromRGB(80, 220, 120), 3)
        local G = makeStatLbl("💰", Color3.fromRGB(120, 190, 255), 4)

        return {frame = q, nameLbl = N, hearts = W, badge = p, winsLbl = k, lossesLbl = g, rateLbl = A, moneyLbl = G}
    end

    for J = 1, 8, 1 do
        cx[J] = createNyawaCard(J)
    end

    local Kx = Instance.new("TextLabel")
    Kx.Size = UDim2.new(1, 0, 0, 40)
    Kx.LayoutOrder = 9
    Kx.BackgroundTransparency = 1
    Kx.Text = "⚠️ Belum ada match aktif"
    Kx.TextColor3 = Color3.fromRGB(100, 90, 130)
    Kx.Font = Enum.Font.Gotham
    Kx.TextSize = 10
    Kx.TextWrapped = true
    Kx.Parent = ex

    local Ux = {}
    local Fx = false

    function snapshotMatch()
        local q = v:GetAttribute("CurrentTable")
        Ux = {}
        for J, N in pairs(game:GetService("Players"):GetPlayers()) do
            if N ~= v then
                local J = false
                if q then
                    local W, v = pcall(function() return N:GetAttribute("CurrentTable") end)
                    if W and (v and v == q) then J = true end
                end
                if not J and not q then
                    local q, W = pcall(function() return N:GetAttribute("Lives") end)
                    if q and typeof(W) == "number" then J = true end
                end
                if J then
                    local J, q = pcall(function() return N:GetAttribute("Lives") end)
                    local W, v, p, Z = nil, nil, nil, nil
                    local e = N:FindFirstChild("leaderstats")
                    if e then
                        local J = e:FindFirstChild("Wins")
                        local q = e:FindFirstChild("Losses")
                        local N = e:FindFirstChild("Money")
                        if J and q then
                            W = J.Value
                            v = q.Value
                            local N = W + v
                            p = N > 0 and math.floor((W / N) * 100) or 0
                        end
                        if N then Z = N.Value end
                    end
                    table.insert(Ux, {player = N, nama = N.Name, lives = J and q or nil, dead = false, wins = W, losses = v, winrate = p, money = Z})
                end
            end
        end
        print("[RAFLYXCILLO] Nyawa: Snapshot " .. (#Ux .. " musuh"))
    end

    function updateNyawaPage()
        local J = v:GetAttribute("CurrentTable")
        if J and not Fx then
            snapshotMatch()
            Fx = true
        end
        if not J and Fx then
            Fx = false
            Ux = {}
        end
        if J and #Ux > 0 then
            for q, N in ipairs(Ux) do
                if not N.dead then
                    local q, W = pcall(function() return N.player:GetAttribute("CurrentTable") end)
                    if not q or W ~= J then
                        N.dead = true
                    else
                        local J, q = pcall(function() return N.player:GetAttribute("Lives") end)
                        if J and typeof(q) == "number" then
                            N.lives = q
                            if q <= 0 then N.dead = true end
                        end
                    end
                    local v, p = pcall(function() return N.player.Name end)
                    if v then N.nama = p end
                    local Z = N.player:FindFirstChild("leaderstats")
                    if Z then
                        local J = Z:FindFirstChild("Wins")
                        local q = Z:FindFirstChild("Losses")
                        local W = Z:FindFirstChild("Money")
                        if J and q then
                            N.wins = J.Value
                            N.losses = q.Value
                            local W = N.wins + N.losses
                            N.winrate = W > 0 and math.floor((N.wins / W) * 100) or 0
                        end
                        if W then N.money = W.Value end
                    end
                end
            end
        end

        for J = 1, 8, 1 do
            cx[J].frame.Visible = false
        end

        if #Ux == 0 then
            Kx.Text = J and "🔄 Mendeteksi musuh... (coba REFRESH)" or "⚠️ Kamu belum di match"
            Kx.Visible = true
            return
        end
        Kx.Visible = false

        for J, q in ipairs(Ux) do
            if J > 8 then break end
            local N = cx[J]
            N.frame.Visible = true
            N.nameLbl.Text = q.nama
            local W = q.wins ~= nil and tostring(q.wins) or "?"
            local v = q.losses ~= nil and tostring(q.losses) or "?"
            local p = q.winrate ~= nil and tostring(q.winrate) .. "%" or "?"
            local Z = q.money ~= nil and "Rp" .. tostring(q.money) or "?"
            N.winsLbl.Text = "🏆 " .. W
            N.lossesLbl.Text = "💀 " .. v
            N.rateLbl.Text = "📈 " .. p
            N.moneyLbl.Text = "💰 " .. Z

            local e = N.frame:FindFirstChildOfClass("UIStroke")
            if q.dead then
                N.hearts[1].Text = "🖤"
                N.hearts[2].Text = "🖤"
                N.badge.Text = "MATI"
                N.badge.TextColor3 = Color3.fromRGB(255, 60, 60)
                if e then e.Color = Color3.fromRGB(150, 20, 20) end
            elseif typeof(q.lives) ~= "number" then
                N.hearts[1].Text = "❤️"
                N.hearts[2].Text = "❤️"
                N.badge.Text = "SIAP"
                N.badge.TextColor3 = Color3.fromRGB(150, 150, 150)
                if e then e.Color = Color3.fromRGB(60, 60, 80) end
            elseif q.lives >= 2 then
                N.hearts[1].Text = "❤️"
                N.hearts[2].Text = "❤️"
                N.badge.Text = "FULL"
                N.badge.TextColor3 = Color3.fromRGB(80, 255, 80)
                if e then e.Color = Color3.fromRGB(20, 100, 20) end
            elseif q.lives == 1 then
                N.hearts[1].Text = "❤️"
                N.hearts[2].Text = "🖤"
                N.badge.Text = "1 NYAWA"
                N.badge.TextColor3 = Color3.fromRGB(255, 200, 0)
                if e then e.Color = Color3.fromRGB(150, 100, 0) end
            else
                N.hearts[1].Text = "🖤"
                N.hearts[2].Text = "🖤"
                N.badge.Text = "MATI"
                N.badge.TextColor3 = Color3.fromRGB(255, 60, 60)
                if e then e.Color = Color3.fromRGB(150, 20, 20) end
                q.dead = true
            end
        end
    end

    Lx.MouseButton1Click:Connect(function()
        local J = v:GetAttribute("CurrentTable")
        if not J then
            Lx.Text = "❌ Belum di match"
            Lx.TextColor3 = Color3.fromRGB(255, 80, 80)
            task.delay(1.5, function()
                Lx.Text = "🔄 REFRESH"
                Lx.TextColor3 = Color3.fromRGB(180, 130, 255)
            end)
            return
        end
        playClickSound()
        Lx.Text = "⏳ ..."
        Lx.TextColor3 = Color3.fromRGB(255, 200, 50)
        Ux = {}
        Fx = false
        task.spawn(function()
            task.wait(.3)
            Fx = true
            pcall(snapshotMatch)
            pcall(updateNyawaPage)
            task.wait(.5)
            Lx.Text = "🔄 REFRESH"
            Lx.TextColor3 = Color3.fromRGB(180, 130, 255)
        end)
    end)

    task.spawn(function()
        while task.wait(1) do
            if not e then break end
            pcall(updateNyawaPage)
        end
    end)

    v:GetAttributeChangedSignal("CurrentTable"):Connect(function()
        local J = v:GetAttribute("CurrentTable")
        if J then
            task.delay(2, function()
                pcall(snapshotMatch)
                pcall(updateNyawaPage)
            end)
            task.delay(5, function()
                if #Ux == 0 then
                    pcall(snapshotMatch)
                    pcall(updateNyawaPage)
                    print("[RAFLYXCILLO] Nyawa: Second attempt snapshot")
                end
            end)
        else
            Fx = false
            Ux = {}
            pcall(updateNyawaPage)
        end
    end)

    game:GetService("Players").PlayerAdded:Connect(function(J)
        J:GetAttributeChangedSignal("Lives"):Connect(function()
            pcall(updateNyawaPage)
        end)
    end)

    for J, q in pairs(game:GetService("Players"):GetPlayers()) do
        if q ~= v then
            q:GetAttributeChangedSignal("Lives"):Connect(function()
                pcall(updateNyawaPage)
            end)
        end
    end

    task.spawn(function()
        task.wait(3)
        local J = v:GetAttribute("CurrentTable")
        if J and not Fx then
            Fx = true
            pcall(snapshotMatch)
            pcall(updateNyawaPage)
            print("[RAFLYXCILLO] Nyawa: Detected in match on load!")
        end
        task.wait(3)
        if Fx and #Ux == 0 then
            pcall(snapshotMatch)
            pcall(updateNyawaPage)
        end
    end)

    function showPage(J)
        local q = {t, Jx, qx, Nx, vx, ex}
        for _, page in pairs(q) do
            if page then page.Visible = false end
        end
        if J then J.Visible = true end
    end

    showPage(Jx)
    setActiveTab(R)

    F.MouseButton1Click:Connect(function() showPage(t) setActiveTab(F) playClickSound() end)
    l.MouseButton1Click:Connect(function() showPage(ex) setActiveTab(l) playClickSound() end)
    R.MouseButton1Click:Connect(function() showPage(Jx) setActiveTab(R) playClickSound() end)
    a.MouseButton1Click:Connect(function() showPage(qx) setActiveTab(a) playClickSound() end)
    o.MouseButton1Click:Connect(function() showPage(Nx) setActiveTab(o) playClickSound() end)
    d.MouseButton1Click:Connect(function() showPage(vx) setActiveTab(d) playClickSound() end)

    local Rx, ax
    local ox = false
    local dx = true
    local lx = .03
    local yx = .08
    local rx = .15
    local sx = .5
    local Dx = .02
    local hx = .06
    local Cx = 1
    local Hx = 2.5
    local Sx = false
    local tx = false
    local JX = 3
    local qX = 0
    local NX = false
    local WX = 0
    local vX = 2
    local pX = false
    local ZX = ""
    local eX = ""
    local QX = {"wkwk", "receh", "noob", "lemah", "kasian", "santuy", "ezz", "wkwk", "lol", "mudah"}
    local VX = {
        IF = {}, X = {}, NG = {}, AI = {}, KS = {}, CY = {}, UI = {}, LY = {}, GY = {}, LT = {},
        EO = {}, OE = {}, EKS = {}, OO = {}, KN = {}, Q = {}, MP = {}, SF = {}, TT = {},
        ["SEMUA KATA SULIT"] = {}
    }
    local kX = {
        IF = false, X = false, NG = false, AI = false, KS = false, CY = false, UI = false, LY = false, GY = false,
        LT = false, EO = false, OE = false, EKS = false, OO = false, KN = false, Q = false, MP = false, SF = false,
        TT = false, ["SEMUA KATA SULIT"] = false
    }

    MainLayout = Instance.new("UIListLayout")
    MainLayout.Padding = UDim.new(0, Q and 5 or 7)
    MainLayout.SortOrder = Enum.SortOrder.LayoutOrder
    MainLayout.Parent = Jx

    MainPad = Instance.new("UIPadding", Jx)
    MainPad.PaddingLeft = UDim.new(0, 5)
    MainPad.PaddingRight = UDim.new(0, 5)
    MainPad.PaddingTop = UDim.new(0, 5)
    MainPad.PaddingBottom = UDim.new(0, 10)

function createCompactSpeedPanel(J, q)
    local W = Q and 48 or 42
    local expandedHeight = (28 + 4 * W) + 6
    local collapsedHeight = 26 -- Tinggi saat ditutup (cuma kelihatan headernya)
    
    local p = Instance.new("Frame")
    p.Size = UDim2.new(1, -4, 0, collapsedHeight) -- Kita atur mulai dari tertutup (collapsed)
    p.ClipsDescendants = true -- INI KUNCINYA: Biar slider di bawahnya sembunyi saat mengecil
    p.LayoutOrder = q
    p.BackgroundColor3 = Color3.fromRGB(12, 11, 20)
    p.BorderSizePixel = 0
    p.Parent = J
    Instance.new("UICorner", p).CornerRadius = UDim.new(0, 11)

    local Z_stroke = Instance.new("UIStroke", p)
    Z_stroke.Color = Color3.fromRGB(60, 30, 110)
    Z_stroke.Thickness = 1
    Z_stroke.Transparency = .3

    -- Ubah header menjadi TextButton supaya bisa diklik
    local e = Instance.new("TextButton")
    e.Size = UDim2.new(1, 0, 0, 26)
    e.BackgroundColor3 = Color3.fromRGB(20, 16, 36)
    e.BorderSizePixel = 0
    e.Text = ""
    e.AutoButtonColor = false
    e.Parent = p
    Instance.new("UICorner", e).CornerRadius = UDim.new(0, 11)

    local V_Frame = Instance.new("Frame")
    V_Frame.Size = UDim2.new(1, 0, .5, 0)
    V_Frame.Position = UDim2.new(0, 0, .5, 0)
    V_Frame.BackgroundColor3 = Color3.fromRGB(20, 16, 36)
    V_Frame.BorderSizePixel = 0
    V_Frame.Parent = e

    local k = Instance.new("TextLabel")
    k.Size = UDim2.new(1, -12, 1, 0)
    k.Position = UDim2.new(0, 12, 0, 0)
    k.BackgroundTransparency = 1
    k.Text = "⚡  SPEED SETTINGS 🔻" -- Tambahan panah
    k.TextColor3 = Color3.fromRGB(180, 140, 255)
    k.Font = Enum.Font.GothamBold
    k.TextSize = 10
    k.TextXAlignment = Enum.TextXAlignment.Left
    k.Parent = e

    -- LOGIKA SHOW & HIDE (DROPDOWN)
    local isExpanded = false
    e.MouseButton1Click:Connect(function()
        -- Efek suara klik
        pcall(function()
            local snd = Instance.new("Sound")
            snd.SoundId = "rbxassetid://139658322785649"
            snd.Volume = 0.5
            snd.Parent = game:GetService("SoundService")
            snd:Play()
            game:GetService("Debris"):AddItem(snd, 1)
        end)

        isExpanded = not isExpanded
        k.Text = isExpanded and "⚡  SPEED SETTINGS ▲" or "⚡  SPEED SETTINGS 🔻"
        
        -- Animasi buka tutup panel
        p:TweenSize(UDim2.new(1, -4, 0, isExpanded and expandedHeight or collapsedHeight), "Out", "Quart", 0.3, true)
    end)

    local g = {
        {icon = "⌚", label = "NULIS", minV = .01, maxV = 1, defMin = .19, defMax = .37, dec = 2, suf = "s", cbMin = function(c) lx = c end, cbMax = function(c) yx = c end},
        {icon = "⏳", label = "DELAY GILIRAN", minV = .1, maxV = 5, defMin = 1.5, defMax = 2.5, dec = 1, suf = "s", cbMin = function(c) Cx = c end, cbMax = function(c) Hx = c end},
        {icon = "📨", label = "ENTER", minV = .01, maxV = 3, defMin = .2, defMax = .5, dec = 2, suf = "s", cbMin = function(c) rx = c end, cbMax = function(c) sx = c end},
        {icon = "🗑️", label = "DELETE", minV = .01, maxV = 1, defMin = .2, defMax = .3, dec = 2, suf = "s", cbMin = function(c) Dx = c end, cbMax = function(c) hx = c end}
    }

    for c, X in ipairs(g) do
        X.cbMin(X.defMin)
        X.cbMax(X.defMax)
    end

    local A = Q and 16 or 11
    local G = Q and 20 or 12

    for c, X in ipairs(g) do
        local d = 28 + (c - 1) * W
        local j = Instance.new("Frame")
        j.Size = UDim2.new(1, -10, 0, W - 4)
        j.Position = UDim2.new(0, 5, 0, d)
        j.BackgroundColor3 = c % 2 == 0 and Color3.fromRGB(16, 14, 26) or Color3.fromRGB(13, 12, 22)
        j.BorderSizePixel = 0
        j.Parent = p
        Instance.new("UICorner", j).CornerRadius = UDim.new(0, 7)

        local g_lbl = Instance.new("TextLabel")
        g_lbl.Size = UDim2.new(0, 80, 0, 14)
        g_lbl.Position = UDim2.new(0, 8, 0, 4)
        g_lbl.BackgroundTransparency = 1
        g_lbl.Text = X.icon .. (" " .. X.label)
        g_lbl.TextColor3 = Color3.fromRGB(170, 155, 210)
        g_lbl.Font = Enum.Font.GothamBold
        g_lbl.TextSize = Q and 8 or 9
        g_lbl.TextXAlignment = Enum.TextXAlignment.Left
        g_lbl.Parent = j

        local w = "%." .. (X.dec .. "f")
        local x = Instance.new("TextLabel")
        x.Size = UDim2.new(0, 90, 0, 14)
        x.Position = UDim2.new(1, -94, 0, 4)
        x.BackgroundTransparency = 1
        x.Font = Enum.Font.GothamBold
        x.TextSize = Q and 8 or 9
        x.TextXAlignment = Enum.TextXAlignment.Right
        x.Parent = j

        local t, Z_max = X.defMin, X.defMax
        
        local function Q_func()
            x.Text = string.format(w, t) .. (" ~ " .. (string.format(w, Z_max) .. X.suf))
            local c_theme = u[X] 
            x.TextColor3 = c_theme and c_theme.logText or Color3.fromRGB(150, 100, 255)
        end
        Q_func()

        local q_sz = Q and 32 or 26
        local R_sz = Q and 6 or 4
        local r = Instance.new("Frame")
        r.Size = UDim2.new(1, -16, 0, R_sz)
        r.Position = UDim2.new(0, 8, 0, q_sz)
        r.BackgroundColor3 = Color3.fromRGB(30, 25, 50)
        r.BorderSizePixel = 0
        r.Parent = j
        Instance.new("UICorner", r).CornerRadius = UDim.new(1, 0)

        local a = Instance.new("Frame")
        a.BackgroundColor3 = Color3.fromRGB(120, 60, 220)
        a.BorderSizePixel = 0
        a.Parent = r
        Instance.new("UICorner", a).CornerRadius = UDim.new(1, 0)

        local C = Instance.new("Frame")
        C.Size = UDim2.new(0, A, 0, A)
        C.BackgroundColor3 = Color3.new(1, 1, 1)
        C.BorderSizePixel = 0
        C.ZIndex = 3
        C.Parent = r
        Instance.new("UICorner", C).CornerRadius = UDim.new(1, 0)

        local l = Instance.new("UIStroke", C)
        l.Color = Color3.fromRGB(150, 80, 255)
        l.Thickness = 1.5

        local S = Instance.new("Frame")
        S.Size = UDim2.new(0, A, 0, A)
        S.BackgroundColor3 = Color3.fromRGB(180, 120, 255)
        S.BorderSizePixel = 0
        S.ZIndex = 3
        S.Parent = r
        Instance.new("UICorner", S).CornerRadius = UDim.new(1, 0)

        local b = Instance.new("UIStroke", S)
        b.Color = Color3.fromRGB(200, 150, 255)
        b.Thickness = 1.5

        local function s(c_val)
            local V_mul = 10 ^ X.dec
            return math.floor(c_val * V_mul + .5) / V_mul
        end

        local K = A / 2
        local function O()
            local c_rat = (t - X.minV) / (X.maxV - X.minV)
            local V_rat = (Z_max - X.minV) / (X.maxV - X.minV)
            a.Position = UDim2.new(c_rat, 0, 0, 0)
            a.Size = UDim2.new(V_rat - c_rat, 0, 1, 0)
            C.Position = UDim2.new(c_rat, -K, .5, -K)
            S.Position = UDim2.new(V_rat, -K, .5, -K)
            Q_func()
        end
        O()

        local W_btn = Instance.new("TextButton")
        W_btn.Size = UDim2.new(1, 0, 0, G * 2)
        W_btn.Position = UDim2.new(0, 0, .5, -G)
        W_btn.BackgroundTransparency = 1
        W_btn.Text = ""
        W_btn.ZIndex = 4
        W_btn.Parent = r

        local y, p_bool = false, false
        local function P(c_pos)
            local X_pos = r.AbsolutePosition.X
            local V_size = r.AbsoluteSize.X
            return math.clamp((c_pos - X_pos) / V_size, 0, 1)
        end
        local function E(c_val)
            return s(X.minV + c_val * (X.maxV - X.minV))
        end

        W_btn.InputBegan:Connect(function(c_input)
            if c_input.UserInputType ~= Enum.UserInputType.MouseButton1 and c_input.UserInputType ~= Enum.UserInputType.Touch then return end
            local X_val = E(P(c_input.Position.X))
            if math.abs(X_val - t) <= math.abs(X_val - Z_max) then
                y = true
            else
                p_bool = true
            end
        end)

        N.InputChanged:Connect(function(c_input)
            if c_input.UserInputType ~= Enum.UserInputType.MouseMovement and c_input.UserInputType ~= Enum.UserInputType.Touch then return end
            if not (y or p_bool) then return end
            local V_val = E(P(c_input.Position.X))
            local L_step = 1 / 10 ^ X.dec
            if y then
                t = math.clamp(V_val, X.minV, Z_max - L_step)
                X.cbMin(t)
            else
                Z_max = math.clamp(V_val, t + L_step, X.maxV)
                X.cbMax(Z_max)
            end
            O()
        end)

        N.InputEnded:Connect(function(c_input)
            if c_input.UserInputType == Enum.UserInputType.MouseButton1 or c_input.UserInputType == Enum.UserInputType.Touch then
                y = false
                p_bool = false
            end
        end)

        table.insert(Y, {fill = a, knobMinStroke = l, knobMaxStroke = b, valLbl = x, knobMax = S})
    end
    return p
end

    function createToggle(J, q, N, W, v)
        local p = Instance.new("Frame")
        p.Size = UDim2.new(1, -4, 0, B)
        p.LayoutOrder = v
        p.BackgroundColor3 = Color3.fromRGB(16, 15, 24)
        p.BorderSizePixel = 0
        p.Parent = q
        Instance.new("UICorner", p).CornerRadius = UDim.new(0, 9)

        local Z = Instance.new("UIStroke", p)
        Z.Color = Color3.fromRGB(55, 30, 100)
        Z.Thickness = 1
        Z.Transparency = .4

        local e = Instance.new("TextLabel")
        e.Size = UDim2.new(1, -60, 1, 0)
        e.Position = UDim2.new(0, 10, 0, 0)
        e.BackgroundTransparency = 1
        e.Text = J
        e.TextColor3 = Color3.fromRGB(210, 200, 230)
        e.Font = Enum.Font.GothamBold
        e.TextSize = w
        e.TextXAlignment = Enum.TextXAlignment.Left
        e.Parent = p

        local V = Q and 48 or 44
        local k = Q and 26 or 22
        local g = Instance.new("Frame")
        g.Size = UDim2.new(0, V, 0, k)
        g.Position = UDim2.new(1, -(V + 6), .5, -k / 2)
        g.BackgroundColor3 = N and Color3.fromRGB(30, 180, 110) or Color3.fromRGB(180, 40, 50)
        g.BorderSizePixel = 0
        g.Parent = p
        Instance.new("UICorner", g).CornerRadius = UDim.new(1, 0)

        local A = Q and 20 or 16
        local G = Instance.new("Frame")
        G.Size = UDim2.new(0, A, 0, A)
        G.Position = N and UDim2.new(1, -(A + 3), .5, -A / 2) or UDim2.new(0, 3, .5, -A / 2)
        G.BackgroundColor3 = Color3.new(1, 1, 1)
        G.BorderSizePixel = 0
        G.Parent = g
        Instance.new("UICorner", G).CornerRadius = UDim.new(1, 0)

        local P = Instance.new("TextButton")
        P.Size = UDim2.new(1, 0, 1, 0)
        P.BackgroundTransparency = 1
        P.Text = ""
        P.Parent = p

        local n = N
        P.MouseButton1Click:Connect(function()
            n = not n
            g.BackgroundColor3 = n and Color3.fromRGB(30, 180, 110) or Color3.fromRGB(180, 40, 50)
            G.Position = n and UDim2.new(1, -(A + 3), .5, -A / 2) or UDim2.new(0, 3, .5, -A / 2)
            playClickSound()
            W(n)
        end)
        return p
    end

    local gX
    createToggle("AUTO TULIS", Jx, false, function(J)
        ox = J
        if ox then
            task.wait(.3)
            gX()
        end
    end, 1)

    createToggle("AUTO REJOIN", Jx, true, function(J) dx = J end, 3)
    createCompactSpeedPanel(Jx, 31)

    createToggle("🧠 MANUSIA [FIX]", Jx, false, function(J) Sx = J end, 32)
    createToggle("💀 BLATANT MODE", Jx, false, function(J)
        pX = J
        if not J then
            ZX = ""
            eX = ""
        end
    end, 33)

    local AX = Instance.new("Frame")
    AX.Size = UDim2.new(1, -4, 0, 0)
    AX.AutomaticSize = Enum.AutomaticSize.Y
    AX.LayoutOrder = 34
    AX.BackgroundColor3 = Color3.fromRGB(60, 10, 10)
    AX.BorderSizePixel = 0
    AX.Parent = Jx
    Instance.new("UICorner", AX).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", AX).Color = Color3.fromRGB(180, 40, 40)

    local GX = Instance.new("UIPadding", AX)
    GX.PaddingLeft = UDim.new(0, 10)
    GX.PaddingRight = UDim.new(0, 10)
    GX.PaddingTop = UDim.new(0, 8)
    GX.PaddingBottom = UDim.new(0, 8)

    local BX = Instance.new("UIListLayout", AX)
    BX.Padding = UDim.new(0, 4)
    BX.SortOrder = Enum.SortOrder.LayoutOrder

    local wX = Instance.new("TextLabel")
    wX.Size = UDim2.new(1, 0, 0, 0)
    wX.AutomaticSize = Enum.AutomaticSize.Y
    wX.LayoutOrder = 1
    wX.BackgroundTransparency = 1
    wX.Text = "⚠️  WAJIB MATIKAN AUTO TULIS"
    wX.TextColor3 = Color3.fromRGB(255, 80, 80)
    wX.Font = Enum.Font.GothamBold
    wX.TextSize = Q and 9 or 10
    wX.TextXAlignment = Enum.TextXAlignment.Left
    wX.TextWrapped = true
    wX.Parent = AX

    local PX = Instance.new("TextLabel")
    PX.Size = UDim2.new(1, 0, 0, 0)
    PX.AutomaticSize = Enum.AutomaticSize.Y
    PX.LayoutOrder = 2
    PX.BackgroundTransparency = 1
    PX.Text = "⚠️  Hati-hati! Fitur ini gampang kena banned."
    PX.TextColor3 = Color3.fromRGB(255, 140, 50)
    PX.Font = Enum.Font.GothamBold
    PX.TextSize = Q and 9 or 10
    PX.TextXAlignment = Enum.TextXAlignment.Left
    PX.TextWrapped = true
    PX.Parent = AX

    local nX = Instance.new("TextLabel")
    nX.Size = UDim2.new(1, 0, 0, 0)
    nX.AutomaticSize = Enum.AutomaticSize.Y
    nX.LayoutOrder = 3
    nX.BackgroundTransparency = 1
    nX.Text = "💡  Tulis apa aja, tekan Enter — kata valid dikirim otomatis."
    nX.TextColor3 = Color3.fromRGB(160, 200, 160)
    nX.Font = Enum.Font.Gotham
    nX.TextSize = Q and 9 or 10
    nX.TextXAlignment = Enum.TextXAlignment.Left
    nX.TextWrapped = true
    nX.Parent = AX

    local OX = Instance.new("TextButton")
    OX.Size = UDim2.new(1, -4, 0, B)
    OX.LayoutOrder = 4
    OX.BackgroundColor3 = Color3.fromRGB(65, 20, 145)
    OX.Text = "🛡️  SET KATA SULIT 🔻"
    OX.TextColor3 = Color3.new(1, 1, 1)
    OX.Font = Enum.Font.GothamBold
    OX.TextSize = w
    OX.Parent = Jx
    Instance.new("UICorner", OX).CornerRadius = UDim.new(0, 9)

    dropBtnGrad = Instance.new("UIGradient", OX)
    dropBtnGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(90, 30, 190)), ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 15, 120))})

    local uX = Instance.new("Frame")
    uX.Size = UDim2.new(1, -4, 0, 0)
    uX.BackgroundColor3 = Color3.fromRGB(14, 13, 22)
    uX.ClipsDescendants = true
    uX.BorderSizePixel = 0
    uX.Parent = Jx
    uX.LayoutOrder = 5

    dropStroke = Instance.new("UIStroke", uX)
    dropStroke.Color = Color3.fromRGB(80, 35, 160)
    dropStroke.Thickness = 1
    dropStroke.Transparency = .3

    local XX = Q and 37 or 33
    function refreshDropUI()
        for J, q in pairs(uX:GetChildren()) do
            if q:IsA("TextButton") then
                q:Destroy()
            end
        end
        local J = {"IF", "X", "NG", "AI", "KS", "CY", "UI", "LY", "GY", "LT", "EO", "OE", "EKS", "OO", "KN", "Q", "MP", "SF", "TT", "SEMUA KATA SULIT"}
        for J, q in ipairs(J) do
            local N = Instance.new("TextButton")
            N.Size = UDim2.new(1, -12, 0, Q and 32 or 28)
            N.Position = UDim2.new(0, 6, 0, (J - 1) * XX + 5)
            local W = kX["SEMUA KATA SULIT"] and q ~= "SEMUA KATA SULIT"
            local v = kX[q]
            N.BackgroundColor3 = W and Color3.fromRGB(25, 22, 36) or v and Color3.fromRGB(80, 30, 170) or Color3.fromRGB(28, 25, 42)
            N.Text = (v and "✓  " or "   ") .. (q .. (v and "  [ON]" or ""))
            N.TextColor3 = W and Color3.fromRGB(70, 65, 90) or v and Color3.new(1, 1, 1) or Color3.fromRGB(160, 150, 190)
            N.Font = Enum.Font.GothamBold
            N.TextSize = w
            N.TextXAlignment = Enum.TextXAlignment.Left
            N.Parent = uX
            Instance.new("UICorner", N).CornerRadius = UDim.new(0, 7)

            local p = Instance.new("UIPadding", N)
            p.PaddingLeft = UDim.new(0, 8)
            if v then
                local J = Instance.new("UIStroke", N)
                J.Color = Color3.fromRGB(130, 70, 220)
                J.Thickness = 1
                J.Transparency = .2
            end

            local Z = Instance.new("TextLabel")
            Z.Size = UDim2.new(0, 60, 1, 0)
            Z.Position = UDim2.new(1, -64, 0, 0)
            Z.BackgroundTransparency = 1
            local e = #(VX[q] or {})
            Z.Text = e > 0 and e .. " kata" or "loading..."
            Z.TextColor3 = W and Color3.fromRGB(60, 55, 80) or Color3.fromRGB(120, 100, 180)
            Z.Font = Enum.Font.Gotham
            Z.TextSize = Q and 8 or 9
            Z.TextXAlignment = Enum.TextXAlignment.Right
            Z.ZIndex = N.ZIndex + 1
            Z.Parent = N

            N.MouseButton1Click:Connect(function()
                if W then return end
                playClickSound()
                if q == "SEMUA KATA SULIT" then
                    kX["SEMUA KATA SULIT"] = not kX["SEMUA KATA SULIT"]
                    if kX["SEMUA KATA SULIT"] then
                        kX.IF = false; kX.X = false; kX.NG = false; kX.AI = false; kX.KS = false; kX.CY = false; kX.UI = false
                        kX.LY = false; kX.GY = false; kX.LT = false; kX.EO = false; kX.OE = false; kX.EKS = false; kX.OO = false
                        kX.KN = false; kX.Q = false; kX.MP = false; kX.SF = false; kX.TT = false
                    end
                else
                    kX[q] = not kX[q]
                end
                refreshDropUI()
            end)
        end
    end

    Y.DropMainBtn = OX
    Y.dropBtnGrad = dropBtnGrad
    Y.dropStroke = dropStroke
    Y.ScrollBar = Jx
    Y.themeBtnStroke = themeBtnStroke
    Y.themeDFStroke = themeDFStroke

    local YX = false
    OX.MouseButton1Click:Connect(function()
        playClickSound()
        YX = not YX
        OX.Text = YX and "🛡️  SET KATA SULIT 🔺" or "🛡️  SET KATA SULIT 🔻"
        uX:TweenSize(UDim2.new(1, -4, 0, YX and 20 * XX + 10 or 0), "Out", "Quart", .3, true)
        refreshDropUI()
    end)

    local jX = Instance.new("Frame")
    jX.Size = UDim2.new(1, -4, 0, Q and 55 or 50)
    jX.LayoutOrder = 10
    jX.BackgroundColor3 = Color3.fromRGB(12, 10, 20)
    jX.BorderSizePixel = 0
    jX.Parent = Jx
    Instance.new("UICorner", jX).CornerRadius = UDim.new(0, 9)

    logStroke = Instance.new("UIStroke", jX)
    logStroke.Color = Color3.fromRGB(80, 40, 140)
    logStroke.Thickness = 1
    logStroke.Transparency = .4
    Y.logStroke = logStroke

    Rx = Instance.new("TextLabel")
    Rx.Size = UDim2.new(1, -12, 0, 22)
    Rx.Position = UDim2.new(0, 8, 0, 4)
    Rx.BackgroundTransparency = 1
    Rx.Text = "AWALAN: -"
    Rx.TextColor3 = Color3.fromRGB(160, 100, 255)
    Rx.Font = Enum.Font.GothamBold
    Rx.TextSize = Q and 10 or 11
    Rx.TextXAlignment = Enum.TextXAlignment.Left
    Rx.Parent = jX
    Y.LogAwalan = Rx

    ax = Instance.new("TextLabel")
    ax.Size = UDim2.new(1, -12, 0, 24)
    ax.Position = UDim2.new(0, 8, 0, 26)
    ax.BackgroundTransparency = 1
    ax.Text = "-"
    ax.TextColor3 = Color3.fromRGB(230, 230, 255)
    ax.Font = Enum.Font.GothamBold
    ax.TextSize = Q and 14 or 16
    ax.TextXAlignment = Enum.TextXAlignment.Left
    ax.Parent = jX

    local fX, iX, EX, xX, IX
    FakePad = Instance.new("UIPadding", qx)
    FakePad.PaddingLeft = UDim.new(0, 6)
    FakePad.PaddingRight = UDim.new(0, 6)
    FakePad.PaddingTop = UDim.new(0, 8)

    FakeLabel = Instance.new("TextLabel")
    FakeLabel.Size = UDim2.new(1, 0, 0, 18)
    FakeLabel.Position = UDim2.new(0, 0, 0, 0)
    FakeLabel.BackgroundTransparency = 1
    FakeLabel.Text = "🎭 GANTI NAMA TAMPILAN"
    FakeLabel.TextColor3 = Color3.fromRGB(120, 80, 200)
    FakeLabel.Font = Enum.Font.GothamBold
    FakeLabel.TextSize = 10
    FakeLabel.TextXAlignment = Enum.TextXAlignment.Left
    FakeLabel.Parent = qx
    Y.FakeLabel = FakeLabel

    fX = Instance.new("TextBox")
    fX.Size = UDim2.new(1, 0, 0, Q and 44 or 38)
    fX.Position = UDim2.new(0, 0, 0, 24)
    fX.BackgroundColor3 = Color3.fromRGB(18, 16, 28)
    fX.PlaceholderText = "Masukkan Nama Palsu..."
    fX.Text = ""
    fX.TextColor3 = Color3.new(1, 1, 1)
    fX.Font = Enum.Font.GothamBold
    fX.TextSize = w + 1
    fX.PlaceholderColor3 = Color3.fromRGB(90, 80, 120)
    fX.Parent = qx
    Instance.new("UICorner", fX).CornerRadius = UDim.new(0, 9)

    fbs = Instance.new("UIStroke", fX)
    fbs.Color = Color3.fromRGB(90, 45, 180)
    fbs.Thickness = 1.5
    fbs.Transparency = .2

    fbp = Instance.new("UIPadding", fX)
    fbp.PaddingLeft = UDim.new(0, 12)
    Y.FakeNameStroke = fbs

    btnY = Q and 76 or 68
    iX = Instance.new("TextButton")
    iX.Size = UDim2.new(1, 0, 0, Q and 44 or 38)
    iX.Position = UDim2.new(0, 0, 0, btnY)
    iX.BackgroundColor3 = Color3.fromRGB(60, 130, 240)
    iX.Text = "✏️ TERAPKAN NAMA"
    iX.TextColor3 = Color3.new(1, 1, 1)
    iX.Font = Enum.Font.GothamBold
    iX.TextSize = w + 1
    iX.Parent = qx
    Instance.new("UICorner", iX).CornerRadius = UDim.new(0, 9)

    sbg = Instance.new("UIGradient", iX)
    sbg.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 150, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 90, 200))})
    Y.SetNameBtn = iX
    Y.sbg = sbg

    FakeDivider = Instance.new("Frame")
    FakeDivider.Size = UDim2.new(1, 0, 0, 1)
    FakeDivider.Position = UDim2.new(0, 0, 0, (btnY + (Q and 52 or 46)) + 6)
    FakeDivider.BackgroundColor3 = Color3.fromRGB(40, 35, 60)
    FakeDivider.BorderSizePixel = 0
    FakeDivider.Parent = qx

    streakSecY = (btnY + (Q and 52 or 46)) + 14
    StreakLabel = Instance.new("TextLabel")
    StreakLabel.Size = UDim2.new(1, 0, 0, 18)
    StreakLabel.Position = UDim2.new(0, 0, 0, streakSecY)
    StreakLabel.BackgroundTransparency = 1
    StreakLabel.Text = "🔥 FAKE STREAK KEMENANGAN"
    StreakLabel.TextColor3 = Color3.fromRGB(255, 140, 50)
    StreakLabel.Font = Enum.Font.GothamBold
    StreakLabel.TextSize = 10
    StreakLabel.TextXAlignment = Enum.TextXAlignment.Left
    StreakLabel.Parent = qx

    EX = Instance.new("TextBox")
    EX.Size = UDim2.new(1, 0, 0, Q and 44 or 38)
    EX.Position = UDim2.new(0, 0, 0, streakSecY + 22)
    EX.BackgroundColor3 = Color3.fromRGB(18, 16, 28)
    EX.PlaceholderText = "Contoh: 7, 25, 99"
    EX.Text = ""
    EX.TextColor3 = Color3.new(1, 1, 1)
    EX.Font = Enum.Font.GothamBold
    EX.TextSize = w + 1
    EX.PlaceholderColor3 = Color3.fromRGB(90, 80, 120)
    EX.Parent = qx
    Instance.new("UICorner", EX).CornerRadius = UDim.new(0, 9)

    skbs = Instance.new("UIStroke", EX)
    skbs.Color = Color3.fromRGB(180, 80, 20)
    skbs.Thickness = 1.5
    skbs.Transparency = .2

    skbp = Instance.new("UIPadding", EX)
    skbp.PaddingLeft = UDim.new(0, 12)
    Y.StreakBoxStroke = skbs
    Y.StreakLabel = StreakLabel

    setStreakBtnY = (streakSecY + 22) + (Q and 52 or 46)
    xX = Instance.new("TextButton")
    xX.Size = UDim2.new(1, 0, 0, Q and 44 or 38)
    xX.Position = UDim2.new(0, 0, 0, setStreakBtnY)
    xX.BackgroundColor3 = Color3.fromRGB(200, 80, 20)
    xX.Text = "🔥 TERAPKAN STREAK"
    xX.TextColor3 = Color3.new(1, 1, 1)
    xX.Font = Enum.Font.GothamBold
    xX.TextSize = w + 1
    xX.Parent = qx
    Instance.new("UICorner", xX).CornerRadius = UDim.new(0, 9)

    sskgb = Instance.new("UIGradient", xX)
    sskgb.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 120, 30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 60, 10))})
    Y.SetStreakBtn = xX
    Y.sskgb = sskgb

    IX = Instance.new("TextLabel")
    IX.Size = UDim2.new(1, 0, 0, 16)
    IX.Position = UDim2.new(0, 0, 0, setStreakBtnY + (Q and 48 or 42))
    IX.BackgroundTransparency = 1
    IX.Text = ""
    IX.TextColor3 = Color3.fromRGB(255, 160, 60)
    IX.Font = Enum.Font.GothamBold
    IX.TextSize = 10
    IX.TextXAlignment = Enum.TextXAlignment.Left
    IX.Parent = qx

        -- ======== [ MULAI TAMBAHAN FAKE DEVICE PC ] ========
    local deviceSecY = setStreakBtnY + (Q and 70 or 64)

    local DeviceLabel = Instance.new("TextLabel")
    DeviceLabel.Size = UDim2.new(1, 0, 0, 18)
    DeviceLabel.Position = UDim2.new(0, 0, 0, deviceSecY)
    DeviceLabel.BackgroundTransparency = 1
    DeviceLabel.Text = "💻 FAKE DEVICE (PC)"
    DeviceLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
    DeviceLabel.Font = Enum.Font.GothamBold
    DeviceLabel.TextSize = 10
    DeviceLabel.TextXAlignment = Enum.TextXAlignment.Left
    DeviceLabel.Parent = qx

    local pcBtn = Instance.new("TextButton")
    pcBtn.Size = UDim2.new(1, 0, 0, Q and 44 or 38)
    pcBtn.Position = UDim2.new(0, 0, 0, deviceSecY + 22)
    pcBtn.BackgroundColor3 = Color3.fromRGB(20, 80, 160)
    pcBtn.Text = "💻 UBAH LOGO KE PC"
    pcBtn.TextColor3 = Color3.new(1, 1, 1)
    pcBtn.Font = Enum.Font.GothamBold
    pcBtn.TextSize = w + 1
    pcBtn.Parent = qx
    Instance.new("UICorner", pcBtn).CornerRadius = UDim.new(0, 9)

    local pcBtnGrad = Instance.new("UIGradient", pcBtn)
    pcBtnGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 120, 220)), 
        ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 60, 140))
    })

    local pcStatus = Instance.new("TextLabel")
    pcStatus.Size = UDim2.new(1, 0, 0, 16)
    pcStatus.Position = UDim2.new(0, 0, 0, deviceSecY + 22 + (Q and 48 or 42))
    pcStatus.BackgroundTransparency = 1
    pcStatus.Text = ""
    pcStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
    pcStatus.Font = Enum.Font.GothamBold
    pcStatus.TextSize = 10
    pcStatus.TextXAlignment = Enum.TextXAlignment.Left
    pcStatus.Parent = qx

    -- FUNGSI GANTI LOGO PC (VERSI FIX - TIDAK MERUBAH STREAK)
    pcBtn.MouseButton1Click:Connect(function()
        playClickSound()
        local char = v.Character
        if not char or not char:FindFirstChild("Head") then
            pcStatus.Text = "❌ Karakter tidak ditemukan!"
            return
        end

        local changed = false
        -- Ini ID Logo PC yang kamu kasih
        local PC_ID = "rbxassetid://12684119225" 
        
        -- Cek semua UI (BillboardGui) di atas kepala karakter
        for _, item in pairs(char.Head:GetDescendants()) do
            -- [ BARIS PERBAIKAN DI SINI ]
            -- Pastikan gambar yang kita temukan BUKAN bagian dari StreakBillboard
            if item:IsA("ImageLabel") and not item:IsDescendantOf(char.Head:FindFirstChild("StreakBillboard")) then
                
                -- Targetkan ImageLabel yang ukurannya sekecil icon device
                -- dan pastikan bukan gambar kosong
                if item.Image ~= "" and item.Image ~= PC_ID then
                    -- Biasanya nama UI device mengandung kata 'Device', 'Platform', 'Icon'
                    if item.Name:lower():find("device") or item.Name:lower():find("platform") then
                        item.Image = PC_ID
                        changed = true
                    -- Jika namanya diacak/enkripsi, kita hajar berdasarkan ukuran logonya (biasanya 20x20 s.d 40x40)
                    elseif item.AbsoluteSize.X > 10 and item.AbsoluteSize.X < 50 and item.AbsoluteSize.X == item.AbsoluteSize.Y then
                        item.Image = PC_ID
                        changed = true
                    end
                end
            end
        end

        if changed then
            pcStatus.Text = "✅ Logo PC diterapkan!"
        else
            pcStatus.Text = "❌ Gagal mendeteksi logo HP (atau sudah PC)"
        end
    end)


    -- Update posisi FakeNote supaya letaknya bergeser ke bawah (tidak menabrak tombol PC)
    noteY = deviceSecY + (Q and 90 or 80)
    
    FakeNote = Instance.new("TextLabel")
    FakeNote.Size = UDim2.new(1, 0, 0, 40)
    FakeNote.Position = UDim2.new(0, 0, 0, noteY)
    FakeNote.BackgroundTransparency = 1
    FakeNote.Text = "⚠️  Fake visual only. Rejoin jika tidak berhasil. \nMerah 1-24 | Hijau 25-49 | Biru 50-99 | Ungu 100+\nFake Streak harus punya streak minimal 1\nFake Rank masih butuh Palette Warna, jadi Belum Ada"
    FakeNote.TextColor3 = Color3.fromRGB(120, 115, 150)
    FakeNote.Font = Enum.Font.Gotham
    FakeNote.TextSize = 10
    FakeNote.TextWrapped = true
    FakeNote.TextXAlignment = Enum.TextXAlignment.Left
    FakeNote.Parent = qx
    -- ======== [ SELESAI TAMBAHAN ] ========


    UtilPad = Instance.new("UIPadding", Nx)
    UtilPad.PaddingLeft = UDim.new(0, 6)
    UtilPad.PaddingRight = UDim.new(0, 6)
    UtilPad.PaddingTop = UDim.new(0, 8)
    UtilPad.PaddingBottom = UDim.new(0, 16)

    function createUtilBtn(J, q, N)
        local W = Instance.new("TextButton")
        W.Size = UDim2.new(1, 0, 0, Q and 42 or 38)
        W.LayoutOrder = N
        W.BackgroundColor3 = Color3.fromRGB(18, 16, 26)
        W.Text = J
        W.TextColor3 = Color3.fromRGB(200, 190, 220)
        W.Font = Enum.Font.GothamBold
        W.TextSize = w
        W.Parent = Nx
        Instance.new("UICorner", W).CornerRadius = UDim.new(0, 9)

        local v = Instance.new("UIStroke", W)
        v.Color = Color3.fromRGB(70, 35, 130)
        v.Thickness = 1
        v.Transparency = .4
        W.MouseButton1Click:Connect(function()
            playClickSound()
            q()
        end)
        return W
    end

    local MX = {}
    local mX = ""
    local TX = 0
    local zX = {"abadi", "abai", "abang", "abdi", "abu", "acara", "ada", "adab", "adang", "adat", "adik", "adil", "adu", "agama", "agar", "agen", "agung", "ahad", "ahli", "aib", "air", "ajak", "ajar", "aju", "akad", "akal", "akan", "akar", "akhir", "akhlak", "akibat", "akta", "aktif", "aku", "akun", "akurat", "alam", "alami", "alang", "alasan", "alat", "album", "alfa", "algojo", "ali", "alias", "alih", "alim", "alir", "aliran", "alis", "alkali", "alkitab", "alkohol", "allah", "alpa", "alu", "alun", "alur", "aluran", "amal", "aman", "baca", "badan", "bagaimana", "baik", "banyak", "baru", "bawa", "bawah", "bebas", "belum", "benar", "bentuk", "besar", "biasa", "bisa", "bukan", "bulan", "bumi", "burung", "cahaya", "cinta", "coba", "dalam", "dan", "dapat", "dari", "datang", "dekat", "dengan", "depan", "di", "dia", "diri", "dua", "dulu", "dunia", "uhuk", "uhuy", "bca", "yanto", "ilang", "oho", "aiba", "eni", "ungik", "aqua", "aikido"}

    function simulateTyping(J, q)
        if not e then return end
        TX = q or #J
        if Sx then
            local q = math.random(1, 2)
            local N = 0
            if N < q and math.random() < .3 then
                N = N + 1
                task.wait(math.random() * .8 + .3)
            end
            local v = 1
            while v <= #J do
                if not e then return end
                if N < q and (v > 1 and math.random() < .12) then
                    N = N + 1
                    task.wait(math.random() * .6 + .2)
                end
                if N < q and math.random() < .08 then
                    N = N + 1
                    local J = "qwertyuiopasdfghjklzxcvbnm"
                    local q = math.random(1, 2)
                    for q = 1, q, 1 do
                        local N = math.random(1, #J)
                        local v = string.upper(string.sub(J, N, N))
                        local p = Enum.KeyCode[v]
                        if p then
                            W:SendKeyEvent(true, p, false, game)
                            task.wait(.01)
                            W:SendKeyEvent(false, p, false, game)
                            task.wait(lx + math.random() * (yx - lx))
                        end
                    end
                    task.wait(.1 + math.random() * .2)
                    for J = 1, q, 1 do
                        W:SendKeyEvent(true, Enum.KeyCode.Backspace, false, game)
                        task.wait(.03)
                        W:SendKeyEvent(false, Enum.KeyCode.Backspace, false, game)
                        task.wait(.04)
                    end
                end
                if N < q and math.random() < .1 then
                    N = N + 1
                    local J = "qwertyuiopasdfghjklzxcvbnm"
                    local q = math.random(1, #J)
                    local v = string.upper(string.sub(J, q, q))
                    local p = Enum.KeyCode[v]
                    if p then
                        W:SendKeyEvent(true, p, false, game)
                        task.wait(.01)
                        W:SendKeyEvent(false, p, false, game)
                        task.wait(lx + math.random() * (yx - lx))
                        task.wait(.08 + math.random() * .15)
                        W:SendKeyEvent(true, Enum.KeyCode.Backspace, false, game)
                        task.wait(.03)
                        W:SendKeyEvent(false, Enum.KeyCode.Backspace, false, game)
                        task.wait(.05 + math.random() * .1)
                    end
                end
                local p = string.upper(string.sub(J, v, v))
                local Z = Enum.KeyCode[p]
                if Z then
                    W:SendKeyEvent(true, Z, false, game)
                    task.wait(.01)
                    W:SendKeyEvent(false, Z, false, game)
                    task.wait(lx + math.random() * (yx - lx))
                end
                v = v + 1
            end
            if N < q and math.random() < .15 then
                N = N + 1
                local J = QX[math.random(1, #QX)]
                task.wait(.2 + math.random() * .3)
                for q = 1, #J, 1 do
                    local N = string.upper(string.sub(J, q, q))
                    local v = Enum.KeyCode[N]
                    if v then
                        W:SendKeyEvent(true, v, false, game)
                        task.wait(.01)
                        W:SendKeyEvent(false, v, false, game)
                        task.wait(lx * .7 + (math.random() * yx) * .5)
                    end
                end
                task.wait(.15 + math.random() * .2)
                for J = 1, #J, 1 do
                    W:SendKeyEvent(true, Enum.KeyCode.Backspace, false, game)
                    task.wait(.03)
                    W:SendKeyEvent(false, Enum.KeyCode.Backspace, false, game)
                    task.wait(.03)
                end
                task.wait(.1 + math.random() * .15)
            end
        else
            for q = 1, #J, 1 do
                local N = string.upper(string.sub(J, q, q))
                local v = Enum.KeyCode[N]
                if v then
                    W:SendKeyEvent(true, v, false, game)
                    task.wait(.01)
                    W:SendKeyEvent(false, v, false, game)
                    task.wait(lx + math.random() * (yx - lx))
                end
            end
        end
        task.wait(rx + math.random() * (sx - rx))
        W:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
        W:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
    end

    local LX = false
    local bX = false

    gX = function()
        if not ox or not e or LX then return end
        LX = true
        if tx and NX then
            local J = v:WaitForChild("PlayerGui")
            local q = J:FindFirstChild("MatchUI", true)
            local N = ""
            if q then
                for J, q in pairs(q:GetDescendants()) do
                    if (q.Name == "WordServer" or q.Name == "Word") and (q:IsA("TextLabel") and q.Visible) then
                        local J = (q.Text:gsub("%s+", "")):lower()
                        if #J >= 1 and #J <= 4 then N = J end
                    end
                end
            end
            if N ~= "" then
                ax.Text = "👾 SPAM " .. (WX + 1 .. "/2")
                for J = 1, #N, 1 do
                    local q = string.upper(string.sub(N, J, J))
                    local v = Enum.KeyCode[q]
                    if v then
                        W:SendKeyEvent(true, v, false, game)
                        task.wait(.01)
                        W:SendKeyEvent(false, v, false, game)
                        task.wait(.01)
                    end
                end
                local J = {"A", "Q", "X", "Z", "J", "V"}
                for q = 1, 2, 1 do
                    local N = J[math.random(1, #J)]
                    local v = Enum.KeyCode[N]
                    if v then
                        W:SendKeyEvent(true, v, false, game)
                        task.wait(.01)
                        W:SendKeyEvent(false, v, false, game)
                        task.wait(.01)
                    end
                end
                task.wait(rx + math.random() * (sx - rx))
                W:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                W:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
            end
            WX = WX + 1
            if WX >= 2 then
                NX = false
                WX = 0
                qX = 0
                tuyulStatus.Text = "Siap: 0/" .. (JX .. " jawab benar")
                tuyulStatus.TextColor3 = Color3.fromRGB(180, 80, 255)
                ax.Text = "-"
            else
                tuyulStatus.Text = "SPAM GILIRAN " .. (WX .. "/2...")
                tuyulStatus.TextColor3 = Color3.fromRGB(255, 80, 80)
            end
            LX = false
            return
        end

        local J = v:WaitForChild("PlayerGui")
        local q = J:FindFirstChild("MatchUI", true)
        local N = ""
        if q then
            for J, q in pairs(q:GetDescendants()) do
                if (q.Name == "WordServer" or q.Name == "Word") and (q:IsA("TextLabel") and q.Visible) then
                    local J = (q.Text:gsub("%s+", "")):lower()
                    if #J >= 1 and #J <= 4 then N = J end
                end
            end
        end

        if N ~= "" then
            Rx.Text = "AWALAN: " .. N:upper()
            local J = {}
            local q = {}
            for J, W in pairs(kX) do
                if W then
                    for J, W in ipairs(VX[J]) do
                        if string.sub(W, 1, #N) == N and (not MX[W] and #W > #N) then
                            table.insert(q, W)
                        end
                    end
                end
            end
            if #q > 0 then J = q end
            if #J == 0 then
                for q, W in ipairs(zX) do
                    if string.sub(W, 1, #N) == N and (not MX[W] and #W > #N) then
                        table.insert(J, W)
                    end
                end
            end
            if #J > 0 then
                local q = J[math.random(1, #J)]
                local W = "KBBI (SEMUA)"
                for J, N in pairs(kX) do
                    if N and table.find(VX[J], q) then
                        W = "KATA SULIT (" .. (J .. ")")
                        break
                    end
                end
                print("🤔 RAFLYXCILLO: " .. (q:upper() .. (" | Awalan: " .. (N:upper() .. (" | " .. W)))))
                ax.Text = q:upper()
                mX = q
                simulateTyping(string.sub(q, #N + 1), #q)
                MX[q] = true
                if tx and not NX then
                    qX = qX + 1
                    tuyulStatus.Text = "Jawab benar: " .. (qX .. ("/" .. (JX .. (" → " .. (JX - qX .. "x lagi")))))
                    tuyulStatus.TextColor3 = Color3.fromRGB(180, 80, 255)
                    if qX >= JX then
                        NX = true
                        WX = 0
                        tuyulStatus.Text = "SPAM MODE AKTIF!"
                        tuyulStatus.TextColor3 = Color3.fromRGB(255, 80, 80)
                        ax.Text = "👾 SPAM MODE"
                    end
                end
                task.wait(1)
                Rx.Text = "AWALAN: -"
                ax.Text = "-"
            end
        end
        task.wait(.5)
        LX = false
    end

    task.spawn(function()
        local J = {
            IF = "https://raw.githubusercontent.com/DexterHUB99/DexterHUB/refs/heads/main/IF.txt",
            X = "https://raw.githubusercontent.com/DexterHUB99/DexterHUB/refs/heads/main/X.txt",
            NG = "https://raw.githubusercontent.com/DexterHUB99/DexterHUB/refs/heads/main/NG.txt",
            AI = "https://raw.githubusercontent.com/DexterHUB99/DexterHUB/refs/heads/main/AI.txt",
            ["SEMUA KATA SULIT"] = "https://raw.githubusercontent.com/DexterHUB99/DexterHUB/refs/heads/main/sulit.txt",
            CY = "https://raw.githubusercontent.com/DexterHUB99/DexterHUB/refs/heads/main/CY.txt",
            UI = "https://raw.githubusercontent.com/DexterHUB99/DexterHUB/refs/heads/main/UI.txt",
            KS = "https://raw.githubusercontent.com/DexterHUB99/DexterHUB/refs/heads/main/KS.txt",
            LY = "https://raw.githubusercontent.com/DexterHUB99/DexterHUB/refs/heads/main/ly.txt",
            GY = "https://raw.githubusercontent.com/DexterHUB99/DexterHUB/refs/heads/main/gy.txt",
            LT = "https://raw.githubusercontent.com/DexterHUB99/DexterHUB/refs/heads/main/lt.txt",
            EO = "https://raw.githubusercontent.com/DexterHUB99/DexterHUB/refs/heads/main/eo.txt",
            OE = "https://raw.githubusercontent.com/DexterHUB99/DexterHUB/refs/heads/main/oe.txt",
            EKS = "https://raw.githubusercontent.com/DexterHUB99/DexterHUB/refs/heads/main/eo.txt",
            OO = "https://raw.githubusercontent.com/DexterHUB99/DexterHUB/refs/heads/main/oo.txt",
            KN = "https://raw.githubusercontent.com/DexterHUB99/DexterHUB/refs/heads/main/kn.txt",
            Q = "https://raw.githubusercontent.com/DexterHUB99/DexterHUB/refs/heads/main/q.txt",
            MP = "https://raw.githubusercontent.com/DexterHUB99/DexterHUB/refs/heads/main/mp.txt",
            SF = "https://raw.githubusercontent.com/DexterHUB99/DexterHUB/refs/heads/main/sf.txt",
            TT = "https://raw.githubusercontent.com/DexterHUB99/DexterHUB/refs/heads/main/tt.txt"
        }
        
        for categoryName, url in pairs(J) do
            local success = false
            local attempts = 0
            local maxAttempts = 3 -- Script akan mencoba ulang sampai 3x kalau gagal
            
            while not success and attempts < maxAttempts do
                attempts = attempts + 1
                local N, W = pcall(function() return game:HttpGet(url) end)
                
                -- Pastikan W beneran string dan nggak kosong
                if N and type(W) == "string" and #W > 0 then
                    success = true
                    for word in string.gmatch(W, "[^\r\n]+") do
                        local cleanWord = (word:gsub("%s+", "")):lower()
                        if #cleanWord > 1 and string.match(cleanWord, "^%a+$") then
                            table.insert(VX[categoryName], cleanWord)
                        end
                    end
                    print("🔥 Category " .. categoryName .. " Loaded!")
                else
                    if attempts < maxAttempts then
                        print("⚠️ Gagal load " .. categoryName .. ", mencoba lagi... (" .. attempts .. "/" .. maxAttempts .. ")")
                        task.wait(0.5) -- Tunggu setengah detik sebelum coba lagi
                    else
                        print("❌ Gagal total load category: " .. categoryName)
                    end
                end
            end
            task.wait(0.2) -- Jeda aman antar file dinaikkan sedikit biar gak kena limit
        end
    end)

    function shuffleTable(J)
        for q = #J, 2, -1 do
            local N = math.random(q)
            J[q], J[N] = J[N], J[q]
        end
    end

    task.spawn(function()
        -- Beri jeda 2 detik di awal agar tidak tabrakan dengan loading file kategori
        task.wait(2) 
        
        local kamusUrl = "https://raw.githubusercontent.com/DexterHUB99/Cari-Kata/refs/heads/main/kamus.txt",
        "https://cdn.jsdelivr.net/gh/geovedi/indonesian-wordlist@master/00-indonesian-wordlist.lst",
        "https://raw.githubusercontent.com/geovedi/indonesian-wordlist/master/00-indonesian-wordlist.lst"
        local tempWords = {}
        
        local success = false
        local attempts = 0
        local maxAttempts = 3
        
        while not success and attempts < maxAttempts do
            if not e then break end
            attempts = attempts + 1
            
            local ok, result = pcall(function() return game:HttpGet(kamusUrl) end)
            
            -- Pastikan request sukses dan ukurannya besar (karena ini kamus)
            if ok and type(result) == "string" and #result > 1000 then
                success = true
                for word in string.gmatch(result, "[^\r\n]+") do
                    local cleanWord = (word:gsub("%s+", "")):lower()
                    if #cleanWord > 1 and string.match(cleanWord, "^%a+$") then
                        table.insert(tempWords, cleanWord)
                    end
                end
            else
                print("⚠️ Gagal load kamus.txt, mencoba lagi... (" .. attempts .. "/" .. maxAttempts .. ")")
                task.wait(1.5) -- Jeda agak lama sebelum coba download ulang
            end
        end
        
        if success and #tempWords > 1000 then
            for _, w in ipairs(tempWords) do
                table.insert(zX, w)
            end
            shuffleTable(zX)
            print("✅ RAFLYXCILLO: " .. (#zX .. " Kata Kamus Dimuat Sukses!"))
        else
            print("❌ Gagal total meload kamus.txt setelah " .. maxAttempts .. " percobaan.")
        end
    end)

    function dismissEndScreen()
        pcall(function()
            local J = workspace.CurrentCamera.ViewportSize
            W:SendMouseButtonEvent(J.X / 2, J.Y / 2, 0, true, game, 0)
            task.wait(.05)
            W:SendMouseButtonEvent(J.X / 2, J.Y / 2, 0, false, game, 0)
        end)
    end

    function startInstantRejoin()
        if not dx or bX then return end
        bX = true
        task.wait(1)
        dismissEndScreen()
        task.spawn(function()
            local J = v:WaitForChild("PlayerGui")
            while bX and e do
                if not dx then
                    bX = false
                    break
                end
                
                local q = J:FindFirstChild("MatchUI", true)
                
                -- Pengecekan ekstra: Pastikan player ada di meja
                local isPlaying = v:GetAttribute("CurrentTable") ~= nil
                
                if q and q.Enabled == true and isPlaying then
                    bX = false
                    if ox then
                        task.wait(1.5)
                        gX()
                    end
                    break
                end
                
                pcall(function()
                    W:SendKeyEvent(true, Enum.KeyCode.E, false, game)
                    task.wait(.02)
                    W:SendKeyEvent(false, Enum.KeyCode.E, false, game)
                end)
                task.wait(.15)
            end
        end)
    end

    function findBlatantWord(J)
        if J == "" then return "" end
        local q = {}
        local N = {}
        for q, W in pairs(kX) do
            if W then
                for q, W in ipairs(VX[q]) do
                    if string.sub(W, 1, #J) == J and (not MX[W] and #W > #J) then
                        table.insert(N, W)
                    end
                end
            end
        end
        if #N > 0 then q = N end
        if #q == 0 then
            for N, W in ipairs(zX) do
                if string.sub(W, 1, #J) == J and (not MX[W] and #W > #J) then
                    table.insert(q, W)
                end
            end
        end
        if #q > 0 then return q[math.random(1, #q)] end
        return ""
    end

    local cX = Instance.new("TextButton")
    cX.Size = UDim2.new(1, -4, 0, Q and 38 or 34)
    cX.LayoutOrder = 35
    cX.BackgroundColor3 = Color3.fromRGB(120, 20, 20)
    cX.BorderSizePixel = 0
    cX.Text = "💀 SUBMIT BLATANT"
    cX.TextColor3 = Color3.fromRGB(255, 255, 255)
    cX.Font = Enum.Font.GothamBold
    cX.TextSize = Q and 12 or 13
    cX.Visible = false
    cX.Parent = Jx
    Instance.new("UICorner", cX).CornerRadius = UDim.new(0, 8)

    local KX = Instance.new("UIStroke", cX)
    KX.Color = Color3.fromRGB(255, 60, 60)
    KX.Thickness = 1.5
    cX.MouseButton1Click:Connect(function()
        if not pX or not e then return end
        if ZX == "" then
            ax.Text = "💀 Kata belum siap!"
            return
        end
        local J = ZX
        local q = eX
        local N = (J:lower()):sub(#q + 1)
        ZX = ""
        eX = ""
        cX.Visible = false
        cX.Text = "💀 SUBMIT BLATANT"
        cX.BackgroundColor3 = Color3.fromRGB(120, 20, 20)
        MX[J] = true
        ax.Text = "💀 " .. J:upper()
        print("💀 Blatant submit: " .. (J:upper() .. (" | awalan: " .. (q:upper() .. (" | suffix: " .. N)))))
        pcall(function()
            game:GetService("ReplicatedStorage").Remotes.SubmitWord:FireServer(N)
        end)
    end)

    -- Membajak jalur pengiriman data ke server & Bypass Anti-Cheat (Hook Enter)
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        
        if not checkcaller() and method == "FireServer" then
            -- [1] ANTI-CHEAT BYPASS
            for _, arg in pairs(args) do
                if type(arg) == "string" then
                    local argLower = string.lower(arg)
                    if string.find(argLower, "kick") or string.find(argLower, "namecallinstance") then
                        return 
                    end
                end
            end

            -- [2] INTERCEPT BLATANT MODE (Submit otomatis pas tekan Enter)
            if self.Name == "SubmitWord" then
                if pX and e and ZX ~= "" then
                    local W = ZX
                    local v = eX
                    local p = (W:lower()):sub(#v + 1)
                    
                    ZX = ""
                    eX = ""
                    MX[W] = true
                    
                    task.spawn(function()
                        if ax then ax.Text = "💀 " .. W:upper() end
                        if cX then
                            cX.Visible = false
                            cX.Text = "💀 SUBMIT BLATANT"
                            cX.BackgroundColor3 = Color3.fromRGB(120, 20, 20)
                        end
                        print("💀 Blatant Hook Sukses: " .. W:upper() .. " | suffix: " .. p)
                    end)
                    
                    return oldNamecall(self, p)
                end
            end
        end
        return oldNamecall(self, ...)
    end)

    task.spawn(function()
        local J = 0
        while task.wait(.1) do
            if not e then cX.Visible = false end
            if pX and (e and ZX ~= "") then
                cX.Visible = true
                J = J + .1
                local q = math.abs(math.sin(J * 3))
                cX.BackgroundColor3 = Color3.fromRGB(math.floor(100 + q * 80), math.floor(10 + q * 10), math.floor(10 + q * 10))
                cX.Text = "💀 TAP → " .. ZX:upper()
            else
                cX.Visible = false
                J = 0
            end
        end
    end)

    local FX = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("MatchUI")
    function botForceClear()
        local J = TX + 1
        for J = 1, J, 1 do
            W:SendKeyEvent(true, Enum.KeyCode.Backspace, false, game)
            task.wait(Dx + math.random() * (hx - Dx))
            W:SendKeyEvent(false, Enum.KeyCode.Backspace, false, game)
        end
        TX = 0
        task.wait(.1)
    end

    FX.OnClientEvent:Connect(function(J)
        if not e then return end
        if J == "StartTurn" or J == "YourTurn" then
            bX = false
            if pX then
                task.spawn(function()
                    task.wait(.6)
                    local J = ""
                    pcall(function()
                        local q = v:WaitForChild("PlayerGui")
                        local N = q:WaitForChild("MatchUI")
                        local W = N.BottomUI.TopUI.WordServerFrame.WordServer
                        J = (W.Text:lower()):gsub("[^a-z]", "")
                    end)
                    if J == "" then
                        local q = (Rx.Text:lower()):match("awalan:%s*([a-z]+)")
                        if q then J = q end
                    end
                    if J ~= "" then
                        local q = findBlatantWord(J)
                        if q ~= "" then
                            eX = J
                            ZX = q
                            Rx.Text = "AWALAN: " .. (J:upper() .. " [BLATANT SIAP]")
                            ax.Text = "💀 " .. (q:upper() .. " (ready)")
                            print("💀 Blatant ready: " .. (q:upper() .. (" | awalan: " .. J:upper())))
                        else
                            ax.Text = "💀 Blatant: Kata tidak ditemukan"
                        end
                    else
                        ax.Text = "💀 Blatant: Awalan tidak terdeteksi"
                    end
                end)
            end
            if not LX and not pX then
                task.wait(Cx + math.random() * (Hx - Cx))
                gX()
            end
        elseif J == "Eliminated" or J == "EndMatch" or J == "HideMatchUI" then
            NX = false
            WX = 0
            qX = 0
            if tx then
                tuyulStatus.Text = "Siap: 0/" .. (JX .. " jawab benar")
                tuyulStatus.TextColor3 = Color3.fromRGB(180, 80, 255)
            end
            Rx.Text = "AWALAN: -"
            ax.Text = "-"
            startInstantRejoin()
                elseif J == "Mistake" then
            -- CEK GILIRAN: Pastikan ini beneran giliran KITA yang salah, bukan musuh!
            local isMyTurn = false
            pcall(function()
                local gui = v:WaitForChild("PlayerGui"):FindFirstChild("MatchUI", true)
                if gui then
                    local submitBtn = gui:FindFirstChild("WordSubmit", true)
                    if submitBtn and submitBtn.Visible and submitBtn.BackgroundTransparency < 0.6 then
                        isMyTurn = true
                    end
                end
            end)

            -- Kalau musuh yang salah, cuekin aja!
            if not isMyTurn then return end

            -- BAGIAN BLATANT MODE
            if pX then
                task.spawn(function()
                    if ZX ~= "" then MX[ZX] = true end
                    task.wait(0.3) -- Jeda biar UI ngereset dulu sebelum di-scan
                    
                    local awalanBaru = ""
                    pcall(function()
                        local matchUI = v:WaitForChild("PlayerGui"):FindFirstChild("MatchUI", true)
                        if matchUI then
                            for _, elemen in pairs(matchUI:GetDescendants()) do
                                if (elemen.Name == "WordServer" or elemen.Name == "Word") and (elemen:IsA("TextLabel") and elemen.Visible) then
                                    local textBersih = (elemen.Text:gsub("%s+", "")):lower()
                                    if #textBersih >= 1 and #textBersih <= 4 then 
                                        awalanBaru = textBersih 
                                    end
                                end
                            end
                        end
                    end)

                    -- Backup kalau text gagal dibaca
                    if awalanBaru == "" then awalanBaru = eX else eX = awalanBaru end

                    local kataBaru = findBlatantWord(awalanBaru)
                    if kataBaru ~= "" then
                        ZX = kataBaru
                        if ax then ax.Text = "💀 RETRY: " .. kataBaru:upper() end
                        if cX then
                            cX.Visible = true
                            cX.Text = "💀 TAP → " .. kataBaru:upper()
                        end
                        print("💀 Blatant retry: " .. (kataBaru:upper() .. " | awalan: " .. awalanBaru:upper()))
                    else
                        ZX = ""
                        if cX then cX.Visible = false end
                        if ax then ax.Text = "💀 Blatant: Habis kata!" end
                    end
                end)
            end

            -- BAGIAN AUTO TULIS (Hanya jalan kalau Auto Tulis nyala)
            if ox then
                if tx and NX then
                    print("[Tuyul] Sengaja salah ke-" .. (WX .. ("/" .. vX)))
                else
                    if mX ~= "" then MX[mX] = true end
                    print("⚠️ RAFLYXCILLO: Salah! Menghapus & Cari Baru...")
                    LX = true
                    botForceClear()
                    LX = false
                    gX()
                end
            end
        end
    end)

    local RX = ""
    function applyFakeName(J)
        local q = v.Character
        if q and q:FindFirstChild("Humanoid") then
            q.Humanoid.DisplayName = J
            for q, N in pairs(q:GetDescendants()) do
                if N:IsA("TextLabel") and (N.Text == v.Name or N.Text == v.DisplayName or N.Text == RX) then
                    N.Text = J
                end
            end
            RX = J
            print("🎭 Fake Name '" .. (J .. "' diterapkan!"))
        end
    end

    iX.MouseButton1Click:Connect(function()
        applyFakeName(fX.Text)
        playClickSound()
    end)

    fX.FocusLost:Connect(function(J)
        if J then
            playClickSound()
            applyFakeName(fX.Text)
        end
    end)

    local aX = {
        {min = 1, max = 24, image = "rbxassetid://124831674833103"},
        {min = 25, max = 49, image = "rbxassetid://117598829066059"},
        {min = 50, max = 99, image = "rbxassetid://129825881918699"},
        {min = 100, max = 999999, image = "rbxassetid://135836679344581"}
    }

    function getStreakAsset(J)
        for q, N in pairs(aX) do
            if J >= N.min and J <= N.max then return N.image end
        end
        return aX[1].image
    end

    function applyFakeStreak(J)
        J = J:gsub("%s+", "")
        if J == "" then
            IX.Text = "❌ Input kosong!"
            return
        end
        if not J:match("^%d+$") then
            IX.Text = "❌ Angka saja!"
            return
        end
        local q = tonumber(J)
        local N = v.Character
        if not N then
            IX.Text = "❌ Karakter tidak ditemukan!"
            return
        end
        local W, p = pcall(function() return N.Head.StreakBillboard.FireBG end)
        if not W or not p then
            IX.Text = "❌ StreakBillboard tidak ada!"
            return
        end
        local Z = p:FindFirstChild("StreakNumber")
        if Z then Z.Text = J end
        p.Image = getStreakAsset(q)
        IX.Text = "✅ Streak " .. (J .. " diterapkan!")
        print("🔥 Fake Streak '" .. (J .. ("' | asset: " .. getStreakAsset(q))))
    end

    xX.MouseButton1Click:Connect(function()
        playClickSound()
        applyFakeStreak(EX.Text)
    end)

    EX.FocusLost:Connect(function(J)
        if J then
            playClickSound()
            applyFakeStreak(EX.Text)
        end
    end)

    local oX, dX
    local lX = Instance.new("TextButton")
    lX.Size = UDim2.new(1, -(L * 2 + 30), 1, 0)
    lX.BackgroundTransparency = 1
    lX.Text = ""
    lX.ZIndex = 5
    lX.Parent = T

    local yX, rX
    lX.InputBegan:Connect(function(J)
        if not isTouchOrMouse(J) then return end
        yX = J.Position
        rX = i.Position
        J.Changed:Connect(function()
            if J.UserInputState == Enum.UserInputState.End then
                yX = nil
            end
        end)
    end)

    N.InputChanged:Connect(function(J)
        if not isMoveTouchOrMouse(J) then return end
        if x then
            local q = J.Position - I
            local N, W = clampWindow(M + q.X, m + q.Y)
            i.Size = UDim2.new(0, N, 0, W)
            syncGlowWrapper()
            return
        end
        if yX then
            local q = J.Position - yX
            local N = UDim2.new(rX.X.Scale, rX.X.Offset + q.X, rX.Y.Scale, rX.Y.Offset + q.Y)
            i.Position = N
            f.Position = UDim2.new(N.X.Scale, N.X.Offset - 2, N.Y.Scale, N.Y.Offset - 2)
            syncResizeHandle()
            return
        end
        if C then
            local q = J.Position - H
            h = q.Magnitude
            s.Position = UDim2.new(S.X.Scale, S.X.Offset + q.X, S.Y.Scale, S.Y.Offset + q.Y)
        end
    end)

    N.InputEnded:Connect(function(J)
        if isTouchOrMouse(J) then
            x = false
        end
    end)

    local sX = false
    local DX

    function toggleNoclip(J)
        sX = J
        if sX then
            DX = game:GetService("RunService").Stepped:Connect(function()
                if v.Character then
                    for J, q in pairs(v.Character:GetDescendants()) do
                        if q:IsA("BasePart") then
                            q.CanCollide = false
                        end
                    end
                end
            end)
        else
            if DX then DX:Disconnect() end
        end
    end

    local hX = false
    local CX = {"admin", "owner", "developer", "pengembang", "staff", "seniorstaff", "juniorstaff", "moderator", "mod", "helper", "builder", "operator", "manager"}

    function isAdminName(J)
        local q = (J:lower()):gsub("[^%a%d]", "")
        for J, N in pairs(CX) do
            if q:find(N, 1, true) then return true, N end
        end
        return false
    end

    function antiAdminCheck()
        for J, q in pairs(game.Players:GetPlayers()) do
            if q ~= v then
                local J, N = isAdminName(q.Name)
                if not J then J, N = isAdminName(q.DisplayName) end
                if J then
                    print("🛡️ ADMIN DETECTED: " .. (q.Name .. (" [" .. (N .. "] — Pindah server!"))))
                    Rx.Text = "⚠️ ADMIN: " .. q.Name
                    ax.Text = "Pindah server..."
                    task.wait(.5)
                    game:GetService("TeleportService"):Teleport(game.PlaceId, v)
                    return
                end
            end
        end
    end

    game.Players.PlayerAdded:Connect(function(J)
        if not hX then return end
        task.wait(1)
        antiAdminCheck()
    end)

    task.spawn(function()
        while task.wait(5) do
            if not e then break end
            if hX then antiAdminCheck() end
        end
    end)

    local HX = Instance.new("TextButton")
    HX.Size = UDim2.new(1, 0, 0, Q and 42 or 38)
    HX.LayoutOrder = 0
    HX.BackgroundColor3 = Color3.fromRGB(25, 22, 38)
    HX.Text = "🎨  TEMA: CYBERPUNK 🔻"
    HX.TextColor3 = Color3.new(1, 1, 1)
    HX.Font = Enum.Font.GothamBold
    HX.TextSize = w
    HX.Parent = Nx
    Instance.new("UICorner", HX).CornerRadius = UDim.new(0, 9)

    themeBtnStroke = Instance.new("UIStroke", HX)
    themeBtnStroke.Color = Color3.fromRGB(150, 80, 255)
    themeBtnStroke.Thickness = 1.5
    themeBtnStroke.Transparency = .2

    local SX = Instance.new("Frame")
    SX.Size = UDim2.new(1, 0, 0, 0)
    SX.BackgroundColor3 = Color3.fromRGB(14, 13, 22)
    SX.ClipsDescendants = true
    SX.BorderSizePixel = 0
    SX.LayoutOrder = 1
    SX.Parent = Nx
    Instance.new("UICorner", SX).CornerRadius = UDim.new(0, 9)

    themeDFStroke = Instance.new("UIStroke", SX)
    themeDFStroke.Color = Color3.fromRGB(70, 35, 130)
    themeDFStroke.Thickness = 1
    themeDFStroke.Transparency = .4

    local tX = {
        CYBERPUNK = Color3.fromRGB(150, 80, 255),
        CRIMSON = Color3.fromRGB(255, 80, 100),
        MATRIX = Color3.fromRGB(50, 255, 120),
        SAKURA = Color3.fromRGB(255, 130, 200),
        OCEAN = Color3.fromRGB(60, 160, 255),
        FLAME = Color3.fromRGB(255, 160, 50)
    }

    local Jh = {"CYBERPUNK", "CRIMSON", "MATRIX", "SAKURA", "OCEAN", "FLAME"}
    local qh = false
    local Nh = Q and 40 or 35

    function refreshThemeDropUI()
        for J, q in pairs(SX:GetChildren()) do
            if q:IsA("Frame") or q:IsA("TextButton") then
                q:Destroy()
            end
        end
        for J, q in ipairs(Jh) do
            local N = Instance.new("Frame")
            N.Size = UDim2.new(1, -12, 0, Q and 34 or 30)
            N.Position = UDim2.new(0, 6, 0, (J - 1) * Nh + 5)
            N.BackgroundColor3 = X == q and Color3.fromRGB(30, 25, 50) or Color3.fromRGB(20, 18, 30)
            N.BorderSizePixel = 0
            N.Parent = SX
            Instance.new("UICorner", N).CornerRadius = UDim.new(0, 7)

            if X == q then
                local J = Instance.new("UIStroke", N)
                J.Color = tX[q]
                J.Thickness = 1
                J.Transparency = .2
            end

            local W = Instance.new("Frame")
            W.Size = UDim2.new(0, 10, 0, 10)
            W.Position = UDim2.new(0, 10, .5, -5)
            W.BackgroundColor3 = tX[q]
            W.BorderSizePixel = 0
            W.Parent = N
            Instance.new("UICorner", W).CornerRadius = UDim.new(1, 0)

            local v = Instance.new("TextLabel")
            v.Size = UDim2.new(1, -50, 1, 0)
            v.Position = UDim2.new(0, 28, 0, 0)
            v.BackgroundTransparency = 1
            v.Text = q .. (X == q and "  ✓" or "")
            v.TextColor3 = X == q and tX[q] or Color3.fromRGB(180, 170, 200)
            v.Font = Enum.Font.GothamBold
            v.TextSize = w
            v.TextXAlignment = Enum.TextXAlignment.Left
            v.Parent = N

            local p = Instance.new("TextButton")
            p.Size = UDim2.new(1, 0, 1, 0)
            p.BackgroundTransparency = 1
            p.Text = ""
            p.Parent = N

            p.MouseButton1Click:Connect(function()
                playClickSound()
                applyTheme(q)
                HX.Text = "🎨  TEMA: " .. (q .. " 🔻")
                themeBtnStroke.Color = tX[q]
                themeDFStroke.Color = tX[q]
                qh = false
                SX:TweenSize(UDim2.new(1, 0, 0, 0), "Out", "Quart", .2, true)
            end)
        end
    end

    HX.MouseButton1Click:Connect(function()
        playClickSound()
        qh = not qh
        HX.Text = "🎨  TEMA: " .. (X .. (qh and " 🔺" or " 🔻"))
        SX:TweenSize(UDim2.new(1, 0, 0, qh and #Jh * Nh + 10 or 0), "Out", "Quart", .3, true)
        if qh then refreshThemeDropUI() end
    end)

    UtilDivider = Instance.new("Frame")
    UtilDivider.Size = UDim2.new(1, 0, 0, 1)
    UtilDivider.BackgroundColor3 = Color3.fromRGB(40, 35, 60)
    UtilDivider.BorderSizePixel = 0
    UtilDivider.LayoutOrder = 2
    UtilDivider.Parent = Nx

    createUtilBtn("💀  RESPAWN", function() v.Character:BreakJoints() end, 3)
    createUtilBtn("🔄  REJOIN SERVER", function() game:GetService("TeleportService"):Teleport(game.PlaceId, v) end, 4)
    createToggle("NOCLIP", Nx, false, function(J) toggleNoclip(J) end, 5)
    createToggle("🛡️ ANTI ADMIN", Nx, false, function(J) hX = J end, 6)

    local Wh = Instance.new("Frame")
    Wh.Size = UDim2.new(1, 0, 0, 0)
    Wh.AutomaticSize = Enum.AutomaticSize.Y
    Wh.LayoutOrder = 7
    Wh.BackgroundColor3 = Color3.fromRGB(14, 12, 22)
    Wh.BorderSizePixel = 0
    Wh.Parent = Nx
    Instance.new("UICorner", Wh).CornerRadius = UDim.new(0, 11)

    tuyulStroke = Instance.new("UIStroke", Wh)
    tuyulStroke.Color = Color3.fromRGB(120, 40, 200)
    tuyulStroke.Thickness = 1.5
    tuyulStroke.Transparency = .2
    Y.tuyulStroke = tuyulStroke

    tuyulPad = Instance.new("UIPadding", Wh)
    tuyulPad.PaddingLeft = UDim.new(0, 10)
    tuyulPad.PaddingRight = UDim.new(0, 10)
    tuyulPad.PaddingTop = UDim.new(0, 10)
    tuyulPad.PaddingBottom = UDim.new(0, 10)

    tuyulLayout = Instance.new("UIListLayout")
    tuyulLayout.Padding = UDim.new(0, 8)
    tuyulLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tuyulLayout.Parent = Wh

    tuyulHeader = Instance.new("TextLabel")
    tuyulHeader.Size = UDim2.new(1, 0, 0, 18)
    tuyulHeader.LayoutOrder = 0
    tuyulHeader.BackgroundTransparency = 1
    tuyulHeader.Text = "👾 MODE TUYUL"
    tuyulHeader.TextColor3 = Color3.fromRGB(180, 80, 255)
    tuyulHeader.Font = Enum.Font.GothamBold
    tuyulHeader.TextSize = 11
    tuyulHeader.TextXAlignment = Enum.TextXAlignment.Left
    tuyulHeader.Parent = Wh
    Y.tuyulHeader = tuyulHeader

    tuyulSubHeader = Instance.new("TextLabel")
    tuyulSubHeader.Size = UDim2.new(1, 0, 0, 14)
    tuyulSubHeader.LayoutOrder = 1
    tuyulSubHeader.BackgroundTransparency = 1
    tuyulSubHeader.Text = "Menjawab benar, jika Tujuan Tercapai akan Menjawab acak"
    tuyulSubHeader.TextColor3 = Color3.fromRGB(120, 100, 160)
    tuyulSubHeader.Font = Enum.Font.Gotham
    tuyulSubHeader.TextSize = 9
    tuyulSubHeader.TextXAlignment = Enum.TextXAlignment.Left
    tuyulSubHeader.Parent = Wh

    tuyulDiv = Instance.new("Frame")
    tuyulDiv.Size = UDim2.new(1, 0, 0, 1)
    tuyulDiv.LayoutOrder = 2
    tuyulDiv.BackgroundColor3 = Color3.fromRGB(60, 30, 100)
    tuyulDiv.BorderSizePixel = 0
    tuyulDiv.Parent = Wh

    local vh = Instance.new("Frame")
    vh.Size = UDim2.new(1, 0, 0, Q and 32 or 30)
    vh.LayoutOrder = 3
    vh.BackgroundTransparency = 1
    vh.Parent = Wh

    tuyulToggleLbl = Instance.new("TextLabel")
    tuyulToggleLbl.Size = UDim2.new(1, -60, 1, 0)
    tuyulToggleLbl.BackgroundTransparency = 1
    tuyulToggleLbl.Text = "AKTIFKAN TUYUL"
    tuyulToggleLbl.TextColor3 = Color3.fromRGB(210, 200, 230)
    tuyulToggleLbl.Font = Enum.Font.GothamBold
    tuyulToggleLbl.TextSize = w
    tuyulToggleLbl.TextXAlignment = Enum.TextXAlignment.Left
    tuyulToggleLbl.Parent = vh

    local ph = Q and 48 or 44
    local Zh = Q and 26 or 22
    tuyulPill = Instance.new("Frame")
    tuyulPill.Size = UDim2.new(0, ph, 0, Zh)
    tuyulPill.Position = UDim2.new(1, -ph, .5, -Zh / 2)
    tuyulPill.BackgroundColor3 = Color3.fromRGB(180, 40, 50)
    tuyulPill.BorderSizePixel = 0
    tuyulPill.Parent = vh
    Instance.new("UICorner", tuyulPill).CornerRadius = UDim.new(1, 0)

    local eh = Q and 20 or 16
    tuyulKnob = Instance.new("Frame")
    tuyulKnob.Size = UDim2.new(0, eh, 0, eh)
    tuyulKnob.Position = UDim2.new(0, 3, .5, -eh / 2)
    tuyulKnob.BackgroundColor3 = Color3.new(1, 1, 1)
    tuyulKnob.BorderSizePixel = 0
    tuyulKnob.Parent = tuyulPill
    Instance.new("UICorner", tuyulKnob).CornerRadius = UDim.new(1, 0)

    tuyulToggleBtn = Instance.new("TextButton")
    tuyulToggleBtn.Size = UDim2.new(1, 0, 1, 0)
    tuyulToggleBtn.BackgroundTransparency = 1
    tuyulToggleBtn.Text = ""
    tuyulToggleBtn.Parent = vh
    tuyulToggleBtn.MouseButton1Click:Connect(function()
        tx = not tx
        qX = 0
        NX = false
        WX = 0
        if tx then
            tuyulStatus.Text = "Siap: 0/" .. (JX .. " jawab benar")
            tuyulStatus.TextColor3 = Color3.fromRGB(180, 80, 255)
        else
            tuyulStatus.Text = "Limit: " .. (JX .. "x jawab benar → mengalah")
            tuyulStatus.TextColor3 = Color3.fromRGB(180, 80, 255)
        end
        tuyulPill.BackgroundColor3 = tx and Color3.fromRGB(30, 180, 110) or Color3.fromRGB(180, 40, 50)
        tuyulKnob.Position = tx and UDim2.new(1, -(eh + 3), .5, -eh / 2) or UDim2.new(0, 3, .5, -eh / 2)
        playClickSound()
    end)

    tuyulInputLabel = Instance.new("TextLabel")
    tuyulInputLabel.Size = UDim2.new(1, 0, 0, 14)
    tuyulInputLabel.LayoutOrder = 4
    tuyulInputLabel.BackgroundTransparency = 1
    tuyulInputLabel.Text = "Jawab benar berapa kali sebelum mengalah?"
    tuyulInputLabel.TextColor3 = Color3.fromRGB(160, 140, 200)
    tuyulInputLabel.Font = Enum.Font.Gotham
    tuyulInputLabel.TextSize = 9
    tuyulInputLabel.TextXAlignment = Enum.TextXAlignment.Left
    tuyulInputLabel.Parent = Wh

    local Qh = Instance.new("Frame")
    Qh.Size = UDim2.new(1, 0, 0, Q and 38 or 34)
    Qh.LayoutOrder = 5
    Qh.BackgroundTransparency = 1
    Qh.Parent = Wh

    tuyulBox = Instance.new("TextBox")
    tuyulBox.Size = UDim2.new(.55, 0, 1, 0)
    tuyulBox.BackgroundColor3 = Color3.fromRGB(18, 16, 28)
    tuyulBox.Text = "3"
    tuyulBox.PlaceholderText = "contoh: 3"
    tuyulBox.TextColor3 = Color3.new(1, 1, 1)
    tuyulBox.Font = Enum.Font.GothamBold
    tuyulBox.TextSize = w
    tuyulBox.PlaceholderColor3 = Color3.fromRGB(90, 80, 120)
    tuyulBox.Parent = Qh
    Instance.new("UICorner", tuyulBox).CornerRadius = UDim.new(0, 8)

    tuyulBoxPad = Instance.new("UIPadding", tuyulBox)
    tuyulBoxPad.PaddingLeft = UDim.new(0, 10)

    tuyulBoxStroke = Instance.new("UIStroke", tuyulBox)
    tuyulBoxStroke.Color = Color3.fromRGB(120, 50, 200)
    tuyulBoxStroke.Thickness = 1.5
    tuyulBoxStroke.Transparency = .2

    tuyulSetBtn = Instance.new("TextButton")
    tuyulSetBtn.Size = UDim2.new(.42, 0, 1, 0)
    tuyulSetBtn.Position = UDim2.new(.58, 0, 0, 0)
    tuyulSetBtn.BackgroundColor3 = Color3.fromRGB(100, 30, 200)
    tuyulSetBtn.Text = "TERAPKAN"
    tuyulSetBtn.TextColor3 = Color3.new(1, 1, 1)
    tuyulSetBtn.Font = Enum.Font.GothamBold
    tuyulSetBtn.TextSize = w - 1
    tuyulSetBtn.Parent = Qh
    Instance.new("UICorner", tuyulSetBtn).CornerRadius = UDim.new(0, 8)

    tuyulSetGrad = Instance.new("UIGradient", tuyulSetBtn)
    tuyulSetGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 50, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 20, 180))})

    tuyulStatus = Instance.new("TextLabel")
    tuyulStatus.Size = UDim2.new(1, 0, 0, 14)
    tuyulStatus.LayoutOrder = 6
    tuyulStatus.BackgroundTransparency = 1
    tuyulStatus.Text = "Limit: 3x jawab benar → mengalah"
    tuyulStatus.TextColor3 = Color3.fromRGB(180, 80, 255)
    tuyulStatus.Font = Enum.Font.GothamBold
    tuyulStatus.TextSize = 9
    tuyulStatus.TextXAlignment = Enum.TextXAlignment.Left
    tuyulStatus.Parent = Wh
    Y.tuyulStatus = tuyulStatus

    tuyulSetBtn.MouseButton1Click:Connect(function()
        playClickSound()
        local J = tonumber(tuyulBox.Text)
        if J and (J >= 1 and J <= 20) then
            JX = math.floor(J)
            qX = 0
            NX = false
            WX = 0
            tuyulStatus.Text = "Limit: " .. (JX .. "x jawab benar → mengalah ✅")
            tuyulStatus.TextColor3 = Color3.fromRGB(80, 255, 120)
        else
            tuyulStatus.Text = "❌ Masukkan angka 1-20!"
            tuyulStatus.TextColor3 = Color3.fromRGB(255, 80, 80)
        end
    end)

    tuyulBox.FocusLost:Connect(function(J)
        if J then
            local J = tonumber(tuyulBox.Text)
            if J and (J >= 1 and J <= 20) then
                JX = math.floor(J)
                qX = 0
                tuyulStatus.Text = "Limit: " .. (JX .. "x jawab benar → mengalah ✅")
                tuyulStatus.TextColor3 = Color3.fromRGB(80, 255, 120)
            end
        end
    end)

    local Vh = nil
    local kh = Instance.new("TextButton")
    kh.Size = UDim2.new(1, 0, 0, Q and 42 or 38)
    kh.LayoutOrder = 1
    kh.BackgroundColor3 = Color3.fromRGB(25, 22, 38)
    kh.Text = "🎯  SKIN BAMBU: (pilih) 🔻"
    kh.TextColor3 = Color3.new(1, 1, 1)
    kh.Font = Enum.Font.GothamBold
    kh.TextSize = w
    kh.Parent = vx
    Instance.new("UICorner", kh).CornerRadius = UDim.new(0, 9)

    SkinDropGrad = Instance.new("UIGradient", kh)
    SkinDropGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(90, 30, 190)), ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 15, 120))})

    SkinDropStroke = Instance.new("UIStroke", kh)
    SkinDropStroke.Color = Color3.fromRGB(150, 80, 255)
    SkinDropStroke.Thickness = 1.5
    SkinDropStroke.Transparency = .2

    local gh = Instance.new("Frame")
    gh.Size = UDim2.new(1, 0, 0, 0)
    gh.BackgroundColor3 = Color3.fromRGB(14, 13, 22)
    gh.ClipsDescendants = true
    gh.BorderSizePixel = 0
    gh.LayoutOrder = 2
    gh.Parent = vx
    Instance.new("UICorner", gh).CornerRadius = UDim.new(0, 9)

    SkinFrameStroke = Instance.new("UIStroke", gh)
    SkinFrameStroke.Color = Color3.fromRGB(70, 35, 130)
    SkinFrameStroke.Thickness = 1
    SkinFrameStroke.Transparency = .4

    local Ah = Instance.new("TextLabel")
    Ah.Size = UDim2.new(1, -12, 0, 20)
    Ah.BackgroundTransparency = 1
    Ah.Text = "Status: belum pilih skin"
    Ah.TextColor3 = Color3.fromRGB(160, 100, 255)
    Ah.Font = Enum.Font.GothamBold
    Ah.TextSize = 10
    Ah.TextXAlignment = Enum.TextXAlignment.Left
    Ah.LayoutOrder = 3
    Ah.Parent = vx
    Y.SkinDropBtn = kh
    Y.SkinDropGrad = SkinDropGrad
    Y.SkinDropStroke = SkinDropStroke
    Y.SkinFrameStroke = SkinFrameStroke
    Y.SkinInfoText = Ah

    SkinTpDivider = Instance.new("Frame")
    SkinTpDivider.Size = UDim2.new(1, 0, 0, 1)
    SkinTpDivider.BackgroundColor3 = Color3.fromRGB(40, 35, 60)
    SkinTpDivider.BorderSizePixel = 0
    SkinTpDivider.LayoutOrder = 4
    SkinTpDivider.Parent = vx

    local Gh = Q and 40 or 34
    local Bh = false
    function refreshSkinDropUI()
        for J, q in pairs(gh:GetChildren()) do
            if q:IsA("Frame") or q:IsA("TextButton") or q:IsA("TextLabel") then
                q:Destroy()
            end
        end
        for J, q in ipairs(n) do
            local N = Instance.new("Frame")
            N.Size = UDim2.new(1, -12, 0, Q and 34 or 30)
            N.Position = UDim2.new(0, 6, 0, (J - 1) * Gh + 6)
            N.BackgroundColor3 = Vh == q.name and Color3.fromRGB(30, 25, 50) or Color3.fromRGB(20, 18, 30)
            N.BorderSizePixel = 0
            N.Parent = gh
            Instance.new("UICorner", N).CornerRadius = UDim.new(0, 7)

            if Vh == q.name then
                local J = Instance.new("UIStroke", N)
                J.Color = q.color
                J.Thickness = 1
                J.Transparency = .2
            end

            local W = Instance.new("Frame")
            W.Size = UDim2.new(0, 10, 0, 10)
            W.Position = UDim2.new(0, 10, .5, -5)
            W.BackgroundColor3 = q.color
            W.BorderSizePixel = 0
            W.Parent = N
            Instance.new("UICorner", W).CornerRadius = UDim.new(1, 0)

            local v = Instance.new("TextLabel")
            v.Size = UDim2.new(1, -140, 1, 0)
            v.Position = UDim2.new(0, 28, 0, 0)
            v.BackgroundTransparency = 1
            v.Text = q.label .. (Vh == q.name and "  ✓" or "")
            v.TextColor3 = Vh == q.name and q.color or Color3.fromRGB(200, 190, 220)
            v.Font = Enum.Font.GothamBold
            v.TextSize = w
            v.TextXAlignment = Enum.TextXAlignment.Left
            v.Parent = N

            local p = Instance.new("TextLabel")
            p.Size = UDim2.new(0, 105, 1, 0)
            p.Position = UDim2.new(1, -110, 0, 0)
            p.BackgroundTransparency = 1
            p.Text = q.rarity
            p.TextColor3 = O[q.rarity] or Color3.fromRGB(180, 180, 180)
            p.Font = Enum.Font.GothamBold
            p.TextSize = 10
            p.TextXAlignment = Enum.TextXAlignment.Right
            p.Parent = N

            local Z = Instance.new("TextButton")
            Z.Size = UDim2.new(1, 0, 1, 0)
            Z.BackgroundTransparency = 1
            Z.Text = ""
            Z.Parent = N

            Z.MouseButton1Click:Connect(function()
                playClickSound()
                Vh = q.name
                kh.Text = "🎯  SKIN BAMBU: " .. (q.label .. " 🔻")
                Ah.Text = "Status: Terpilih " .. (q.label .. (" | " .. q.rarity))
                Ah.TextColor3 = O[q.rarity] or u[X] and u[X].logText or Color3.new(1, 1, 1)
                applySupremeSkin(q.name)
                refreshSkinDropUI()
            end)
        end
    end

    kh.MouseButton1Click:Connect(function()
        playClickSound()
        Bh = not Bh
        kh.Text = "🎯  SKIN BAMBU: " .. ((Vh and Vh:gsub("^Bambu", "") or "(pilih)") .. (Bh and " 🔺" or " 🔻"))
        gh:TweenSize(UDim2.new(1, 0, 0, Bh and #n * Gh + 12 or 0), "Out", "Quart", .25, true)
        refreshSkinDropUI()
    end)

    function createTpBtn(J, q, N)
        local W = Instance.new("TextButton")
        W.Size = UDim2.new(1, 0, 0, Q and 42 or 38)
        W.LayoutOrder = N
        W.BackgroundColor3 = Color3.fromRGB(18, 16, 26)
        W.Text = J
        W.TextColor3 = Color3.fromRGB(200, 190, 220)
        W.Font = Enum.Font.GothamBold
        W.TextSize = w
        W.Parent = vx
        Instance.new("UICorner", W).CornerRadius = UDim.new(0, 9)

        local p = Instance.new("UIStroke", W)
        p.Color = Color3.fromRGB(70, 35, 130)
        p.Thickness = 1
        p.Transparency = .4

        local Z = J
        W.MouseButton1Click:Connect(function()
            playClickSound()
            local J = v:GetAttribute("CurrentTable") ~= nil
            if J then
                W.Text = "⛔ Tidak bisa saat match!"
                W.TextColor3 = Color3.fromRGB(255, 80, 80)
                task.delay(2, function()
                    W.Text = Z
                    W.TextColor3 = Color3.fromRGB(200, 190, 220)
                end)
                return
            end
            local N = workspace:FindFirstChild(q)
            if not N then
                W.Text = "⚠️ Folder tidak ada!"
                W.TextColor3 = Color3.fromRGB(255, 180, 50)
                task.delay(2, function()
                    W.Text = Z
                    W.TextColor3 = Color3.fromRGB(200, 190, 220)
                end)
                print("⚠️ " .. (q .. " tidak ditemukan!"))
                return
            end
            local p
            for J, q in ipairs(N:GetDescendants()) do
                if q:IsA("BasePart") then
                    p = q
                    break
                end
            end
            if not p then
                print("⚠️ Tidak ada BasePart di " .. (q .. "!"))
                return
            end
            local e = v.Character and v.Character:FindFirstChild("HumanoidRootPart")
            if e then
                e.CFrame = CFrame.new(p.Position + Vector3.new(0, 5, 0))
                W.Text = "✅ TP Berhasil!"
                W.TextColor3 = Color3.fromRGB(80, 255, 120)
                task.delay(2, function()
                    W.Text = Z
                    W.TextColor3 = Color3.fromRGB(200, 190, 220)
                end)
                print("⚡ TP ke " .. q)
            end
        end)
        task.spawn(function()
            while task.wait(1) do
                if not e then break end
                local J = v:GetAttribute("CurrentTable") ~= nil
                p.Transparency = J and 0 or .4
                p.Color = J and Color3.fromRGB(180, 40, 50) or Color3.fromRGB(70, 35, 130)
                W.TextColor3 = J and Color3.fromRGB(150, 140, 170) or Color3.fromRGB(200, 190, 220)
            end
        end)
        return W
    end

    createTpBtn("🌋  TELEPORT KE BAMBU LAVA", "ParkourBambu2", 5)
    createTpBtn("🏠  TELEPORT KE LOBBY", "MainSpawn", 6)

    applyTheme(X)

    c.MouseButton1Click:Connect(function()
        j:Destroy()
        e = false
    end)

    i.Visible = false
    f.Visible = false

    local wh = Instance.new("Frame")
    wh.Size = UDim2.new(0, V, 0, k)
    wh.Position = UDim2.new(.5, -V / 2, .5, -k / 2)
    wh.BackgroundColor3 = Color3.fromRGB(8, 6, 18)
    wh.ZIndex = 100
    wh.BorderSizePixel = 0
    wh.Parent = j
    Instance.new("UICorner", wh).CornerRadius = UDim.new(0, 14)
    Instance.new("UIStroke", wh).Color = Color3.fromRGB(80, 40, 160)

    local Ph = Instance.new("UIListLayout", wh)
    Ph.HorizontalAlignment = Enum.HorizontalAlignment.Center
    Ph.VerticalAlignment = Enum.VerticalAlignment.Center
    Ph.Padding = UDim.new(0, Q and 3 or 4)
    Ph.SortOrder = Enum.SortOrder.LayoutOrder

    local nh = Instance.new("UIPadding", wh)
    nh.PaddingLeft = UDim.new(0, 20)
    nh.PaddingRight = UDim.new(0, 20)
    nh.PaddingTop = UDim.new(0, Q and 30 or 36)
    nh.PaddingBottom = UDim.new(0, 14)

    local Oh = Q and 54 or 62
    local uh = Instance.new("ImageLabel")
    uh.Size = UDim2.new(0, Oh, 0, Oh)
    uh.Position = UDim2.new(.5, -Oh / 2, 0, -Oh / 2)
    uh.ZIndex = 103
    uh.BackgroundColor3 = Color3.fromRGB(20, 15, 40)
    uh.BorderSizePixel = 0
    uh.Parent = wh
    Instance.new("UICorner", uh).CornerRadius = UDim.new(1, 0)

    local Xh = Instance.new("UIStroke", uh)
    Xh.Thickness = 2.5
    pcall(function()
        local J = game:GetService("Players"):GetUserThumbnailAsync(v.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size60x60)
        uh.Image = J
    end)

    task.spawn(function()
        while uh.Parent do
            Xh.Color = Color3.fromHSV((tick() % 3) / 3, .7, 1)
            task.wait(.05)
        end
    end)

    local Yh = Instance.new("Frame")
    Yh.Size = UDim2.new(1, 0, 0, Q and 26 or 30)
    Yh.LayoutOrder = 0
    Yh.ZIndex = 101
    Yh.BackgroundTransparency = 1
    Yh.BorderSizePixel = 0
    Yh.Parent = wh

    local jh = Instance.new("TextLabel")
    jh.Size = UDim2.new(1, 0, 1, 0)
    jh.ZIndex = 102
    jh.BackgroundTransparency = 1
    jh.TextXAlignment = Enum.TextXAlignment.Center
    jh.TextWrapped = true
    jh.Font = Enum.Font.GothamBold
    jh.TextSize = Q and 11 or 12
    jh.Parent = Yh
    pcall(function()
        jh.Text = "Hai, " .. (v.DisplayName .. "!  Selamat Datang Kembali 👋")
    end)

    task.spawn(function()
        while jh.Parent do
            jh.TextColor3 = Color3.fromHSV((tick() % 4) / 4, .55, 1)
            task.wait(.05)
        end
    end)

    local fh = Instance.new("TextLabel")
    fh.Size = UDim2.new(1, 0, 0, Q and 24 or 28)
    fh.LayoutOrder = 1
    fh.ZIndex = 101
    fh.BackgroundTransparency = 1
    fh.Text = "⚠️  PEMBERITAHUAN"
    fh.TextColor3 = Color3.fromRGB(255, 220, 60)
    fh.Font = Enum.Font.GothamBold
    fh.TextSize = Q and 16 or 18
    fh.TextXAlignment = Enum.TextXAlignment.Center
    fh.Parent = wh

    local ih = Instance.new("Frame")
    ih.Size = UDim2.new(.9, 0, 0, 1)
    ih.LayoutOrder = 2
    ih.BackgroundColor3 = Color3.fromRGB(80, 50, 150)
    ih.BorderSizePixel = 0
    ih.Parent = wh

    local Eh = Instance.new("TextLabel")
    Eh.Size = UDim2.new(1, 0, 0, 0)
    Eh.AutomaticSize = Enum.AutomaticSize.Y
    Eh.LayoutOrder = 3
    Eh.ZIndex = 101
    Eh.BackgroundTransparency = 1
    Eh.Text = "Saya sebagai owner script RAFLYXCILLO memberitahu kalau:"
    Eh.TextColor3 = Color3.fromRGB(170, 160, 200)
    Eh.Font = Enum.Font.Gotham
    Eh.TextSize = Q and 9 or 10
    Eh.TextXAlignment = Enum.TextXAlignment.Center
    Eh.TextWrapped = true
    Eh.Parent = wh

    local xh = Instance.new("TextLabel")
    xh.Size = UDim2.new(1, 0, 0, 0)
    xh.AutomaticSize = Enum.AutomaticSize.Y
    xh.LayoutOrder = 4
    xh.ZIndex = 101
    xh.BackgroundColor3 = Color3.fromRGB(50, 6, 6)
    xh.BorderSizePixel = 0
    xh.Text = "SCRIPT RAFLYXCILLO 100% FREE,\nJANGAN MAU DIBODOH-BODOHIN SAMA PENJUAL\nSCRIPT YANG NGAKU-NGAKU SEBAGAI OWNER RAFLYXCILLO."
    xh.TextColor3 = Color3.fromRGB(255, 60, 60)
    xh.Font = Enum.Font.GothamBold
    xh.TextSize = Q and 11 or 13
    xh.TextXAlignment = Enum.TextXAlignment.Center
    xh.TextWrapped = true
    xh.Parent = wh
    Instance.new("UICorner", xh).CornerRadius = UDim.new(0, 10)

    local Ih = Instance.new("UIStroke", xh)
    Ih.Color = Color3.fromRGB(120, 20, 20)
    Ih.Thickness = 0

    local Mh = Instance.new("UIPadding", xh)
    Mh.PaddingLeft = UDim.new(0, 12)
    Mh.PaddingRight = UDim.new(0, 12)
    Mh.PaddingTop = UDim.new(0, 12)
    Mh.PaddingBottom = UDim.new(0, 12)

    task.spawn(function()
        while wh.Parent do
            local J = math.abs(math.sin(tick() * 1.5))
            xh.TextColor3 = Color3.fromRGB(math.floor(200 + J * 30), math.floor(50 + J * 20), math.floor(50 + J * 20))
            task.wait(.05)
        end
    end)

    local mh = Instance.new("Frame")
    mh.Size = UDim2.new(1, 0, 0, Q and 34 or 38)
    mh.LayoutOrder = 6
    mh.BackgroundTransparency = 1
    mh.BorderSizePixel = 0
    mh.Parent = wh

    local Th = Instance.new("UIListLayout", mh)
    Th.FillDirection = Enum.FillDirection.Horizontal
    Th.HorizontalAlignment = Enum.HorizontalAlignment.Center
    Th.VerticalAlignment = Enum.VerticalAlignment.Center
    Th.Padding = UDim.new(0, 10)

    local zh = Instance.new("TextButton")
    zh.Size = UDim2.new(0, Q and 128 or 148, 1, 0)
    zh.ZIndex = 101
    zh.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
    zh.BorderSizePixel = 0
    zh.Text = "🎵  TikTok "
    zh.TextColor3 = Color3.fromRGB(100, 200, 255)
    zh.Font = Enum.Font.GothamBold
    zh.TextSize = Q and 10 or 11
    zh.Parent = mh
    Instance.new("UICorner", zh).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", zh).Color = Color3.fromRGB(50, 130, 190)

    zh.MouseButton1Click:Connect(function()
        pcall(function()
            setclipboard("https://www.tiktok.com/@raflynurhafizh")
        end)
        zh.Text = "✅ Link Disalin!"
        task.delay(2, function()
            zh.Text = "🎵  TikTok"
        end)
    end)

    local Lh = Instance.new("TextButton")
    Lh.Size = UDim2.new(0, Q and 138 or 158, 1, 0)
    Lh.ZIndex = 101
    Lh.BackgroundColor3 = Color3.fromRGB(20, 60, 20)
    Lh.BorderSizePixel = 0
    Lh.Text = "✅  Saya Sudah Membaca"
    Lh.TextColor3 = Color3.fromRGB(100, 255, 100)
    Lh.Font = Enum.Font.GothamBold
    Lh.TextSize = Q and 10 or 11
    Lh.Parent = mh
    Instance.new("UICorner", Lh).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", Lh).Color = Color3.fromRGB(40, 160, 40)

    Lh.MouseButton1Click:Connect(function()
        wh:Destroy()
        i.Visible = true
        f.Visible = true
    end)

    task.spawn(function()
        while task.wait() do
            if not e then break end
            z.TextColor3 = Color3.fromHSV((tick() % 5) / 5, .7, 1)
        end
    end)
