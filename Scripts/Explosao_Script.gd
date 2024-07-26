extends Node2D

@export var damage: int = 30

@onready var area2d: Area2D = $Area2D


func deal_damage():
	var bodies = area2d.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("Inimigos"):
			var enemy: Inimigo = body
			enemy.damage(damage)
		if body.is_in_group("Player"):
			var player: Player = body
			player.damage(damage)

