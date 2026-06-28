extends Node2D

var counter = 0
func _ready() -> void:
	GlobalSonarState.tickSonar.connect(tick)
func tick() -> void:
	var build = GlobalSonarState.building
	var pos = Vector2i(round(global_position.x/100), round(global_position.y/100)) 
	var shouldTick = (counter % 20 == 4)
	counter = (counter + 1) % 20
	if(shouldTick):
		_spawn(pos, build, Vector2i(1,0))
		_spawn(pos,build, Vector2i(1,1))
		_spawn(pos,build, Vector2i(-1,0))
		_spawn(pos,build, Vector2i(-1,-1))
		_spawn(pos,build, Vector2i(1,-1))
		_spawn(pos,build, Vector2i(-1,1))
func _spawn(pos:Vector2i, build: Node2D, direction: Vector2i):
	build.spawnWave(pos + direction, direction)
