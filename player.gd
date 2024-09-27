extends CharacterBody2D

const SPEED = 15.0
const JUMP_VELOCITY = -400.0
const MAX_SPEED = 500
const GRAVITY = Vector2(0, 800.0)

var jump_count = 3


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += GRAVITY * delta
	else: 
		jump_count = 3
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump(JUMP_VELOCITY, 1)
	elif Input.is_action_just_pressed("jump") and !is_on_floor() and jump_count>1:
		jump(JUMP_VELOCITY, 1)
		jump_count -= 1

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		accelerate(direction)
	else:
		decelerate()

	move_and_slide()
	
func jump(y_velocity, mult):
	velocity.y = y_velocity*mult

func accelerate(dir):
	if dir==1:
		velocity.x = min(velocity.x + SPEED*dir, MAX_SPEED)
		print(velocity.x)
	elif dir==-1:
		velocity.x = max(velocity.x + SPEED*dir, -MAX_SPEED)
		print(velocity.x)

func decelerate():
	if velocity.x > 0:
		velocity.x = max(velocity.x - SPEED*0.5, 0)
	elif velocity.x < 0:
		velocity.x = min(velocity.x + SPEED*0.5, 0)

func check_dir():
	if velocity.x > 0:
		return 1
	elif velocity.x < 0:
		return -1
	else:
		return 0