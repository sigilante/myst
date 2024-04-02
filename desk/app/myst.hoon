  ::  /app/myst
::::
::
/-  *myst
/+  dbug,
    default-agent,
    *myst,
    verb,
    schooner,
    server
/=  w  /app/myst/world
/*  ui  %html  /app/myst/html
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
  %=  this
    user-state  [[%posn /dock-1e] [%page `%red]]
    world  `^world`w
  ==
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
      ::
        %handle-http-request
      (handle-http:aux !<([@ta =inbound-request:eyre] vase))
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
      ::
        [%http-response *]
      [~ state]
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
                  state:(get-node posn.user-state)
      ==  ==  ==
  state
::
++  get-node
  |=  id=node-id
  ^-  node 
  (need (~(get of world) id))
::
++  handle-http
  |=  [eyre-id=@ta =inbound-request:eyre]
  ^-  [(list card) _state]
  ?>  =(our.bowl src.bowl)
  =/  ,request-line:server
    (parse-request-line:server url.request.inbound-request)
  =+  send=(cury response:schooner eyre-id)
  ::
  ?+    method.request.inbound-request
    :_  state
    (send [405 ~ [%stock ~]])
    ::
      %'POST'
    ?~  body.request.inbound-request  !!
    ?+    site
        :_  state
        (send [404 ~ [%plain "404 - Not Found"]])
    ::
        [%apps %myst ~]
      =/  json  (de:json:html q.u.body.request.inbound-request)
      =/  clik=event  (dejs-event +.json)
      =/  acts  actions:(get-node posn.user-state)
      =/  act=action
        =/  map  ~(tap by acts)
        |-
        ?~  map  !!
        ?:  (in-range [click.clik -.i.map])
          +.i.map
        $(map t.map)
      ~&  >  act
      ?+    -.act  [~ state]
          %goto
        :_  state(user-state [[%posn node-id.act] [%page page.user-state]])
        %-  send
        :+  200 
          ~ 
        :-  %json
        %-  enjs-state
        :-  state:(get-node node-id.act)
        user-state(posn node-id.act)
      ==
    ==
    ::
      %'GET'
    :_  state
    %-  send
    ?+    site  [404 ~ [%plain "404 - Not Found"]]
    ::
        [%apps %myst ~]
      [200 ~ [%html ui]]
    ::
        [%apps %myst %json ~]
      :+  200 
        ~ 
      :-  %json 
      %-  enjs-state
      :-  state:(get-node posn.user-state)
      user-state
    ==
  ==
++  enjs-state
  |=  [node=^node-state user=^user-state]
  ^-  json
  %-  pairs:enjs:format
  :~  [%image [%s url.node]]
      ::
      :-  %state
      :-  %a
      %+  turn
        ~(tap in tags.node)
      |=  tag=term
      [%s tag] 
      ::
      [%position (path:enjs:format posn.user)]
      ::
      :-  %page 
      ?~  page.user
        ~
      ?:  =(page.user %blue)
        [%s 'blue']
      [%s 'red']
  ==
++  dejs-event
  |=  jon=json
  ^-  event
  =,  dejs:format
  %.  jon
  %-  of
  :~  [%click (ot ~[x+ni y+ni])]
  == 
--
