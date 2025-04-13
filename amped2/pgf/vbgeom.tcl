proc uint32_or_unused {} {
  set number [uint32]
  if {$number == 3735936685} {
    return "deaddead"
  }
  return $number
}

set n 0
# while {![end]} {
for {set i 0} {$i < 10} {incr i} {
  section "$n" {
    uint32 ;# unused

    section -collapsed "vertex buffer offsets" {
      sectionvalue [uint32_or_unused]
      entry "" [uint32_or_unused]
      entry "" [uint32_or_unused]
      entry "" [uint32_or_unused]
    }
    set indexBuffersPtr [uint32 "index buffer offset"]
    set auxDataPtr [uint32 "aux data offset"]
    set numOfRenderLists [uint32 "num of render lists"]
    set primitiveListPtr [uint32 "primitive list offset"]
    set boundingVolumePtr [uint32 "bounding volume offset"]
    set vertexSize [uint32 "vertex stride"]
    set numOfVertices [uint32 "num of vertices"]

    incr n
  }
}

