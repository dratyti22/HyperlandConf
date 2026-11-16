------------------
---- MONITORS ----
------------------
hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1080@60",
    position = "0x0",
    scale    = 1,
})

---------------------
---- MY PROGRAMS ----
---------------------
-- Глобальные переменные: их использует keybind.lua (подключается ниже).
-- Меняешь программу — только здесь.
terminal    = "warp-terminal"
fileManager = "thunar"
menu        = "wofi --show drun"
browser     = "yandex-browser-stable"

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Adwaita")
hl.env("HYPRCURSOR_THEME", "Adwaita")

-------------------
---- AUTOSTART ----
-------------------
hl.on("hyprland.start", function()
    hl.exec_cmd("hyprctl setcursor Adwaita 24")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("/usr/bin/waybar -c " .. os.getenv("HOME") .. "/.config/waybar/config.json")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
    hl.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/waybar-light-controls/hyprsunset_init.sh")
end)

-----------------------
---- LOOK AND FEEL ----
-----------------------
hl.config({
    general = {
        gaps_in          = 5,
        gaps_out         = 20,
        border_size      = 2,
        col = {
            active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },
        resize_on_border = false,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled  = true,
            size     = 3,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo   = false,
    },

    -- Программный курсор: на AMD Stoney аппаратный слой курсора
    -- иногда не отображается (курсор "пропадает").
    cursor = {
        no_hardware_cursors = true,
    },
})

-- Кривые (bezier)
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1}, {0.32, 1} } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1} } })
hl.curve("linear",         { type = "bezier", points = { {0, 0}, {1, 1} } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5}, {0.75, 1.0} } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0}, {0.1, 1} } })
--
hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "windows",       enabled = true, speed = 7,    bezier = "default",      style = "slide" })

---------------
---- INPUT ----
---------------
hl.config({
    input = {
        kb_layout  = "us,ru",
        kb_variant = "",
        kb_model   = "",
        kb_options = "grp:win_space_toggle",
        kb_rules   = "",

        follow_mouse = 1,
        sensitivity  = -0.1,

        touchpad = {
            natural_scroll = true,
        },
    },
})

-- Per-device
hl.device({
    name        = "compx-2.4g-wireless-receiver",
    sensitivity = -0.3,
})

hl.device({
    name       = "at-translated-set-2-keyboard",
    kb_options = "grp:win_space_toggle,ctrl:swapcaps",
})

---------------------
---- KEYBINDINGS ----
---------------------
-- Клавиши и мышь вынесены в отдельный файл: ~/.config/hypr/keybind.lua
-- Путь строится от XDG_CONFIG_HOME или ~/.config
dofile((os.getenv("XDG_CONFIG_HOME") or (os.getenv("HOME") .. "/.config")) .. "/hypr/keybind.lua")

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------
-- Полезные правила (те, что у тебя были закомментированы, оставил закомментированными)

-- Игнорировать maximize-запросы
hl.window_rule({
    name = "suppress-maximize",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- Фикс XWayland drag
hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})
