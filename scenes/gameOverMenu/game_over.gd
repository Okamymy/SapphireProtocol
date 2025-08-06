extends Control

func _on_play_again_pressed():
	TdSystemMb.megabytes=80
	TdSystemGameManager.change_scene("res://scenes/TD/levels/level0/level00.tscn")

func _on_exit_pressed():
	TdSystemGameManager.change_scene("res://scenes/MainMenu/MainMenul.tscn")
	
