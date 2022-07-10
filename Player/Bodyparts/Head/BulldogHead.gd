extends BodypartHead

func _init():
	visibleName = "bulldog head"
	id = "bulldoghead"

func getCompatibleSpecies():
	return [Species.Canine, Species.Wolf]

func getDoll3DScene():
	return "res://Player/Player3D/Parts/Head/BulldogHead/BulldogHead.tscn"
