-- Hyprland Lua config (migrated from hyprland.conf)
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- You can split this configuration into multiple files and require them:
-- require("myColors")


------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

-- HDR variants:
-- hl.monitor({ output = "DP-1", mode = "3440x1440@90", position = "0x0",     scale = "auto", bitdepth = 10, vrr = 1, cm = "hdr", sdrbrightness = 1.4, sdrsaturation = 1.1 })
-- hl.monitor({ output = "DP-2", mode = "2560x1440@90", position = "440x-1440", scale = "auto", bitdepth = 10, vrr = 1, cm = "hdr", sdrbrightness = 1.4, sdrsaturation = 1.1 })

hl.monitor({ output = "DP-1",     mode = "3440x1440@60", position = "0x0",       scale = "auto", bitdepth = 8, vrr = 0 })
hl.monitor({ output = "DP-2",     mode = "2560x1440@60", position = "440x-1440", scale = "auto", bitdepth = 8, vrr = 0 })
hl.monitor({ output = "HDMI-A-1", mode = "2560x1440@60", position = "440x-1440", scale = "auto", bitdepth = 8, vrr = 0 })


---------------------
---- MY PROGRAMS ----
---------------------

local cursor_theme = "Nordzy-hyprcursors-white"
local cursor_size  = 32

-- Set programs that you use
local terminal    = "ghostty"
local fileManager = "nautilus"
-- local menu        = "caelestia shell drawers toggle launcher"
local menu        = "qs -c focus ipc call launcher toggle"
local browser     = "flatpak run app.zen_browser.zen"


-------------------
---- AUTOSTART ----
-------------------

-- Equivalent of `exec` (runs on every config reload)
hl.exec_cmd("dbus-update-activation-environment --all")

-- Equivalent of `exec-once`
hl.on("hyprland.start", function()
    -- hl.exec_cmd("waybar")
    -- hl.exec_cmd("swaync")
    -- hl.exec_cmd("hypridle")
    -- hl.exec_cmd("hyprdim")
    -- hl.exec_cmd("swww-daemon")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    -- focusshell is the polkit agent; hyprpolkitagent only if the shell didn't register
    hl.exec_cmd(os.getenv("HOME") .. "/.config/quickshell/focus/scripts/polkit-fallback.sh")
    hl.exec_cmd("hyprctl setcursor " .. cursor_theme .. " " .. cursor_size)
    hl.exec_cmd("1password --silent")
    hl.exec_cmd("easyeffects --service-mode -w")
    -- hl.exec_cmd("caelestia shell --daemon")
    hl.exec_cmd("qs -c focus -d")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE",      tostring(cursor_size))
hl.env("XCURSOR_THEME",     cursor_theme)
hl.env("HYPRCURSOR_SIZE",   tostring(cursor_size))
hl.env("HYPRCURSOR_THEME",  cursor_theme)

-- focusshell: SSH / git passphrase prompts in the shell (when there is no terminal to ask in)
hl.env("SSH_ASKPASS", os.getenv("HOME") .. "/.config/quickshell/focus/scripts/askpass-focusshell")


-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Permission changes require a Hyprland restart and are not applied on-the-fly.

-- hl.config({
--     ecosystem = {
--         enforce_permissions = true,
--     },
-- })

hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 20,

        border_size = 2,

        col = {
            active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = "rgba(1a1a1aee)",
        },

        blur = {
            enabled  = true,
            size     = 5,
            passes   = 3,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

-- Curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1.0}  } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, bezier = "easeOutQuint" })
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

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

hl.config({
    dwindle = {
        -- pseudotile = true, -- Master switch for pseudotiling. Enabling is bound to mainMod + P below
        preserve_split = true, -- You probably want this
    },

    master = {
        new_status = "master",
    },

    misc = {
        vrr = 1,
        force_default_wallpaper = 0,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = true, -- If true disables the random hyprland logo / anime girl background. :(

        anr_missed_pings = 30,
    },

    render = {
        cm_auto_hdr = 1,
        -- cm_fs_passthrough = 2,
    },

    -- ecosystem = {
    --     enforce_permissions = true,
    -- },

    -- experimental = {
    --     xx_color_management_v4 = true,
    -- },
})


---------------
---- INPUT ----
---------------

-- https://wiki.hypr.land/Configuring/Basics/Variables/#input
hl.config({
    input = {
        kb_layout  = "us, bg",
        kb_variant = ",phonetic",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = true,
        },
    },
})

-- gestures
-- hl.gesture({
--     fingers   = 3,
--     direction = "horizontal",
--     action    = "workspace",
-- })

-- Per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- See https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q",      hl.dsp.window.close())
hl.bind(mainMod .. " + ALT + SHIFT + M", hl.dsp.exit())
hl.bind(mainMod .. " + E",      hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + O",      hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D",      hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P",      hl.dsp.window.pseudo())    -- dwindle
-- hl.bind(mainMod .. " + J",   hl.dsp.layout("togglesplit")) -- dwindle
hl.bind(mainMod .. " + B",      hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + F",      hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
-- `locked`: also works on the lock screen, so a wrong layout can never keep you out
hl.bind(mainMod .. " + Space",  hl.dsp.exec_cmd("hyprctl switchxkblayout all next"), { locked = true })
hl.bind("CTRL + ALT + Delete",  hl.dsp.exec_cmd("flatpak run io.missioncenter.MissionCenter"))
-- focusshell lock screen; hyprlock if the shell isn't running
hl.bind(mainMod .. " + L",      hl.dsp.exec_cmd("qs -c focus ipc call session lock || hyprlock"))
-- focusshell: screenshot / record picker, clipboard history (were grim+slurp and rofi)
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("qs -c focus ipc call capture toggle"))
hl.bind("Print",                   hl.dsp.exec_cmd("qs -c focus ipc call capture toggle"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("qs -c focus ipc call capture record"))
hl.bind(mainMod .. " + V",      hl.dsp.exec_cmd("qs -c focus ipc call launcher clipboard"))
hl.bind(mainMod .. " + slash",  hl.dsp.exec_cmd("qs -c focus ipc call cheatsheet toggle"))
hl.bind(mainMod .. " + C",      hl.dsp.exec_cmd("qs -c focus ipc call calendar toggle"))

-- focusshell switchers: hold SUPER / ALT and tap Tab, let go to switch
hl.bind(mainMod .. " + Tab",         hl.dsp.exec_cmd("qs -c focus ipc call switcher workspaces"))
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.exec_cmd("qs -c focus ipc call switcher workspacesBack"))
hl.bind("ALT + Tab",                 hl.dsp.exec_cmd("qs -c focus ipc call switcher windows"))
hl.bind("ALT + SHIFT + Tab",         hl.dsp.exec_cmd("qs -c focus ipc call switcher windowsBack"))
hl.bind(mainMod .. " + SUPER_L",     hl.dsp.exec_cmd("qs -c focus ipc call switcher commit"), { release = true })
hl.bind("ALT + ALT_L",               hl.dsp.exec_cmd("qs -c focus ipc call switcher commit"), { release = true })

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + minus",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + minus", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),  { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),       { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),      { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("qs -c focus ipc call display up"),                   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("qs -c focus ipc call display down"),                   { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Ignore maximize requests from apps. You'll probably like this.
hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    name  = "fix-xwayland-drags",
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

-- Inhibit idle while anything is fullscreen
hl.window_rule({
    name  = "idle-inhibit-fullscreen",
    match = { class = ".*" },

    idle_inhibit = "fullscreen",
})

-- Picture-in-Picture
hl.window_rule({
    name  = "picture-in-picture",
    match = { title = "^(Picture-in-Picture)$" },

    pin   = true,
    float = true,
    size  = "25% 25%",
    move  = "72% 7%",
})

-- xwaylandvideobridge
hl.window_rule({
    name  = "xwaylandvideobridge",
    match = { class = "^(xwaylandvideobridge)$" },

    opacity          = "0.0 override 0.0 override",
    no_anim          = true,
    no_initial_focus = true,
    max_size         = "1 1",
    no_blur          = true,
})

-- Steam game
hl.window_rule({
    name  = "steam-app-1042800-fullscreen",
    match = { class = "^(steam_app_1042800)$" },

    fullscreen = true,
})


-----------------
---- LAYERS -----
-----------------

hl.layer_rule({
    name  = "sherlock",
    match = { namespace = "sherlock" },

    ignore_alpha = 0,
    blur         = true,
    -- dim_around = true,
    -- xray       = false,
})

hl.layer_rule({
    name  = "gtk-layer-shell",
    match = { namespace = "gtk-layer-shell" },

    blur = true,
})

hl.layer_rule({
    name  = "swaync-control-center",
    match = { namespace = "swaync-control-center" },

    blur         = true,
    ignore_alpha = 0.5,
})

hl.layer_rule({
    name  = "swaync-notification-window",
    match = { namespace = "swaync-notification-window" },

    blur         = true,
    ignore_alpha = 0.5,
})


-----------------
--- FOCUSSHELL ---
-----------------

-- blur behind the shell's islands, panels and popups
hl.layer_rule({
    name  = "focusshell",
    match = { namespace = "^focusshell-(bar|notifications|osd|control|launcher|overview|picker|power|assistant|settings|taskmanager|cheatsheet|calendar|auth|switcher)$" },

    blur         = true,
    ignore_alpha = 0.3,
})

-- wallpaper picker, power menu
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("qs -c focus ipc call wallpaper picker"))
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("qs -c focus ipc call session menu"))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("qs -c focus ipc call assistant toggle"))
hl.bind(mainMod .. " + period", hl.dsp.exec_cmd("qs -c focus ipc call launcher emoji"))
hl.bind(mainMod .. " + comma",  hl.dsp.exec_cmd("qs -c focus ipc call settings toggle"))

-- if the shell ever dies while locked, let a restarted shell take the lock back
-- (instead of a permanent "lockscreen crashed" screen)
hl.config({ misc = { allow_session_lock_restore = true } })

-- fullscreen windows (games, videos) keep the screen awake: no idle lock / screen-off
hl.window_rule({
    name  = "focusshell-fullscreen-idle",
    match = { class = ".*" },

    idle_inhibit = "fullscreen",
})

-- settings changed in the shell's Settings window (borders, gaps, blur, window rules…)
pcall(dofile, os.getenv("HOME") .. "/.config/hypr/focusshell-settings.lua")

-- border colours generated from the wallpaper (rewritten on every wallpaper change; keep this last)
pcall(dofile, os.getenv("HOME") .. "/.config/hypr/focusshell-colors.lua")
