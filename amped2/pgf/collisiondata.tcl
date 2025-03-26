little_endian

section "cColliderHeader" {
  set iColliderVersion [uint32 "iColliderVersion"]
  set iColliderSize [uint32 "iColliderSize"]
  set iSuperNodeOffset [uint32 "iSuperNodeOffset"]
  set iTreeListOffset [uint32 "iTreeListOffset"]
  set iTreeOffset [uint32 "iTreeOffset"]
  set iMatrixOffset [uint32 "iMatrixOffset"]
  set iNodeOffset [uint32 "iNodeOffset"]
  set iTriListOffset [uint32 "iTriListOffset"]
  set iLeafTrisOffset [uint32 "iLeafTrisOffset"]
  set iFloatsOffset [uint32 "iFloatsOffset"]
}
set numSuperNodes [expr ($iTreeListOffset - $iSuperNodeOffset) / 48]
section -collapsed "$numSuperNodes superTree" {
  for {set i 0} {$i < $numSuperNodes} {incr i} {
    section -collapsed "$i" {
      section vMin { float "x"; float "y"; float "z" }
      section vMax { float "x"; float "y"; float "z" }
      uint32 "iSplitCoord"
      float  "fBoundary"
      uint32 "iTreeCount"
      uint32 "pTreeList_ptr"
      uint32 "pChild1_offs"
      uint32 "pChild2_offs"
    }
  }
}
set treeListSize [expr $iTreeOffset - $iTreeListOffset]
bytes $treeListSize "$treeListSize treeList"
#section "cCollider"; section "->0_iNumTrees"; section " = " {}
#
set numTrees [expr ($iNodeOffset - $iTreeOffset) / 72]
section -collapsed "$numTrees trees" {
  for {set i 0} {$i < $numTrees} {incr i} {
    section -collapsed "$i" {
      section "vMin" { float "x"; float "y"; float "z" }
      section "vMax" { float "x"; float "y"; float "z" }
      uint32 "pVBuffer"
      uint32 "iVertexStride"
      uint32 "iNumNodes"
      uint32 "pNodeList"
      uint16 "iNumTris"
      uint16 "iPrimType"
      uint32 "pTriList"
      uint32 "pLocalToWorld"
      uint32 "iCategory"
      uint32 "iObjectId"
      uint16 "iObjectMaterial"
      uint16 "iObjectAttributes"
      int32 "pFloatValues"
      uint32 "iHasbeenVisited"
    }
  }
}
set numNodes [expr ($iTriListOffset - $iNodeOffset) / 0x28]
section -collapsed "$numNodes nodeList" {
  for {set i 0} {$i < [expr $numNodes]} {incr i} {
    section -collapsed "$i" {
      section "vMin" { float "x"; float "y"; float "z" }
      section "vMax" { float "x"; float "y"; float "z" }
      section "CColliderNode_u_24" {
        section "CColliderNode_u_24_s_0 union" {
          #uint32 "iSplitCoord"; # or iTriCount
          #float "fBoundary"; # or uint32 pLeafTris
          uint32 "iTriCount"
          uint32 "pLeafTris"
        }
      }
      uint32 "pChild1"
      uint32 "pChild2"
    }
  }
}

