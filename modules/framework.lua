local Renewed = exports['Renewed-Lib']:getLib()

return {
    addMoney = function(source, amount, mType, reason)
        if not source or not amount or not mType then return false end

        return Renewed.addMoney(source, amount, mType, reason)
    end,
    removeMoney = function(source, amount, mType, reason)
        if not source or not amount or not mType then return false end

        return Renewed.removeMoney(source, amount, mType, reason)
    end,
    getCharId = function(source)
        if not source then return false end
        return Renewed.getCharId(source)
    end,
    getCharName = function(source)
        if not source then return false end

        return Renewed.getCharName(source)
    end,
    getCharNameById = function(id)
        if not id then return false end

        return Renewed.getCharNameById(id)
    end,
    getMoney = function(source, mType, all)
        return Renewed.getMoney(source, mType, all)
    end,
    getGroups = function(source)
        return Renewed.getGroups(source)
    end,
    isGroupAuth = function(group, grade)
        return Renewed.isGroupAuth(group, grade)
    end,
    init = Config.Framework == 'qb' and require('modules.framework.qb').initFramework or Config.Framework == 'esx' and require('modules.framework.esx').initFramework or function()
        print('UNKNOWN FRAMEWORK')
    end
}