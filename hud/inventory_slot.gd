extends Control

@export var SLOT_SELECTION: GlobalPlayerState.SlotSelectionState
@export var SELECTED_TEXTURE: Texture2D 
@export var UNSELECTED_TEXTURE: Texture2D 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalPlayerState.inventory_changed.connect(updateInventory)
	$TextureButton.texture_normal = UNSELECTED_TEXTURE
	$TextureButton.z_index = -1
	$Label.z_index = 100

func updateInventory():
	if(GlobalPlayerState.currentSlot != SLOT_SELECTION):
		$TextureButton.texture_normal = UNSELECTED_TEXTURE
	else:
		$TextureButton.texture_normal = SELECTED_TEXTURE
	$Label.text = str(GlobalPlayerState.getValueOfSlot(SLOT_SELECTION))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$Label.z_index = 100

func _on_pressed() -> void:
	# SELECT ACTIVE SLOT
	# THAT IS ALL
	# CHANGE YOUR SLOT TO CURRENT
	# AND ALSO SUBSCRIBE TO UPDATING
	print("pressed")
	GlobalPlayerState.selectNewSlot(SLOT_SELECTION)

func _on_texture_button_pressed() -> void:
	print("pressed")
	GlobalPlayerState.selectNewSlot(SLOT_SELECTION)
 # Replace with function body.
