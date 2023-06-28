extends RichTextLabel

var dead = false

func _ready():
	$"../Player".died.connect(_player_died)

func _process(_delta):
	if not dead:
		text = str($"../Player".health)
	else:
		text = "0"

func _player_died():
	dead = true
