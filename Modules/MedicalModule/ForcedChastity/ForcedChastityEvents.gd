extends EventBase

func _init():
	id = "ForcedChastityEvents"

func registerTriggers(es):
	es.addTrigger(self, Trigger.WakeUpInCell)

func react(_triggerID, _args):
	if(!getFlag("MedicalModule.PC_ReceivedPermanentCage")):
		return false
	if(GM.pc.isWearingPortalPanties()):
		return false
	if(getFlag("MedicalModule.Eliza_BusyDays", 0) > 0):
		return false
	if(!GM.pc.getInventory().hasItemIDEquipped("ChastityCagePermanent") && !GM.pc.getInventory().hasItemIDEquipped("ChastityCagePermanentNormal")):
		return false
	
	var lastDayEventHappened = getFlag("MedicalModule.Chastity_LastEventDay", 0)
	if(GM.main.getDays() < (lastDayEventHappened + 5)): #5 is default. Switch to 1 for testing
		return false
	
	var currentEventNumber = getFlag("MedicalModule.Chastity_EventNumber", 0)
	
	#						DON'T FORGET THESE
	if(currentEventNumber in [0, 1, 2]):
		setFlag("MedicalModule.Chastity_LastEventDay", GM.main.getDays())
		GM.pc.removeAllRestraints()
		
		if(currentEventNumber == 0):
			setFlag("MedicalModule.Chastity_EventNumber", 1)
			runScene("ForcedChastityScene1")
		if(currentEventNumber == 1):
			setFlag("MedicalModule.Chastity_EventNumber", 2)
			runScene("ForcedChastityScene2")
		if(currentEventNumber == 2):
			setFlag("MedicalModule.Chastity_EventNumber", 3)
			runScene("ForcedChastityScene3")
		return true
	
	return false

func getPriority():
	return 10

