extends CharacterBody2D

const speed = 15.0

enum ChickenState {
	walk,
	stay,
	blink
}

var chicken_states:Array[ChickenState] = [
	ChickenState.walk,
	ChickenState.stay,
	ChickenState.blink,
]

var chicken_states_no_blink:Array[ChickenState] = [
	ChickenState.walk,
	ChickenState.stay,
]

const animationMap = {
	ChickenState.walk: "Walk",
	ChickenState.stay: "Stay",
	ChickenState.blink: "Blink",
}

var chicken_state: ChickenState = ChickenState.stay
var is_in_state_progress: bool = false

func _physics_process(_delta):
	update_chicken_state()
	move_and_slide()

func update_chicken_state():
	if is_in_state_progress == false:
		is_in_state_progress = true
		var new_chicken_state = chicken_states[randi()%chicken_states.size()]
		
		if new_chicken_state == ChickenState.blink and chicken_state == ChickenState.blink:
			new_chicken_state = chicken_states_no_blink[randi()%chicken_states_no_blink.size()]
			
		chicken_state = new_chicken_state
		
		if chicken_state == ChickenState.stay:
			print('ChickenState.stay')
			$ChangeStateTimer.start(0.8)
			create_tween().tween_property(self, 'velocity', Vector2(0, 0), 0.2)
			
		if chicken_state == ChickenState.walk:
			var is_right: bool = randi() % 2 == 0
			var direction = Vector2(randi() % 10, randi() % 10).normalized()
			
			if is_right:
				$FreeChickenSprites.scale = Vector2(1, 1)
			else:
				$FreeChickenSprites.scale = Vector2(-1, 1)
				direction.x = -direction.x
				
			if randi() % 2 == 0:
				direction.y = -direction.y

			print('ChickenState.walk')
			$ChangeStateTimer.start(1.6)
			create_tween().tween_property(self, 'velocity', direction * speed, 0.3)

		if chicken_state == ChickenState.blink:
			print('ChickenState.blink')
			$ChangeStateTimer.start(0.6)
			create_tween().tween_property(self, 'velocity', Vector2(0, 0), 0.3)
			
		$AnimationPlayer.play(animationMap[chicken_state])

func _on_change_state_timer_timeout():
	is_in_state_progress = false
