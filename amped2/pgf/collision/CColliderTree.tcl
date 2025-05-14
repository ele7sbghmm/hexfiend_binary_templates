
proc CColliderTree {name} {
  section "$name CColliderTree"
  if {$name > 0} { sectioncollapse }

  section -collapsed "vMin" { set vMin [dict create x [float "x"] y [float "y"] z [float "z"]] }
  section -collapsed "vMax" { set vMax [dict create x [float "x"] y [float "y"] z [float "z"]] }
  set pVBuffer          [uint32 "pVBuffer"]
  set iVertexStride     [uint32 "iVertexStride"]
  set iNumNodes         [uint32 "iNumNodes"]
  set pNodeList         [uint32 "pNodeList"]
  set iNumTris          [uint16 "iNumTris"]
  set iPrimType         [uint16 "iPrimType"]
  set pTriList          [uint32 "pTriList"]
  set pLocalToWorld     [uint32 "pLocalToWorld"]
  set iCategory         [uint32 "iCategory"]
  set iObjectId         [uint32 "iObjectId"]
  set iObjectMaterial   [uint16 "iObjectMaterial"]
  set iObjectAttributes [uint16 "iObjectAttributes"]
  set pFloatValues      [int32 "pFloatValues"]
  set iHasBeenVisited   [uint32 "iHasBeenVisited"]
  endsection

  return [dict create\
    "vMin" $vMin\
    "vMax" $vMax\
    "pVBuffer" $pVBuffer\
    "iVertexStride" $iVertexStride\
    "iNumNodes" $iNumNodes\
    "pNodeList" $pNodeList\
    "iNumTris" $iNumTris\
    "iPrimType" $iPrimType\
    "pTriList" $pTriList\
    "pLocalToWorld" $pLocalToWorld\
    "iCategory" $iCategory\
    "iObjectId" $iObjectId\
    "iObjectMaterial" $iObjectMaterial\
    "iObjectAttributes" $iObjectAttributes\
    "pFloatValues" $pFloatValues\
    "iHasBeenVisited" $iHasBeenVisited
  ]
}

