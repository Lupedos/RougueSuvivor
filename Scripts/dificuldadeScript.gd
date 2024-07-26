extends Node

@export var mob_spanner: MobSpawnner
@export var inicial_dificuldade: float = 60.0
@export var mob_increase_por_minutos: float = 30.0
@export var wave_duration: float = 20.0
@export var break_intensity: float = 0.5
var time: float = 0.0

func _process(delta: float) -> void:
	if GameManager.is_game_over: return
	time += delta
	
	var spawn_rate = inicial_dificuldade + mob_increase_por_minutos +(time/60.0)
	
	var sin_wave = sin((time * TAU)/ wave_duration)
	var wave_factor = remap(sin_wave, -1.0, 1.0, break_intensity,1)
	spawn_rate *= wave_factor
	
	mob_spanner.mob_por_minuto = spawn_rate
