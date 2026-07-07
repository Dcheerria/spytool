local Packets = require(game:GetService("ReplicatedStorage").Modules.Packets)
for namaPaket, _ in pairs(Packets) do
    game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
        Text = "Paket: " .. tostring(namaPaket);
        Color = Color3.fromRGB(0, 255, 128);
    })
end
