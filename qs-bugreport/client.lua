-- Register the event to open the bug report menu
RegisterNetEvent("bugreport:openMenu")
AddEventHandler("bugreport:openMenu", function()
    local input = exports.ox_lib:inputDialog('Bug Report', {
        { 
            type = 'input', 
            label = 'Describe the bug', 
            placeholder = 'Please describe the bug...', 
            required = true 
        },
        { 
            type = 'input', 
            label = 'Steps to reproduce', 
            placeholder = 'How to reproduce the bug?', 
            required = true 
        },
        { 
            type = 'select', 
            label = 'Bug Category', 
            options = {
                {label = 'Gameplay', value = 'Gameplay', description = 'Issues related to the game mechanics'},
                {label = 'UI', value = 'UI', description = 'Issues related to user interface'},
                {label = 'Server', value = 'Server', description = 'Server-side issues like crashes or lag'},
                {label = 'Performance', value = 'Performance', description = 'Performance-related problems like frame drops'},
                {label = 'Other', value = 'Other', description = 'Any other issues not covered above'}
            },
            default = 'Gameplay', 
            required = false 
        },
        { 
            type = 'select', 
            label = 'Priority', 
            options = {
                {label = 'Low', value = 'Low', description = 'Minor issue, not urgent'},
                {label = 'Medium', value = 'Medium', description = 'Moderate issue, may affect gameplay'},
                {label = 'High', value = 'High', description = 'Critical issue, needs urgent attention'}
            },
            default = 'Medium', 
            required = false 
        },
        { 
            type = 'input', 
            label = 'Contact Info (Optional)', 
            placeholder = 'Discord/E-mail for contact...', 
            required = false 
        },
        { 
            type = 'input', 
            label = 'Reproduction Checklist', 
            placeholder = 'Step-by-step instructions...', 
            required = false 
        }
    })

    -- Check if the player entered valid data in the input dialog
    if input then
        -- Destructure the input data for convenience
        local bugDescription = input[1]
        local stepsToReproduce = input[2]
        local bugCategory = input[3] or "Unspecified Category"
        local priority = input[4] or "Medium"
        local contactInfo = input[5]
        local reproductionChecklist = input[6]
        
        -- Get the player's current coordinates
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)

        -- Ensure the bug description is provided before submitting the bug report
        if bugDescription and bugDescription ~= '' then
            -- Trigger the server event to create a bug report with the provided data
            TriggerServerEvent("bugreport:createBugReport", GetPlayerServerId(PlayerId()), bugDescription, stepsToReproduce, bugCategory, priority, contactInfo, reproductionChecklist, coords)
        else
            -- Notify the player if they haven't provided a bug description
            exports.ox_lib:notify({
                title = "Error",
                description = "You must describe the bug.",
                type = "error"
            })
        end
    else
        -- Notify the player if they canceled the report
        exports.ox_lib:notify({
            title = "Cancelled",
            description = "Bug report has been cancelled.",
            type = "error"
        })
    end
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

