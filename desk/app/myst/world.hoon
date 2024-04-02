/-  *myst
^-  world
=/  top     [0 0 1.000 100]
=/  bottom  [0 900 1.000 100]
=/  left    [0 0 100 1.000]
=/  right   [900 0 100 1.000]
=/  middle  [100 100 800 800]
%-  ~(gas of *world)
:~  ::  Dock, Node 1 East
    :-  /dock-1e
    ^-  node
    :-
    ^-  (map coord action)
    %-  malt
    ^-  (list [coord action])
    :~  :-  left
        [%goto /dock-1n]
        ::
        :-  right
        [%goto /dock-1s]
        ::
        :-  top
        [%goto /dock-2e]
        ::
        :-  middle
        [%goto /dock-2e]
    ==
    ^-  node-state
    :-  [%image '/app/myst/dock-1e.png']
    [%state (silt `(list term)`~)]
    ::
    ::  Dock, Node 1 South
    :-  /dock-1s
    ^-  node
    :-
    ^-  (map coord action)
    %-  malt
    ^-  (list [coord action])
    :~  :-  left
        [%goto /dock-1e]
        ::
        :-  right
        [%goto /dock-1w]
    ==
    ^-  node-state
    :-  [%image '/app/myst/dock-1s.png']
    [%state (silt `(list term)`~)]
    ::
    ::  Dock, Node 1 West
    :-  /dock-1w
    ^-  node
    :-
    ^-  (map coord action)
    %-  malt
    ^-  (list [coord action])
    :~  :-  left
        [%goto /dock-1s]
        ::
        :-  right
        [%goto /dock-1n]
    ==
    ^-  node-state
    :-  [%image '/app/myst/dock-1w.png']
    [%state (silt `(list term)`~)]
    ::
    ::  Dock, Node 1 North, Closed
    :-  /dock-1n
    ^-  node
    :-
    ^-  (map coord action)
    %-  malt
    ^-  (list [coord action])
    :~  :-  left
        [%goto /dock-1w]
        ::
        :-  right
        [%goto /dock-1e]
        ::
        :-  [400 600 200 400]
        [%goto /dock-1n-o]
    ==
    ^-  node-state
    :-  [%image '/app/myst/dock-1n.png']
    [%state (silt `(list term)`~[%closed])]
    ::
    ::  Dock, Node 1 North, Open
    :-  /dock-1n
    ^-  node
    :-
    ^-  (map coord action)
    %-  malt
    ^-  (list [coord action])
    :~  :-  left
        [%goto /dock-1w]
        ::
        :-  right
        [%goto /dock-1e]
        ::
        :-  [400 600 200 400]
        [%goto /fore-1n]
    ==
    ^-  node-state
    :-  [%image '/app/myst/dock-1n-o.png']
    [%state (silt `(list term)`~[%open])]
==
