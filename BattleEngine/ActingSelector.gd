extends Node2D

var input = Vector2.ZERO
var selection = 0

var enable = false

var positionArray = [Vector2(80,285), Vector2(320,285),
					Vector2(80,315), Vector2(320,315),
					Vector2(80,350), Vector2(320,350)]
var soul

var list = []

signal select

func enable(soul):
	self.soul = soul
	connect("select", self, "disable")
	yield(get_tree().create_timer(0.1), "timeout")
	self.enable = true

func _process(delta):
	if enable:
		input.x = int(Input.is_action_just_pressed("ui_right")) - int(Input.is_action_just_pressed("ui_left"))
		input.y = (int(Input.is_action_just_pressed("ui_down")) - int(Input.is_action_just_pressed("ui_up"))) * 2
		
		if input:
			get_parent().get_node("Squeak").play()
		
		selection = int(selection + input.x + input.y) % list.size()
		
		soul.position = positionArray[selection]
		
		if Input.is_action_just_pressed("ui_accept"):
			self.enable = false
			get_parent().get_node("Select").play()
			emit_signal("select")
		elif Input.is_action_just_pressed("ui_cancel"):
			get_parent().get_node("Squeak").play()
			emit_signal("select")

func string():
	var string = ""
	for index in range(list.size()):
		var option = list[index]
		if index % 2 == 1:
			for spaces in range(14 - len(list[index-1])):
				string += " "
			string += "* " + option + "\n"
		else:
			string += "\t\t* " + option
	return string

func disable():
	disconnect("select", self, "disable")

func selection():
	return list[selection]
