extends Node

signal on_powerup_hit(power_up: GameData.POWERUP_TYPE)
signal on_player_hit(damage: int)
signal on_player_health_bonus(value: int)
signal on_player_died
signal on_score_updated(value: int)
