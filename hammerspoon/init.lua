local HyperKey = hs.loadSpoon("HyperKey")

hyper = {'ctrl', 'alt', 'cmd', 'shift'}
super = {'ctrl', 'alt', 'cmd'}

hyperKey = HyperKey:new(hyper, { overlayTimeoutMs = 1000 })
superKey = HyperKey:new(super, { overlayTimeoutMs = 1000 })

function p(variable)
  print(hs.inspect.inspect(variable))
end

hyperKey:bind('h'):toFunction('Reload Hammerspoon', function()
  hs.application.launchOrFocus("Hammerspoon")
  hs.notify.show("Hammerspoon", "Configuration reloaded!", "")
  hs.reload()
end)

superKey:bind('j'):toFunction('iTerm 2', function()
  hs.application.launchOrFocus("iTerm")
end)

superKey:bind('k'):toFunction('VSCode', function()
  hs.application.launchOrFocus("Visual Studio Code")
end)

superKey:bind('l'):toFunction('Xcode', function()
  hs.application.launchOrFocus("xcode-13-3")
end)

superKey:bind('h'):toFunction('Chrome', function()
  hs.application.launchOrFocus("Google Chrome")
end)

require "gh-stars"
require "countdown"
require "window-management"
require "window-hotkeys"
require "ocr-paste"
require "md2jira"
require "typing-speed"
