  ::  /lib/myst
::::
::
/-  *myst
|%
++  in-range
  |=  [=click =coord]
  ?&  &((gth x.click x.coord) (lth x.click (add x.coord w.coord)))
      &((gth y.click y.coord) (lth y.click (add y.coord h.coord)))
  ==
--
