class_name List
extends Node2D

var list = []

var selection = 0
var input = Vector2.ZERO

var enable = false
var list_increase = Vector2.ZERO

signal select
signal exit

func enable():
	connect("select", self, "select")
	enable = true

func _process(delta):
	if enable:
		input.x = (int(Input.is_action_just_pressed("ui_right")) - int(Input.is_action_just_pressed("ui_left"))) * list_increase.x
		input.y = (int(Input.is_action_just_pressed("ui_down")) - int(Input.is_action_just_pressed("ui_up"))) * list_increase.y

		selection = int(selection + input.x + input.y) % list.size()
		
		if Input.is_action_just_pressed("ui_accept"):
			emit_signal("select")
			disable()

func disable():
	disconnect("select", self, "select")
	enable = false

func select():
	return list[selection]
