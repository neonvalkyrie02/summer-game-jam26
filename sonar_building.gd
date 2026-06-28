extends Node2D


# Called when the node enters the scene tree for the first time.

func _ready():
	$Timer.wait_time = 0.05
	$Timer.timeout.connect(_on_timeout)
	$Timer.start()
	
func spawnWave(pos: Vector2i, directionVector: Vector2i):
	var wave = preload("res://SonarWave.tscn").instantiate()
	add_child(wave)
	wave.global_position = Vector2(pos.x * 100, pos.y*100)

	wave.z_index = 100
	wave.setDirection(directionVector)
	GlobalSonarState.addNode(pos, wave)
func _on_timeout():
	GlobalSonarState.tick(self)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if GlobalPlayerState.currentSlot == GlobalPlayerState.SlotSelectionState.COILS:
				if(GlobalPlayerState.getCoils() > 0): 
					GlobalPlayerState.modifyCurrentSlot(-1)
					print("SOMETHING DETECTED")
					var coil = preload("res://SonarCoil.tscn").instantiate()
					add_child(coil)
					var mouse_pos =  get_global_mouse_position()
					coil.global_position = Vector2(round(mouse_pos.x/100)*100, round(mouse_pos.y/100)*100) 
					GlobalSonarState.addNode(Vector2i(round(mouse_pos.x/100), round(mouse_pos.y/100)), coil)
					print(mouse_pos)
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			if GlobalPlayerState.currentSlot == GlobalPlayerState.SlotSelectionState.COILS:
					var mouse_pos =  get_global_mouse_position()
					var grid_pos = Vector2i(round(mouse_pos.x/100), round(mouse_pos.y/100))
					var node = GlobalSonarState.getNode(grid_pos)
					if(node and node.name == "SonarCoil"):
						GlobalSonarState.removeNode(grid_pos)
						node.queue_free()
						GlobalPlayerState.setCoils(GlobalPlayerState.getCoils()+1)
