extends Control

@onready var health_bar = $Background/MC/HB/HealthBar
@onready var score_label = $Background/MC/HB/ScoreLabel

func _ready():
	SignalManager.on_player_hit.connect(on_player_hit)
	SignalManager.on_player_health_bonus.connect(on_player_health_bonus)
	SignalManager.on_score_updated.connect(on_score_updated)


func on_player_hit(val: int) -> void:
	health_bar.take_damage(val)


func on_player_health_bonus(val: int) -> void:
	health_bar.incr_value(val)


func on_score_updated(val: int) -> void:
	score_label.text = "%06d" % val


func _on_health_bar_died():
	SignalManager.on_player_died.emit()
