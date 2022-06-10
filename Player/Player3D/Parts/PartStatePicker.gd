extends Spatial
class_name PartStatePicker

export(String) var state = ""
export(String) var defaultValue = ""

func _ready():
	setValue(defaultValue)

func getState():
	if(state == null || state == ""):
		return name
	return state

func setValue(value):
	for child in get_children():
		if(child is PartState):
			if(child.getStateValue() == value):
				child.visible = true
			else:
				child.visible = false
