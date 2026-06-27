extends Node2D

var player_at_leak = false
var leak_fixed = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("leaks")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Leak")
	player_at_leak = true
	#if(body.is_in_group("player")):
		#body.at_leak = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	print("NoLeak")
	player_at_leak = false
	#if(body.is_in_group("player")):
		#body.at_leak = false

func use_leakage() -> void:
	if player_at_leak: 
		print("fixLeak")
		var metalplates = GlobalPlayerState.getMetalPlates()
		if metalplates==0: pass
		else: 
			GlobalPlayerState.setMetalPlates(metalplates-1)
			leak_fixed=true
	
	
