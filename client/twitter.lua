local QBCore = exports['qb-core']:GetCoreObject()

-- Functions

local function escape_str(s)
	return s
end

local function GenerateTweetId()
    local tweetId = "TWEET-"..math.random(11111111, 99999999)
    return tweetId
end

-- NUI Callback

RegisterNUICallback('GetTweets', function(_, cb)
    local hasVPN = exports.ox_inventory:Search(1, Config.VPNItem)

    cb({
        TweetData = PhoneData.Tweets,
        hasVPN = hasVPN,
    })
end)

RegisterNUICallback('PostNewTweet', function(data, cb)

    local URL

    if data.url ~= "" and string.match(data.url, '[a-z]*://[^ >,;]*') then
        URL = data.url
    else
        URL = ""
    end

    local TweetMessage = {
        firstName = PhoneData.PlayerData.charinfo.firstname,
        lastName = PhoneData.PlayerData.charinfo.lastname,
        citizenid = PhoneData.PlayerData.citizenid,
        message = escape_str(data.Message):gsub("[%<>\"()\'$]",""),
        time = data.Date,
        tweetId = GenerateTweetId(),
        type = data.type,
        url = URL,
        showAnonymous = data.anonymous
    }

    TriggerServerEvent('Renewed-Phone:server:UpdateTweets', TweetMessage)
    cb("ok")
end)

RegisterNUICallback('DeleteTweet',function(data)
    TriggerServerEvent('Renewed-Phone:server:DeleteTweet', data.id)
end)

RegisterNUICallback('FlagTweet',function(data, cb)
    lib.notify({ description = data.name..' was reported for saying '..data.message, type = "error" })
    cb('ok')
end)

-- Events

RegisterNetEvent('Renewed-Phone:client:UpdateTweets', function(src, Tweets, delete)
    if not PhoneData or not FullyLoaded then return end
    PhoneData.Tweets = Tweets
    local MyPlayerId = PlayerData.source or -1


    if delete and src == MyPlayerId then
        SendNUIMessage({
            action = "PhoneNotification",
            PhoneNotify = {
                title = "Twitter",
                text = "Tweet deleted!",
                icon = "fab fa-twitter",
                color = "#1DA1F2",
                timeout = 1000,
            },
        })
    end

    local hasVPN = exports.ox_inventory:Search(1, Config.VPNItem)

    SendNUIMessage({
        action = "UpdateTweets",
        Tweets = PhoneData.Tweets,
        hasVPN = hasVPN,
    })

    if delete then return end

    local NewTweetData = Tweets[#Tweets]
    local newFirst, newLast = NewTweetData.firstName:gsub("[%<>\"()\'$]",""), NewTweetData.lastName:gsub("[%<>\"()\' $]","")


    if not delete and src == MyPlayerId then return end

    if not delete then
        SendNUIMessage({
            action = "PhoneNotification",
            PhoneNotify = {
                title = "@"..newFirst.." "..newLast,
                text = NewTweetData.message:gsub("[%<>\"()\'$]",""),
                icon = "fab fa-twitter",
                color = "#1DA1F2",
            },
        })
    end
end)