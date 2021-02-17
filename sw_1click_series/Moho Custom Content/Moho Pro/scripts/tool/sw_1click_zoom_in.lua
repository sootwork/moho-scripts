-- **************************************************
-- Provide Moho with the name of this script object
-- **************************************************
ScriptName = "SW_1Click_Zoom_In"

-- **************************************************
-- General information about this script
-- **************************************************

SW_1Click_Zoom_In = {}

function SW_1Click_Zoom_In:Name() return "1Click Zoom In" end

function SW_1Click_Zoom_In:Version() return "1.00" end

function SW_1Click_Zoom_In:Description() return "1Click Zoom In" end

function SW_1Click_Zoom_In:Creator() return "howdy(sootwork)" end

function SW_1Click_Zoom_In:UILabel() return "1Click Zoom In" end

-- **************************************************
-- Recurring values
-- **************************************************

SW_1Click_Zoom_In.scaleAry = {
    0.78, 1.56, 3.13, 6.25, 12.5, 25.0, 33.33, 50.0, 66.67, 100.0, 150.0, 200.0,
    400.0, 800.0, 1600.0, 3200.0
}

-- **************************************************
-- The guts of this script
-- **************************************************

function SW_1Click_Zoom_In:Run(moho)
    local scaleAry = self.scaleAry

    local g = moho.view:Graphics()
    local viewHeight = g:Height()
    local canvasHeight = moho.document:Height()

    local zoomNumFor100Per = canvasHeight / viewHeight
    local currentZoomNum = g:ViewZoom()
    local currentPer = currentZoomNum / zoomNumFor100Per * 100

    local roundedCurrentPer = math.floor(currentPer * 100 + 0.5) / 100

    local nearestIndex = self:GetNearestValue(scaleAry, roundedCurrentPer)
    local nearestPer = scaleAry[nearestIndex]

    -- print("currentPer: " .. currentPer)
    -- print("roundedCurrentPer: " .. roundedCurrentPer)
    -- print("nearestPer: " .. nearestPer)

    if roundedCurrentPer < scaleAry[1] then
        g:SetViewZoom(scaleAry[1] * zoomNumFor100Per / 100)
        -- print("targetZoom: " .. scaleAry[1] / 100)
        -- print("ViewZoom: " .. g:ViewZoom())
        return false
    end

    if roundedCurrentPer >= scaleAry[#scaleAry] then
        g:SetViewZoom(scaleAry[#scaleAry] * zoomNumFor100Per / 100)
        -- print("targetZoom: " .. scaleAry[#scaleAry] / 100)
        -- print("ViewZoom: " .. g:ViewZoom())
        return false
    end

    if roundedCurrentPer >= nearestPer then
        g:SetViewZoom(scaleAry[nearestIndex + 1] * zoomNumFor100Per / 100)
        -- print("targetZoom: " .. scaleAry[nearestIndex + 1] / 100)
        -- print("ViewZoom: " .. g:ViewZoom())
        return false
    end

    if roundedCurrentPer < nearestPer then
        g:SetViewZoom(scaleAry[nearestIndex] * zoomNumFor100Per / 100)
        -- print("targetZoom: " .. scaleAry[nearestIndex] / 100)
        -- print("ViewZoom: " .. g:ViewZoom())
        return false
    end
end

-- http://talavax.com/nearestvalue.html
function SW_1Click_Zoom_In:GetNearestValue(list, v)
    local i
    local num
    local minv

    if 1 > #list then return -1 end

    num = 1
    minv = math.abs(list[1] - v)

    for i = 2, #list do
        if math.abs(list[i] - v) < minv then
            num = i
            minv = math.abs(list[i] - v)
        end
    end

    return num
end
