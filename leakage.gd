extends Node2D

var player_at_leak = false
var leak_fixed = false
@onready var Area = $Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_at_leak = false
	leak_fixed = false
	add_to_group("leaks")
	add_to_group("open_leaks")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Leak")
	if(body.is_in_group("player")):
		player_at_leak = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	print("NoLeak")
	if(body.is_in_group("player")):
		player_at_leak = false


func use_leakage() -> void:
	if player_at_leak: 
		print("fixLeak")
		var metalplates = GlobalPlayerState.getMetalPlates()
		if metalplates==0: pass
		else: 
			GlobalPlayerState.setMetalPlates(metalplates-1)
			leak_fixed=true
			remove_from_group("open_leaks")
			add_to_group("fixed_leaks")

	
	
