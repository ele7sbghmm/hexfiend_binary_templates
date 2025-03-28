entry "label" "" 1 100000

section -collapsed endOfRun {
  set len [uint32]
  for {set i 0} {$i < $len} {incr i} {
    section "$i" {
      float ""; float ""; float ""
    }
  }
}
section -collapsed innerBoundary {
  set len [uint32]
  for {set i 0} {$i < $len} {incr i} {
    section "$i" {
      float ""; float ""; float ""
    }
  }
}
section -collapsed outerBoundary {
  set len [uint32]
  for {set i 0} {$i < $len} {incr i} {
    section "$i" {
      float ""; float ""; float ""
    }
  }
}
section runLines {
  set len [uint32]
  for {set i 0} {$i < [expr $len * 2]} {incr i} {
    section "$i" {
      float ""; float ""; float ""
    }
  }
}

