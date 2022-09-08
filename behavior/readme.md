qualquer extensão de node:
  - caso necessário, implementar `_metadata()` que fornecerá dados para os `will_exit(_)` no caso de interrupções
  - implementar `will_exit(_)` caso haja setup para fazer, chamar `.will_exit(_)` também

custom action node:
  - imeplementar ação em `_do_action(_, _)`
    - devolver `RUNNING` enquanto estiver rodando
    - devolver `SUCCESS` ou `FAILURE` para terminar ação

custom condition node:
  - imeplementar checagem em `_check_condition(_, _)`
    - devolver `SUCCESS` ou `FAILURE`

wait node:
  - não implementar nada
  - selecionar `wait_time` e `one_shot` no editor