extends VBoxContainer
class_name ItemContainer

var items: Array[SwagItem]
var shop_item_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().mouse_entered.connect(_bring_item_to_front)
	items.clear()
	for item in PlayerSaveState.unlocked_items:
		if item not in PlayerSaveState.items:
			items.append(item)
	shop_item_scene = preload("res://shop/shop_item.tscn")
	for item in items:
		var shop_item_bar = shop_item_scene.instantiate()
		shop_item_bar.item = item
		add_child(shop_item_bar)
		
func _bring_item_to_front() -> void:
	z_index += 2
