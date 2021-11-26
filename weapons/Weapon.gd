extends Node2D
class_name Weapon

export var MAX_AMMO = 500
export var RELOAD_TIME := 1.5
export var CROSS_HAIR: Texture

export var RELOAD_SOUND: AudioStream

# Properties
var weapon_name: String
var active := false

# Fields
var ammo = 0

var crosshair: Texture
var crosshair_offsets

# Node
var reload_timer := Timer.new()

func _ready():
	ammo = MAX_AMMO # Set from export
	
	reload_timer.one_shot = true
	reload_timer.autostart = false
	reload_timer.connect("timeout", self, "_reload")
	add_child(reload_timer)
	
	crosshair = CROSS_HAIR
	crosshair_offsets = Vector2(crosshair.get_width()/2.0, crosshair.get_height()/2.0)
	
func use():
	if Input.is_action_just_pressed("reload") and reload_timer.time_left == 0:
		start_reload()
		
	if can_shoot():
		on_active()
	
	
func switch():
	Input.set_custom_mouse_cursor(crosshair, 0, crosshair_offsets)
	on_switch()
	
func switch_out():
	start_reload()
	on_switch_out()

# Called every frame when active
func on_active():
	pass
	
# Called on the single frame when the weapon is changed to this weapon
func on_switch():
	pass

# Called on the single frame when the weapon is changed from this weapon
func on_switch_out():
	pass
	
func can_shoot() -> bool:
	return ammo > 0 and reload_timer.time_left == 0
	
func reloading() -> bool:
	return reload_timer.time_left != 0
	
func start_reload():
	on_switch_out()
	reload_timer.start(RELOAD_TIME)
	
	
func _reload():
	ammo = MAX_AMMO
