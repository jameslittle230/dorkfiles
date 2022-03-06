GithubStars = {}

GithubStars.menu = hs.menubar.new()

update = function()
  hs.http.asyncGet(
    "https://api.jameslittle.me/github/stork-stars",
    nil,
    function(status, body, headers)
      stargazers_count = hs.json.decode(body)['stargazers']
      has_notif = hs.json.decode(body)['has_notif']
      GithubStars.menu:setTitle("★ " .. stargazers_count .. (has_notif and ' ♬' or ''))
      addMenu(GithubStars.menu)
    end
  )
end

addMenu = function(menu)

  menu:setMenu({  
    {
      title = "Open Stork",
      fn = function() hs.execute("open https://github.com/jameslittle230/stork") end,
    },

    {
      title = "Open Stork Stars",
      fn = function() hs.execute("open https://github.com/jameslittle230/stork/stargazers") end
    },

    {
      title = "Open Github Notifications",
      fn = function() hs.execute("open https://github.com/notifications") end
    },

    {
      title = "Last updated " .. os.date("%c")
    }
  })
end

update()
GithubStars.timer = hs.timer.doEvery(hs.timer.hours(4), function()
  update()
end)
