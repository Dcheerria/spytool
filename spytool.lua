local Packets = require(game:GetService("ReplicatedStorage").Modules.Packets)
local oldSwing = Packets.SwingTool.send

-- Fungsi buat ngebongkar isi table ke chat
local function printTableStructure(tbl, indent)
    indent = indent or ""
    for k, v in pairs(tbl) do
        local typeV = type(v)
        local displayValue = tostring(v)
        if typeV == "userdata" and v.ClassName then
            displayValue = v.Name .. " (" .. v.ClassName .. ")"
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

-- Kita bégal fungsi send-nya
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
    Text = "Mata-mata SwingTool aktif! Silakan pukul Gold Node 1 kali secara manual.",
    Color = Color3.fromRGB(0, 255, 255);
})
