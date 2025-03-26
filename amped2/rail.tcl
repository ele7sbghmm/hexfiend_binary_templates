
section header {
  set unk [uint32 "0 unk"]
  set numRails [uint32 "numRails "]
  set fileSize   [uint32 "fileSize"]
}
section -collapsed "$numRails rails" {
  for {set i 0} {$i < $numRails} {incr i} {
    section -collapsed "$i" {
      uint32 "typeId"
      section "sphereCenter" { float "x"; float "y"; float "z" }
      float "sphereRadius"
      uint32 "numPoints"
      uint32 "pointArrayOffset"
      uint32 "directionArrayOffset"
      uint32 "normalArrayOffset"
    }
  }
}

