local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

-- Fungsi aman buat nge-print isi table ke chat
local function dump(tbl, indent)
    indent = indent or "  "
    for k, v in pairs(tbl) do
        local display = tostring(v)
        if type(v) == "userdata" then
            display = v.ClassName and (v.Name .. " (" .. v.ClassName .. ")") or tostring(v)
        end
        pcall(function()
            StarterGui:SetCore("ChatMakeSystemMessage", {
                Text = indent .. tostring(k) .. " : " .. display,
                Color = Color3.fromRGB(255, 215, 0)
            })
        end)
        if type(v) == "table" then
            dump(v, indent .. "   ")
        end
    end
end

-- Cari modul Packets langsung dari memory
local Packets = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Packets"))

if Packets and Packets.SwingTool and Packets.SwingTool.send then
    local originalSend = Packets.SwingTool.send
    
    Packets.SwingTool.send = function(...)
        local args = {...}
        pcall(function()
            StarterGui:SetCore("ChatMakeSystemMessage", {
                Text = "🎯 SWINGTOOL NYANGKUT! DAFTAR ARGUMEN:",
                Color = Color3.fromRGB(0, 255, 255)
            })
        end)
        
        for i, arg in ipairs(args) do
            if type(arg) == "table" then
                dump(arg)
            else
                pcall(function()
                    StarterGui:SetCore("ChatMakeSystemMessage", {
                        Text = "  [" .. i .. "] " .. tostring(arg) .. " (" .. type(arg) .. ")",
                        Color = Color3.fromRGB(100, 200, 255)
                    })
                end)
            end
        end
        return originalSend(...)
    end
    
    StarterGui:SetCore("ChatMakeSystemMessage", {
        Text = "🟢 Sistem bégal v3 sukses terpasang! Silakan ayunkan alat lu, bro.",
        Color = Color3.fromRGB(0, 255, 128)
    })
else
    StarterStorage:SetCore("ChatMakeSystemMessage", {
        Text = "❌ Gagal nemu struktur Packets.SwingTool.send",
        Color = Color3.fromRGB(255, 80, 80)
    })
end
