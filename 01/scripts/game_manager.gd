extends Node

@onready var lbl_score = $LblScore

var score=0

func add_point():
	score += 1
	lbl_score.text="分數:"+str(score)
