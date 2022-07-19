extends PathFollow2D


var time: float = 0.0


func _physics_process(delta: float) -> void:
	time += delta
	unit_offset = cos(time) * 0.5 + 1.0
	
