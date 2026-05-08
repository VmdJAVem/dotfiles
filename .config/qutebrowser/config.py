from colors import *
import os
from qutebrowser.api import hook
config.load_autoconfig()

c.fonts.default_family = "Iosevka Nerd Font Mono"
c.fonts.default_size = "11pt"

c.fonts.statusbar = "11pt Iosevka Nerd Font Mono"
c.fonts.prompts = "11pt Iosevka Nerd Font Mono"
c.fonts.debug_console = "11pt Iosevka Nerd Font Mono"

c.fonts.web.family.standard = "Iosevka Nerd Font Mono"
c.fonts.web.family.fixed = "Iosevka Nerd Font Mono"
c.fonts.web.family.sans_serif = "Iosevka Nerd Font Mono"
c.fonts.web.family.serif = "Iosevka Nerd Font Mono"
c.completion.shrink = True

config.bind("xb", "config-cycle statusbar.show always never")
config.bind("xt", "config-cycle tabs.show always never")
config.bind("xx", "config-cycle statusbar.show always never;; config-cycle tabs.show always never")
config.bind("xd", "config-cycle colors.webpage.darkmode.enabled True False")
#config.bind(" v", "hint links spawn --userscript v.sh {hint-url}")
config.bind("xv", "hint links spawn mpv {hint-url}")

c.url.searchengines = {
    "DEFAULT": "http://localhost:8087/search?q={}",
    "!aw": "https://wiki.archlinux.org/index.php?search={}",
    "!yt": "https://www.youtube.com/results?search_query={}",
    "!r": "https://www.reddit.com/search/?q={}",
}

c.content.user_stylesheets = ["square.css"]

config.bind('xa', "config-cycle content.user_stylesheets 'square.css' 'all-cites.css';; config-cycle colors.webpage.darkmode.enabled False True")
config.bind('xg', "set content.user_stylesheets ''")

config.set("colors.webpage.darkmode.enabled", False, "http://localhost:8087/*")
config.set("colors.webpage.darkmode.enabled", True, "https://redsails.org/*")
# Generate CSS content with colors and font
# Generate CSS content with colors, fonts, spacing and full webpage theming
css_content = f"""
:root {{
    color-scheme: dark;
}}

html,
body {{
    background: {bg0} !important;
    color: {fg0} !important;
    font-family: "Iosevka Nerd Font Mono";
}}

/* text */
p,
span,
li,
td,
th {{
    color: {fg1};
}}

h1,h2,h3,h4,h5,h6 {{
    color: {accent};
}}

/* links */
a {{
    color: {accent} !important;
}}

a:visited {{
    color: {bright_purple} !important;
}}

/* forms */
input,
textarea,
select,
button {{
    background: {bg1} !important;
    color: {fg0} !important;
    border: 1px solid {bg2} !important;
}}

/* code */
pre,
code {{
    background: {bg1} !important;
}}

pre {{
    padding: 1em !important;
    overflow-x: auto !important;
}}

/* selection */
::selection {{
    background: {accent} !important;
    color: {bg0} !important;
}}

/* scrollbar */
::-webkit-scrollbar {{
    width: 10px;
    height: 10px;
}}

::-webkit-scrollbar-track {{
    background: {bg0};
}}

::-webkit-scrollbar-thumb {{
    background: {bg2};
}}
"""
# Write the CSS file to your config directory
css_path = os.path.join(os.path.dirname(__file__), "all-cites.css")
with open(css_path, "w") as f:
    f.write(css_content)


# colors
c.colors.webpage.bg = bg0

# =========================
# Completion
# =========================
c.colors.completion.fg = [fg1, bright_green, accent]

c.colors.completion.odd.bg = bg0
c.colors.completion.even.bg = bg0

c.colors.completion.category.bg = bg0
c.colors.completion.category.fg = accent
c.colors.completion.category.border.top = bg0
c.colors.completion.category.border.bottom = bg0

c.colors.completion.item.selected.bg = bg1
c.colors.completion.item.selected.fg = fg0
c.colors.completion.item.selected.border.top = accent
c.colors.completion.item.selected.border.bottom = accent

c.colors.completion.match.fg = accent

c.colors.completion.scrollbar.bg = bg0
c.colors.completion.scrollbar.fg = bg2

# =========================
# Downloads
# =========================
c.colors.downloads.bar.bg = bg0

c.colors.downloads.start.bg = dark_blue
c.colors.downloads.start.fg = fg0

c.colors.downloads.stop.bg = bright_green
c.colors.downloads.stop.fg = bg0

c.colors.downloads.error.bg = bright_red
c.colors.downloads.error.fg = bg0

# =========================
# Hints
# =========================
c.colors.hints.bg = accent
c.colors.hints.fg = bg0

c.colors.hints.match.fg = bright_yellow

# =========================
# Keyhint widget
# =========================
c.colors.keyhint.bg = bg0
c.colors.keyhint.fg = fg2

c.colors.keyhint.suffix.fg = accent

# =========================
# Messages
# =========================
c.colors.messages.error.bg = bright_red
c.colors.messages.error.fg = bg0
c.colors.messages.error.border = bright_red

c.colors.messages.warning.bg = bright_yellow
c.colors.messages.warning.fg = bg0
c.colors.messages.warning.border = bright_yellow

c.colors.messages.info.bg = bg0
c.colors.messages.info.fg = fg1
c.colors.messages.info.border = bg0

# =========================
# Prompts
# =========================
c.colors.prompts.bg = bg0
c.colors.prompts.fg = fg1

c.colors.prompts.border = f"1px solid {bg2}"

c.colors.prompts.selected.bg = bg2

# =========================
# Statusbar
# =========================
c.colors.statusbar.normal.bg = bg0
c.colors.statusbar.normal.fg = fg2

c.colors.statusbar.insert.bg = accent
c.colors.statusbar.insert.fg = bg0

c.colors.statusbar.command.bg = bg0
c.colors.statusbar.command.fg = fg1

c.colors.statusbar.command.private.bg = bg0
c.colors.statusbar.command.private.fg = bright_purple

c.colors.statusbar.passthrough.bg = dark_blue
c.colors.statusbar.passthrough.fg = bg0

c.colors.statusbar.private.bg = bg0
c.colors.statusbar.private.fg = bright_purple

c.colors.statusbar.caret.bg = dark_purple
c.colors.statusbar.caret.fg = bg0

c.colors.statusbar.caret.selection.bg = bright_purple
c.colors.statusbar.caret.selection.fg = bg0

c.colors.statusbar.progress.bg = accent

c.colors.statusbar.url.fg = fg4
c.colors.statusbar.url.error.fg = bright_red
c.colors.statusbar.url.hover.fg = accent

c.colors.statusbar.url.success.http.fg = bright_yellow
c.colors.statusbar.url.success.https.fg = bright_green

c.colors.statusbar.url.warn.fg = bright_yellow

# =========================
# Tabs
# =========================
c.colors.tabs.bar.bg = bg1

# inactive
c.colors.tabs.odd.bg = bg2
c.colors.tabs.even.bg = bg3

c.colors.tabs.odd.fg = fg2
c.colors.tabs.even.fg = fg2

# selected
c.colors.tabs.selected.odd.bg = bg0
c.colors.tabs.selected.even.bg = bg0

c.colors.tabs.selected.odd.fg = fg0
c.colors.tabs.selected.even.fg = fg0

# pinned
c.colors.tabs.pinned.odd.bg = dark_blue
c.colors.tabs.pinned.even.bg = dark_blue

c.colors.tabs.pinned.odd.fg = fg0
c.colors.tabs.pinned.even.fg = fg0

c.colors.tabs.pinned.selected.odd.bg = accent
c.colors.tabs.pinned.selected.even.bg = accent

c.colors.tabs.pinned.selected.odd.fg = bg0
c.colors.tabs.pinned.selected.even.fg = bg0

# indicators
c.colors.tabs.indicator.start = accent
c.colors.tabs.indicator.stop = accent

c.colors.tabs.indicator.error = bright_red

c.colors.tabs.indicator.system = "none"

# =========================
# Context menu
# =========================
c.colors.contextmenu.menu.bg = bg0
c.colors.contextmenu.menu.fg = fg1

c.colors.contextmenu.disabled.bg = bg0
c.colors.contextmenu.disabled.fg = fg4

c.colors.contextmenu.selected.bg = bg2
c.colors.contextmenu.selected.fg = fg0

# =========================
# Tooltips
# =========================
c.colors.tooltip.bg = bg0
c.colors.tooltip.fg = fg1

# =========================
# Scrollbars
# =========================
c.colors.completion.scrollbar.bg = bg0
c.colors.completion.scrollbar.fg = bg2
