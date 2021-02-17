-- **************************************************
-- Provide Moho with the name of this script object
-- **************************************************
ScriptName = "SW_1Click_Zoom_Reset"

-- **************************************************
-- General information about this script
-- **************************************************

SW_1Click_Zoom_Reset = {}

function SW_1Click_Zoom_Reset:Name() return "1Click Zoom Reset" end

function SW_1Click_Zoom_Reset:Version() return "1.00" end

function SW_1Click_Zoom_Reset:Description() return '1Click Zoom Reset' end

function SW_1Click_Zoom_Reset:Creator() return "howdy(sootwork)" end

function SW_1Click_Zoom_Reset:UILabel() return "1Click Zoom Reset" end

-- **************************************************
-- Recurring values
-- **************************************************

-- **************************************************
-- The guts of this script
-- **************************************************

function SW_1Click_Zoom_Reset:Run(moho) moho.view:ResetView() end
