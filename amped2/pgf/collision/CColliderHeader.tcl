
proc CColliderHeader {} {
  return [dict create\
    iColliderVersion [uint32 "iColliderVersion"]\
    iColliderSize    [uint32 "iColliderSize"]\
    iSuperNodeOffset [uint32 "iSuperNodeOffset"]\
    iTreeListOffset  [uint32 "iTreeListOffset"]\
    iTreeOffset      [uint32 "iTreeOffset"]\
    iMatrixOffset    [uint32 "iMatrixOffset"]\
    iNodeOffset      [uint32 "iNodeOffset"]\
    iTriListOffset   [uint32 "iTriListOffset"]\
    iLeafTrisOffset  [uint32 "iLeafTrisOffset"]\
    iFloatsOffset    [uint32 "iFloatsOffset"]
  ]
}

