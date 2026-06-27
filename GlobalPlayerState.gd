extends Node
#  THIS SCRIPT SHOULD BE AUTOLOADED
signal inventory_changed
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
 
enum SlotSelectionState {
	WIRES,
	METAL_PLATES,
	COILS
}
var currentSlot = SlotSelectionState.WIRES
var _amountWires:int = 10
var _amountCoils:int = 10
var _amountMetalPlates:int = 10

func getWires():
	return _amountWires

func getCoils():
	return _amountCoils

func getMetalPlates():
	return _amountMetalPlates
func selectNewSlot(newSlot: SlotSelectionState):
	currentSlot = newSlot # 
	emit_signal("inventory_changed")
func setCurrentSlotsValue(newValue: int):
	match currentSlot:
		SlotSelectionState.WIRES:
			setWires(newValue)
		SlotSelectionState.METAL_PLATES:
			setMetalPlates(newValue)
		SlotSelectionState.COILS:
			setCoils(newValue)
	
func modifyCurrentSlot(difference: int):
	setCurrentSlotsValue(getValueOfSlot(currentSlot)+ difference)
	emit_signal("inventory_changed")

func setWires(newWires: int):
	_amountWires = newWires
	emit_signal("inventory_changed")
func setCoils(newCoils: int):
	_amountCoils = newCoils
	emit_signal("inventory_changed")
func setMetalPlates(newMetalPlates):
	_amountMetalPlates = newMetalPlates
	emit_signal("inventory_changed")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func getValueOfSlot(slot: SlotSelectionState):
	match slot:
		SlotSelectionState.WIRES:
			return _amountWires
		SlotSelectionState.METAL_PLATES:
			return _amountMetalPlates
		SlotSelectionState.COILS:
			return _amountCoils
		_:
			return _amountCoils
