local screenW, screenH = guiGetScreenSize()
local x, y = screenW/1366, screenH/768

local font = dxCreateFont("files/fonts/Tomorrow-Regular.ttf", y*12)
local font2 = dxCreateFont("files/fonts/Tomorrow-Regular.ttf", y*9)

local falando = true
----[Interpolate_Hud]----

----[Vida]
VidaAnterior = getElementHealth(localPlayer)
tick = getTickCount()

VidaComecar = VidaAnterior
VidaTerminar = VidaAnterior

----[Colete]
ColeteAnterior = getPedArmor(localPlayer)
tick2 = getTickCount()

ColeteComecar = ColeteAnterior
ColeteTerminar = ColeteAnterior

--[Sede]
SedeAnterior = getElementData(localPlayer, "AirNewSCR_Sede") or 0
tick3 = getTickCount()

SedeComecar = SedeAnterior 
SedeTerminar = SedeAnterior

--[Fome]
FomeAnterior = getElementData(localPlayer, "AirNewSCR_Fome") or 0
tick4 = getTickCount()

FomeComecar = FomeAnterior
FomeTerminar = FomeAnterior

--[Vida Carro]
VidaCarroAnterior = math.floor(getElementHealth ( getLocalPlayer() )/10)
tick5 = getTickCount()

CarroVidaComecar = VidaCarroAnterior
CarroVidaTerminar = VidaCarroAnterior
--------------------------


addEventHandler("onClientRender", getRootElement(), function()
    local vida = getElementHealth(localPlayer)
    local colete = getPlayerArmor(localPlayer)
    local fome = getElementData(localPlayer, "AirNewSCR_Fome") or 0
    local sede = getElementData(localPlayer, "AirNewSCR_Sede") or 0
    VidaNova = getElementHealth(localPlayer)
    if VidaAnterior ~= VidaNova then
        VidaComecar = VidaAnterior
        VidaTerminar = VidaNova
        VidaAnterior = VidaNova
        tick = getTickCount()
    end
    ColeteNovo = getPedArmor(localPlayer)
    if ColeteAnterior ~= ColeteNovo then
        ColeteComecar = ColeteAnterior
        ColeteTerminar = ColeteNovo
        ColeteAnterior = ColeteNovo
        tick2 = getTickCount()
    end
    SedeNova = getElementData(localPlayer, "AirNewSCR_Sede") or 0
    if SedeAnterior ~= SedeNova then
        SedeComecar = SedeAnterior
        SedeTerminar = SedeNova
        SedeAnterior = SedeNova
        tick3 = getTickCount()
    end
    FomeNova = getElementData(localPlayer, "AirNewSCR_Fome") or 0
    if FomeAnterior ~= FomeNova then
        FomeComecar = FomeAnterior
        FomeTerminar = FomeNova
        FomeAnterior = FomeNova
        tick4 = getTickCount()
    end
    local VidaIntepolate = interpolateBetween(VidaComecar, 0, 0, VidaTerminar, 0, 0, (getTickCount()-tick) /1500, "Linear")
    local ColeteIntepolate = interpolateBetween(ColeteComecar, 0, 0, ColeteTerminar, 0, 0, (getTickCount()-tick2) /1500, "Linear")
    local SedeInterpolate = interpolateBetween(SedeComecar, 0, 0, SedeTerminar, 0, 0, (getTickCount()-tick3) /1500, "Linear")
    local FomeInterpolate = interpolateBetween(FomeComecar, 0, 0, FomeTerminar, 0, 0, (getTickCount()-tick4) /1500, "Linear")
    local x1, y1, z1 = getElementPosition(localPlayer)
    local street = getZoneName ( x1, y1, z1, true )
    local timehour, timeminute = getTime()
    local direction = getZoneName ( x1, y1, z1, false )

        dxDrawRoundedRectangle(x*1293, y*31, x*59, y*26, tocolor(1, 2, 2, 255), 7)
        dxDrawRoundedRectangle(x*1153, y*31, x*132, y*26, tocolor(1, 2, 2, 255), 7)
        dxDrawRoundedRectangle(x*1064, y*31, x*81, y*26, tocolor(1, 2, 2, 255), 7)
        dxDrawText("190.00MHZ", x*1080, y*37, x*40, y*8, tocolor(254, 255, 255, 255), x*0.5, font, "left", "top", false, false, false, true, false)
        dxDrawText(street, x*1174, y*32, x*102, y*11, tocolor(254, 255, 255, 255), x*0.8, font, "left", "top", false, false, false, true, false)
        dxDrawText(timehour..":"..timeminute.."", x*1306, y*33, x*40, y*8, tocolor(254, 255, 255, 255), x*0.7, font, "left", "top", false, false, false, true, false)
        dxDrawRectangle(x*1293, y*36, x*1, y*16, tocolor(77, 78, 255, 255), false)
        dxDrawRectangle(x*1153, y*36, x*1, y*16, tocolor(77, 78, 255, 255), false)
        dxDrawRectangle(x*1064, y*36, x*1, y*16, tocolor(77, 78, 255, 255), false)
        --Colete c/Colete
        hou_circle(x*1327, y*319, x*34, y*34, tocolor(29, 28, 31, 255), 360, 360, 20)
        hou_circle(x*1327, y*319, x*34, y*34, tocolor(47, 48, 50, 125), 0, 360, 4)
        hou_circle(x*1327, y*319, x*34, y*34, tocolor(77, 77, 255, 255), 0, 360/100 * ColeteIntepolate, 4)
        dxDrawImage(x*1339, y*331, x*9, y*11, "files/gfx/colete.png")
        --Vida c/Colete
        hou_circle(x*1327, y*278, x*34, y*34, tocolor(29, 28, 31, 255), 360, 360, 20)
        hou_circle(x*1327, y*278, x*34, y*34, tocolor(47, 48, 50, 125), 0, 360, 4)
        hou_circle(x*1327, y*278, x*34, y*34, tocolor(77, 77, 255, 255), 0, 360/100 * VidaIntepolate, 4)
        dxDrawImage(x*1338, y*290, x*11, y*9.5, "files/gfx/vida.png")
    if colete <= 0 then
        -- Vida s/Colete
        hou_circle(x*1198, y*705, x*34, y*34, tocolor(62, 62, 62, 255), 360, 360, 20)
        hou_circle(x*1198, y*705, x*34, y*34, tocolor(56, 211, 59, 125), 0, 360, 4)
        hou_circle(x*1198, y*705, x*34, y*34, tocolor(56, 211, 59, 255), 0, 360/100 * VidaIntepolate, 4)
        dxDrawImage(x*1205, y*712, x*20, y*20, "files/gfx/vida.png")
    end
    hou_circle(x*1327 , y*441, x*34, y*34, tocolor(29, 28, 31, 255), 360, 360, 20)
    hou_circle(x*1327, y*441, x*34, y*34, tocolor(47, 48, 50, 255), 0, 360, 4)
    if falando then
        tick_voice = getTickCount ()
    else
        hou_circle(x*1327, y*441, x*34, y*34, tocolor(47, 48, 50, 255), 0, 0, 4)
    end

    if tick_voice then
        local rotation = interpolateBetween (0, 0, 0, 360, 0, 0, (getTickCount () - tick_voice) / 1500, "Linear")
        hou_circle(x*1327, y*441, x*34, y*34, tocolor(77,77,255,255), 0, rotation, 4)
    end
    dxDrawImage(x*1334, y*447, x*21, y*21, "files/gfx/mic.png")
    hou_circle(x*1327, y*400, x*34, y*34, tocolor(29, 28, 31, 255), 360, 360, 20)
    hou_circle(x*1327, y*400, x*34, y*34, tocolor(47, 48, 50, 125), 0, 360, 4)
    hou_circle(x*1327, y*400, x*34, y*34, tocolor(77, 77, 255, 255), 0, 360/ 100 * SedeInterpolate, 4)
    dxDrawImage(x*1340, y*410, x*9, y*12.33, "files/gfx/sede.png")
    hou_circle(x*1327, y*360, x*34, y*34, tocolor(29, 28, 31, 255), 360, 360, 20)
    hou_circle(x*1327, y*360, x*34, y*34, tocolor(47, 48, 50, 125), 0, 360, 4)
    hou_circle(x*1327, y*360, x*34, y*34, tocolor(77, 77, 255, 255), 0, 360/ 100 * FomeInterpolate, 4)
    dxDrawImage(x*1338, y*372, x*11, y*10, "files/gfx/fome.png")
end)





function hou_circle( x, y, width, height, color, angleStart, angleSweep, borderWidth )
	height = height or width
	color = color or tocolor(255,255,255)
	borderWidth = borderWidth or 1e9
	angleStart = angleStart or 0
	angleSweep = angleSweep or 360 - angleStart
	if ( angleSweep < 360 ) then
		angleEnd = math.fmod( angleStart + angleSweep, 360 ) + 0
	else
		angleStart = 0
		angleEnd = 360
	end
	if not circleShader then
		circleShader = dxCreateShader ( "files/shader/shader.fx" )
	end
	dxSetShaderValue ( circleShader, "sCircleWidthInPixel", width );
	dxSetShaderValue ( circleShader, "sCircleHeightInPixel", height );
	dxSetShaderValue ( circleShader, "sBorderWidthInPixel", borderWidth );
	dxSetShaderValue ( circleShader, "sAngleStart", math.rad( angleStart ) - math.pi );
	dxSetShaderValue ( circleShader, "sAngleEnd", math.rad( angleEnd ) - math.pi );
	dxDrawImage( x, y, width, height, circleShader, 0, 0, 0, color )
end

function setHud()
    setPlayerHudComponentVisible("armour", false)
    setPlayerHudComponentVisible("wanted", false)
    setPlayerHudComponentVisible("weapon", false)
    setPlayerHudComponentVisible("money", false)
    setPlayerHudComponentVisible("health", false)
    setPlayerHudComponentVisible("clock", false)
    setPlayerHudComponentVisible("breath", false)
    setPlayerHudComponentVisible("ammo", false)
  
  end
  addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), setHud)
  
  function removeHud()
    setPlayerHudComponentVisible("armour", true)
    setPlayerHudComponentVisible("wanted", true)
    setPlayerHudComponentVisible("weapon", true)
    setPlayerHudComponentVisible("money", true)
    setPlayerHudComponentVisible("health", true)
    setPlayerHudComponentVisible("clock", true)
    setPlayerHudComponentVisible("breath", true)
    setPlayerHudComponentVisible("ammo", true)
  end
  addEventHandler("onClientResourceStop", getResourceRootElement(getThisResource()), removeHud)


  function getElementSpeed(element,unit)
    if (unit == nil) then unit = 0 end
    if (isElement(element)) then
        local x,y,z = getElementVelocity(element)
        if (unit=="mph" or unit==1 or unit =='1') then
            return math.floor((x^2 + y^2 + z^2) ^ 0.49 * 100)
        else
            return math.floor((x^2 + y^2 + z^2) ^ 0.49 * 100 * 1.609344)
        end
    else
        return false
    end
end

addEventHandler ("onClientPlayerVoiceStart", getRootElement (), function ()
    if (source and isElement(source) and getElementType(source) == "player") and localPlayer == source then
        if falando then
            falando = false
        end
    end
end)

addEventHandler ("onClientPlayerVoiceStop", getRootElement (), function ()
    if not falando then
        falando = true
    end
end)

function dxDrawRoundedRectangle(x, y, rx, ry, color, radius)
    rx = rx - radius * 2
    ry = ry - radius * 2
    x = x + radius
    y = y + radius
    if (rx >= 0) and (ry >= 0) then
        dxDrawRectangle(x, y, rx, ry, color)
        dxDrawRectangle(x, y - radius, rx, radius, color)
        dxDrawRectangle(x, y + ry, rx, radius, color)
        dxDrawRectangle(x - radius, y, radius, ry, color)
        dxDrawRectangle(x + rx, y, radius, ry, color)
        dxDrawCircle(x, y, radius, 180, 270, color, color, 7)
        dxDrawCircle(x + rx, y, radius, 270, 360, color, color, 7)
        dxDrawCircle(x + rx, y + ry, radius, 0, 90, color, color, 7)
        dxDrawCircle(x, y + ry, radius, 90, 180, color, color, 7)
    end
end