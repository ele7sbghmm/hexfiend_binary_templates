
include "amped2/pgf/collision/CColliderHeader.tcl"
include "amped2/pgf/collision/CColliderSuperNode.tcl"
include "amped2/pgf/collision/CColliderNode.tcl"
include "amped2/pgf/collision/CColliderTree.tcl"

section "Header" { set Header [CColliderHeader] }

set numSuperNodes [expr ([dict get $Header iTreeListOffset]\
                       - [dict get $Header iSuperNodeOffset]) / 48]
section "$numSuperNodes SuperNodes" {
  for {set i 0} {$i < $numSuperNodes} {incr i} {
    CColliderSuperNode $i
  }
}
#
#
set numTreeList [expr ([dict get $Header iTreeOffset]\
                     - [dict get $Header iTreeListOffset]) / 2]
section -collapse "$numTreeList TreeList" {
  bytes [expr $numTreeList * 2] ""
}
#
#
set numTrees [expr ([dict get $Header iNodeOffset]\
                  - [dict get $Header iTreeOffset]) / 72]
section -collapse "$numTrees Trees" {
  for {set i 0} {$i < $numTrees} {incr i} {
    CColliderTree $i
  }
}
#
#
set numNodes [expr ([dict get $Header iTriListOffset]\
                  - [dict get $Header iNodeOffset]) / 40]
CColliderNodeList $numNodes
#
#
;# set numTriList [expr ([dict get $Header iLeafTrisOffset]\
;#                     - [dict get $Header iTriListOffset] / ?]
#
#
set numLeafTris [expr [dict get $Header iFloatsOffset]\
                    - [dict get $Header iLeafTrisOffset] / 2]
section -collapse "$numLeafTris LeafTris" {
  for {set i 0} {$i < [expr $numLeafTris / 3]} {incr i} {
    entry "[expr $i * 3]" "[uint16] [uint16] [uint16]"
  }
}
#
#
set numFloats [expr ([dict get $Header iMatrixOffset]\
                   - [dict get $Header iFloatsOffset]) / 4]
entry "floats" $numFloats
# section -collapsed "$numFloats floats" {
#   for {set i 0} {$i < $numFloats} {} {
#     float "$i"
#   }
# }

