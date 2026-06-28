extends Node2D

var direction: Vector2i = Vector2i(1,1)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalSonarState.tickSonar.connect(tick)
func setDirection(dir: Vector2i):
	self.direction = dir
func addDirection(dir: Vector2i):
	setDirection(dir + self.direction)

# Called every frame. 'delta' is the elapsed time 
func tick() -> void:
	var building = GlobalSonarState.building
	var cords = Vector2i(round(global_position.x/100), round(global_position.y/100)) 
	var newPos = cords + self.direction
	GlobalSonarState.moveNode(cords, newPos)
	self.z_index = 100
	if(cords.y < -1 or cords.y > 4):
		var multiplier = -1
		if(cords.y < -1):
			multiplier = 1
		var newDirection = Vector2i(self.direction.x, abs(self.direction.y) * multiplier)
		setDirection(newDirection)
	if(cords.x > 55 or cords.x < 31):
		if(cords.x > 55):
			GlobalSonarState.addScore()
		building.remove_child(self)
		GlobalSonarState.removeNode(cords)
		queue_free()
	self.global_position = Vector2(newPos.x* 100, newPos.y* 100)
