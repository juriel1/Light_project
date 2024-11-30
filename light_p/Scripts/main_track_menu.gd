extends AudioStreamPlayer2D

@export var intro:bool
@export var main_track:AudioStream
@export var inter_track:AudioStream

func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	if intro:
		self.stream = main_track
		self.play()
		print("F track")
	

func _on_timer_main_menu_timeout() -> void:
	self.stream = main_track
	self.play()
	print("track menu")

func _on_timer_inter_menu_timeout() -> void:
	self.stream = inter_track
	self.play()
	print("track inter")
