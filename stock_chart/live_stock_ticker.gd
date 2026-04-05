extends Container
class_name StockTicker

@export var horizontal_spacing: float = 50.0
@export var vertical_scaling: float = 3.0
@export var ticker_size: float = 10.0

@export var follow_ticks: bool = true

var vertices: Array[Vector2]
var prices: Array[Price]

var origin_y: float
var origin_x: float
var size_x: float
var size_y: float
var floor: float = 0
var offset: Vector2 = Vector2.ZERO

var initialized: bool = false
	
func _ready() -> void:
	await get_tree().process_frame
	size_x = get_global_rect().size.x
	size_y = get_global_rect().size.y
	var position_x = get_global_rect().position.x
	var position_y = get_global_rect().position.y
	origin_y = (position_y/size_y) + (size_y/2)
	origin_x = (position_x/size_x)
	floor = origin_y + size_y/2
		
		
func price_to_height(price: Price) -> float:
	return origin_y - price.price * vertical_scaling
	
func get_latest_price() -> Price:
	if prices.size() > 0:
		return prices[-1]
	return null
	
func price_to_offset(price: Price) -> float:
	return origin_x + price.time * horizontal_spacing
	
func set_color(color: Color):
	%StockLine.default_color = color
	%StockPolygon.color = color
	
func create_vertex_for_price(price: Price) -> Vector2:
	return Vector2(
		price_to_offset(price), 
		price_to_height(price)
	)
	
func transform_verticies() -> Array[Vector2]:
	var arr: Array[Vector2]
	for vert in vertices:
		arr.append(vert - offset)
	return arr
	
func create_polygons_from_price_vertices():
	var transformed_vertices = transform_verticies()
	if follow_ticks:
		transformed_vertices = transformed_vertices.slice(-20)
	transformed_vertices.append(Vector2((transformed_vertices[-1]).x, floor))
	transformed_vertices.append(Vector2((transformed_vertices[0]-offset).x, floor))
	return transformed_vertices
	
func append_price(price: Price):
	prices.append(price)
	var vertex: Vector2 = create_vertex_for_price(price)
	vertices.append(vertex)
	if follow_ticks:
		offset = Vector2(max(0,(price_to_offset(prices[-1])) - (origin_x + get_global_rect().size.x/2)), price_to_height(prices[-1]) - origin_y)
	%StockLine.points = transform_verticies()
	var price_polygon: Array[Vector2] = create_polygons_from_price_vertices()
	if follow_ticks:
		%StockPolygon.polygon = price_polygon
		
