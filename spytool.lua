local Packets = require(game:GetService("ReplicatedStorage").Modules.Packets)
local oldSwing = Packets.SwingTool.send

-- Fungsi bongkar table yang udah kebal CFrame / Vector3
local function printTableStructure(tbl, indent)
    indent = indent or ""
    for k, v in pairs(tbl) do
        local typeV = type(v)
        local displayValue = tostring(v)
        
        -- Cek aman pake pcall biar ga crash kalau tipe datanya aneh
        local success, className = pcall(function() return v.ClassName end)
        if success and className then
            displayValue = v.Name .. " (" .. className .. ")"
        elseif typeV == "userdata" then
            displayValue = tostring(v) .. " (Userdata/Struct)"
        end
        
        game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
            Text = indent .. tostring(k) .. " : " .. displayValue .. " [" .. typeV .. "]",
            Color = Color3.fromRGB(255, 200, 0);
        })
        
        if typeV == "table" then
            printTableStructure(v, indent .. "   ")
        end
    end
end

-- Bégal ulang fungsi send
Packets.SwingTool.send = function(...)
    local args = {...}
    game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
        Text = "=== SWINGTOOL DETECTED ===",
        Color = Color3.fromRGB(255, 50, 50);
    })
    
    for i, arg in ipairs(args) do
        if type(arg) == "table" then
            printTableStructure(arg, "  ")
        else
            game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
                Text = " Arg ["..i.."]: " .. tostring(arg) .. " ["..type(arg).."]",
                Color = Color3.fromRGB(100, 200, 255);
            })
        end
    end
    return oldSwing(...)
end

game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
    Text = "Mata-mata v2 Aktif! Coba pukul Gold Node-nya sekali lagi, bro.",
    Color = Color3.fromRGB(0, 255, 255);
})
