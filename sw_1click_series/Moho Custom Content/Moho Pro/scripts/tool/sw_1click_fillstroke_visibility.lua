-- **************************************************
-- Provide Moho with the name of this script object
-- **************************************************
ScriptName = "SW_1Click_FillStroke_Visibility"

-- **************************************************
-- General information about this script
-- **************************************************

SW_1Click_FillStroke_Visibility = {}

function SW_1Click_FillStroke_Visibility:Name() return "1Click FillStroke Visibility" end

function SW_1Click_FillStroke_Visibility:Version() return "1.00" end

function SW_1Click_FillStroke_Visibility:Description()
    return "1Click FillStroke Visibility"
end

function SW_1Click_FillStroke_Visibility:Creator() return "howdy(sootwork)" end

function SW_1Click_FillStroke_Visibility:UILabel()
    return "1Click FillStroke Visibility"
end

-- **************************************************
-- Recurring values
-- **************************************************

-- **************************************************
-- The guts of this script
-- **************************************************

function SW_1Click_FillStroke_Visibility:Run(moho) self:FillStrokeVisibility(moho) end

-- http://mohoscripting.com/modules/MOHO#Layer_display_quality
SW_1Click_FillStroke_Visibility.QUALITY_TABLE =
    {
        MOHO.LDQ_WIREFRAME, -- 1
        MOHO.LDQ_FILLS, -- 2
        MOHO.LDQ_OUTLINES, -- 3
        MOHO.LDQ_IMAGES, -- 4
        MOHO.LDQ_IMAGES_HQ, -- 5
        MOHO.LDQ_MASKING, -- 6
        MOHO.LDQ_TRANSPARENCY, -- 7
        MOHO.LDQ_ANTIALIASING, -- 8
        MOHO.LDQ_BRUSHES, -- 9
        MOHO.LDQ_SHAPE_EFFECTS, -- 10
        MOHO.LDQ_LABELS, -- 11
        MOHO.LDQ_GRAY_UNSELECTED -- 12
    }

function SW_1Click_FillStroke_Visibility:QualityFlagsToTable(qf)
    local tbl = {}
    local len = #self.QUALITY_TABLE

    for i = 0, len - 1 do
        local flagInt = self.QUALITY_TABLE[len - i]
        if qf >= flagInt then
            tbl[len - i] = 1
            qf = qf - flagInt
        else
            tbl[len - i] = 0
        end
    end
    return tbl
end

function SW_1Click_FillStroke_Visibility:FillStrokeVisibility(moho)
    local qf = moho.view:QualityFlags()
    local len = #self.QUALITY_TABLE
    local qfTbl = self:QualityFlagsToTable(qf)
    local show_or_hide

    if qfTbl[2] == 1 or qfTbl[3] == 1 then
        -- 塗りつぶし・ストローク、どちらかが表示 → 非表示
        show_or_hide = "hide"
    elseif qfTbl[2] == 1 and qfTbl[3] == 1 then
        -- 塗りつぶし・ストローク、両方表示 → 非表示
        show_or_hide = "hide"
    elseif qfTbl[2] == 0 and qfTbl[3] == 0 then
        -- 塗りつぶし・ストローク、両方非表示 → 表示
        show_or_hide = "show"
    end

    if show_or_hide == "show" then
        --  塗りつぶし・ストローク表示
        qfTbl[2] = 1
        qfTbl[3] = 1
    elseif show_or_hide == "hide" then
        --  塗りつぶし・ストローク非表示
        qfTbl[2] = 0
        qfTbl[3] = 0
    end

    local setQF = 0
    for i = 1, len - 1 do setQF = setQF + qfTbl[i] * self.QUALITY_TABLE[i] end

    moho.view:SetQualityFlags(setQF)
end

