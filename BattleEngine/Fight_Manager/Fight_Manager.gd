class_name Fight_Manager
extends Node2D

var input
var selection = 0

var enable = false

var possiblePositions = [285,315,350]
var positionArray = []
var soul

var children = []

var cutscene = []

signal select
signal cutscene_end

func _ready():
	connect("cutscene_end", self, "selection")

func _process(delta):
	if enable:
		input = int(Input.is_action_just_pressed("ui_down")) - int(Input.is_action_just_pressed("ui_up"))
		
		if input:
			get_parent().get_node("Squeak").play()
		
		selection = (selection + input) % children.size()
		soul.position = Vector2(80, positionArray[selection])
		
		if Input.is_action_just_pressed("ui_accept"):
			self.enable = false
			get_parent().get_node("Select").play()
			emit_signal("select")
		elif Input.is_action_just_pressed("ui_cancel"):
			get_parent().get_node("Squeak").play()
			emit_signal("select")

func enable(soul):
	children.clear()
	for child in get_children():
		if !child.spared:
			children.append(child)

	positionArray = possiblePositions.slice(0, children.size() - 1)
	self.soul = soul
	connect("select", self, "disable")
	yield(get_tree().create_timer(0.1), "timeout")
	self.enable = true

func disable():
	disconnect("select", self, "disable")

func string():
	var string = ""
	for child in children:
		var monster = "\t\t* " + child.NAME + "\n"
		if child.spareable:
			monster = "[color=yellow]" + monster + "[/color]"
		string += monster
	return string

func selection():
	return children[selection]

func select():
	pass
