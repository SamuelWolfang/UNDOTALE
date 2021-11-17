extends KinematicBody2D

export var damage = 50

var from = ""
var motion = Vector2(0,0)

var save_size = 11
var save_position = 0

onready var visual = $Bone

func _process(delta):
	
	match from:
		"top":
			pass
		"bot":
			visual.rect_position.y = save_position + (save_size - visual.rect_size.y)
		"none":
			visual.rect_position.y = save_position + (save_size - visual.rect_size.y) / 2.0
		_:
			switch_from()
	
	$CollisionShape2D.position.y = visual.rect_position.y +  (visual.rect_size.y / 2.0)
	$CollisionShape2D.shape.extents = Vector2(2.5, (visual.rect_size.y / 2.0) - 5.5)
	
	move_and_collide(motion * delta)
	
func switch_from(new = "none"):
	save_size = $Bone.rect_size.y
	save_position = $Bone.rect_position.y
	from = new

func _on_screen_exited():
	queue_free()
