extends CharacterBody2D
@onready var _animation_tree = $AnimationTree

signal use_torpedos

const SPEED = 300.0
const SPRINT = 1000.0
const BUFFED = 4000.0

const JUMP_VELOCITY = -400.0
const LADDER_VELOCITY = -400.0

var sit = false
var use = false
var on_ladder = false
var at_torpedo = false
var at_leak = false


func _ready(): 
	_animation_tree.set_active(true) 
	on_ladder = false
	
func _process(_delta:float):
	if Input.is_action_just_released("key_1"):
		GlobalPlayerState.selectNewSlot(GlobalPlayerState.SlotSelectionState.WIRES)
	if Input.is_action_just_released("key_2"):
		GlobalPlayerState.selectNewSlot(GlobalPlayerState.SlotSelectionState.COILS)
	if Input.is_action_just_released("key_3"):
		GlobalPlayerState.selectNewSlot(GlobalPlayerState.SlotSelectionState.METAL_PLATES)
	if Input.is_action_just_released("eat"):
		GlobalPlayerState.eat();
		
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and not on_ladder:
		velocity += get_gravity() * delta


	use = false
	
	# Handle Ladders.
	var ladder_direction := Input.get_axis("ui_up", "ui_down")
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		sit = false

	if ladder_direction and on_ladder:
		position.y +=  LADDER_VELOCITY * -ladder_direction * delta
		sit = false

	if Input.is_action_just_pressed("ui_down") and is_on_floor():
		sit = true
		
	if Input.is_action_just_pressed("action_use") and is_on_floor():
		use = true
		if at_torpedo:
			emit_signal("use_torpedos")
		get_tree().call_group("leaks", "use_leakage")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		$PlayerSprite.scale.x = abs($PlayerSprite.scale.x) * direction	
		sit = false
		if Input.is_action_pressed("action_sprint"):
			if GlobalPlayerState.getSpeedBuf():
				velocity.x = direction * BUFFED
			else: 
				velocity.x = direction * SPRINT
		else:
			velocity.x = direction * SPEED 
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
