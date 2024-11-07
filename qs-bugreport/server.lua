local bugReports = {}
local bugReportCounter = 0

-- Log errors to console
function logError(message, code)
    print(string.format("DEV LOG", message, code))
end

-- Command to trigger the bug report menu
RegisterCommand("bugreport", function(source)
    TriggerClientEvent("bugreport:openMenu", source)
end)

-- Event to create the bug report
RegisterNetEvent("bugreport:createBugReport")
AddEventHandler("bugreport:createBugReport", function(playerId, description, steps, category, priority, contactInfo, checklist, coords)
    local playerName = GetPlayerName(playerId)
    bugReportCounter = bugReportCounter + 1
    local reportId = bugReportCounter

    -- Store bug report data in a table
    bugReports[reportId] = {
        playerId = playerId,
        description = description,
        steps = steps,
        category = category,
        priority = priority,
        contactInfo = contactInfo,
        checklist = checklist,
        coords = coords,
        reportedAt = os.time(),
    }

    -- Notify admins about the new bug report
    for _, teamPlayerId in ipairs(GetPlayers()) do
        if IsPlayerAceAllowed(teamPlayerId, "bugreport.notify") then
            TriggerClientEvent("ox_lib:notify", teamPlayerId, {
                title = "New Bug Report",
                description = string.format("Player %s [%d] reported a bug: %s\nPriority: %s\nCategory: %s\nReport ID: %d", playerName, playerId, description, priority, category, reportId),
                type = "info",
                duration = 20000,
                position = "center-right"
            })
        end
    end

    -- Send Discord log with Bug ID included
    sendDiscordLog("New Bug Report", reportId, {
        title = "Bug Report #" .. reportId,
        description = description,
        stepsToReproduce = steps,
        category = category,
        priority = priority,
        contactInfo = contactInfo or "Not provided",
        coords = coords,
    })

    -- Send confirmation message to the player who submitted the bug report
    TriggerClientEvent("ox_lib:notify", playerId, {
        title = "Bug Report Submitted",
        description = string.format("Your bug report has been successfully submitted. Report ID: %d", reportId),
        type = "success",
        duration = 5000,
        position = "center-right"
    })
end)

-- Function to send a Discord log with improved embed design
function sendDiscordLog(title, reportId, data)
    local coordsFormatted = "Not provided" -- Default value for coordinates if they are not passed
    if data.coords then
        coordsFormatted = string.format("X: %.2f, Y: %.2f, Z: %.2f", data.coords.x or 0.0, data.coords.y or 0.0, data.coords.z or 0.0)
    end

    local embed = {
        {
            ["title"] = title,
            ["description"] = data.description,
            ["color"] = 3447003, -- Custom color (can be changed)
            ["footer"] = { ["text"] = "Bug Report System | Developed by luca_112" },
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ"), -- Timestamp for when the report was made
            ["fields"] = {
                {
                    ["name"] = "Bug Report ID",
                    ["value"] = reportId,
                    ["inline"] = true
                },
                {
                    ["name"] = "Category",
                    ["value"] = data.category,
                    ["inline"] = true
                },
                {
                    ["name"] = "Priority",
                    ["value"] = data.priority,
                    ["inline"] = true
                },
                {
                    ["name"] = "Contact Info",
                    ["value"] = data.contactInfo or "Not provided",
                    ["inline"] = true
                },
                {
                    ["name"] = "Coordinates",
                    ["value"] = coordsFormatted,
                    ["inline"] = false
                }
            }
        }
    }
    PerformHttpRequest(Config.WebhookURL, function(err, text, headers)
        if err ~= 200 then
            logError("Error sending Discord message: " .. err, -1)
        else
            print("Discord log sent successfully.")
        end
    end, "POST", json.encode({ embeds = embed }), { ["Content-Type"] = "application/json" })
end

-- Table to hold the bug reports (this can be expanded to be more sophisticated, like a database or a file)
bugReports = {}
