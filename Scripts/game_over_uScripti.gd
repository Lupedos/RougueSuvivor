class_name GameOverUI
extends CanvasLayer

@onready var time_label: Label = $butaoPanel/CenterContainer/GridContainer/TempoVivo
@onready var Monstros_label: Label = $butaoPanel/CenterContainer/GridContainer/MonstrosMortos
@onready var dinheiro_label: Label = $butaoPanel/CenterContainer/GridContainer/Dinheiro

@export var restart_delay: float = 5.0
var restart_cooldown: float


func _ready():
	time_label.text = str("Tempo vivo: " , GameManager.Time_elapsed_string)
	Monstros_label.text = str("Monstros derrotados: ", GameManager.monster_counter)
	dinheiro_label.text = str("Dinheiro coletado: ",GameManager.dinheiro_counter)
	restart_cooldown = restart_delay
	
func _process(delta):
	restart_cooldown -= delta
	if restart_cooldown <= 0.0:
		restart_game()

func restart_game():
	GameManager.reset()
	get_tree().reload_current_scene()
	
	
