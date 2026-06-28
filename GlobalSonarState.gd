extends Node
# HANDLES -> GRID SAVING + CCIKIO
# QUESTION: HOW SHOULD WE HANDLE INSTANTIATING
# Called when the node enters the scene tree for the first time.
var length: float # HOW FAR CAN SONAR SEE
var angle: float # How big is the angle we can see # DEPENDS ON DIRECTION VARIABILITY
var nodes: Dictionary[Vector2i, Node2D]  = {}
var building: Node2D
signal tickSonar
func _ready() -> void:
	pass # Replace with function body.
func addNode(cord: Vector2i, node: Node2D):
	# SHOULD ALSO BE RESPONSIBLE FOR PROPERLY INSTANTIATING or not? NOT
	# SHOULD NODE
	# and position
	if nodes.has(cord):
		return 

	nodes[cord] = node

func removeNode(cord:Vector2i):
	var node = getNode(cord)
	if(node):
		nodes.erase(cord)
func moveNode(oldCords: Vector2i, newCords: Vector2i):
	# OR VECTOR 2D something -> IDK HOW TO DO IT CORRECTLY0
	
	if !getNode(oldCords):
		return # TODO: ERROR HANDLING THAT WORKS HERE
	addNode(newCords, getNode(oldCords))
	removeNode(oldCords)

func getNode(cord: Vector2i) -> Node2D:
	var node = nodes.get(cord)
	if(node):
		return node
	else:
		return null
func tick(sonarBuild:Node2D):
	building = sonarBuild
	emit_signal("tickSonar")
# Called every frame. 'delta' is the elapsed time since the previous frame.
