extends CharacterBody2D


const SPEED = 125.0
const JUMP_VELOCITY = -300.0

# Give a grace period where the player can still jump after falling off a platform.
const COYOTE_TIME = 0.3
var air_time = 0.0

var dead = false

@onready var animation: AnimatedSprite2D = $Animation

@onready var snd_hurt: AudioStreamPlayer2D = $Hurt
@onready var snd_jump: AudioStreamPlayer2D = $Jump

func can_jump() -> bool:
	return air_time < COYOTE_TIME

func jump() -> void:
	velocity.y = JUMP_VELOCITY
	# Prevent jumping until the player lands on the ground.
	air_time = COYOTE_TIME
	snd_jump.play()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		air_time += delta
	else:
		air_time = 0.0

	# Early out if the player is dead, only process gravity.
	if dead:
		return

	# Handle jump.
	if Input.is_action_just_pressed("jump") and can_jump():
		jump()

	# Get the input direction and handle the movement/deceleration.
	# Can be between -1 and 1.
	var direction := Input.get_axis("move_left", "move_right")
	if direction: # If the player is moving.
		velocity.x = direction * SPEED

		# Flip sprite towards last input
		animation.flip_h = direction < 0
	else: # If the player is not moving.
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Play the correct animation.
	animation.play(get_target_anim())

	move_and_slide()

func get_target_anim() -> StringName:
	if not is_on_floor():
		return "jump"
	elif velocity.x != 0:
		return "run"
	else:
		return "idle"

func die() -> void:
	dead = true
	snd_hurt.play()
	animation.play("death")
