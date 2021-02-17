-- **************************************************
-- Provide Moho with the name of this script object
-- **************************************************
ScriptName = "SW_1Click_Redo"

-- **************************************************
-- General information about this script
-- **************************************************

SW_1Click_Redo = {}

function SW_1Click_Redo:Name() return "1Click Redo" end

function SW_1Click_Redo:Version() return "1.00" end

function SW_1Click_Redo:Description() return '1Click Redo' end

function SW_1Click_Redo:Creator() return "howdy(sootwork)" end

function SW_1Click_Redo:UILabel() return "1Click Redo" end

-- **************************************************
-- Recurring values
-- **************************************************

-- **************************************************
-- The guts of this script
-- **************************************************

function SW_1Click_Redo:Run(moho) moho.document:Redo() end
