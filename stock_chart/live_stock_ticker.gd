extends Node2D

@export var horizontal_spacing: float = 50.0
@export var vertical_scaling: float = 1.0
@export var ticker_size: float = 10.0

var vertices: Array[Vector2]
var prices: Array[float]
var current_time_step: int = 0

var height: float = 300
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%TickTimer.timeout.connect(_on_tick_timeout)
	
func price_to_height(price: float) -> float:
	return height - price * vertical_scaling
	
func set_color(color: Color):
	%StockLine.default_color = color
	%StockPolygon.color = color
	
func _on_tick_timeout() -> void:
	var diff: float = (randi() % 50) - 25
	if prices.size() < 1:
		append_price(diff)
	else:
		append_price(prices[-1] + diff)
	if diff > 0:
		set_color(Color.GREEN_YELLOW)
	else:
		set_color(Color.RED)
	current_time_step += 1
	%TickTimer.start()
	
func create_vertex_for_price(price: float, time_step: int) -> Vector2:
	return Vector2(
		time_step * horizontal_spacing, 
		price_to_height(price)
	)
	
func create_polygons_from_price_vertices(floor: float):
	if vertices.size() < 2:
		return vertices
	var arr: Array[Vector2] = vertices.duplicate()
	arr.append(Vector2(vertices[-1].x, floor))
	arr.append(Vector2(vertices[0].x, floor))
	return arr
	
func append_price(price: float):
	prices.append(price)
	var vertex: Vector2 = create_vertex_for_price(price, current_time_step)
	vertices.append(vertex)
	%StockLine.points = vertices
	var price_polygon: Array[Vector2] = create_polygons_from_price_vertices(600)
	%StockPolygon.polygon = price_polygon

func draw_prices():
	for i in range(len(vertices)):
		if i > 0:
			draw_line(vertices[i-1], vertices[i], Color.GREEN)
		var size_vector: Vector2 = Vector2(ticker_size, ticker_size)
		draw_rect(Rect2((vertices[i] - size_vector/2), size_vector), Color.GREEN)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
