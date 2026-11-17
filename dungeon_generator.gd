
extends Node2D

const MAP_WIDTH = 60
const MAP_HEIGHT = 36
const TILE_SIZE = 16
const MIN_REGION = 12
const MAX_DEPTH = 4

const WALL = 0
const FLOOR = 1

var grid = []
var rooms = []
var rng = RandomNumberGenerator.new()
var seed_value = 0

func _ready():
	generate_dungeon()

func _unhandled_key_input(event):
	if event is InputEventKey:
		if event.pressed and not event.echo:
			if event.keycode == KEY_SPACE:
				generate_dungeon()

func generate_dungeon():
	rng.randomize()
	seed_value = rng.seed

	grid.clear()
	rooms.clear()

	for y in range(MAP_HEIGHT):
		var row = []
		for x in range(MAP_WIDTH):
			row.append(WALL)
		grid.append(row)

	split_region(Rect2i(1, 1, MAP_WIDTH - 2, MAP_HEIGHT - 2), 0)

	queue_redraw()
	print("Mazmorra generada. Semilla: ", seed_value)
	print("Habitaciones: ", rooms.size())

func split_region(region: Rect2i, depth: int) -> Vector2i:
	var can_split_vertical = region.size.x >= MIN_REGION * 2
	var can_split_horizontal = region.size.y >= MIN_REGION * 2

	if depth >= MAX_DEPTH or (
		not can_split_vertical and not can_split_horizontal
	):
		return create_room(region)

	var vertical = rng.randi_range(0, 1) == 0

	if not can_split_vertical:
		vertical = false
	elif not can_split_horizontal:
		vertical = true

	var first: Rect2i
	var second: Rect2i

	if vertical:
		var cut = rng.randi_range(
			MIN_REGION, region.size.x - MIN_REGION
		)

		first = Rect2i(
			region.position.x,
			region.position.y,
			cut,
			region.size.y
		)

		second = Rect2i(
			region.position.x + cut,
			region.position.y,
			region.size.x - cut,
			region.size.y
		)
	else:
		var cut = rng.randi_range(
			MIN_REGION, region.size.y - MIN_REGION
		)

		first = Rect2i(
			region.position.x,
			region.position.y,
			region.size.x,
			cut
		)

		second = Rect2i(
			region.position.x,
			region.position.y + cut,
			region.size.x,
			region.size.y - cut
		)

	var center_a = split_region(first, depth + 1)
	var center_b = split_region(second, depth + 1)

	connect_rooms(center_a, center_b)

	return center_a

func create_room(region: Rect2i) -> Vector2i:
	var max_w = region.size.x - 2
	var max_h = region.size.y - 2

	var width = rng.randi_range(4, max(4, max_w))
	var height = rng.randi_range(4, max(4, max_h))

	var x = rng.randi_range(
		region.position.x + 1,
		region.position.x + region.size.x - width - 1
	)

	var y = rng.randi_range(
		region.position.y + 1,
		region.position.y + region.size.y - height - 1
	)

	for yy in range(y, y + height):
		for xx in range(x, x + width):
			grid[yy][xx] = FLOOR

	var center = Vector2i(
		x + int(width / 2),
		y + int(height / 2)
	)

	rooms.append(Rect2i(x, y, width, height))
	return center

func connect_rooms(a: Vector2i, b: Vector2i):
	if rng.randi_range(0, 1) == 0:
		carve_horizontal(a.x, b.x, a.y)
		carve_vertical(a.y, b.y, b.x)
	else:
		carve_vertical(a.y, b.y, a.x)
		carve_horizontal(a.x, b.x, b.y)

func carve_horizontal(x1: int, x2: int, y: int):
	for x in range(min(x1, x2), max(x1, x2) + 1):
		grid[y][x] = FLOOR

func carve_vertical(y1: int, y2: int, x: int):
	for y in range(min(y1, y2), max(y1, y2) + 1):
		grid[y][x] = FLOOR

func _draw():
	if grid.is_empty():
		return

	for y in range(MAP_HEIGHT):
		for x in range(MAP_WIDTH):
			var color = Color("#17212b")

			if grid[y][x] == FLOOR:
				color = Color("#b9b6a5")

			draw_rect(
				Rect2(
					x * TILE_SIZE,
					y * TILE_SIZE,
					TILE_SIZE - 1,
					TILE_SIZE - 1
				),
				color
			)

	for room in rooms:
		draw_rect(
			Rect2(
				room.position.x * TILE_SIZE,
				room.position.y * TILE_SIZE,
				room.size.x * TILE_SIZE,
				room.size.y * TILE_SIZE
			),
			Color("#50d6a3"),
			false,
			2.0
		)
