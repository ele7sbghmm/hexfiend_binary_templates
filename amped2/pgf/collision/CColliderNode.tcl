proc CColliderNode {name} {
  section "$name CColliderNode" {
    if {$name > 0} { sectioncollapse }
    section -collapsed "vMin" { set vMin [dict create x [float "x"] y [float "y"] z [float "z"]] }
    section -collapsed "vMax" { set vMax [dict create x [float "x"] y [float "y"] z [float "z"]] }
    set c_union_a [list [uint32 "a iSplitCoord"] [float "a fBoundary"]]
    move -8
    set c_union_b [list [uint32 "b iTriCount"] [uint32 "b pLeafTris"]]
    set pChild1 [uint32 "pChild1"]
    set pChild2 [uint32 "pChild2"]
  }

  return [dict create\
    "vMin" $vMin\
    "vMax" $vMax\
    "c_union_a" $c_union_a\
    "c_union_b" $c_union_b\
    "pChild1" $pChild1\
    "pChild1" $pChild1
  ]
}

proc CColliderNodeList {n} {
  set List [list]
  section -collapsed "collider nodes" {
    for {set i 0} {$i < $n} {incr i} {
      lappend $List [CColliderNode $i]
    }
  }
  return List
}
