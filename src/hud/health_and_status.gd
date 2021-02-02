extends CanvasLayer

onready var bars = {
    "health": $VBoxContainer/HBoxContainer2/healthbar,
    "concentration": $VBoxContainer/HBoxContainer/concentrationbar,
   }


# Called when the node enters the scene tree for the first time.
func _ready():
    initializeBars()

func initializeBars():
    # Health Bar
    bars.health.max_value = PlayerStore.max_health
    bars.health.value = PlayerStore.health
    bars.health.tint_progress = Color.red
    
    # Concentration Bar
    bars.concentration.max_value = 1
    bars.concentration.step = 0.01
    bars.concentration.value = PlayerStore.concentration
    bars.concentration.tint_progress = Color.blue

func updateHealthValue():
    bars.health.value = PlayerStore.health

func updateConcentrationValue():
    bars.concentration.value = PlayerStore.concentration
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
