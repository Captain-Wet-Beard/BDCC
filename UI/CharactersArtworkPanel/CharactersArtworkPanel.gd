extends Control

var currentCharacter = null
var characters = {}

onready var nameLabel = $VBoxContainer2/Control/MarginContainer/VBoxContainer/NameLabel
onready var textureRect = $VBoxContainer2/Control/TextureRect
onready var textureRect2 = $VBoxContainer2/Control/TextureRect2
onready var textureRect3 = $VBoxContainer2/Control/TextureRect3
onready var characterStatusGrid = $VBoxContainer2/CharacterStatusGrid

func _ready():
	clear()
	
	addCharacter("rahi", [])
	addCharacter("tavi", [])
	addCharacter("risha", [])
	pass
	
func clear():
	characters.clear()
	textureRect.texture = null
	textureRect2.texture = null
	textureRect3.texture = null
	currentCharacter = null
	updateMainCharacter()
	
func addCharacter(charID:String, variant:Array):
	var data = {}
	
	var imagePath = Images.getCharacter(charID, variant)
	if(imagePath == null):
		imagePath = "res://icon.png"
	
	data["imagePath"] = imagePath
	
	characters[charID] = data
	
	if(currentCharacter == null):
		currentCharacter = charID
		updateMainCharacter()
		
	updateImages()

func removeCharacter(charID:String):
	if(!characters.has(charID)):
		return
	
	var keys = characters.keys()
	var index = keys.find(currentCharacter)
	characters.erase(charID)
	
	if(characters.size() == 0):
		currentCharacter = null
		updateMainCharacter()
		updateImages()
		return
	
	if(currentCharacter == charID):
		if(index >= characters.size()):
			index = 0
		currentCharacter = keys[index]
		updateMainCharacter()
	updateImages()
		
func updateImages():
	if(characters.size() == 0):
		textureRect.texture = null
		textureRect2.texture = null
		textureRect3.texture = null
		return
	
	if(currentCharacter == null):
		return
	
	var keys = characters.keys()
	
	var index = keys.find(currentCharacter)
	
	textureRect.texture = load(characters[currentCharacter]["imagePath"])
	if(characters.size() > 1):
		var nextIndex = index + 1
		if(nextIndex >= characters.size()):
			nextIndex = 0
		
		textureRect2.texture = load(characters[keys[nextIndex]]["imagePath"])
	else:
		textureRect2.texture = null
	
	if(characters.size() > 2):
		var prevIndex = index - 1
		if(prevIndex < 0):
			prevIndex = characters.size() - 1
		
		textureRect3.texture = load(characters[keys[prevIndex]]["imagePath"])
	else:
		textureRect3.texture = null

func updateMainCharacter():
	if(currentCharacter == null):
		nameLabel.text = ""
		nameLabel.self_modulate = Color.white
		return
	
	var character:Character = GlobalRegistry.getCharacter(currentCharacter)
	if(character == null):
		nameLabel.text = "???"
		nameLabel.self_modulate = Color.white
		return
	nameLabel.text = character.getName()
	nameLabel.self_modulate = character.getChatColor()
	character.updateEffectPanel(characterStatusGrid)

func _on_NextButton_pressed():
	var keys = characters.keys()
	
	if(currentCharacter == null && keys > 0):
		currentCharacter = keys[0]
	
	if(currentCharacter == null):
		updateMainCharacter()
		return
	
	var index = keys.find(currentCharacter)
	index += 1
	if(index >= characters.size()):
		index = 0
	
	currentCharacter = keys[index]
	updateImages()
	updateMainCharacter()

func _on_NameLabel_mouse_entered():
	if(currentCharacter == null):
		return
	
	var character:Character = GlobalRegistry.getCharacter(currentCharacter)
	if(character == null):
		return
		
	GlobalTooltip.showTooltip(character.getName() + ", " + character.getSpeciesFullName(), character.getSmallDescription(), true)


func _on_NameLabel_mouse_exited():
	GlobalTooltip.hideTooltip()
