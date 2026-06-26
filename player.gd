extends CharacterBody2D
@onready var _animation_player = $AnimationPlayer
@onready var _animation_tree = $AnimationTree

const SPEED = 300.0
const SPRINT = 1000.0

const JUMP_VELOCITY = -400.0
const LADDER_VELOCITY = -200.0

var sit = false
var use = false
var on_ladder = false

func _ready(): 
	_animation_tree.set_active(true) 
	on_ladder = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and not on_ladder:
		velocity += get_gravity() * delta
		set_collision_mask_value(1, true)


	use = false
	
	# Handle jump.
	var ladder_direction := Input.get_axis("ui_up", "ui_down")
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		sit = false
		set_collision_mask_value(1, true)
	if ladder_direction and on_ladder:
		position.y +=  LADDER_VELOCITY * -ladder_direction * delta
		sit = false
		set_collision_mask_value(1, false)

		
		
	if Input.is_action_just_pressed("ui_down") and is_on_floor():
		sit = true
		
	if Input.is_action_just_pressed("action_use") and is_on_floor():
		use = true
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		$PlayerSprite.scale.x = abs($PlayerSprite.scale.x) * direction	
		sit = false
		if Input.is_action_pressed("action_sprint"):
			velocity.x = direction * SPRINT
		else:
			velocity.x = direction * SPEED 
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	

	move_and_slide()
