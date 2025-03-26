
little_endian

section CCylinderTreeHeader {
  uint32 "version"
  uint32 "cylinderFileSize"
  set numNodes [uint32 "num nodes"]
  set nodeOffset [uint32 "node offset"]
  set numCylinders [uint32 "num cylinders"]
  set cylinderOffset [uint32 "cylinder offset"]
}

goto $nodeOffset
section -collapsed "CCylinderTreeNode\[$numNodes\]" {
  for {set i 0} {$i < $numNodes} {incr i} {
    section "$i" {
      section -collapsed "vMin" { float ""; float ""; float "" }
      section -collapsed "vMax" { float ""; float ""; float "" }
      uint32 ""
      float ""
      uint32 "pChild1"
      uint32 "pChild2"
    }
  }
}

goto $cylinderOffset
section -collapsed "CCollideCylinder\[$numCylinders\]" {
  for {set i 0} {$i < $numCylinders} {incr i} {
    section "$i" {
      section -collapsed "base" { float ""; float ""; float "" }
      float "radius"
      uint32 "filter"
      float "height"
    }
  }
}

