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
import re
import socket
import subprocess
from libqtile import qtile
from libqtile.config import Drag, Key, Screen, Group, Drag, Click, Rule
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from libqtile.widget import Spacer
import asyncio

# debug tool
# from libqtile.log_utils import logger

# import arcobattery

# colors
def init_colors():
    colors = [
        "#391e26",  # color 0 - background - deep red
        "#391e26",  # color 1 - arrows background - deep red
        "#e73956",  # color 2 - arrows background - pinkish red
        "#e19b37",  # color 3 - yellow
        "#c1516c",  # color 4 - blue
        "#e9dcb6",  # color 5 - foreground - yellow/white
        "#c17fd2",  # color 6 - magenta?
        "#a6bb55",  # color 7 - green
        "#e73956",  # color 8 - selected workspace/border - red-pink-ish
        "#FEF28A",  # color 9 - inactive - light yellow
    ]
    return colors


colors = init_colors()


# mod4 or mod = super key
mod = "mod4"
mod1 = "alt"
mod2 = "control"
home = os.path.expanduser("~")


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
    # DEFAULT
    # Most of our keybindings are in sxhkd file - except these
    # SUPER + FUNCTION KEYS
    Key([mod], "f", lazy.window.toggle_fullscreen()),
    Key([mod], "q", lazy.window.kill()),
    # SUPER + SHIFT KEYS
    Key([mod, "shift"], "q", lazy.window.kill()),
    Key([mod, "shift"], "r", lazy.restart()),
    # QTILE LAYOUT KEYS
    Key([mod], "n", lazy.layout.normalize()),
    Key([mod], "space", lazy.next_layout()),
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
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
    ),
    Key(
        [mod, "control"],
        "Right",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
    ),
    Key(
        [mod, "control"],
        "h",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
    ),
    Key(
        [mod, "control"],
        "Left",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
    ),
    Key(
        [mod, "control"],
        "k",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
    ),
    Key(
        [mod, "control"],
        "Up",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
    ),
    Key(
        [mod, "control"],
        "j",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
    ),
    Key(
        [mod, "control"],
        "Down",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
    ),
    # FLIP LAYOUT FOR MONADTALL/MONADWIDE
    Key([mod, "shift"], "f", lazy.layout.flip()),
    # FLIP LAYOUT FOR BSP
    # Key([mod, "mod2"], "k", lazy.layout.flip_up()),
    # Key([mod, "mod2"], "j", lazy.layout.flip_down()),
    # Key([mod, "mod2"], "l", lazy.layout.flip_right()),
    # Key([mod, "mod2"], "h", lazy.layout.flip_left()),
    # MOVE WINDOWS UP OR DOWN BSP LAYOUT
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left()),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right()),
    # MOVE WINDOWS UP OR DOWN MONADTALL/MONADWIDE LAYOUT
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "Left", lazy.layout.swap_left()),
    Key([mod, "shift"], "Right", lazy.layout.swap_right()),
    # TOGGLE FLOATING LAYOUT
    # Key([mod, "shift"], "space", lazy.winmod1dow.toggle_floating()),
]

groups = []

# FOR QWERTY KEYBOARDS
group_names = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "0",
]

# FOR AZERTY KEYBOARDS
# group_names = ["ampersand", "eacute", "quotedbl", "apostrophe", "parenleft", "section", "egrave", "exclam", "ccedilla", "agrave",]

# group_labels = ["1 ", "2 ", "3 ", "4 ", "5 ", "6 ", "7 ", "8 ", "9 ", "0",]
# group_labels = ["", "", "", "", "", "", "", "", "", "",]
group_labels = [
    "WWW",
    "DEV",
    "TERM",
    "FILES",
    "VID",
    "MUS",
    "NET",
    "GAMES",
    "OTHER",
    "SYS",
]

group_layouts = [
    "monadtall",
    "monadtall",
    "monadtall",
    "monadtall",
    "monadtall",
    "monadtall",
    "monadtall",
    "monadtall",
    "monadtall",
    "monadtall",
]
# group_layouts = ["monadtall", "matrix", "monadtall", "bsp", "monadtall", "matrix", "monadtall", "bsp", "monadtall", "monadtall",]

for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            layout=group_layouts[i].lower(),
            label=group_labels[i],
        )
    )

for i in groups:
    keys.extend(
        [
            # CHANGE WORKSPACES
            Key([mod], i.name, lazy.group[i.name].toscreen()),
            Key([mod], "Tab", lazy.screen.next_group()),
            Key([mod, "shift"], "Tab", lazy.screen.prev_group()),
            Key(["mod1"], "Tab", lazy.screen.next_group()),
            Key(["mod1", "shift"], "Tab", lazy.screen.prev_group()),
            # MOVE WINDOW TO SELECTED WORKSPACE 1-10 AND STAY ON WORKSPACE
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name)),
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
        "border_focus": colors[8],
        "border_normal": colors[5],
    }


layout_theme = init_layout_theme()


layouts = [
    layout.MonadTall(**layout_theme),
    # layout.Bsp(**layout_theme),
    # layout.Floating(**layout_theme),
    layout.Max(**layout_theme),
]

# WIDGETS FOR THE BAR

font = "Caskaydia Cove Nerd Font"
powerline_font = "Caskaydia Cove Nerd Font"
powerline_font_size = 54
powerline_char = ""
powerline_padding=-8


def init_widgets_defaults():
    return dict(font=font, fontsize=14, background=colors[0])


widget_defaults = init_widgets_defaults()


def init_widgets_list():
    # prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())
    widgets_list = [
        # left aligned
        widget.GroupBox(
            font=font,
            fontsize=14,
            padding_y=6,
            padding_x=5,
            borderwidth=0,
            disable_drag=True,
            highlight_method="block",
            background=colors[0],
            active=colors[9],
            inactive=colors[5],
            this_current_screen_border=colors[8],
            this_screen_border=colors[4],
        ),
        # widget.Sep(**widget_defaults),
        # widget.WindowName(
        #     font=font,
        #     fontsize=14,
        #     background=colors[0],
        #     foreground=colors[5],
        # ),
        Spacer(),
        # center aligned
        widget.Clock(
            foreground=colors[5],
            background=colors[0],
            fontsize=20,
            font=font,
            format="%H:%M",
        ),
        Spacer(),
        # right aligned
        widget.TextBox(
            text=powerline_char,
            background=colors[1],
            foreground=colors[2],
            padding=powerline_padding,
            fontsize=powerline_font_size,
            font=powerline_font,
        ),
        widget.Net(
            font=font,
            fontsize=14,
            foreground=colors[5],
            background=colors[2],
            padding=5,
            format="{down} ↓↑ {up}",
        ),
        widget.TextBox(
            text=powerline_char,
            background=colors[2],
            foreground=colors[1],
            padding=powerline_padding,
            fontsize=powerline_font_size,
            font=powerline_font,
        ),
        widget.TextBox(
            text="  ",
            background=colors[1],
            foreground=colors[5],
            padding=0,
            fontsize=18,
            font=font,
        ),
        widget.CPU(
            background=colors[1],
            foreground=colors[5],
            format=" {load_percent}%",
            fontsize=14,
            font=font,
        ),
        widget.TextBox(
            text=powerline_char,
            background=colors[1],
            foreground=colors[2],
            padding=powerline_padding,
            fontsize=powerline_font_size,
            font=powerline_font,
        ),
        widget.CurrentLayout(
            font=font, foreground=colors[5], background=colors[2], fontsize=14
        ),
        widget.TextBox(
            text=powerline_char,
            background=colors[2],
            foreground=colors[1],
            padding=powerline_padding,
            fontsize=powerline_font_size,
            font=powerline_font,
        ),
        widget.ThermalSensor(
            foreground=colors[5],
            foreground_alert=colors[3],
            background=colors[1],
            metric=True,
            padding=3,
            threshold=80,
            fontsize=14,
            font=font,
        ),
        widget.TextBox(
            text=powerline_char,
            background=colors[1],
            foreground=colors[2],
            padding=powerline_padding,
            fontsize=powerline_font_size,
            font=powerline_font,
        ),
        widget.Clock(
            foreground=colors[5],
            background=colors[2],
            fontsize=14,
            font=font,
            format="%d-%m-%Y",
        ),
        widget.TextBox(
            text=powerline_char,
            background=colors[2],
            foreground=colors[1],
            padding=powerline_padding,
            fontsize=powerline_font_size,
            font=powerline_font,
        ),
        widget.TextBox(
            text="🔊",
            background=colors[1],
            foreground=colors[5],
            padding=0,
            fontsize=16,
            mouse_callbacks={
                "Button1": lambda: qtile.cmd_spawn(
                    "sh ~/.config/qtile/scripts/change_output.sh", shell=True
                )
            },
        ),
        widget.Volume(
            background=colors[1],
            foreground=colors[5],
            font=font,
            padding=5,
            fontsize=14,
        ),
        widget.KeyboardLayout(
            background=colors[1],
            configured_keyboards=["us", "it"],
            font=font,
            foreground=colors[5],
            fontsize=14,
        ),
        widget.Systray(background=colors[1], icon_size=20, padding=4),
        widget.Sep(padding=10, background=colors[1], foreground=colors[1]),
    ]
    return widgets_list


def init_widgets_screen1():
    widgets_screen2 = init_widgets_list()
    return widgets_screen2


def init_widgets_screen2():
    widgets_screen1 = init_widgets_list()
    # remove systray on second monitor
    del widgets_screen1[-2]
    return widgets_screen1


def init_screens():
    return [
        Screen(
            top=bar.Bar(
                widgets=init_widgets_screen1(),
                size=26,
                opacity=0.7,
                margin=[5, 10, 0, 10],
            )
        ),
        Screen(
            top=bar.Bar(
                widgets=init_widgets_screen2(),
                size=26,
                opacity=0.7,
                margin=[5, 10, 0, 10],
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

#########################################################
################ assgin apps to groups ##################
#########################################################
@hook.subscribe.client_new
def assign_app_group(client):
    d = {}
    # Use xprop fo find  the value of WM_CLASS(STRING) -> First field is sufficient
    d[group_names[0]] = ["firefox", "Navigator"]
    d[group_names[1]] = ["atom", "subl", "geany", "code-oss", "code"]
    d[group_names[2]] = []
    d[group_names[3]] = ["pcmanfm", "nautilus", "dolphin", "pcmanfm-qt"]
    d[group_names[4]] = ["Vlc", "vlc", "Mpv", "mpv", "resolve"]
    d[group_names[5]] = ["spotify", "Spotify"]
    d[group_names[6]] = ["telegram-desktop", "discord", "kdeconnect-app"]
    d[group_names[7]] = ["Steam", "lutris"]
    d[group_names[8]] = []
    d[group_names[9]] = ["bpytop", "htop"]

    # get wm_class list
    wm_class = client.window.get_wm_class()
    # if it doesn't exist wait and try again
    # i.e. spotify take longer to get a wm_class
    while not wm_class:
        asyncio.sleep(0.02)
        wm_class = client.window.get_wm_class()
    # only use the first value of the wm_class
    wm_class = wm_class[0]

    for key in d:
        if wm_class in d[key]:
            client.togroup(key)
            client.group.cmd_toscreen(toggle=False)


# END
# ASSIGN APPLICATIONS TO A SPECIFIC GROUPNAME


main = None


@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser("~")
    subprocess.call([home + "/.config/qtile/scripts/autostart.sh"])


@hook.subscribe.startup
def start_always():
    # Set the cursor to something sane in X
    subprocess.Popen(["xsetroot", "-cursor_name", "left_ptr"])


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
        {"wmclass": "Arcolinux-welcome-app.py"},
        {"wmclass": "Arcolinux-tweak-tool.py"},
        {"wmclass": "Arcolinux-calamares-tool.py"},
        {"wmclass": "confirm"},
        {"wmclass": "dialog"},
        {"wmclass": "download"},
        {"wmclass": "error"},
        {"wmclass": "file_progress"},
        {"wmclass": "notification"},
        {"wmclass": "splash"},
        {"wmclass": "toolbar"},
        {"wmclass": "confirmreset"},
        {"wmclass": "makebranch"},
        {"wmclass": "maketag"},
        {"wmclass": "Arandr"},
        {"wmclass": "feh"},
        {"wmclass": "Galculator"},
        {"wmclass": "arcolinux-logout"},
        {"wmclass": "xfce4-terminal"},
        {"wname": "branchdialog"},
        {"wname": "Open File"},
        {"wname": "pinentry"},
        {"wmclass": "ssh-askpass"},
        {"wmclass": "nvidia-settings"},
        {"wmclass": "tk"},
    ],
    fullscreen_border_width=0,
    border_width=0,
)
auto_fullscreen = True

focus_on_window_activation = "focus"  # or smart

wmname = "LG3D"
