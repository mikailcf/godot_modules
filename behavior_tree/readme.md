# Behavior tree

## Setup
Copy the folders inside `./script_templates` to the project's `script_templates` folder.

## Usage

1. Add a blackboard node to your scene.
1. Add a behavior tree node to your scene and choose its blackboard node in the editor.
1. Add behavior tree nodes as children of this behavior tree node.
	1. The only nodes that should have custom implementation are: `BehaviorTreeCondition` and `BehaviorTreeAction`. This should be done by right-clicking the node after adding it and clicking extend script, choosing the empty template.

action node:
	- folha
	- estender action node
	- imeplementar ação em `_do_action(_, _)`
		- can use signals to execute action or call specific outside nodes/functions to capture result, but being more coupled this way
		- devolver `RUNNING` enquanto estiver rodando
		- devolver `SUCCESS` ou `FAILURE` para terminar ação

condition node:
	- máximo 2 filhos
	- estender condition node
	- imeplementar checagem em `_check_condition(_, _)`
		- devolver `SUCCESS` ou `FAILURE`
		- entra no primeiro filho caso `SUCCESS`
		- entra no segundo caso `FAILURE`

wait node:
	- folha
	- no editor: `Wait Time - number` e `One Shot - bool`
	- não implementar nada
	- enquanto tá rodando o timer, devolve `RUNNING`
	- depois do timer terminar de rodar, devolve `SUCCESS`
		- se for one shot, devolve `SUCCESS` pra sempre
		- se não for one shot, devolve `SUCCESS` uma vez e se reseta no mesmo tick (i.e. no tick seguinte começa o timer de novo)

sequence node:
	- n filhos
	- no editor: `Skip Previous Success - bool`
	- executa em ordem, guardando child index no estado
		- se encontrar `SUCCESS` vai para próximo child
			- se pular sucessos anteriores, nem roda de novo o que já teve sucesso antes
		- se encontrar `FAILURE`, devolve ele, para aí e reseta estado
		- se encontrar `RUNNING`, devolve ele
		- se só encontrar `SUCCESS`, devolve `SUCCESS`

fallback node:
	- n filhos
	- no editor: `Skip Previous Failure - bool`
	- executa em ordem até sucesso
	- dá pra pular falhas anteriores

parallel node:
	- n filhos
	- executa em paralelo e devolve `SUCCESS`
	
inverter node:
	- 1 child
	- returns `RUNNING` if child is running
	- returns the opposite of child if child is not nunning

failer node:
	- 1 child
	- returns `RUNNING` if child is running
	- returns `FAILURE` if child is not nunning

succeeder node:
	- 1 child
	- returns `RUNNING` if child is running
	- returns `SUCCESS` if child is not nunning
