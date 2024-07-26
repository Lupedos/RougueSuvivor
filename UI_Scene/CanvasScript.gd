extends CanvasLayer

@onready var Timer_label: Label = $Timer
@onready var Dinheiro_label: Label = $Dinheiro

var Time_elapsed: float = 0.0
var dinheiro_counter: int = 0

func _ready():
	GameManager.player.dinheiro_coletado.connect(dinheiro_coletado)
	Dinheiro_label.text = str("Dinheiro: " , dinheiro_counter)

func _process(delta: float):
	
	Time_elapsed += delta
	var time_elapsed_in_seconds: int = floori(Time_elapsed)
	var seconds: int = time_elapsed_in_seconds % 60
	var minutes: int = time_elapsed_in_seconds / 60
	Timer_label.text = "%02d:%02d" % [minutes,seconds]

func dinheiro_coletado(value: int) -> void:
	dinheiro_counter += value
	Dinheiro_label.text = str("Dinheiro: " , dinheiro_counter)
	
