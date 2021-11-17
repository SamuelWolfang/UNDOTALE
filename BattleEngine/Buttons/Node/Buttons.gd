extends Node2D

var input
var selection = 0

var enable = false

var positionArray = [50,205,362,517]
var soul

onready var children = self.get_children().slice(0,3)

signal select

func enable(soul):
	self.soul = soul
	connect("select", self, "disable")
	self.enable = true

func _process(delta):
	if enable:
		input = int(Input.is_action_just_pressed("ui_right")) - int(Input.is_action_just_pressed("ui_left"))
		
		if input:
			get_parent().get_node("Squeak").play()
		
		children[selection].frame = 0
		selection = (selection + input) % 4
		children[selection].frame = 1
		
		soul.position = Vector2(positionArray[selection], 453)
		
		if Input.is_action_just_pressed("ui_accept"):
			get_parent().get_node("Select").play()
			emit_signal("select")

func disable():
	self.enable = false
	disconnect("select", self, "disable")

func turn_off():
	for child in get_children():
		child.frame = 0

func selection():
	return children[selection].name
