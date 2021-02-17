-- **************************************************
-- Provide Moho with the name of this script object
-- **************************************************
ScriptName = "SW_1Click_Preview"

-- **************************************************
-- General information about this script
-- **************************************************

SW_1Click_Preview = {}

function SW_1Click_Preview:Name() return "1Click Preview" end

function SW_1Click_Preview:Version() return "1.00" end

function SW_1Click_Preview:Description() return '1Click Preview' end

function SW_1Click_Preview:Creator() return "howdy(sootwork)" end

function SW_1Click_Preview:UILabel() return "1Click Preview" end

-- **************************************************
-- Recurring values
-- **************************************************

-- **************************************************
-- The guts of this script
-- **************************************************

function SW_1Click_Preview:Run(moho) moho:FileRender() end
