ESX = nil
local scenes = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('opis2:fetch', function()
    local _source = source
    TriggerClientEvent('opis2:send', _source, scenes)
end)

function reloadOpisy()
    scenes = {}
end

reloadOpisy()
RegisterNetEvent('opis2:add', function(coords, message)
    local source = source

    table.insert(scenes, {
        message = message,
        coords = coords,
        owner = source,
        showid = "~g~["..source.."]"
    })
    TriggerClientEvent('opis2:send', -1, scenes)
    exports['hash_logs']:SendLog(source, "Dodał opis2\nKoordynaty: "..coords.."\nO treści: "..message, "opis2")
end)

RegisterNetEvent('opis2:delete', function(key)
    local source = source
    if source == scenes[key].owner then
        table.remove(scenes, key)
        TriggerClientEvent('opis2:send', -1, scenes)
        exports['hash_logs']:SendLog(source, "Usunął opis2", "opis2")
    else
        TriggerClientEvent('esx:showNotification', source, 'To nie twój opis.')
    end
end)

RegisterNetEvent('opis2:admindelete', function(key)
    local source = source
    if IsPlayerAceAllowed(source, "easyadmin.kick") then
        table.remove(scenes, key)
        TriggerClientEvent('opis2:send', -1, scenes)
        exports['hash_logs']:SendLog(source, "**[ADMIN]: "..GetPlayerName(source).."** usunął opis2", "opis2")
    else
        exports['esx_k9']:ban(source,"Admin deleteopis")
    end
end)

RegisterNetEvent('opis2:admindelete2', function(key)
    local source = source
    if IsPlayerAceAllowed(source, "easyadmin.kick") then
        reloadOpisy()
        TriggerClientEvent('opis2:send', -1, scenes)
        exports['hash_logs']:SendLog(source, "**[ADMIN]: "..GetPlayerName(source).."** usunął opisy2", "opis2")
    else
        exports['esx_k9']:ban(source,"Admin deleteopis")
    end
end)

RegisterServerEvent('cotykurwabocie')
AddEventHandler('cotykurwabocie', function()
    DropPlayer(source, "Nie rób takich opisów ok?")
end)