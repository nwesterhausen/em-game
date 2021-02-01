extends KinematicBody2D

var basic_attack = preload("res://src/objects/basic_attack/basic_attack.tscn")

onready var sprite = $Sprite
onready var anim_mach = $AnimationTree.get("parameters/playback")

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_input(true)
	# Set the collision shape to be a grid square
	get_node("CollisionShape2D").set_shape(GridController.GridShape);
	
	# Set initial position to position from tile
	self.position = snapped_pos();
	# Resize sprite to be grid size
	#sprite.offset = Vector2(0,sprite_height - 2.5*GridCtrl.gdelta);

func _process(delta):
	tick_cooldowns(delta)
	
	# Handle Movement
	var velocity = Vector2()
	
	if (Input.is_action_pressed("ui_up")):
		velocity += Vector2.UP
	if (Input.is_action_pressed("ui_left")):
		velocity += Vector2.LEFT
		sprite.scale.x = -1
	if (Input.is_action_pressed("ui_right")):
		velocity += Vector2.RIGHT
		sprite.scale.x = 1
	if (Input.is_action_pressed("ui_down")):
		velocity += Vector2.DOWN
	
	if velocity == Vector2.ZERO:
		if position != snapped_pos():
			var closeness = (snapped_pos().x - position.x)+(snapped_pos().y - position.y)
			if closeness < 1:
				position = snapped_pos()
			else:
				velocity = (snapped_pos() - position).normalized();			
	else:
		velocity = velocity.normalized() * PlayerStore.speed * delta
		anim_mach.travel("run")
	
	var collision = move_and_collide(velocity);
	
	if collision:
		print("Player collided with ", collision.collider.name)
	
	# Update grid position
	GridController.player_tile = GridController.pos_to_tile(position);

func _input(event):
	# Set Casting State
	PlayerStore.reset_targeting_state()
	if event.is_action_pressed("ui_spell_1"):
		PlayerStore.targeting_wall = true
	if event.is_action_pressed("ui_spell_2"):
		PlayerStore.targeting_side = true
	if event.is_action_pressed("ui_spell_3"):
		PlayerStore.targeting_area = true
	
	# Swap Active Element
	if event.is_action_pressed("ui_cast_alt"):
		PlayerStore.active_element += 1
		if PlayerStore.active_element >= PlayerStore.elemental_affinities.size():
			PlayerStore.active_element = 0
	
	# Cast spells
	if event.is_action_pressed("ui_cast"):
		if GridController.mouse_tile.x < GridController.player_tile.x:
			sprite.scale.x = -1
		else:
			sprite.scale.x = 1
			
		if PlayerStore.targeting_wall:
			print("Casted wall")
		elif PlayerStore.targeting_side:
			print("Casting side")
		elif PlayerStore.targeting_area:
			print("Casted platform")
		else:
			cast_basic()


func snapped_pos():
	# Since origin is centered, we adjust the position to line up with the grid
	# for the initial placement (halfway into grid)
	return GridController.tile_to_pos(GridController.player_tile) + 0.5*GridController.gsize_vector;
	
# If our cooldown is 0, cast a basic spell from the spell book for the current element    
func cast_basic():
	if PlayerStore.cooldowns[Global.SpellTypes.BASIC] == 0:
		var b = basic_attack.instance()
		b.element = PlayerStore.elemental_affinities[PlayerStore.active_element]
		add_child(b);
		PlayerStore.cooldowns[Global.SpellTypes.BASIC] = Global.basic_cooldown_timer[Global.basic_spell_weight[PlayerStore.elemental_affinities[PlayerStore.active_element]]]



# Tick spell cooldowns to 0
func tick_cooldowns(delta):
	for type in Global.SpellTypes:
		if PlayerStore.cooldowns[Global.SpellTypes[type]] != 0:
			PlayerStore.cooldowns[Global.SpellTypes[type]] -= delta;
		# If cooldown went negative, correct. Will catch "changes" outside of this
		# function as well.
		if PlayerStore.cooldowns[Global.SpellTypes[type]] < 0:
			PlayerStore.cooldowns[Global.SpellTypes[type]] = 0;
