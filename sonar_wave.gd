extends Node2D

var direction: Vector2i = Vector2i(1,1)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func setDirection(dir: Vector2i):
	self.direction = dir
# Called every frame. 'delta' is the elapsed time 
func tick(cords: Vector2i, building: Node2D ) -> void:
	var newPos = cords + self.direction
	GlobalSonarState.moveNode(cords, newPos)
	self.z_index = 100
	if(cords.x > 57 or cords.x < 31 or cords.y < -1 or cords.y > 4):
		building.remove_child(self)
		GlobalSonarState.removeNode(cords)
		queue_free()	
	self.global_position = Vector2(newPos.x* 100, newPos.y* 100)
