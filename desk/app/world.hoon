/-  *myst
^-  world
%-  ~(gas of *world)
:~  :-  /beach/n
    ^-  node
    :-
    ^-  (map coord action)
    %-  malt
    ^-  (list [coord action])
    :~  :-  [0 0 100 1.000]
        [%goto /beach/w]
        ::
        :-  [900 0 100 1.000]
        [%goto /beach/e]
        ::
        :-  [0 900 1.000 1.000]
        [%goto /beach/s]
        ::
        :-  [0 0 1.000 100]
        [%goto /lighthouse]
    ==
    ^-  node-state
    :-  [%image 'https://www.shutterstock.com/image-photo/untouched-tropical-beach-sri-lanka-600nw-109674992.jpg']
    [%state (silt `(list term)`[%a %b %c ~])]
    ::
    :-  /lighthouse
    ^-  node
    :-
    ^-  (map coord action)
    %-  malt
    ^-  (list [coord action])
    :~  :-  [0 900 1.000 1.000]
        [%goto /beach/n]
    ==
    ^-  node-state
    :-  [%image 'https://th-thumbnailer.cdn-si-edu.com/43-3sEbWnKoLc8c2E33G_fh0ZYg=/fit-in/1600x0/filters:focal(2400x1371:2401x1372)/https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer_public/d2/e9/d2e9b7cd-cb51-41aa-a591-b96117052c18/opener_-_1_-_1a56abea-de68-49aa-aaf7-a8b9569b22d8.jpg']
    [%state (silt `(list term)`[%on ~])]
==