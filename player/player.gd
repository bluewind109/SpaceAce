extends Area2D

class_name Player

@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var shield = $Shield

@export var speed: float = 250.0
@export var bullet_scene: PackedScene
@export var bullet_speed: float = 250.0
@export var bullet_damage: int = 10
@export var bullet_direction: Vector2 = Vector2.UP

const MARGIN: float = 32.0

var _upper_left: Vector2
var _lower_right: Vector2

func _ready():
	set_limits()
	SignalManager.on_powerup_hit.connect(on_powerup_hit)


func _process(delta):
	var input = get_input()
	
	global_position += input * delta * speed
	global_position = global_position.clamp(
		_upper_left,
		_lower_right
	)
	
	if (Input.is_action_just_pressed("shoot")):
		shoot()


func set_limits() -> void:
	var vp = get_viewport_rect()
	_lower_right = Vector2(
		vp.size.x - MARGIN,
		vp.size.y - MARGIN,
	)
	_upper_left = Vector2(MARGIN, MARGIN)


func get_input() -> Vector2:
	var inputVector = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down"),
	)

	if (inputVector.x != 0):
		animation_player.play("turn")
		if (inputVector.x > 0):
			sprite_2d.flip_h = true
		else:
			sprite_2d.flip_h = false
	else:
		animation_player.play("fly")

	return inputVector.normalized()


func shoot() -> void:
	var bullet = bullet_scene.instantiate()
	bullet.setup(
		global_position,
		bullet_direction,
		bullet_speed,
		bullet_damage
	)
	get_tree().root.add_child(bullet)


func on_powerup_hit(power_up: GameData.POWERUP_TYPE) -> void:
	if (power_up == GameData.POWERUP_TYPE.SHIELD):
		shield.enable_shield()
	print("power_up: ", power_up)


func _on_area_entered(area):
	print("Player hit")
