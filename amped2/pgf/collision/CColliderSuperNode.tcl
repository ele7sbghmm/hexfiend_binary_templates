
proc CColliderSuperNode {name} {
  section "$name CColiderSuperNode"
  if {$name > 0} { sectioncollapse }

  section -collapsed "vMin" { set vMin [dict create x [float "x"] y [float "y"] z [float "z"]] }
  section -collapsed "vMax" { set vMax [dict create x [float "x"] y [float "y"] z [float "z"]] }
  set iSplitCoord [uint32 "iSplitCoord"]
  set fBoundary   [float "fBoundary"]
  set iTreeCount  [uint32 "iTreeCount"]
  set pTreeList   [uint32 "pTreeList"]
  set pChild1     [uint32 "pChild1"]
  set pChild2     [uint32 "pChild2"]
  endsection

  return [dict create\
    "vMin" $vMin\
    "vMax" $vMax\
    "iSplitCoord" $iSplitCoord\
    "fBoundary" $fBoundary\
    "iTreeCount" $iTreeCount\
    "pTreeList" $pTreeList\
    "pChild1" $pChild1\
    "pChild2" $pChild2
  ]
}

