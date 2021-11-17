extends Control

export var border = 5

onready var attacks = $Attacks
onready var resize_tween = $Resize
onready var pos_tween = $Positioning
onready var shapes = $Collisions

func _ready():
	#resize(Vector2(100,100), 0)
	pass

func _process(delta):
	update_size()

func update_size():
	shapes.get_child(0).position.x = -100 + border
	shapes.get_child(1).position.y = -100 + border
	shapes.get_child(2).position.y = self.rect_size.y + 100 - border
	shapes.get_child(3).position.x = self.rect_size.x + 100 - border

func resize(dimension : Vector2, newpos = null, top = 1, bot = 1, time = 1.5):
	resize_tween.interpolate_property(
		self,
		"rect_size:y",
		self.rect_size.y,
		dimension.y,
		time,
		Tween.TRANS_QUINT,
		Tween.EASE_OUT
		)
	resize_tween.interpolate_property(
		self,
		"rect_size:x",
		self.rect_size.x,
		dimension.x,
		time,
		Tween.TRANS_QUINT,
		Tween.EASE_OUT
		)
	match top:
		0:
			pass
		1:
			resize_tween.interpolate_property(
				self,
				"rect_position:y",
				self.rect_position.y,
				self.rect_position.y + ((rect_size.y - dimension.y)/2.0),
				time,
				Tween.TRANS_QUINT,
				Tween.EASE_OUT
				)
		2:
			resize_tween.interpolate_property(
				self,
				"rect_position:y",
				self.rect_position.y,
				self.rect_position.y + ((rect_size.y - dimension.y)),
				time,
				Tween.TRANS_QUINT,
				Tween.EASE_OUT
				)
	match bot:
		0:
			pass
		1:
			resize_tween.interpolate_property(
				self,
				"rect_position:x",
				self.rect_position.x,
				self.rect_position.x + ((rect_size.x - dimension.x)/2.0),
				time,
				Tween.TRANS_QUINT,
				Tween.EASE_OUT
				)
		2:
			resize_tween.interpolate_property(
				self,
				"rect_position:x",
				self.rect_position.x,
				self.rect_position.x + ((rect_size.x - dimension.x)),
				time,
				Tween.TRANS_QUINT,
				Tween.EASE_OUT
				)
	
	resize_tween.start()
	if newpos != null:
		pos_tween.interpolate_property(
			self,
			"rect_position",
			self.rect_position,
			newpos,
			time + 0.1,
			Tween.TRANS_QUINT,
			Tween.EASE_OUT
			)
		pos_tween.start()

func move(newpos : Vector2, time = 1.0):
	pos_tween.interpolate_property(
		self,
		"rect_position",
		self.rect_position,
		newpos,
		time,
		Tween.TRANS_QUINT,
		Tween.EASE_OUT
		)
	pos_tween.start()

func add_attack(node):
	attacks.add_child(node)
	print(node.global_position)
