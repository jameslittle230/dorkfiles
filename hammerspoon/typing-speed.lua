TypingSpeed = {}

TypingSpeed.menu = hs.menubar.new()

TypingSpeed.count = 0
TypingSpeed.seconds = 8
TypingSpeed.timerCount = 0
TypingSpeed.data = {}

TypingSpeed.watcher = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, function(event)
    local keyPressed = hs.keycodes.map[event:getKeyCode()]

    -- if keypressed is a letter??
    TypingSpeed.count = TypingSpeed.count + 1
end)

TypingSpeed.timer = hs.timer.doEvery(1, function()
    -- https://www.speedtypingonline.com/typing-equations
    TypingSpeed.data[TypingSpeed.timerCount + 1] = TypingSpeed.count
    TypingSpeed.count = 0

    local letterCountSum = 0
    local slotsWithTypingData = 0

    for index, value in ipairs(TypingSpeed.data) do
        letterCountSum = letterCountSum + value
        if value > 0 then
            slotsWithTypingData = slotsWithTypingData + 1
        end
    end

    local wpm = (letterCountSum / 5) / (1 / 60 * hs.math.max(1, slotsWithTypingData))
    TypingSpeed.menu:setTitle(math.floor(wpm) .. " WPM")
    TypingSpeed.timerCount = TypingSpeed.timerCount + 1

    if TypingSpeed.timerCount == TypingSpeed.seconds + 1 then
        TypingSpeed.timerCount = 0
    end
end)

TypingSpeed.watcher:start()
TypingSpeed.menu:setTitle("88 WPM")

