extends Node2D

@export  var explosao: PackedScene


func explodiu() -> void:
	var obj_explosao = explosao.instantiate()
	obj_explosao.position = position
	get_parent().add_child(obj_explosao)
	queue_free()
	
	
	pass 
