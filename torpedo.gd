extends Node2D

var torpedo_step = 0

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
	torpedo_step +=1
	if torpedo_step > 4: torpedo_step=0
	pass # Replace with function body.
