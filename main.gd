extends Node

@export var Leakage: PackedScene
@export var watercurve: Curve = preload("res://watercurve.tres")

var score = 0
var waterlevel = 0
const PUMPSPEED = 2
const WATERSPEED = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score = 0
	$Hud/GameOver.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	waterlevel += sqrt(get_tree().get_nodes_in_group("open_leaks").size()*WATERSPEED)
	waterlevel = move_toward(waterlevel, 0, PUMPSPEED)
	if waterlevel > 1000: waterlevel=1000 
	$Hud/Waterlevel.value = watercurve.sample(waterlevel)
	if $Hud/Waterlevel.value == 100:
		gameover()

func gameover() -> void:
	$ScoreTimer.stop()
	$LeakTimer.stop()
	$Hud/GameOver.show()
	$Hud/GameOver/Label.text = "Game Over
								Press Space to try again  
								Score: %s" % score

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and $Hud/GameOver.visible:
		# This restarts the current scene.
		get_tree().reload_current_scene()
	elif event.is_action_pressed("ui_accept"):
		gameover()

func _on_leak_timer_timeout() -> void:
	print("Timer")
	if $Hud/Waterlevel.value<90:
		for i in range(3):
			spawn_leakage()
	pass # Replace with function body.

func spawn_leakage() -> void:
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


func _on_score_timer_timeout() -> void:
	score += 1
	$Hud/ScoreLabel._on_score_change(score)
	pass # Replace with function body.


func _on_torpedo_machine_torpedo_fired() -> void:
	score += 10
	$Hud/ScoreLabel._on_score_change(score)
	pass # Replace with function body.
