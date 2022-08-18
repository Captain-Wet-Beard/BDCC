extends Object
class_name Images

static func getCharacter(characterID: String, variant: Array):
	var packs = OPTIONS.getImagePackOrder()
	
	for packID in packs:
		var pack = GlobalRegistry.getImagePack(packID)
		if(pack == null):
			continue
		var imagePath = pack.getCharacterImage(characterID, variant)
		if(imagePath != null):
			return imagePath
		
	return null
