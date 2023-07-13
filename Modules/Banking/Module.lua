local _
local LAM = LibAddonMenu2

local changed = false
local function Init(mId, moduleName)
	local panelData = Init_ModulePanel(moduleName, "Banking Improvement Settings")

	local optionsTable = {
		{
			type = "checkbox",
			name = "Item Icon - Unbound Items",
			tooltip = "Show an icon after unbound items.",
			getFunc = function () return BETTERUI.Settings.Modules["Banking"].showIconUnboundItem end,
			setFunc = function (value) BETTERUI.Settings.Modules["Banking"].showIconUnboundItem = value
				changed = true end,
			width = "full",
			requiresReload = true,
		},
		{
			type = "checkbox",
			name = "Item Icon - Enchantment",
			tooltip = "Show an icon after enchanted item.",
			getFunc = function () return BETTERUI.Settings.Modules["Banking"].showIconEnchantment end,
			setFunc = function (value) BETTERUI.Settings.Modules["Banking"].showIconEnchantment = value
				changed = true end,
			width = "full",
			requiresReload = true,
		},
		{
			type = "checkbox",
			name = "Item Icon - Set Gear",
			tooltip = "Show an icon after set gears.",
			getFunc = function () return BETTERUI.Settings.Modules["Banking"].showIconSetGear end,
			setFunc = function (value) BETTERUI.Settings.Modules["Banking"].showIconSetGear = value
				changed = true end,
			width = "full",
			requiresReload = true,
		},
	}
	LAM:RegisterAddonPanel("BETTERUI_"..mId, panelData)
	LAM:RegisterOptionControls("BETTERUI_"..mId, optionsTable)
end

function BETTERUI.Banking.InitModule(m_options)
	m_options["showIconEnchantment"] = true
	m_options["showIconSetGear"] = true
	m_options["showIconUnboundItem"] = true
	return m_options
end

function BETTERUI.Banking.Setup()

	Init("Bank", "Banking")

	BETTERUI.Banking.Init()

end
