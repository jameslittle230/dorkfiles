-- window-management.lua provides all the interesting functions we need to
-- bind these hotkeys
local wm = require('window-management')

superKey
  :bind('s'):toFunction('Center', wm.centerOnScreen)
  :bind('r'):toFunction('Maximize', wm.maximizeWindow)
  :bind('f'):toFunction('Focus', wm.focusWindow)
  :bind('b'):toFunction('Focus vertically', wm.focusWindowVertical)
  :bind('a'):toFunction('Left half', wm.leftHalf)
  :bind('x'):toFunction('Bottom half', wm.bottomHalf)
  :bind('w'):toFunction('Top half', wm.topHalf)
  :bind('d'):toFunction('Right half', wm.rightHalf)
  :bind('q'):toFunction('Top left corner', wm.topLeftCorner)
  :bind('e'):toFunction('Top right corner', wm.topRightCorner)
  :bind('z'):toFunction('Bottom left corner', wm.bottomLeftCorner)
  :bind('c'):toFunction('Bottom right corner', wm.bottomRightCorner)
  :bind('n'):toFunction('1080p', wm.streamLocation)
  :bind('v'):toFunction('Next screen', wm.throw)