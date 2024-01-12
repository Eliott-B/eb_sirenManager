local function Draw2DText(x, y, text, scale)
    SetTextFont(4)
    SetTextProportional(7)
    SetTextScale(scale, scale)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

function SirenOn()
    sirenIndication = Draw2DText(0.95, 0.94, "Siren : ~g~On", 0.45)
end

function SirenOff()
    sirenIndication = Draw2DText(0.95, 0.94, "Siren : ~r~Off", 0.45)
end

function LightOff()
    sirenIndication = Draw2DText(0.95, 0.94, "Light : ~r~Off", 0.45)
end