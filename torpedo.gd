extends Node2D

var torpedo_step = 0
signal torpedo_fired

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.is_in_group("player")):
		body.at_torpedo = true
		print("At Torpedo")


func _on_area_2d_body_exited(body: Node2D) -> void:
	if(body.is_in_group("player")):
		body.at_torpedo = false

func _on_player_use_torpedos() -> void:
	print(torpedo_step)
	if torpedo_step == 3: 
		emit_signal("torpedo_fired")
		$ResupplyTimer.start()
		torpedo_step +=1
	else:
		torpedo_step +=1

func _on_resupply_timer_timeout() -> void:
	print("Resupplyed")
	torpedo_step = 0
	pass # Replace with function body.
