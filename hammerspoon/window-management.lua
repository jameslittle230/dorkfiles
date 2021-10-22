hs.window.animationDuration = 0

-- No margins between windows.
hs.grid.setMargins('0, 0')

local function setGridForScreens()
  -- Set screen grid depending on resolution
  for _, screen in pairs(hs.screen.allScreens()) do
    hs.grid.setGrid('12 * 12', screen)
  end
end

-- Call meta once on config load.
setGridForScreens()

-- Set screen watcher, in case you connect a new monitor, or unplug a monitor
screenWatcher = hs.screen.watcher.new(function()
  setGridForScreens()
end)

screenWatcher:start()

-- Create a handy struct to hold the current window/screen and their grids.
local function windowMeta()
  local self = {}

  self.window = hs.window.focusedWindow()
  self.screen = self.window:screen()
  self.windowGrid = hs.grid.get(self.window)
  self.screenGrid = hs.grid.getGrid(self.screen)

  return self
end

--------------------------------------
-- Configure module functions
--------------------------------------

local module = {}

-- Given a list of grid cells, this function will resize the given window
-- between them in order. If the window's size isn't listed, it'll set the
-- window to the first index.
module.rotateBetweenCells = function (meta, cells)
  local len = #cells
  for index, value in ipairs(cells) do
    if meta.windowGrid == value then
      if index == len then
        hs.grid.set(meta.window, cells[1])
      else
        hs.grid.set(meta.window, cells[index + 1])
      end
      return
    end
  end
  
  hs.grid.set(meta.window, cells[1])
end

-- Maximizes a window to fit the entire grid.
module.maximizeWindow = function ()
  local meta = windowMeta()
  hs.grid.maximizeWindow(meta.window)
end

-- Centers a window in the middle of the screen.
module.centerOnScreen = function ()
  local meta = windowMeta()
  meta.window:centerOnScreen(meta.screen)
end

module.focusWindow = function ()
  local meta = windowMeta()
  local cell = hs.geometry(0.05 * meta.screenGrid.w, 0.05 * meta.screenGrid.h, 0.9 * meta.screenGrid.w, 0.9 * meta.screenGrid.h)
  hs.grid.set(meta.window, cell, meta.screen)
end

-- Throws a window 1 screen to the left
module.throw = function ()
  local meta = windowMeta()
  meta.window:centerOnScreen(meta.screen:next())
end

-- 1. Moves a window all the way left
-- 2. Resizes it to take up the left half of the screen (grid)
module.leftHalf = function ()
  local meta = windowMeta()
  local cells = {
    hs.geometry(0, 0, 6, 12),
    hs.geometry(0, 0, 4, 12),
    hs.geometry(0, 0, 8, 12),
  }

  module.rotateBetweenCells(meta, cells)
end

-- 1. Moves a window all the way right
-- 2. Resizes it to take up the right half of the screen (grid)
module.rightHalf = function ()
  local meta = windowMeta()

  local cells = {
    hs.geometry(6, 0, 6, 12),
    hs.geometry(8, 0, 4, 12),
    hs.geometry(4, 0, 8, 12),
  }

  module.rotateBetweenCells(meta, cells)
end

-- 1. Moves a window all the way to the top
-- 2. Resizes it to take up the top half of the screen (grid)
module.topHalf = function ()
  local meta = windowMeta()

  local cells = {
    hs.geometry(0, 0, 12, 6),
    hs.geometry(0, 0, 12, 4),
    hs.geometry(0, 0, 12, 8),
  }

  module.rotateBetweenCells(meta, cells)
end

-- 1. Moves a window all the way to the bottom
-- 2. Resizes it to take up the bottom half of the screen (grid)
module.bottomHalf = function ()
  local meta = windowMeta()

  local cells = {
    hs.geometry(0, 6, 12, 6),
    hs.geometry(0, 8, 12, 4),
    hs.geometry(0, 4, 12, 8),
  }

  module.rotateBetweenCells(meta, cells)
end

-- 1. Moves a window all the way to the bottom
-- 2. Resizes it to take up the bottom half of the screen (grid)
module.topRightCorner = function ()
  local meta = windowMeta()

  local cells = {
    hs.geometry(6, 0, 6, 6),
    hs.geometry(8, 0, 4, 6),
    hs.geometry(4, 0, 8, 6),
  }

  module.rotateBetweenCells(meta, cells)
end

-- 1. Moves a window all the way to the bottom
-- 2. Resizes it to take up the bottom half of the screen (grid)
module.bottomLeftCorner = function ()
  local meta = windowMeta()

  local cells = {
    hs.geometry(0, 6, 6, 6),
    hs.geometry(0, 6, 4, 6),
    hs.geometry(0, 6, 8, 6),
  }

  module.rotateBetweenCells(meta, cells)
end

-- 1. Moves a window all the way to the bottom
-- 2. Resizes it to take up the bottom half of the screen (grid)
module.bottomRightCorner = function ()
  local meta = windowMeta()

  local cells = {
    hs.geometry(6, 6, 6, 6),
    hs.geometry(8, 6, 4, 6),
    hs.geometry(4, 6, 8, 6),
  }

  module.rotateBetweenCells(meta, cells)
end

-- 1. Moves a window all the way to the bottom
-- 2. Resizes it to take up the bottom half of the screen (grid)
module.topLeftCorner = function ()
  local meta = windowMeta()

  local cells = {
    hs.geometry(0, 0, 6, 6),
    hs.geometry(0, 0, 4, 6),
    hs.geometry(0, 0, 8, 6),
  }

  module.rotateBetweenCells(meta, cells)
end

module.streamLocation = function ()
  local meta = windowMeta()
  local cell = hs.geometry(0, 0, 1280, 720)
  meta.window:setFrameInScreenBounds(cell)
end

-- Shrinks a window's size horizontally to the left.
module.shrinkLeft = function()
  local meta = windowMeta()
  local cell = hs.geometry(meta.windowGrid.x, meta.windowGrid.y, meta.windowGrid.w - 1, meta.windowGrid.h)

  hs.grid.set(meta.window, cell, meta.screen)
end

-- Grows a window's size horizontally to the right.
module.growRight = function()
  local meta = windowMeta()
  local cell = hs.geometry(meta.windowGrid.x, meta.windowGrid.y, meta.windowGrid.w + 1, meta.windowGrid.h)

  hs.grid.set(meta.window, cell, meta.screen)
end

-- Shrinks a window's size vertically up.
module.shrinkUp = function()
  local meta = windowMeta()
  local cell = hs.geometry(meta.windowGrid.x, meta.windowGrid.y, meta.windowGrid.w, meta.windowGrid.h - 1)

  hs.grid.set(meta.window, cell, meta.screen)
end

-- Grows a window's size vertically down.
module.growDown = function()
  local meta = windowMeta()
  local cell = hs.geometry(meta.windowGrid.x, meta.windowGrid.y, meta.windowGrid.w, meta.windowGrid.h + 1)

  hs.grid.set(meta.window, cell, meta.screen)
end

module.nudgeLeft = function()
  local meta = windowMeta()
  local cell = hs.geometry(meta.windowGrid.x - 1, meta.windowGrid.y, meta.windowGrid.w, meta.windowGrid.h)

  hs.grid.set(meta.window, cell, meta.screen)
end

module.nudgeRight = function()
  local meta = windowMeta()
  local cell = hs.geometry(meta.windowGrid.x + 1, meta.windowGrid.y, meta.windowGrid.w, meta.windowGrid.h)

  hs.grid.set(meta.window, cell, meta.screen)
end

module.nudgeUp = function()
  local meta = windowMeta()
  local cell = hs.geometry(meta.windowGrid.x, meta.windowGrid.y - 1, meta.windowGrid.w, meta.windowGrid.h)

  hs.grid.set(meta.window, cell, meta.screen)
end

module.nudgeDown = function()
  local meta = windowMeta()
  local cell = hs.geometry(meta.windowGrid.x, meta.windowGrid.y + 1, meta.windowGrid.w, meta.windowGrid.h)

  hs.grid.set(meta.window, cell, meta.screen)
end

return module

