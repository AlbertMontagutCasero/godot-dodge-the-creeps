extends Node

export (PackedScene) var Mob
var score

func _ready():
	$Player.connect("hit", self, "game_over")
	$StartTimer.connect("timeout", self, "_on_StartTimer_timeout")
	$ScoreTimer.connect("timeout", self, "_on_ScoreTimer_timeout")
	$MobTimer.connect("timeout", self, "_on_MobTimer_timeout")
	$HUD.connect("start_game", self, "new_game")
	randomize()

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathMusic.play()

func new_game():
	score = 0
	$HUD.update_score(score)
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.show_message("Get Ready")
	$Music.play()

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_MobTimer_timeout():
	# Choose a random location on Path2D.
	$MobPath/MobSpawnLocation.set_offset(randi())

	var mob = Mob.instance()
	add_child(mob)
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	mob.position = $MobPath/MobSpawnLocation.position
	direction += rand_range( -PI / 4 , PI / 4)
	mob.rotation = direction
	mob.set_linear_velocity(Vector2(rand_range(mob.min_speed, mob.max_speed), 0).rotated(direction))

