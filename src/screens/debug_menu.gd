extends CanvasLayer

onready var affinity_buttons = [
	$VBoxContainer/CenterContainer/HBoxContainer/CenterContainer/VBoxContainer/checkWater,
	$VBoxContainer/CenterContainer/HBoxContainer/CenterContainer/VBoxContainer/checkIce,
	$VBoxContainer/CenterContainer/HBoxContainer/CenterContainer/VBoxContainer/checkGround,
	$VBoxContainer/CenterContainer/HBoxContainer/CenterContainer/VBoxContainer/checkFire,
	$VBoxContainer/CenterContainer/HBoxContainer/CenterContainer/VBoxContainer/checkAir,
	$VBoxContainer/CenterContainer/HBoxContainer/CenterContainer/VBoxContainer/checkElectric,
	$VBoxContainer/CenterContainer/HBoxContainer/CenterContainer/VBoxContainer/checkLife,
	$VBoxContainer/CenterContainer/HBoxContainer/CenterContainer/VBoxContainer/checkNecrotic,
	$VBoxContainer/CenterContainer/HBoxContainer/CenterContainer/VBoxContainer/checkArcane
]

onready var buttons = {
	"back": $VBoxContainer/HBoxContainer/btnBack,
	"start": $VBoxContainer/HBoxContainer/btnStart,
	}

# Called when the node enters the scene tree for the first time.
func _ready():
	# Register affinity selection buittons
	for i in range(affinity_buttons.size()):
		affinity_buttons[i].connect("button_up",self,"_select_element",[i])
	for el in PlayerStore.elemental_affinities:
		affinity_buttons[el].pressed = true
	_disable_buttons()
	
	# Register back | start buttons
	var game_root = get_tree().get_root().get_node("root")
	buttons.start.connect("button_up", game_root, "load_screen", ["game"])
	buttons.back.connect("button_up", game_root, "load_screen", ["main_menu"])

func _select_element(index):
	if affinity_buttons[index].is_pressed():
		# Selected element
		if PlayerStore.elemental_affinities.has(index):
			print('Tried to add duplicate element to affinity list',index)
			return
		PlayerStore.elemental_affinities.push_back(index);
	else:
		# Deselected elment
		if !PlayerStore.elemental_affinities.has(index):
			print('Tried to deselect element not in affinity list',index)
			return
		PlayerStore.elemental_affinities.erase(index)
	_disable_buttons()
	print('Currently chosen elements',PlayerStore.elemental_affinities)
	
func _disable_buttons():
	if PlayerStore.elemental_affinities.size() == 2:
		for i in range(affinity_buttons.size()):
			if !PlayerStore.elemental_affinities.has(i):
				affinity_buttons[i].disabled = true;
	else:
		for i in range(affinity_buttons.size()):
			affinity_buttons[i].disabled = false;
