extends Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_on_score_change(0)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func _on_score_change(score: int):
	text = "Score: %s" % score
