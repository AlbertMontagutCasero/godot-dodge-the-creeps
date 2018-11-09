extends RigidBody2D

export (int) var min_speed # Minimum speed range.
export (int) var max_speed # Maximum speed range.
var mob_types = ["walk", "swim", "fly"]

func _ready():
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]
	$Visibility.connect("screen_exited", self, "_on_Visibility_screen_exited")
	
func _on_Visibility_screen_exited():
	queue_free()