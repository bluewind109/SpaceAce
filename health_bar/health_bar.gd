extends TextureProgressBar

signal died

@export var level_low: int = 30
@export var level_med: int = 65
@export var start_health: int = 100

const COLOR_DANGER: Color = Color("#cc0000")
const COLOR_MID: Color = Color("#ff9900")
const COLOR_GOOD: Color = Color("#33cc33")

func _ready():
	max_value = start_health
	value = start_health


func set_color() -> void:
	if (value < level_low):
		tint_progress = COLOR_DANGER
	elif (value < level_med):
		tint_progress = COLOR_MID
	else:
		tint_progress = COLOR_GOOD


func incr_value(v: int) -> void:
	value += v
	if (value <= 0):
		died.emit()
	set_color()


func take_damage(v: int) -> void:
	incr_value(-v)





