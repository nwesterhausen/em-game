extends CanvasLayer

onready var gem_display = [
	$CenterContainer/gem0,
	$CenterContainer/gem1,
	$CenterContainer/gem2,
	$CenterContainer/gem3
]

onready var element_words = [
	$elementAffinity1,
	$elementAffinity2
]

onready var fonts = {
	"bold": preload("res://src/ui/fonts/Abassy.tres"),
	"normal": preload("res://src/ui/fonts/MavenPro.tres"),
}

var gem_elements = [0,0,0,0]


# Called when the node enters the scene tree for the first time.
func _ready():
	highlight_active_element()
	_init_gem_elements()

func _init_gem_elements():
	var gemdiffs = PlayerStore.elemental_affinities.size()
	for i in range(4):
		gem_elements[i] = PlayerStore.elemental_affinities[0]
		if i > 1 && gemdiffs > 1:
			gem_elements[i] = PlayerStore.elemental_affinities[1]
		gem_display[i].modulate = Global.element_colors[gem_elements[i]]

func highlight_active_element():
	for i in PlayerStore.elemental_affinities.size():
		if i == PlayerStore.active_element:
			element_words[i].set("custom_fonts/font", fonts.bold)
		else:
			element_words[i].set("custom_fonts/font", fonts.normal)
		element_words[i].text = Lang.element_names[PlayerStore.elemental_affinities[i]]
		print(element_words[i].text, ' | ',  i == PlayerStore.active_element)
