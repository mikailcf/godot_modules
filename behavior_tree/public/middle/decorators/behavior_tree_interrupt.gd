@icon("../../../icons/logout.svg")
class_name BehaviorTreeInterrupt
extends BehaviorTreeDecorator

@export var _interrupt_actions: Array[BehaviorTreeAction]

func _ready() -> void:
	super._ready()
	var has_interrupt_ancestor = false
	
	var ancestor = get_parent()
	while not ancestor is BehaviorTree:
		if ancestor is BehaviorTreeInterrupt:
			has_interrupt_ancestor = true
			break

		ancestor = ancestor.get_parent()
	
	assert(!has_interrupt_ancestor, "Interrupt nodes shouldn't have interrupt ancestors")

func _update_running(blackboard: Blackboard):
	var previous_interrupt = blackboard.running_interrupt
	
	if previous_interrupt == self:
		return

	blackboard.running_interrupt = self
	
	if previous_interrupt != null:
		previous_interrupt._interrupt(blackboard)

func _update_done(blackboard: Blackboard):
	blackboard.running_interrupt = null

func _interrupt(blackboard: Blackboard):
	for node in _interrupt_actions:
		node._interrupt(blackboard)

func _did_tick(result: BehaviorResult, blackboard: Blackboard):
	super._did_tick(result, blackboard)

	if result == BehaviorResult.RUNNING:
		_update_running(blackboard)
	else:
		_update_done(blackboard)

func _tick(host, blackboard) -> int:
	return child.tick(host, blackboard)
