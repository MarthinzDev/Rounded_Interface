MunitorC, MunitorL = guiGetScreenSize()
abx, aby = (MunitorC/1366), (MunitorL/768)
AbFont = dxCreateFont("files/fonts/AbFont.ttf", abx*35)
AbFont2 = dxCreateFont("files/fonts/AbFont.ttf", abx*13)

function Velocimetro()
	theVehicle = getPedOccupiedVehicle(getLocalPlayer())
	vehs = getElementSpeed(getPedOccupiedVehicle(getLocalPlayer()), "kmh")
	actualspeed = getVehicleSpeed()
	kmh = math.floor(actualspeed)
	if not theVehicle or getVehicleOccupant(theVehicle) ~= localPlayer then return true end



        dxDrawText("KM/H", abx*730, aby*820, abx*710, aby*680, tocolor(255, 255, 255, 255), 0.75, AbFont2, "center", "center", false, false, false, false, false)

        if kmh < 405 then
        	dxDrawText(kmh, abx*730, aby*770, abx*710, aby*680, tocolor(255, 255, 255, 255), 1.00, AbFont, "center", "center", false, false, false, false, false)
        end

        if (vehicleSpeed == 0) then

    else
    end
end

function getFormatNeutral()
	local neutral = "N"
	return neutral
end

function getFormatGear()
    local gear = getVehicleCurrentGear(getPedOccupiedVehicle(getLocalPlayer()))
    local rear = "R"
	local neutral = "N"
    if (gear > 0) then 
        return gear
    else
        return rear
    end
end

function getVehicleSpeed()
    if isPedInVehicle(getLocalPlayer()) then
	    local theVehicle = getPedOccupiedVehicle (getLocalPlayer())
        local vx, vy, vz = getElementVelocity (theVehicle)
        return math.sqrt(vx^2 + vy^2 + vz^2) * 165
    end
    return 0
end

function getElementSpeed(element)
	speedx, speedy, speedz = getElementVelocity (element)
	actualspeed = (speedx^2 + speedy^2 + speedz^2)^(0.5) 
	kmh = actualspeed * 180
	return math.round(kmh)
end

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end

function getVehicleRPM(vehicle)
	local vehicleRPM = 0
    if (vehicle) then  
        if (getVehicleEngineState(vehicle) == true) then
            if getVehicleCurrentGear(vehicle) > 0 then   
				vehicleRPM = math.floor(((getElementSpeed(vehicle, "kmh")/getVehicleCurrentGear(vehicle))*180) + 0.5) 
				if getElementSpeed(vehicle, "kmh") == 0 then vehicleRPM  = math.random(1500, 1650) end
                if (vehicleRPM < 650) then
                    vehicleRPM = math.random(650, 750)
                elseif (vehicleRPM >= 9800) then
                    vehicleRPM = math.random(9800, 9900)
                end
            else
                vehicleRPM = math.floor((getElementSpeed(vehicle, "kmh")*80) + 0.5)
				if getElementSpeed(vehicle, "kmh") == 0 then vehicleRPM  = math.random(1500, 1650) end
                if (vehicleRPM < 650) then
                    vehicleRPM = math.random(650, 750)
                elseif (vehicleRPM >= 9800) then
                    vehicleRPM = math.random(9800, 9900)
                end
            end
        else
            vehicleRPM = 0
        end
        return tonumber(vehicleRPM)
    else
        return 0
    end
end

function getElementSpeed(element,unit)
	if (unit == nil) then unit = 0 end
	if (isElement(element)) then
		local x,y,z = getElementVelocity(element)
		if (unit=="mph" or unit==1 or unit =='1') then
			return (x^2 + y^2 + z^2) ^ 0.5 * 100
		else
			return (x^2 + y^2 + z^2) ^ 0.5 * 180
		end
	else
		return false
	end
end

function setElementSpeed(element, unit, speed)
	if (unit == nil) then unit = 0 end
	if (speed == nil) then speed = 0 end
	speed = tonumber(speed)
	local acSpeed = getElementSpeed(element, unit)
	if (acSpeed~=false) then 
		local diff = speed/acSpeed
		local x,y,z = getElementVelocity(element)
		setElementVelocity(element,x*diff,y*diff,z*diff)
		return true
	else
		return false
	end
end

function in_array(e, t)
	for _,v in pairs(t) do
		if (v==e) then return true end
	end
	return false
end

function round2(num, idp)
  return tonumber(string.format("%." .. (idp or 0) .. "f", num))
end

function angle(vehicle)
	local vx,vy,vz = getElementVelocity(vehicle)
	local modV = math.sqrt(vx*vx + vy*vy)
	
	if not isVehicleOnGround(vehicle) then return 0,modV end
	
	local rx,ry,rz = getElementRotation(vehicle)
	local sn,cs = -math.sin(math.rad(rz)), math.cos(math.rad(rz))
	
	local cosX = (sn*vx + cs*vy)/modV
	return math.deg(math.acos(cosX))*0.5, modV
end

bindKey("c","down",function()
	triggerServerEvent( "triggerVehicleSystem", localPlayer, "lights" )
end)

bindKey("l","down",function()
	triggerServerEvent( "triggerVehicleSystem", localPlayer, "lock" )
end)

function setHud()
	addEventHandler("onClientRender", getRootElement(), Velocimetro)
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
