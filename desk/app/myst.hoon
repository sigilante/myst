  ::  /app/myst
::::
::
/-  *myst
/+  dbug,
    default-agent,
    *myst,
    verb
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0
  $:  %0
      game-state
  ==
+$  card  card:agent:gall
--
%+  verb  &
%-  agent:dbug
=|  state-0
=*  state  -
^-  agent:gall
=<
|_  =bowl:gall
+*  this     .
    default  ~(. (default-agent this %|) bowl)
    aux      ~(. +> bowl)
++  on-init
  ^-  [(list card) _this]
  ~&  >  "%myst initialized successfully."
  :-  :~  [%pass /eyre/connect %arvo %e %connect [~ /apps/[dap.bowl]] dap.bowl]
      ==
  this
++  on-save   !>(state)
++  on-load
  |=  old=vase
  ^-  [(list card) _this]
  :-  ^-  (list card)
      ~
  %=  this
    state  !<(state-0 old)
  ==
++  on-poke
  |=  [=mark =vase]
  ^-  [(list card) _this]
  =^  cards  state
    ?+    mark  (on-poke:default mark vase)
        %myst-event
      (take-event !<(event vase))
      ::
        %myst-action
      (take-action !<(action vase))
    ==
  [cards this]
::
++  on-peek
  |=  path=(pole knot)
  ^-  (unit (unit cage))
  ?+    path  (on-peek:default path)
    [%x %user ~]     [~ ~ [%noun !>(user-state)]]
    [%x %world ~]    [~ ~ [%noun !>(world)]]
  ==
++  on-watch
  |=  path=(pole knot)
  ^-  [(list card) _this]
  =^  cards  state
    ?+    path  (on-watch:default path)
        [%user ~]
      (send-update %user)
      ::
        [%world ~]
      (send-update %world)
    ==
  [cards this]
++  on-arvo
  |=  [=wire =sign-arvo]
  ^-  (quip card _this)
  ?+    sign-arvo  (on-arvo:default [wire sign-arvo])
      [%eyre %bound *]
    ?:  accepted.sign-arvo
      %-  (slog leaf+"/apps/{(trip dap.bowl)} bound successfully!" ~)
      [~ this]
    %-  (slog leaf+"Binding /apps/{(trip dap.bowl)} failed!" ~)
    [~ this]
  ==
++  on-leave  on-leave:default
++  on-agent  on-agent:default
++  on-fail   on-fail:default
--
::
::  Helper Core
::
|_  =bowl:gall
+*  this     .
    default  ~(. (default-agent this %|) bowl)
++  take-event
  |=  evt=event
  ^-  [(list card) _state]
  ~&  >  'take-event'
  [~ state]
++  take-action
  |=  act=action
  ^-  [(list card) _state]
  ~&  >  'take-action'
  [~ state]
++  send-update
  |=  =term
  ^-  [(list card) _state]
  ~&  >  'subs:  send-update'
  :-  :~  :*  %give  %fact  ~
              %myst-update
              !>  ^-  update
              :*  %state  user-state
                  (need (need (~(get of world) posn.user-state)))
      ==  ==  ==
  state
--
