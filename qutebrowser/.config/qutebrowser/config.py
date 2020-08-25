import os

c.auto_save.session = True
c.content.autoplay = False
c.content.canvas_reading = False
c.content.cookies.accept = 'no-3rdparty'
c.content.webgl = False
c.content.webrtc_ip_handling_policy = 'default-public-interface-only'
c.session.lazy_restore = True
c.tabs.background = True
c.tabs.position = 'left'
# c.window.hide_decoration = False
c.completion.web_history.max_items = 10000

c.colors.webpage.darkmode.enabled = True

config.unbind("co")
config.bind("xjt", "set content.javascript.enabled true")
config.bind("xjf", "set content.javascript.enabled false")

c.content.javascript.enabled = False
js_whitelist = [
    "*://localhost/*",
    "*://127.0.0.1/*",
    "*://duckduckgo.com/*",
    "*://startpage.com/*",
    "*://github.com/*",
    "*://news.ycombinator.com/*",
]
private_whitelist = os.path.expanduser("~/.config/qutebrowser/private-whitelist")
if os.path.exists(private_whitelist):
    with open(private_whitelist) as f:
        js_whitelist += filter(lambda l: bool(l), f.read().split("\n"))

for site in js_whitelist:
    with config.pattern(site) as p:
        p.content.javascript.enabled = True
