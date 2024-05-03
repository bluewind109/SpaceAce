extends Node

var _score: int = 0
var _highscore: int = 0

func get_score() -> int:
	return _score


func get_highscore() -> int:
	return _highscore


func increment_score(val: int) -> void:
	_score += val
	if (_highscore < _score):
		_highscore = _score
	SignalManager.on_score_updated.emit(_score)


func reset_score() -> void:
	_score = 0
	SignalManager.on_score_updated.emit(_score)




