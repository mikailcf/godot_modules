qualquer extensão de node:
  - caso necessário, implementar `_metadata()` que fornecerá dados para os `will_exit(_)` no caso de interrupções

action node:
  - estender action node
  - imeplementar ação em `_do_action(_, _)`
    - devolver `RUNNING` enquanto estiver rodando
    - devolver `SUCCESS` ou `FAILURE` para terminar ação

condition node:
  - estender condition node
  - imeplementar checagem em `_check_condition(_, _)`
    - devolver `SUCCESS` ou `FAILURE`

wait node:
  - não implementar nada
  - selecionar `Wait Time` e `One Shot` no editor

sequence:
  - selecionar `Skip Previous Success` no editor

fallback:
  - selecionar `Skip Previous Failure` no editor