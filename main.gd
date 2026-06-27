extends Node

@export var Leakage: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_leak_timer_timeout() -> void:
	print("Timer")
	# Create a new instance of the leak scene.
	var leak = Leakage.instantiate()

	# Choose a random location on Path2D.
	var leak_spawn_location = $leakPath/leakSpawnLocation
	leak_spawn_location.progress_ratio = randf()

	# Set the leak's position to the random location.
	leak.position = leak_spawn_location.position

	# Set the leak's direction perpendicular to the path direction.
	var direction = leak_spawn_location.rotation + PI / 2

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	leak.rotation = direction

	# Spawn the leak by adding it to the Main scene.
	add_child(leak)
	pass # Replace with function body.
