GithubStars = {}

GithubStars.menu = hs.menubar.new()

update = function()
  stargazers_count = nil
  has_notif = nil

  auth_header_value = "Basic " .. hs.json.read("~/.secrets.json")["github_api_key_base64"]

  hs.http.asyncGet(
    "https://api.github.com/repos/jameslittle230/stork",
    nil,
    function(status, body, headers)
      stargazers_count = hs.json.decode(body)['stargazers_count']
    end
  )

  hs.http.asyncGet(
    "https://api.github.com/notifications",
    {
      Authorization = auth_header_value
    },
    function(status, body, headers)
      has_notif = #(hs.json.decode(body)) > 0
    end
  )

  hs.timer.waitUntil(function()
    return stargazers_count ~= nil and has_notif ~= nil
  end, function()
    GithubStars.menu:setTitle("★ " .. stargazers_count .. (has_notif and ' ♬' or ''))
    addMenu(GithubStars.menu)
  end)
end

addMenu = function(menu)
  menu:setMenu({
    {
      title = "Open Stork",
      fn = function() hs.open("https://github.com/jameslittle230/stork") end,
    },

    {
      title = "Open Stork Stars",
      fn = function() hs.open("https://github.com/jameslittle230/stork/stargazers") end
    },

    {
      title = "Open Github Notifications",
      fn = function() hs.open("https://github.com/notifications") end
    }
  })
end

update()
hs.timer.doEvery(hs.timer.minutes(15), function()
  update()
end)
