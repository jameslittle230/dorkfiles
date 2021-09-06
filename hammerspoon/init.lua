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
  hs.reload()
end)

require "window-management"
require "window-hotkeys"
require "ocr-paste"
