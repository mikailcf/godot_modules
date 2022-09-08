class_name BehaviorTreeAction
extends BehaviorTreeLeafWrap

func _tick(agent: Node, blackboard: BlackBoard) -> int:
  if _child.has_method("do_action"):
    return _child.do_action(agent, blackboard)
  
  return SUCCESS