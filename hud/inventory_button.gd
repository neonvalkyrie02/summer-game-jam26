extends TextureButton

@export var SLOT_SELECTION: GlobalPlayerState.SlotSelectionState
@export var SELECTED_TEXTURE: Texture2D = preload("res://assets/icons/coil_icon.png")
@export var UNSELECTED_TEXTURE: Texture2D = preload("res://assets/icons/coil_icon.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalPlayerState.inventory_changed.connect(updateInventory)
	texture_normal = UNSELECTED_TEXTURE

func updateInventory():
	if(GlobalPlayerState.currentSlot != SLOT_SELECTION):
		texture_normal = UNSELECTED_TEXTURE
	else:
		texture_normal = SELECTED_TEXTURE

	return
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_pressed() -> void:
	# SELECT ACTIVE SLOT
	# THAT IS ALL
	# CHANGE YOUR SLOT TO CURRENT
	# AND ALSO SUBSCRIBE TO UPDATING
	GlobalPlayerState.selectNewSlot(SLOT_SELECTION)
