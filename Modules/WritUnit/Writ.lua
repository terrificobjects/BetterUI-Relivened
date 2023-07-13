local _

function BETTERUI.Writs.Get(qId)
	writLines = {}
	writConcate = ''
	for lineId = 1, GetJournalQuestNumConditions(qId,1) do
		local writLine,current,maximum,_,complete = GetJournalQuestConditionInfo(qId,1,lineId)
		local colour
		if writLine ~= '' then
			if current == maximum then
				colour = "00FF00"
			else
				colour = "CCCCCC"
			end
			writLines[lineId] = {line=zo_strformat("|c<<1>><<2>>|r",colour,writLine),cur=current,max=maximum}
		end
	end
	for key,line in pairs(writLines) do
		writConcate = zo_strformat("<<1>><<2>>\n",writConcate,line.line)
	end

	return writConcate
end

function BETTERUI.Writs.Update()
	BETTERUI.Writs.List = {}
	for qId=1, MAX_JOURNAL_QUESTS do
		if IsValidQuestIndex(qId) then
			if GetJournalQuestType(qId) == QUEST_TYPE_CRAFTING then
				local qName,_,qDesc,_,_,qCompleted  = GetJournalQuestInfo(qId)
				local currentWrit = -1

				if string.find(string.lower(qName),'blacksmith') then currentWrit = CRAFTING_TYPE_BLACKSMITHING end
				if string.find(string.lower(qName),'cloth') then currentWrit = CRAFTING_TYPE_CLOTHIER end
				if string.find(string.lower(qName),'woodwork') then currentWrit = CRAFTING_TYPE_WOODWORKING end
				if string.find(string.lower(qName),'enchant') then currentWrit = CRAFTING_TYPE_ENCHANTING end
				if string.find(string.lower(qName),'provision') then currentWrit = CRAFTING_TYPE_PROVISIONING end
				if string.find(string.lower(qName),'alchemist') then currentWrit = CRAFTING_TYPE_ALCHEMY end
				if string.find(string.lower(qName),'jewelry') then currentWrit = CRAFTING_TYPE_JEWELRYCRAFTING end
				if string.find(string.lower(qName),'witches') then currentWrit = CRAFTING_TYPE_PROVISIONING end

				if currentWrit ~= -1 then
					BETTERUI.Writs.List[currentWrit] = { id = qId, writLines = BETTERUI.Writs.Get(qId) }
				end
			end
		end
	end
end

function BETTERUI.Writs.Show(writType)
	BETTERUI.Writs.Update()
	if BETTERUI.Writs.List[writType] ~= nil then
		local qName,_,activeText,_,_,completed = GetJournalQuestInfo(BETTERUI.Writs.List[writType].id)
		BETTERUI_WritsPanelSlotContainerExtractionSlotWritName:SetText(zo_strformat("|c0066ff[BETTERUI]|r <<1>>",qName))
		BETTERUI_WritsPanelSlotContainerExtractionSlotWritDesc:SetText(zo_strformat("<<1>>",BETTERUI.Writs.List[writType].writLines))
		BETTERUI_WritsPanel:SetHidden(false)
	end
end

function BETTERUI.Writs.Hide()
	BETTERUI_WritsPanel:SetHidden(true)
end