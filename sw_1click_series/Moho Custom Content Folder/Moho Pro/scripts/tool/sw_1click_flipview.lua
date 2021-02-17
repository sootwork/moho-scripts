-- **************************************************
-- Provide Moho with the name of this script object
-- **************************************************
ScriptName = "SW_1Click_FlipView"

-- **************************************************
-- General information about this script
-- **************************************************

SW_1Click_FlipView = {}

function SW_1Click_FlipView:Name() return "1Click FlipView" end

function SW_1Click_FlipView:Version() return "1.00" end

function SW_1Click_FlipView:Description() return "1Click FlipView" end

function SW_1Click_FlipView:Creator() return "howdy(sootwork)" end

function SW_1Click_FlipView:UILabel() return "1Click FlipView" end

-- **************************************************
-- Recurring values
-- **************************************************

SW_1Click_FlipView.gChInfo = MOHO.MohoLayerChannel:new_local()

-- **************************************************
-- The guts of this script
-- **************************************************

function SW_1Click_FlipView:Run(moho)
    -- FlipView グループレイヤーの有無フラグ
    local isExistFlipView = false

    -- ルートに FlipView グループレイヤーが存在しているか、全レイヤーを走査する
    local count = 0
    repeat
        -- 注意※ LayerByAbsoluteID はルートに存在するレイヤーだけを取得する
        local layer = moho.document:LayerByAbsoluteID(count)
        if layer then
            count = count + 1
            -- 親レイヤーを持たないグループレイヤーかどうか
            if layer:Parent() == nil and layer:LayerType() == MOHO.LT_GROUP then
                -- レイヤーが持つスクリプトデータ
                local scriptData = layer:ScriptData()
                -- FlipView グループレイヤーの識別する埋め込まれた文字列
                local isHasKey = scriptData:HasKey(
                                     "SW_1Click_FlipView_IsFlipViewGroup")

                -- レイヤーのスクリプトデータに識別文字列が有るかで、FlipView グループレイヤーかを判別する
                -- 走査中のレイヤーが FlipView グループレイヤーの場合
                if isHasKey == true then
                    -- FlipView グループレイヤーの有無フラグをオン
                    isExistFlipView = true

                    -- FlipView グループレイヤーの左右反転値を逆にする
                    local flipBool = not layer.fFlipH:GetValue(0)

                    -- FlipView グループレイヤーの左右反転値をフレーム0, フレーム1 にセットする
                    layer.fFlipH:SetValue(0, flipBool)
                    layer.fFlipH:SetValue(1, flipBool)

                    -- レイヤーを更新
                    layer:UpdateCurFrame()

                    -- 分かりやすいように ON/OFF を示した名前へ変更する
                    if flipBool then
                        layer:SetName("[FlipView]-ON")
                    else
                        layer:SetName("[FlipView]-OFF")
                    end

                    -- 作業ビューの表示位置も左右反転する
                    local g = moho.view:Graphics()
                    g:SetViewOffset(-1 * g:ViewOffset().x, g:ViewOffset().y)
                end
            end
        end
    until not layer

    -- ルートに FlipView グループレイヤーが存在しない場合、FlipView グループレイヤーを作る
    if isExistFlipView == false then self:MakeGroup(moho) end
end

function SW_1Click_FlipView:MakeGroup(moho)
    moho.document:PrepMultiUndo(true)
    moho.document:SetDirty()

    -- FlipView グループレイヤー作成を告げるアラートを出す
    LM.GUI.Alert(LM.GUI.ALERT_INFO, self:Localize("alert_l1"),
                 self:Localize("alert_l2"), self:Localize("alert_l3"),
                 MOHO.Localize("/Scripts/OK=OK"), nil, nil)

    -- ルートにある一番上のレイヤーを選択
    local rootZeroLayer = moho.document:LayerByAbsoluteID(
                              moho.document:CountLayers() - 1)
    moho:SetSelLayer(rootZeroLayer)
    moho:UpdateUI()

    -- FlipView グループレイヤー作成(一番上に作られ選択されます)
    moho:CreateNewLayer(MOHO.LT_GROUP)
    moho.layer:SetName("[FlipView]-OFF")

    -- ユニークID を保存
    local flipViewGroupUUID = moho.layer:UUID()

    -- このスクリプトで生成されたレイヤーであることを示すデータを FlipView グループレイヤーに埋め込む
    local curScriptData = moho.layer:ScriptData()
    curScriptData:Set("SW_1Click_FlipView_IsFlipViewGroup", true)

    -- すべてのレイヤーを FlipView グループレイヤーに入れる
    repeat
        -- 一番上に FlipView グループレイヤー があるはずなので、ルートの2番目を繰り返し入れ続ける
        -- 注意※ LayerByAbsoluteID はルートに存在するレイヤーだけを取得する
        local targetLayer = moho.document:LayerByAbsoluteID(
                                moho.document:CountLayers() - 2)
        if targetLayer then
            -- 対象レイヤーは FlipView グループレイヤーではない、かつ親レイヤーがない → FlipView グループレイヤー に入れる
            if targetLayer:UUID() ~= flipViewGroupUUID and targetLayer:Parent() ==
                nil then
                moho:PlaceLayerInGroup(targetLayer, moho.layer, false, false)
            end
        end
    until not targetLayer
end

-- **************************************************
-- Localization
-- **************************************************
function SW_1Click_FlipView:Localize(text)
    local fileWord = MOHO.Localize("/Menus/File/File=File")

    local phrase = {}

    phrase["alert_l1"] = "All layers have grouped into [FlipView] on root ."
    phrase["alert_l2"] =
        "Clicking me do flip view, WHEN ONLY [FlipView] IS ON ROOT.\n\n"

    if fileWord == "ファイル" then
        phrase["alert_l1"] =
            "すべてのレイヤーを [FlipView] にグループ化しました。"
        phrase["alert_l2"] =
            "ルートに [FlipView] のみ存在するとき、アイコンクリックでビューを左右反転をします。\n\n"
    end

    return phrase[text]
end
