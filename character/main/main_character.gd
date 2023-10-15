extends CharacterBody2D

const defaultSpeed = 60.0
enum DirectionEnum {up, down, left, right}

const animationMap = {
	idle = {
		DirectionEnum.up: "IdleUp",
		DirectionEnum.down: "IdleDown",
		DirectionEnum.left: "IdleLeft",
		DirectionEnum.right: "IdleRight",
	},
	run = {
		DirectionEnum.up: "RunUp",
		DirectionEnum.down: "RunDown",
		DirectionEnum.left: "RunLeft",
		DirectionEnum.right: "RunRight",
	},
}

func _ready():
	$Character/AnimationPlayer.play("IdleDown")

var last_movement: Vector2 = Vector2(0.0, 0.0)

func _physics_process(_delta: float) -> void:
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	var direction: DirectionEnum = get_direction(direction_x, direction_y)
	var new_movement: Vector2 = Vector2(direction_x, direction_y)

	if new_movement != last_movement:
		last_movement = new_movement
		if direction_x == 0 and direction_y == 0:
			$Character/AnimationPlayer.play(animationMap.idle[direction])
		else:
			$Character/AnimationPlayer.play(animationMap.run[direction])

		create_tween().tween_property(self, 'velocity', Vector2(direction_x, direction_y).normalized() * defaultSpeed, 0.2)

	move_and_slide()

var last_direction: DirectionEnum = DirectionEnum.down

func get_direction(direction_x, direction_y) -> DirectionEnum:
	if direction_y < 0: last_direction = DirectionEnum.up
	if direction_y > 0: last_direction = DirectionEnum.down
	if direction_x < 0: last_direction = DirectionEnum.left
	if direction_x > 0: last_direction = DirectionEnum.right
	return last_direction
