from colors import *
import os
config.load_autoconfig()

c.fonts.default_family = "Iosevka Nerd Font Mono"
c.fonts.default_size = "11pt"

c.fonts.statusbar = "11pt Iosevka Nerd Font Mono"
c.fonts.prompts = "11pt Iosevka Nerd Font Mono"
c.fonts.debug_console = "11pt Iosevka Nerd Font Mono"

c.fonts.web.family.standard = "Iosevka Nerd Font Mono"
c.fonts.web.family.fixed = "Iosevka Nerd Font Mono"
c.fonts.web.family.sans_serif = "Iosevka"
c.fonts.web.family.serif = "Iosevka"
c.completion.shrink = True

config.bind("xb", "config-cycle statusbar.show always never")
config.bind("xt", "config-cycle tabs.show always never")
config.bind("xx", "config-cycle statusbar.show always never;; config-cycle tabs.show always never")
config.bind("xd", "config-cycle colors.webpage.darkmode.enabled True False")
#config.bind(" v", "hint links spawn --userscript v.sh {hint-url}")
config.bind(",v", "hint links spawn mpv --ytdl-format=best {hint-url} &")

c.url.searchengines = {
    "DEFAULT": "http://localhost:8087/search?q={}",
    "!aw": "https://wiki.archlinux.org/index.php?search={}",
    "!yt": "https://www.youtube.com/results?search_query={}",
    "!r": "https://www.reddit.com/search/?q={}",
}

config.bind(',a', 'config-cycle content.user_stylesheets [] ["~/.config/qutebrowser/all-cites.css"]')
# Generate CSS content with colors and font
css_content = f"""
* {{
    background-color: {bg0} !important;
    color: {fg0} !important;
    font-family: "Iosevka NFM" !important;
    border-radius: 0px;
}}
a {{
    color: {accent} !important;
}}
a:visited {{
    color: {bright_purple} !important;
}}
input, textarea, select, button {{
    background-color: {bg1} !important;
    color: {fg0} !important;
    border-color: {bg2} !important;
}}
::selection {{
    background-color: {accent} !important;
    color: {bg0} !important;
}}
"""

# Write the CSS file to your config directory
css_path = os.path.join(os.path.dirname(__file__), "all-cites.css")
with open(css_path, "w") as f:
    f.write(css_content)


# colors

c.colors.webpage.bg = bg0

c.colors.completion.fg = [fg1, bright_green, accent]
c.colors.completion.odd.bg = bg0
c.colors.completion.even.bg = bg0

c.colors.completion.item.selected.bg = bg0
c.colors.completion.item.selected.fg = fg0

c.colors.completion.match.fg = accent
c.colors.completion.item.selected.border.top = accent
c.colors.completion.item.selected.border.bottom = accent

c.colors.completion.category.bg = bg0
c.colors.completion.category.fg = accent
c.colors.completion.category.border.top = bg0
c.colors.completion.category.border.bottom = bg0

c.colors.statusbar.normal.bg = bg0_hard
c.colors.statusbar.normal.fg = fg2

c.colors.statusbar.insert.bg = accent
c.colors.statusbar.insert.fg = bg0

c.colors.statusbar.command.bg = bg0
c.colors.statusbar.command.fg = fg1

c.colors.statusbar.passthrough.bg = dark_blue
c.colors.statusbar.passthrough.fg = bg0

c.colors.statusbar.private.bg = bg0_hard
c.colors.statusbar.private.fg = bright_purple

c.colors.statusbar.caret.bg = dark_purple
c.colors.statusbar.caret.fg = bg0

c.colors.statusbar.caret.selection.bg = bright_purple
c.colors.statusbar.caret.selection.fg = bg0

c.colors.statusbar.url.fg = fg4
c.colors.statusbar.url.success.https.fg = fg0
c.colors.statusbar.url.error.fg = bright_red
c.colors.statusbar.url.hover.fg = accent

# -------- Tabs --------
c.colors.tabs.bar.bg = bg1
c.colors.tabs.selected.odd.bg = bg0_hard
c.colors.tabs.selected.even.bg = bg0_hard

c.colors.tabs.odd.bg = bg2
c.colors.tabs.even.bg = bg3

c.colors.tabs.odd.fg = fg2
c.colors.tabs.even.fg = fg2


c.colors.tabs.indicator.start = accent
c.colors.tabs.indicator.stop = accent

