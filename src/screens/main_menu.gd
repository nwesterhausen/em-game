extends CanvasLayer

onready var buttons = {
	"start": $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/BtnStart,
	"controls": $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/BtnControls,
	"settings": $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer4/BtnSettings,
	"quit": $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer3/BtnQuit,
	"credits": $CenterContainer/VBoxContainer/CenterContainer3/VBoxContainer/CenterContainer/BtnCredits,
   }

func _ready():
	var game_root = get_tree().get_root().get_node("root")
	buttons.start.connect("button_up", game_root, "load_screen", ["debug_menu"])
	buttons.controls.connect("button_up", game_root, "load_screen", ["controls"])
	buttons.settings.connect("button_up", game_root, "load_screen", ["settings"])
	buttons.credits.connect("button_up", game_root, "load_screen", ["credits"])
	buttons.quit.connect("button_up", self, "_quit_game")

func _quit_game():
	get_tree().quit()
