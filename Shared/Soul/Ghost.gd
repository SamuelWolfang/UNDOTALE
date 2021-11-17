extends Sprite

var enable = false

func _ready():
	self.scale = Vector2(0.5, 0.5)

func _process(_delta):
	self.scale += Vector2(0.1, 0.1)
	self.modulate.a -= 0.05
	
	if self.modulate.a <= 0:
		self.queue_free()
