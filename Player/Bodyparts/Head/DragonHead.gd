extends BodypartHead

func _init():
	visibleName = "dragon head"
	id = "dragonhead"
	dollType = "Dragon"

func getCompatibleSpecies():
	return [Species.Dragon]
