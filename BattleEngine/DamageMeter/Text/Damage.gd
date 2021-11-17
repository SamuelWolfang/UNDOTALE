extends Node2D

func _ready():
	if int($Label.text) > 0:
		$Label.set("custom_colors/font_color", Color(1,0,0,1))
		$AudioStreamPlayer.play()
	position.x = -($Label.rect_size.x / 2.0) + global_position.x
	$AnimationPlayer.play("jump")

func _on_animation_finished(anim_name):
	$AnimationPlayer.stop()
	queue_free()
