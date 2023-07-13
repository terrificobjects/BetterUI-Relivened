local _
local LAM = LibAddonMenu2

local function Init(mId, moduleName)
	local panelData = Init_ModulePanel(moduleName, "Writ Settings")

	LAM:RegisterAddonPanel("BETTERUI_"..mId, panelData)
	LAM:RegisterOptionControls("BETTERUI_"..mId, optionsTable)
end

function BETTERUI.Writs.InitModule(m_options)
    return m_options
end

local function OnCraftStation(eventCode, craftId, sameStation)
	if eventCode ~= 0 then -- 0 is an invalid code
			BETTERUI.Writs.Show(tonumber(craftId))
	end
end

local function OnCloseCraftStation(eventCode)
	BETTERUI.Writs.Hide()
end

local function OnCraftItem(eventCode, craftId)
	if eventCode ~= 0 then -- 0 is an invalid code
			BETTERUI.Writs.Show(tonumber(craftId))
	end
end

function BETTERUI.Writs.Setup()
	local tlw = BETTERUI.WindowManager:CreateTopLevelWindow("BETTERUI_TLW")
	local BETTERUI_WP = BETTERUI.WindowManager:CreateControlFromVirtual("BETTERUI_WritsPanel",tlw,"BETTERUI_WritsPanel")

	EVENT_MANAGER:RegisterForEvent(BETTERUI.name, EVENT_CRAFTING_STATION_INTERACT, OnCraftStation)
	EVENT_MANAGER:RegisterForEvent(BETTERUI.name, EVENT_END_CRAFTING_STATION_INTERACT, OnCloseCraftStation)
	EVENT_MANAGER:RegisterForEvent(BETTERUI.name, EVENT_CRAFT_COMPLETED, OnCraftItem)

	BETTERUI_WP:SetHidden(true)
end