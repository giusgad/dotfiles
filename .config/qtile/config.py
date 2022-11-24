# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.


import os
import subprocess
from libqtile import qtile
from libqtile.config import Drag, Key, Screen, Group, Drag, Match
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from libqtile.widget import Spacer
import asyncio

# debug tool
# from libqtile.log_utils import logger

COLORS = [
    "#282828",  # color 0 - bar background
    "#fb4934",  # color 1 - alert color
    "#EBA982",  # color 2 - inactive screen wallpaper
    "#ebdbb2",  # color 3 - foreground
    "#ebdbb2",  # color 4 - inactive workspace font
    "#a89984",  # color 5 - other screen workspace
    "#E37536",  # color 6 - selected workspace/ active window border
    "#edbca3",  # color 7 - active workspace font
    "#4D4A4A",  # color 8 - powerline background
    "#282828",  # color 9 - powerline background
    "#4D4A4A",  # color 10 - powerline background
    "#282828",  # color 11 - powerline background
    "#4D4A4A",  # color 12 - powerline background
    "#282828",  # color 13 - powerline background
]


# mod4 or mod = super key
mod = "mod4"
mod1 = "alt"
mod2 = "control"
home = os.path.expanduser("~")
my_term = "alacritty"


@lazy.function
def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)


@lazy.function
def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)


keys = [
    # Most of our keybindings are in sxhkd file - except these
    # SUPER + FUNCTION KEYS
    Key([mod], "f", lazy.window.toggle_fullscreen()),
    Key([mod], "t", lazy.window.toggle_floating()),
    Key([mod], "q", lazy.window.kill()),
    # SUPER + SHIFT KEYS
    Key([mod, "shift"], "q", lazy.window.kill()),
    Key([mod, "shift"], "r", lazy.restart()),
    # QTILE LAYOUT KEYS
    Key([mod], "n", lazy.layout.normalize()),
    Key([mod], "space", lazy.next_layout()),
    Key([mod, "shift"], "space", lazy.prev_layout()),
    # CHANGE SCREEN FOCUS
    Key([mod], "w", lazy.next_screen()),
    # CHANGE FOCUS
    Key([mod], "Up", lazy.layout.up()),
    Key([mod], "Down", lazy.layout.down()),
    Key([mod], "Left", lazy.layout.left()),
    Key([mod], "Right", lazy.layout.right()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),
    # switch focus to next window
    Key([mod], "e", lazy.layout.next()),
    # RESIZE UP, DOWN, LEFT, RIGHT
    Key(
        [mod, "control"],
        "l",
        lazy.layout.grow_right(),
    ),
    Key(
        [mod, "control"],
        "Right",
        lazy.layout.grow_right(),
    ),
    Key(
        [mod, "control"],
        "h",
        lazy.layout.grow_left(),
    ),
    Key(
        [mod, "control"],
        "Left",
        lazy.layout.grow_left(),
    ),
    Key(
        [mod, "control"],
        "k",
        lazy.layout.grow_up(),
    ),
    Key(
        [mod, "control"],
        "Up",
        lazy.layout.grow_up(),
    ),
    Key(
        [mod, "control"],
        "j",
        lazy.layout.grow_down(),
    ),
    Key(
        [mod, "control"],
        "Down",
        lazy.layout.grow_down(),
    ),
    # FLIP LAYOUT FOR MONADTALL/MONADWIDE
    Key([mod, "shift"], "f", lazy.layout.flip()),
    # MOVE WINDOWS UP OR DOWN BSP LAYOUT
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left()),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right()),
    # GROW AND SHRINK FOR MONADTALL/MONADWIDE
    Key([mod], "i", lazy.layout.grow()),
    Key([mod], "m", lazy.layout.shrink()),
]

# DEFINING WORKSPACES
# group_labels = ["WWW", "DEV", "TERM", "FILES", "SYS", "MUS", "NET", "VID", "OTHER"]

workspaces = [
    {"label": " ", "key": "1", "spawn": "firefox"},
    {"label": " ", "key": "2", "layout": "bsp"},
    {"label": " ", "key": "3"},
    {"label": " ", "key": "4"},
    {"label": " ", "key": "5"},
    {"label": "阮 ", "key": "6", "spawn": "spotify"},
    {"label": " ", "key": "7", "spawn": "telegram-desktop"},
    {"label": " ", "key": "8"},
    {"label": " ", "key": "9"},
    {"label": " ", "key": "0"},
]

groups = []
for workspace in workspaces:
    spawn = workspace["spawn"] if "spawn" in workspace else None
    group_layout = workspace["layout"] if "layout" in workspace else "monadtall"
    groups.append(
        Group(
            name=workspace["key"],
            label=workspace["label"],
            layout=group_layout,
            spawn=spawn,
        )
    )

# ASSIGN APPS TO GROUPS
@hook.subscribe.client_new
def assign_app_group(client):
    d = {}
    # Use xprop fo find  the value of WM_CLASS(STRING) -> First field is sufficient
    # some of the apps open in the designed group only at startup | see above
    d["1"] = []
    d["2"] = ["atom", "subl", "code-oss", "code"]
    d["3"] = []
    d["4"] = ["pcmanfm", "nautilus", "dolphin"]
    d["5"] = []
    d["6"] = ["spotify", "Spotify"]
    d["7"] = ["telegram-desktop", "discord", "kdeconnect-app"]
    d["8"] = ["joplin"]
    d["9"] = ["Steam", "heroic"]
    d["0"] = []

    # get wm_class list
    wm_class = client.window.get_wm_class()
    # if it doesn't exist wait and try again
    # i.e. spotify takes longer to get a wm_class
    wm_class_timeout = 0
    while not wm_class and wm_class_timeout < 50:
        asyncio.sleep(0.02)
        wm_class_timeout += 1
        wm_class = client.window.get_wm_class()
    # only use the first value of the wm_class
    wm_class = wm_class[0]

    for key in d:
        if wm_class in d[key]:
            client.togroup(key)
            client.group.cmd_toscreen(toggle=False)


# KEYBINDINGS FOR GROUPS
for i in groups:
    keys.extend(
        [
            # CHANGE WORKSPACES
            Key([mod], i.name, lazy.group[i.name].toscreen()),
            # MOVE WINDOW TO SELECTED WORKSPACE 1-10 AND STAY ON WORKSPACE
            Key([mod, "control"], i.name, lazy.window.togroup(i.name)),
            # MOVE WINDOW TO SELECTED WORKSPACE 1-10 AND FOLLOW MOVED WINDOW TO WORKSPACE
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name),
                lazy.group[i.name].toscreen(),
            ),
        ]
    )


def init_layout_theme():
    return {
        "margin": 10,
        "border_width": 2,
        "border_focus": COLORS[6],
        "border_normal": COLORS[3],
    }


layout_theme = init_layout_theme()


layouts = [
    layout.MonadTall(**layout_theme),
    layout.Max(**layout_theme),
    layout.Bsp(**layout_theme, fair=False),
    layout.Columns(**layout_theme, insert_position=1, border_on_single=True),
    layout.Floating(**layout_theme),
]

# WIDGETS FOR THE BAR
# powerline characters: https://github.com/ryanoasis/powerline-extra-symbols

FONT = "Caskaydia Cove Nerd Font"
POWERLINE_FONT = "Caskaydia Cove Nerd Font"
POWERLINE_FONT_SIZE = 26
POWERLINE_CHAR = "\ue0b6"
POWERLINE_PADDING = 0

BAR_HEIGHT = 26
BAR_OPACITY = 0.65
BAR_MARGIN = [5, 10, 0, 10]


def init_widgets_defaults():
    return dict(font=FONT, fontsize=14, background=COLORS[0])


widget_defaults = init_widgets_defaults()


def init_widgets_list():
    # prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())
    widgets_list = [
        # left aligned
        widget.GroupBox(
            font=FONT,
            fontsize=16,
            padding_y=6,
            padding_x=10,
            borderwidth=0,
            disable_drag=True,
            highlight_method="block",
            background=COLORS[0],
            active=COLORS[7],
            inactive=COLORS[4],
            this_current_screen_border=COLORS[6],
            this_screen_border=COLORS[2],
            other_screen_border=COLORS[5],
            other_current_screen_border=COLORS[5],
            urgent_border=COLORS[1],
        ),
        widget.Sep(**widget_defaults),
        widget.WindowName(
            font=FONT,
            fontsize=14,
            background=COLORS[0],
            foreground=COLORS[3],
            max_chars=50,
        ),
        # Spacer(),
        # center aligned
        widget.Clock(
            foreground=COLORS[3],
            background=COLORS[0],
            fontsize=20,
            font=FONT,
            format="%H:%M",
        ),
        widget.Pomodoro(
            background=COLORS[0],
            foreground=COLORS[3],
            color_active=COLORS[5],
            color_inactive=COLORS[5],
            color_break=COLORS[5],
            font=FONT,
            fontsize=16,
            prefix_inactive="",
            prefix_break=" ",
            prefix_long_break=" ",
            prefix_paused="",
            prefix_active=" ",
        ),
        Spacer(),
        # right aligned
        widget.TextBox(
            text=POWERLINE_CHAR,
            background=COLORS[0],
            foreground=COLORS[8],
            padding=POWERLINE_PADDING,
            fontsize=POWERLINE_FONT_SIZE,
            font=POWERLINE_FONT,
        ),
        widget.Net(
            font=FONT,
            fontsize=14,
            foreground=COLORS[3],
            background=COLORS[8],
            padding=5,
            format="{down} ↓↑ {up}",
        ),
        widget.TextBox(
            text=POWERLINE_CHAR,
            background=COLORS[8],
            foreground=COLORS[9],
            padding=POWERLINE_PADDING,
            fontsize=POWERLINE_FONT_SIZE,
            font=POWERLINE_FONT,
        ),
        widget.TextBox(
            text=" ",
            background=COLORS[9],
            foreground=COLORS[3],
            padding=0,
            fontsize=18,
            font=FONT,
        ),
        widget.CPU(
            background=COLORS[9],
            foreground=COLORS[3],
            format=" {load_percent}%",
            update_interval=3.0,
            fontsize=14,
            font=FONT,
        ),
        widget.TextBox(
            text=POWERLINE_CHAR,
            background=COLORS[9],
            foreground=COLORS[10],
            padding=POWERLINE_PADDING,
            fontsize=POWERLINE_FONT_SIZE,
            font=POWERLINE_FONT,
        ),
        widget.CurrentLayout(
            font=FONT, foreground=COLORS[3], background=COLORS[10], fontsize=14
        ),
        widget.TextBox(
            text=POWERLINE_CHAR,
            background=COLORS[10],
            foreground=COLORS[11],
            padding=POWERLINE_PADDING,
            fontsize=POWERLINE_FONT_SIZE,
            font=POWERLINE_FONT,
        ),
        widget.Clock(
            foreground=COLORS[3],
            background=COLORS[11],
            fontsize=14,
            font=FONT,
            format="%d-%m-%Y",
        ),
        widget.TextBox(
            text=POWERLINE_CHAR,
            background=COLORS[11],
            foreground=COLORS[12],
            padding=POWERLINE_PADDING,
            fontsize=POWERLINE_FONT_SIZE,
            font=POWERLINE_FONT,
        ),
        widget.TextBox(
            text=" ",
            background=COLORS[12],
            foreground=COLORS[3],
            padding=0,
            fontsize=16,
            mouse_callbacks={
                "Button1": lambda: qtile.cmd_spawn(
                    "sh ~/.scripts/change_output.sh", shell=True
                ),
                "Button3": lambda: qtile.cmd_spawn("pavucontrol"),
            },
        ),
        widget.Volume(
            background=COLORS[12],
            foreground=COLORS[3],
            font=FONT,
            padding=5,
            fontsize=14,
        ),
        widget.KeyboardLayout(
            background=COLORS[12],
            configured_keyboards=["us", "it"],
            font=FONT,
            foreground=COLORS[3],
            fontsize=14,
        ),
        widget.TextBox(
            text="﨤 ",
            background=COLORS[12],
            foreground=COLORS[3],
            font=FONT,
            padding=0,
            fontsize=16,
            mouse_callbacks={
                "Button1": lambda: qtile.cmd_spawn(
                    "sh ~/.scripts/live_wallpaper_toggle.sh", shell=True
                )
            },
        ),
        widget.CheckUpdates(
            background=COLORS[12],
            foreground=COLORS[3],
            colour_no_updates=COLORS[3],
            colour_have_updates=COLORS[3],
            pkdding=0,
            fontsize=16,
            font=FONT,
            display_format="| {updates} ",
            restart_indicator="ﰇ",
            mouse_callbacks={"Button1": lambda: qtile.cmd_spawn(my_term + " -e paru")},
        ),
        widget.TextBox(
            text=POWERLINE_CHAR,
            background=COLORS[12],
            foreground=COLORS[13],
            padding=POWERLINE_PADDING,
            fontsize=POWERLINE_FONT_SIZE,
            font=POWERLINE_FONT,
        ),
        widget.Systray(background=COLORS[13], icon_size=20, padding=4),
        widget.TextBox(
            text="",
            background=COLORS[13],
            foreground=COLORS[3],
            font=FONT,
            padding=5,
            fontsize=18,
            mouse_callbacks={
                "Button1": lambda: qtile.cmd_spawn(
                    "rofi -show p -modi p:'.config/rofi/rofi-power-menu'", shell=True
                )
            },
        ),
        widget.Sep(padding=10, background=COLORS[13], foreground=COLORS[13]),
    ]
    return widgets_list


def init_widgets_screen1():
    widgets_screen2 = init_widgets_list()
    del widgets_screen2[4]
    return widgets_screen2


def init_widgets_screen2():
    widgets_screen1 = init_widgets_list()
    # remove unwanted widgets on second monitor
    # systray and first separator
    del widgets_screen1[-4:]
    return widgets_screen1


def init_screens():
    return [
        Screen(
            top=bar.Bar(
                widgets=[],
                size=BAR_HEIGHT,
                opacity=0,
                margin=BAR_MARGIN,
            )
        ),
    ]


if __name__ in ["config", "__main__"]:
    screens = init_screens()
    widgets_list = init_widgets_list()
    widgets_screen1 = init_widgets_screen1()
    widgets_screen2 = init_widgets_screen2()


# MOUSE CONFIGURATION
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
]

dgroups_key_binder = None
dgroups_app_rules = []

# ASSIGN APPLICATIONS TO A SPECIFIC GROUPNAME
# BEGIN


# END
# ASSIGN APPLICATIONS TO A SPECIFIC GROUPNAME


main = None


@hook.subscribe.startup_once
def start_once():
    subprocess.call([home + "/.config/qtile/scripts/autostart.sh"])


@hook.subscribe.startup
def start_always():
    # Set the cursor to something sane in X
    subprocess.Popen(["xsetroot", "-cursor_name", "left_ptr"])
    # os.system(
    #     "sleep 5 && ~/.scripts/live_wallpaper.sh (cat ~/.config/qtile/scripts/wallpaper_path)"
    # )


@hook.subscribe.client_new
def set_floating(window):
    if (
        window.window.get_wm_transient_for()
        or window.window.get_wm_type() in floating_types
    ):
        window.floating = True


floating_types = ["notification", "toolbar", "splash", "dialog"]


follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        Match(wm_class="Arcolinux-welcome-app.py"),
        Match(wm_class="Arcolinux-tweak-tool.py"),
        Match(wm_class="Arcolinux-calamares-tool.py"),
        Match(wm_class="confirm"),
        Match(wm_class="dialog"),
        Match(wm_class="download"),
        Match(wm_class="error"),
        Match(wm_class="file_progress"),
        Match(wm_class="notification"),
        Match(wm_class="splash"),
        Match(wm_class="toolbar"),
        Match(wm_class="confirmreset"),
        Match(wm_class="makebranch"),
        Match(wm_class="maketag"),
        Match(wm_class="Arandr"),
        Match(wm_class="feh"),
        Match(wm_class="Galculator"),
        Match(wm_class="arcolinux-logout"),
        Match(wm_class="xfce4-terminal"),
        Match(title="branchdialog"),
        Match(title="Open File"),
        Match(title="pinentry"),
        Match(wm_class="ssh-askpass"),
        Match(wm_class="nvidia-settings"),
        Match(wm_class="tk"),
        Match(wm_class="gnome-screenshot"),
        Match(wm_class="gpartedbin"),
    ],
    fullscreen_border_width=0,
    border_width=0,
)
auto_fullscreen = True

focus_on_window_activation = "focus"  # or smart

wmname = "LG3D"
