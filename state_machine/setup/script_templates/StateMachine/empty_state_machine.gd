extends StateMachine

#class_name YourStateMachine

#enum State {
	#NONE = -1,
	#IDLE = 0,
	#RUNNING,
	#ATTACKING_1,
	#ATTACKING_2,
	#ATTACKING_3,
	#DEAD
#}
#
#enum Action {
	#MOVE = 0,
	#ATTACK,
	#GOT_HIT,
	#DIE,
#}
	
func handle_action(action, params = {}):
	if not _active:
		return
		
	#if action == State.Action.DIE:
		#if _states.front().get_state() == State.States.DEAD:
			#return
		#change_state(State.States.DEAD, {})
		#set_active(false)
		#return
#
	#if action == State.Action.ATTACK:
		#if _states.front().get_state() != State.States.ATTACKING_1:
			#return
		#change_state(State.States.ATTACKING_1, {}, true)

	_states.front().handle_action(action, params)
