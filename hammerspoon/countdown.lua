Countdown = {}

Countdown.menu = hs.menubar.new()
Countdown.menu:setTitle("Countdown Timer")

Countdown.items = {
  {
    title = "End of Q3",
    timestamp = {year=2021, month=10, day=1}
  },
  {
    title = "New Year",
    timestamp = {year=2022, month=1, day=1}
  }
}

updateMenu = function()
  local items = hs.fnutils.map(Countdown.items, function(item)
    daysfrom = os.difftime(os.time(item.timestamp), os.time()) / (24 * 60 * 60) -- seconds in a day
    wholedays = math.floor(daysfrom)

    if(wholedays < 0) then
      return nil
    end

    return {
      title = item.title .. " - " .. wholedays .. "d",
      disabled = false
    }
  end)

  Countdown.menu:setMenu(items)
end

updateMenu()
Countdown.timer = hs.timer.doEvery(hs.timer.hours(6), function()
  updateMenu()
end)
