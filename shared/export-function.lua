return function (name, cb)
    AddEventHandler(string.format('__cfx_export_qb-phone_%s', name), function(setCB)
        setCB(cb)
    end)
end