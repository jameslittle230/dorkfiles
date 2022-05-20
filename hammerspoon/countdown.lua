Countdown = {}

Countdown.menu = hs.menubar.new()
Countdown.menu:setTitle("↓")

Countdown.items = {
  {
    title = "Dopro",
    timestamp = {year=2022, month=6, day=13}
  },
  {
    title = "H2",
    timestamp = {year=2022, month=7, day=1}
  },
  {
    title = "M30",
    timestamp = {year=2022, month=8, day=29}
  },
  {
    title = "Q3",
    timestamp = {year=2022, month=10, day=1}
  },
  {
    title = "J26",
    timestamp = {year=2022, month=11, day=23}
  },
  {
    title = "4Y",
    timestamp = {year=2023, month=08, day=05}
  },
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
