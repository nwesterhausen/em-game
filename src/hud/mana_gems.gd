extends CanvasLayer

onready var gem_display = [
	$CenterContainer/gem0,
	$CenterContainer/gem1,
	$CenterContainer/gem2,
	$CenterContainer/gem3
]

var gem_elements = [0,0,0,0]


# Called when the node enters the scene tree for the first time.
func _ready():
	_init_gem_elements()

func _init_gem_elements():
	var gemdiffs = PlayerStore.elemental_affinities.size()
	for i in range(4):
		gem_elements[i] = PlayerStore.elemental_affinities[0]
		if i > 1 && gemdiffs > 1:
			gem_elements[i] = PlayerStore.elemental_affinities[1]
		gem_display[i].modulate = Global.element_colors[gem_elements[i]]

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
