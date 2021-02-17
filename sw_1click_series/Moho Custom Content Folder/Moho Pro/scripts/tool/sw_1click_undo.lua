-- **************************************************
-- Provide Moho with the name of this script object
-- **************************************************
ScriptName = "SW_1Click_Undo"

-- **************************************************
-- General information about this script
-- **************************************************

SW_1Click_Undo = {}

function SW_1Click_Undo:Name() return "1Click Undo" end

function SW_1Click_Undo:Version() return "1.00" end

function SW_1Click_Undo:Description() return "1Click Undo" end

function SW_1Click_Undo:Creator() return "howdy(sootwork)" end

function SW_1Click_Undo:UILabel() return "1Click Undo" end

-- **************************************************
-- Recurring values
-- **************************************************

-- **************************************************
-- The guts of this script
-- **************************************************

function SW_1Click_Undo:Run(moho) moho.document:Undo() end
