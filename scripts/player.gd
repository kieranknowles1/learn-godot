extends CharacterBody2D


const SPEED = 125.0
const JUMP_VELOCITY = -300.0

# Give a grace period where the player can still jump after falling off a platform.
const COYOTE_TIME = 0.3
var air_time = 0.0

func can_jump() -> bool:
	return air_time < COYOTE_TIME

# Prevent jumping until the player lands on the ground.
func block_jump() -> void:
	air_time = COYOTE_TIME

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		air_time += delta
	else:
		air_time = 0.0

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and can_jump():
		velocity.y = JUMP_VELOCITY
		block_jump()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
