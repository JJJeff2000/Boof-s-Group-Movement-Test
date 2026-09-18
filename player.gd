extends CharacterBody2D

const Gravity = 900
const FallGravity = 1500
const Base_Speed = 300
var Can_Move = true
var Current_DIR = "Right"
var Jump_Available: bool = true
var Jump_Velocity = -600
var jump_upgrade = true

func _ready():
	Global.Player = self

func _physics_process(_delta):
	if Can_Move:
		_delta_player_movement()
	if not is_on_floor():
		velocity.y += get_current_gravity(velocity) * _delta
	else:
		Jump_Available = true
	if Can_Move:
		_delta_player_movement()
		if jump_upgrade:
			_delta_jump()

func _delta_player_movement():
	if Input.is_action_pressed("ui_right"):
		velocity.x = Base_Speed
		if not is_on_floor():
			pass
		else:
			pass
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -Base_Speed
		if not is_on_floor():
			pass
		else:
			pass
	else:
		velocity.x = 0
	move_and_slide()

func get_current_gravity(_velocity):
	if velocity.y < 0:
		return Gravity
	return Gravity

func _delta_jump():
	if Input.is_action_just_pressed("ui_up"):
		if Jump_Available:
			jump()
	if Input.is_action_just_released("ui_up") and velocity.y < 0:
		velocity.y = float(Jump_Velocity)/4
		

func jump():
	velocity.y = Jump_Velocity
	Jump_Available = false
