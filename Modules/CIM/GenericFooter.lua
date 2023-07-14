local _

function BETTERUI.GenericFooter:Initialize()
	if(self.footer == nil) then self.footer = self.control.container:GetNamedChild("FooterContainer").footer end

	if(self.footer.GoldLabel ~= nil) then BETTERUI.GenericFooter.Refresh(self) end
end

function BETTERUI.GenericFooter:Refresh()
	-- we're currently shortening the code using if/else statements to create SetCurrencyText functions
	function SetCurrencyText(object, currencyLabel, currencyType, colorCode, iconSize)
		local currencyAmount
		local lowercaseLabel = currencyLabel:lower()

		if lowercaseLabel == "gold" or lowercaseLabel == "tv" or lowercaseLabel == "ap" or lowercaseLabel == "writs" then
			currencyAmount = GetCurrencyAmount(currencyType)
		else
			currencyAmount = GetCurrencyAmount(currencyType, CURRENCY_LOCATION_ACCOUNT)
		end

		local formattedAmount = BETTERUI.DisplayNumber(currencyAmount)
		local currencyIcon = GetCurrencyGamepadIcon(currencyType)
		-- d(formattedAmount)
		-- d(currencyIcon)
		
		local text = zo_strformat(": |c" .. colorCode .. "<<1>>|r |t" .. iconSize .. ":" .. iconSize .. ":<<2>>|t", formattedAmount, currencyIcon)
		-- d(text)

		-- Set text for the label directly using GetNamedChild
		if object[currencyLabel .. "Label"] ~= nil then
			object[currencyLabel .. "Label"]:SetText(currencyLabel .. text)
			-- d("Set text for " .. currencyLabel .. "Label directly")
		-- If direct property access fails, try GetNamedChild
		elseif object:GetNamedChild(currencyLabel .. "Label") ~= nil then
			object:GetNamedChild(currencyLabel .. "Label"):SetText(currencyLabel .. text)
			-- d("Set text for " .. currencyLabel .. "Label via GetNamedChild")
		else
			d("GenericFooter.lua:38 No label found for: " .. currencyLabel)
		end
	end	

	-- Now, call the SetCurrencyText function for each label
	SetCurrencyText(self.footer, "Gold", CURT_MONEY, "FFBF00", "24")
	SetCurrencyText(self.footer, "TV", CURT_TELVAR_STONES, "00FF00", "24")
	-- I still need to modernize this code
	if(self.footer.GoldLabel ~= nil) then
		self.footer.CWLabel:SetText(zo_strformat("BAG: (<<1>>)|t32:32:/esoui/art/inventory/inventory_all_tabicon_inactive.dds|t",zo_strformat(SI_GAMEPAD_INVENTORY_CAPACITY_FORMAT, GetNumBagUsedSlots(BAG_BACKPACK), GetBagSize(BAG_BACKPACK))))
		self.footer.BankLabel:SetText(zo_strformat("BANK: (<<1>>)|t32:32:/esoui/art/inventory/inventory_all_tabicon_inactive.dds|t",zo_strformat(SI_GAMEPAD_INVENTORY_CAPACITY_FORMAT, GetNumBagUsedSlots(BAG_BANK) + GetNumBagUsedSlots(BAG_SUBSCRIBER_BANK), GetBagUseableSize(BAG_BANK) + GetBagUseableSize(BAG_SUBSCRIBER_BANK))))
	else
		
		self.footer:GetNamedChild("CWLabel"):SetText(zo_strformat("BAG: (<<1>>)|t32:32:/esoui/art/inventory/inventory_all_tabicon_inactive.dds|t",zo_strformat(SI_GAMEPAD_INVENTORY_CAPACITY_FORMAT, GetNumBagUsedSlots(BAG_BACKPACK), GetBagSize(BAG_BACKPACK))))
		self.footer:GetNamedChild("BankLabel"):SetText(zo_strformat("BANK: (<<1>>)|t32:32:/esoui/art/inventory/inventory_all_tabicon_inactive.dds|t",zo_strformat(SI_GAMEPAD_INVENTORY_CAPACITY_FORMAT, GetNumBagUsedSlots(BAG_BANK) + GetNumBagUsedSlots(BAG_SUBSCRIBER_BANK), GetBagUseableSize(BAG_BANK) + GetBagUseableSize(BAG_SUBSCRIBER_BANK))))
	end
	SetCurrencyText(self.footer, "AP", CURT_ALLIANCE_POINTS, "00FF00", "24")
	SetCurrencyText(self.footer, "Gems", CURT_CROWN_GEMS, "00FF00", "24")
	SetCurrencyText(self.footer, "TC", CURT_CHAOTIC_CREATIA, "00FF00", "24")
	SetCurrencyText(self.footer, "Crowns", CURT_CROWNS, "00FF00", "24")
	SetCurrencyText(self.footer, "Writs", CURT_WRIT_VOUCHERS, "00FF00", "24")
	SetCurrencyText(self.footer, "Tickets", CURT_EVENT_TICKETS, "00FF00", "24")
	SetCurrencyText(self.footer, "Keys", CURT_UNDAUNTED_KEYS, "00FF00", "24")
	SetCurrencyText(self.footer, "Outfit", CURT_STYLE_STONES, "00FF00", "24")
end