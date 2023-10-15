extends Node2D


## Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_area_2d_body_entered(body):
	$DoorAnimationPlayer.play("OpenDoor")

func _on_area_2d_body_exited(body):
	$DoorAnimationPlayer.play_backwards("OpenDoor")


func _on_hide_roof_body_entered(body):
	create_tween().tween_property($Roof, 'modulate', Color(1, 1, 1, 0), 0.5)

func _on_hide_roof_body_exited(body):
	create_tween().tween_property($Roof, 'modulate', Color(1, 1, 1, 1), 0.5)
