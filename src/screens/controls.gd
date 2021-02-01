extends CanvasLayer

onready var main_buttons = {
	"back": $BtnBack,
   }


# Called when the node enters the scene tree for the first time.
func _ready():
	var game_root = get_tree().get_root().get_node("root")
	main_buttons.back.connect("button_up", game_root, "load_screen", ["main_menu"])


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
