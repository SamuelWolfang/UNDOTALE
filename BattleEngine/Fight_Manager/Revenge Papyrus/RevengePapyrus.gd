extends Fight_Manager

# MAKE CUSTOM CUTSCENES AS YOU WISH

onready var bone_tscn = preload("res://BattleEngine/Fight_Manager/Revenge Papyrus/Attacks/Bone.tscn")

var cutscene_counter = 0
var box

func cutscene(varbox): #YOU CAN CHOOSE WHAT PARAMETERS TO PASS IN
	box = varbox
	soul.position = varbox.rect_position + (varbox.rect_size / 2)
	soul.changeMovement("still")
	match cutscene_counter:
		0:
			varbox.resize(Vector2(300,140), null, 1, 1, 1.5)
			$Papyrus.bubble(["NYEH HEH HEH!! FUCK OFF, HUMANO"])
			yield($Papyrus.blitter, "next")
			$Papyrus/Bubble.visible = false
	
	emit_signal("cutscene_end")
	
func attack():
	soul.changeMovement("red")
	soul.changeMovement("blue")
	for i in range(3):
		var bone = bone_tscn.instance()
		bone.motion = Vector2(100,0)
		bone.switch_from("bot")
		box.attacks.add_child(bone)
		bone.global_position = box.rect_global_position + Vector2(-30, box.rect_size.y - 16)
		bone.visual.rect_size.y = 30
		yield(get_tree().create_timer(1), "timeout")
	box_adopts(soul, get_parent())
	box.move(Vector2.ZERO)
	for i in range(3):
		var bone = bone_tscn.instance()
		bone.motion = Vector2(100,0)
		bone.switch_from("bot")
		box.attacks.add_child(bone)
		bone.global_position = box.rect_global_position + Vector2(-30, box.rect_size.y - 16)
		bone.visual.rect_size.y = 30
		yield(get_tree().create_timer(1), "timeout")
	
	box.resize(Vector2(575,140), Vector2(32,250), 1, 1, 0.8)

	for i in range(5):
		var bone = bone_tscn.instance()
		bone.motion = Vector2(100,0)
		bone.switch_from("bot")
		box.attacks.add_child(bone)
		bone.global_position = box.rect_global_position + Vector2(-30, box.rect_size.y - 16)
		bone.visual.rect_size.y = 30
		yield(get_tree().create_timer(1), "timeout")
		if box.has_node("Soul"):
			box_adopts(soul, get_parent(), true)
		box.resize(Vector2(box.rect_size.x - 100, 140), null, 0, 1)
	
	yield(get_tree().create_timer(4), "timeout")
	
	box_adopts(soul, get_parent(), true)
	for child in box.attacks.get_children():
		child.queue_free()
	box.resize(Vector2(575,140), Vector2(32,250), 1, 1, 0.8)
	emit_signal("cutscene_end")

func box_adopts(node, from = self, reverse = false):
	if reverse:
		var node_pos = node.global_position 
		box.remove_child(node)
		from.add_child(node)
		node.global_position = node_pos
	else:
		var node_pos = node.global_position 
		from.remove_child(node)
		box.add_child(node)
		node.global_position = node_pos
