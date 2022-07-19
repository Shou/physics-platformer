extends RigidBody2D


onready var FloorCast: RayCast2D = $RayCast2D
onready var AnimSprite: AnimatedSprite = $AnimatedSprite
onready var AnimPlayer: AnimationPlayer = $AnimatedSprite/AnimationPlayer

var jumpTime: float = 0.0
var fallTime: float = 0.0
var jumpDuration: float = 0.3


func _ready() -> void:
	pass # Replace with function body.

func _integrate_forces(s: Physics2DDirectBodyState) -> void:
	var delta: float = s.get_step()
	var hm: float = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var movement := Vector2(hm * 128, 0)
	
	var newAnim := AnimPlayer.current_animation
	
	if abs(hm) > 0.1:
		newAnim = "Run"
		AnimSprite.flip_h = true if hm < 0 else false
	else:
		newAnim = "Idle"
	
	if FloorCast.is_colliding():
		jumpTime = 0.0
		fallTime = 0.0
	else:
		jumpTime += delta
		fallTime += delta
	
	if Input.get_action_strength("jump") and jumpTime < jumpDuration:
		var unitProgress: float = jumpTime / jumpDuration
		movement.y = -(1.0 - pow(unitProgress, 2.0)) * 360
		newAnim = "Jump"
	elif not FloorCast.is_colliding():
		movement.y = log(fallTime + 1) * 128
		newAnim = "Fall"
	
	AnimSprite.play(newAnim)
	
	s.set_linear_velocity(movement)
