  ::  /sur/myst
::::
::
|%
::  State variables
+$  user-state
  $:  [%posn posn=node-id]
      [%page p=(unit ?(%red %blue))]
  ==
+$  node-state
  $:  [%image url=cord]
      [%state (set term)]
  ==
::  Game world
+$  coord  [x=@ y=@ w=@ h=@]
+$  coords  (list [x=@ y=@ w=@ h=@])
+$  node
  $:  actions=(map coord action)
      state=node-state
  ==
+$  node-id  path
+$  world  (axal node)
+$  game-state
  $:  =user-state
      =world
  ==
::  Front-end sends and returns
::    receive a click from the FE (scaled by client)
+$  click  [x=@ y=@]
+$  event  [%click =click]
::    process an action in the backend
+$  action
  $%  [%goto =node-id]
      [%page p=?(%red %blue)]
      [%game p=*]
      ::  user-action
  ==
::    send an update to the FE
+$  update  [%state =user-state =node-state]
--
