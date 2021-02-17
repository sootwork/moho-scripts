-- **************************************************
-- Provide Moho with the name of this script object
-- **************************************************
ScriptName = "SW_1Click_Zoom_x1"

-- **************************************************
-- General information about this script
-- **************************************************

SW_1Click_Zoom_x1 = {}

function SW_1Click_Zoom_x1:Name() return "1Click Zoom x1" end

function SW_1Click_Zoom_x1:Version() return "1.00" end

function SW_1Click_Zoom_x1:Description() return "1Click Zoom x1" end

function SW_1Click_Zoom_x1:Creator() return "howdy(sootwork)" end

function SW_1Click_Zoom_x1:UILabel() return "1Click Zoom x1" end

-- **************************************************
-- Recurring values
-- **************************************************

-- **************************************************
-- The guts of this script
-- **************************************************

function SW_1Click_Zoom_x1:Run(moho)
    local g = moho.view:Graphics()
    local viewHeight = g:Height()
    local canvasHeight = moho.document:Height()
    g:SetViewZoom(canvasHeight / viewHeight)
end
