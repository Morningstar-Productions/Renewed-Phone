Renewed-Phone exports

# Crypto (Server side)

```

exports['Renewed-Phone']:RemoveCrypto(src, type, amount)

exports['Renewed-Phone']:hasEnough(src, type, amount)

exports['Renewed-Phone']:AddCrypto(src, type, amount)

```

# Employment (Server side)

```

exports['Renewed-Phone']:hireUser(Job, CID, grade)

exports['Renewed-Phone']:fireUser(Job, CID)

```

# Groups (Server Side)
```

exports['Renewed-Phone']:NotifyGroup(group, msg, type)

exports['Renewed-Phone']:pNotifyGroup(group, header, msg, icon, colour, length)

exports['Renewed-Phone']:CreateBlipForGroup(groupID, name, data)

exports['Renewed-Phone']:RemoveBlipForGroup(groupID, name)

exports['Renewed-Phone']:GetGroupByMembers(src)

exports['Renewed-Phone']:getGroupMembers(groupID)

exports['Renewed-Phone']:getGroupSize(groupID)

exports['Renewed-Phone']:GetGroupLeader(groupID)

exports['Renewed-Phone']:DestroyGroup(groupID)

exports['Renewed-Phone']:isGroupLeader(src, groupID)

--------------------------------------------------

exports['Renewed-Phone']:setJobStatus(groupID, status, stages)

exports['Renewed-Phone']:getJobStatus(groupID)

exports['Renewed-Phone']:resetJobStatus(groupID)

--------------------------------------------------

exports['Renewed-Phone']:isGroupTemp(groupID)

exports['Renewed-Phone']:CreateGroup(src, name, password)

```

# Notifications (Client side)

```

exports['Renewed-Phone']:PhoneNotification(title, text, icon, color, timeout, accept, deny)

```

# Twitter (Server side)

```

local function escape_str(s)
	return s
end

local TweetData = {
    firstName = PhoneData.PlayerData.charinfo.firstname,
    lastName = PhoneData.PlayerData.charinfo.lastname,
    citizenid = PhoneData.PlayerData.citizenid,
    message = escape_str(data.Message):gsub("[%<>\"()\'$]",""),
    time = data.Date,
    tweetId = "TWEET-"..math.random(11111111, 99999999),
    type = data.type,
    url = URL
}

exports['Renewed-Phone']:AddNewTweet(TweetData)

```
