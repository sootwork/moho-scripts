-- **************************************************
-- Provide Moho with the name of this script object
-- **************************************************
ScriptName = "SW_1Click_Zoom_Selection"

-- **************************************************
-- General information about this script
-- **************************************************

SW_1Click_Zoom_Selection = {}

function SW_1Click_Zoom_Selection:Name() return "1Click Zoom Selection" end

function SW_1Click_Zoom_Selection:Version() return "1.00" end

function SW_1Click_Zoom_Selection:Description() return "1Click Zoom Selection" end

function SW_1Click_Zoom_Selection:Creator() return "howdy(sootwork)" end

function SW_1Click_Zoom_Selection:UILabel() return "1Click Zoom Selection" end

-- **************************************************
-- Recurring values
-- **************************************************

-- **************************************************
-- The guts of this script
-- **************************************************

function SW_1Click_Zoom_Selection:Run(moho)
    local zoomBool = false

    if moho:CountSelectedBones() > 0 then zoomBool = true end

    if moho:CountSelectedCurves() > 0 then zoomBool = true end

    if moho:CountSelectedEdges() > 0 then zoomBool = true end

    if moho:CountSelectedFilledShapes() > 0 then zoomBool = true end

    if moho:CountSelectedPoints() > 0 then zoomBool = true end

    if moho:CountSelectedShapes() > 0 then zoomBool = true end

    if zoomBool == true then moho.view:ResetView(1) end
end
