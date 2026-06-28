extends Node2D

var shouldTick = false
func tick(pos:Vector2i, build: Node2D) -> void:
	shouldTick = !shouldTick

	if(shouldTick):
		print("TICKING")
		_spawn(pos, build, Vector2i(1,0))
		_spawn(pos,build, Vector2i(1,1))
		_spawn(pos,build, Vector2i(0,1))
		_spawn(pos,build, Vector2i(-1,0))
		_spawn(pos,build, Vector2i(-1,-1))
		_spawn(pos,build, Vector2i(1,-1))
		_spawn(pos,build, Vector2i(-1,1))
		_spawn(pos,build, Vector2i(0,-1))

func _spawn(pos:Vector2i, build: Node2D, direction: Vector2i):
	build.spawnWave(pos + direction, direction)
