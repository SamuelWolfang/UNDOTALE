extends RichTextLabel

onready var click_node = $Click

var line = ["Test! One two three, one two three", [-1], [0.035, 0.5], false]
var click = preload("res://Shared/Text/Clicks/Files/generic2.wav")

var ongoing = false
export var skippable = false

signal next

onready var timer = $Timer

func _ready():
	connect("next", self, "next")
	click_node.stream = click

func _process(delta):
	if skippable:
		if Input.is_action_just_pressed("ui_accept") and !ongoing:
			emit_signal("next")
		elif Input.is_action_just_pressed("ui_cancel") and ongoing:
			freeze()

func freeze():
	timer.stop()
	ongoing = false
	visible_characters = len(line[0])

func feed(args = [""]):
	
	ongoing = true
	
	timer.stop()
	
	for index in range(args.size()):
		if args[index] != null:
			line[index] = args[index]

	bbcode_text = ""
	visible_characters = 0
	
	bbcode_text = line[0]
	yield(get_tree().create_timer(0.1), "timeout")
	
	if line[3]:
		visible_characters = len(line[0])
		return

	nextChar()

func nextChar():
	if visible_characters < len(line[0]):
		visible_characters += 1
		click_node.play()
		var check = int(visible_characters in line[1])
		timer.start(line[2][check])
	else:
		ongoing = false

func next():
	visible_characters = 0

func _on_text_timeout():
	nextChar()
