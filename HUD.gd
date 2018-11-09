extends CanvasLayer

signal start_game

func _ready():
	$MessageTimer.connect("timeout", self, "_on_MessageTimer_timeout")
	$StartButton.connect("pressed", self, "_on_StartButton_pressed")

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start() # Empieza el contador de timer

func show_game_over():
	show_message("Game Over")
	yield($MessageTimer, "timeout")
	$StartButton.show()
	$MessageLabel.text = "Dodge the\nCreeps"
	$MessageLabel.show()
	
func update_score(score):
	$ScoreLabel.text = str(score)
	
func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")

func _on_MessageTimer_timeout():
	$MessageLabel.hide()