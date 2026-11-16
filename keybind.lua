-------------------------------------------------
---- ПРОГРАММЫ, ИСПОЛЬЗУЕМЫЕ В БИНДАХ ----
-------------------------------------------------
-- Берутся из hyprland.lua; fallback — если файл запустят отдельно.
local terminal    = terminal    or "warp-terminal"
local fileManager = fileManager or "thunar"
local menu        = menu        or "wofi --show drun"
local browser     = browser     or "yandex-browser-stable"

local mainMod = "SUPER"

-----------------
---- ОСНОВНЫЕ ----
-----------------

-- Полноэкранный режим
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())

-- Swap windows
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.swap({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.swap({ direction = "right" }))

-- Cycle next / previous workspace
hl.bind("ALT + Tab",         hl.dsp.focus({ window = "next" }))
hl.bind(mainMod .. " + Tab", hl.dsp.focus({ workspace = "previous" }))

-- Resize (repeating)
hl.bind(mainMod .. " + L", hl.dsp.window.resize({ x = 70,  y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + H", hl.dsp.window.resize({ x = -70, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + K", hl.dsp.window.resize({ x = 0,   y = -70, relative = true }), { repeating = true })
hl.bind(mainMod .. " + J", hl.dsp.window.resize({ x = 0,   y = 70, relative = true }), { repeating = true })

-- Основные бинды
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("Telegram"))
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd("killall waybar; waybar -c " .. os.getenv("HOME") .. "/.config/waybar/config.json --log-level error &"))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("/usr/bin/zeditor"))

-- Скриншот
hl.bind("PRINT", hl.dsp.exec_cmd([[mkdir -p "$HOME/Pictures/screenshots" && hyprshot -m region -o "$HOME/Pictures/screenshots/" -f "screenshot_$(date +'%Y%m%d_%H%M%S').png" -c]]))

-- Основные
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C",      hl.dsp.window.close())
hl.bind(mainMod .. " + M",      hl.dsp.exit())
hl.bind(mainMod .. " + E",      hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V",      hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R",      hl.dsp.exec_cmd(menu))

-- Фокус стрелками
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Воркспейсы 1-10
for i = 1, 10 do
    local key = i % 10          -- 10 becomes 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, silent = true }))
end

-- Special workspace
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(mainMod .. " + CTRL + S",  hl.dsp.window.move({ workspace = "e+0" }))

-- Мышь
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-------------------------
---- МЕДИА И ЯРКОСТЬ ----
-------------------------
-- Работают даже на lock-screen

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })

hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 10%-"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl set +10%"), { locked = true, repeating = true })

-- Playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

------------------------
---- ЖЕСТЫ ТАЧПАДА ----
------------------------
-- Работает только на тачпаде.

-- 3 пальца влево/вправо — нативное переключение рабочих столов
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- 3 пальца вверх — меню приложений (wofi)
hl.gesture({
    fingers   = 3,
    direction = "up",
    action = {
        finish = function() hl.exec_cmd(menu) end,
    },
})

-- 3 пальца вниз — шторка: special workspace "magic"
hl.gesture({
    fingers   = 3,
    direction = "down",
    action = {
        finish = function() hl.dispatch(hl.dsp.workspace.toggle_special("magic")) end,
    },
})

-- 4 пальца вверх — полноэкранный режим
hl.gesture({ fingers = 4, direction = "up", action = "fullscreen" })

-- 4 пальца вниз — плавающее окно (toggle)
hl.gesture({ fingers = 4, direction = "down", action = "float" })
