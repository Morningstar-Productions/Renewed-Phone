local function escape_sqli(source)
    local replacements = {
        ['"'] = '\\"',
        ["'"] = "\\'"
    }
    return source:gsub("['\"]", replacements)
end

lib.callback.register('qb-phone:server:TransferCid', function(_, NewCid, house)
    local result = MySQL.query.await('SELECT * FROM players WHERE citizenid = ?', { NewCid })
    if result[1] then
        local HouseName = house.name
        housekeyholders[HouseName] = {}
        housekeyholders[HouseName][1] = NewCid
        houseownercid[HouseName] = NewCid
        houseowneridentifier[HouseName] = result[1].license
        MySQL.update(
            'UPDATE player_houses SET citizenid = ?, keyholders = ?, identifier = ? WHERE house = ?',
            { NewCid, json.encode(housekeyholders[HouseName]), result[1].license, HouseName })
        return true
    else
        return false
    end
end)

lib.callback.register('qb-phone:server:GetPlayerHouses', function(source)
    local src = source
    local Player = exports.qbx_core:GetPlayer(src)
    local MyHouses = {}
    local result = MySQL.query.await('SELECT * FROM player_houses WHERE citizenid = ?', { Player.PlayerData.citizenid })
    if result and result[1] then
        for k, v in pairs(result) do
            MyHouses[#MyHouses + 1] = {
                name = v.house,
                keyholders = {},
                owner = Player.PlayerData.citizenid,
                price = Config.Houses[v.house].price,
                label = Config.Houses[v.house].adress,
                tier = Config.Houses[v.house].tier,
                garage = Config.Houses[v.house].garage
            }

            if v.keyholders ~= 'null' then
                v.keyholders = json.decode(v.keyholders)
                if v.keyholders then
                    for _, data in pairs(v.keyholders) do
                        local keyholderdata = MySQL.query.await('SELECT * FROM players WHERE citizenid = ?', { data })
                        if keyholderdata[1] then
                            keyholderdata[1].charinfo = json.decode(keyholderdata[1].charinfo)

                            local userKeyHolderData = {
                                charinfo = {
                                    firstname = keyholderdata[1].charinfo.firstname,
                                    lastname = keyholderdata[1].charinfo.lastname
                                },
                                citizenid = keyholderdata[1].citizenid,
                                name = keyholderdata[1].name
                            }
                            MyHouses[k].keyholders[#MyHouses[k].keyholders + 1] = userKeyHolderData
                        end
                    end
                else
                    MyHouses[k].keyholders[1] = {
                        charinfo = {
                            firstname = Player.PlayerData.charinfo.firstname,
                            lastname = Player.PlayerData.charinfo.lastname
                        },
                        citizenid = Player.PlayerData.citizenid,
                        name = Player.PlayerData.name
                    }
                end
            else
                MyHouses[k].keyholders[1] = {
                    charinfo = {
                        firstname = Player.PlayerData.charinfo.firstname,
                        lastname = Player.PlayerData.charinfo.lastname
                    },
                    citizenid = Player.PlayerData.citizenid,
                    name = Player.PlayerData.name
                }
            end
        end

        SetTimeout(100, function()
            return MyHouses
        end)
    else
        return {}
    end
end)

lib.callback.register('qb-phone:server:GetHouseKeys', function(source)
    local src = source
    local Player = exports.qbx_core:GetPlayer(src)
    local MyKeys = {}

    local result = MySQL.query.await('SELECT * FROM player_houses', {})
    for _, v in pairs(result) do
        if v.keyholders ~= 'null' then
            v.keyholders = json.decode(v.keyholders)
            for _, p in pairs(v.keyholders) do
                if p == Player.PlayerData.citizenid and (v.citizenid ~= Player.PlayerData.citizenid) then
                    MyKeys[#MyKeys + 1] = {
                        HouseData = Config.Houses[v.house]
                    }
                end
            end
        end

        if v.citizenid == Player.PlayerData.citizenid then
            MyKeys[#MyKeys + 1] = {
                HouseData = Config.Houses[v.house]
            }
        end
    end
    return MyKeys
end)

lib.callback.register('qb-phone:server:MeosGetPlayerHouses', function(_, input)
    if input then
        local search = escape_sqli(input)
        local searchData = {}
        local query = '%' .. search .. '%'
        local result = MySQL.query.await('SELECT * FROM players WHERE citizenid = ? OR charinfo LIKE ?', { search, query })
        if result[1] then
            local houses = MySQL.query.await('SELECT * FROM player_houses WHERE citizenid = ?', { result[1].citizenid })
            if houses[1] then
                for _, v in pairs(houses) do
                    searchData[#searchData + 1] = {
                        name = v.house,
                        keyholders = v.keyholders,
                        owner = v.citizenid,
                        price = Config.Houses[v.house].price,
                        label = Config.Houses[v.house].adress,
                        tier = Config.Houses[v.house].tier,
                        garage = Config.Houses[v.house].garage,
                        charinfo = json.decode(result[1].charinfo),
                        coords = {
                            x = Config.Houses[v.house].coords.enter.x,
                            y = Config.Houses[v.house].coords.enter.y,
                            z = Config.Houses[v.house].coords.enter.z
                        }
                    }
                end
                return searchData
            end
        else
            return nil
        end
    else
        return nil
    end
end)