extends Node2D

export var NAME = "Papyrus"

var ATK = 10
var DEF = 30

var check_line = "He is just a test monster after all"
var actings = ["Check", "Hey", "DidYouKnw", "ThatIdont", "knowhowto", "makeaMojito"]

var HP = 100
export var spareable = true
var spared = false
var store_amnt = 0

signal done
onready var blitter = $Bubble/Blitter

func _ready():
	$Animations.play("Idle")
	connect("done", self, "test")
	var click = preload("res://Shared/Text/Clicks/Files/papyrus.wav")
	$Bubble/Blitter/Click.stream = click

func spare():
	spared = true
	self.modulate.a = 0.3

func shake(amount):
	if store_amnt == 0:
		store_amnt = (amount/100.0) + 0.01
	var offset_sign = (int($Sprite.position.x >= 0) * 2) - 1
	$Sprite.position.x = -(amount * offset_sign)
	amount -= 1
	var test = amount/100.0
	yield(get_tree().create_timer(store_amnt - test), "timeout")
	if amount != 0:
		shake(amount)
	else:
		store_amnt = 0

func acting():
	#Custom behaviour!
	pass

func bubble(line):
	$Bubble.visible = true
	blitter.feed(line)
