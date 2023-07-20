extends CharacterBody2D

@export var move_speed : float = 200.0
@export var jump_velocity : float = -230.0
@export var dash_speed : float = 500
@export var dash_duration : float = 0.2

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var dash = $Dash

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var animation_locked : bool = false
var direction : Vector2 = Vector2.ZERO
var was_in_air :bool = false
var on_ladder :bool = false

func _physics_process(delta):
	print(on_ladder)
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		was_in_air = true
#	else:
#		if was_in_air == true:
#			land()
			
		was_in_air = false
		
	if Input.is_action_just_pressed("dash") && dash.can_dash && !dash.is_dashing():
		dash.start_dash(dash_duration)
		
	var speed = dash_speed if dash.is_dashing() else move_speed

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		#jump()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.x != 0:
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
	update_animation()
	move_and_slide()
	
	update_facing_direction()
	
func update_animation():
	if not animation_locked:
		if not is_on_floor():
			animated_sprite.play("jump_loop")
		else:
			if direction.x != 0:
				animated_sprite.play("run")
			else:
				animated_sprite.play("idle")
			
func update_facing_direction():
	if direction.x > 0:
		animated_sprite.position = Vector2(-28,-24)
		animated_sprite.flip_h = false
	elif direction.x < 0:
		animated_sprite.position = Vector2(-40,-24)
		animated_sprite.flip_h = true
		
#func jump():
#	velocity.y = jump_velocity
#	animated_sprite.play("jump_start")
#	animation_locked = true
#
#func land():
#	animated_sprite.play("jump_end")
#	animation_locked = true
		

#
#func _on_animated_sprite_2d_animation_finished():
#	if(animated_sprite.animation == "jump_end"):
#		animation_locked = false
#	elif(animated_sprite.animation == "jump_start"):
#		animation_locked = false

func _input(event : InputEvent):
	if(event.is_action_pressed("down") && is_on_floor()):
		position.y += 1 
		
func _on_hitbox_area_entered(area):
	if area.is_in_group("Death"):
		GameManager.move_to_checkpoint()

