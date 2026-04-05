extends HBoxContainer
class_name ShopItem

@export var buy_button: Button
@export var price_label: Label
@export var item_label: Label
@export var item_icon: TextureRect

@export var item: SwagItem

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	buy_button.pressed.connect(_attempt_buy)
	initialize_from_item(item)
	
func _attempt_buy() -> void:
	if (PlayerSaveState.current_money >= item.price):
		PlayerSaveState.current_money -= item.price
		PlayerSaveState.items.append(item)
		queue_free()
		

func initialize_from_item(item: SwagItem) -> void:
	item_icon.texture = item.shop_icon
	price_label.text = str(item.price)
	item_label.text = item.name
