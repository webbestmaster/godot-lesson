extends CharacterBody2D

const speed = 15.0

enum CowState {
	walk,
	stay,
	blink
}

var cow_states:Array[CowState] = [
	CowState.walk,
	CowState.stay,
	CowState.blink,
]

var cow_states_no_blink:Array[CowState] = [
	CowState.walk,
	CowState.stay,
]

const animationMap = {
	CowState.walk: "Walk",
	CowState.stay: "Stay",
	CowState.blink: "Blink",
}

var cow_state: CowState = CowState.stay
var is_in_state_progress: bool = false

func _physics_process(delta):
	update_cow_state()
	move_and_slide()

func update_cow_state():
	if is_in_state_progress == false:
		is_in_state_progress = true
		var new_cow_state = cow_states[randi()%cow_states.size()]
		
		if new_cow_state == CowState.blink and cow_state == CowState.blink:
			new_cow_state = cow_states_no_blink[randi()%cow_states_no_blink.size()]
			
		cow_state = new_cow_state
		
		if cow_state == CowState.stay:
			print('CowState.stay')
			$ChangeStateTimer.start(0.8)
			create_tween().tween_property(self, 'velocity', Vector2(0, 0), 0.3)
			
		if cow_state == CowState.walk:
			var is_right: bool = randi() % 2 == 0
			var direction = Vector2(randi() % 10, randi() % 10).normalized()
			
			if is_right:
				$FreeCowSprites.scale = Vector2(1, 1)
			else:
				$FreeCowSprites.scale = Vector2(-1, 1)
				direction.x = -direction.x
				
			if randi() % 2 == 0:
				direction.y = -direction.y

			print('CowState.walk')
			$ChangeStateTimer.start(1.6)
			create_tween().tween_property(self, 'velocity', direction * speed, 0.3)

		if cow_state == CowState.blink:
			print('CowState.blink')
			$ChangeStateTimer.start(0.6)
			create_tween().tween_property(self, 'velocity', Vector2(0, 0), 0.3)
			
		$AnimationPlayer.play(animationMap[cow_state])

func _on_change_state_timer_timeout():
	is_in_state_progress = false
