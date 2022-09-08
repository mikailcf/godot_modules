class_name BehaviorTreeCondition
extends BehaviorTreeLeafWrap

func _tick(agent: Node, blackboard: BlackBoard) -> int:
  if _child.has_method("check_condition"):
    return _child.check_condition(agent, blackboard)
    
  return SUCCESS