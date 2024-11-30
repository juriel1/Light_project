extends AudioStreamPlayer3D

func _on_dead_zone_body_entered(body: Node3D) -> void:
	self.play()
