
proc beginChunk {} {
  set chunkId [uint32 "chunk id"]
  set dataSize [uint32 "data size"]
  set chunkSize [uint32 "chunk size "]
}

proc intersect {} {
  beginChunk

  set numIndices [uint32]
  section -collapsed "$numIndices Indices" {
    if {$numIndices > 0} {
      for {set i 0} {$i < $numIndices} {incr i} {
        uint32 "$i"
      }
    }
  }

  set numVertices [uint32]
  section -collapsed "$numVertices Vertices" {
    if {$numVertices > 0} {
      for {set i 0} {$i < $numVertices} {incr i} {
        float "x $i"
        float "y"
        float "z"
      }
    }
  }

  set numNormals [uint32]
  section -collapsed "$numNormals Normals" {
    if {$numNormals > 0} {
      for {set i 0} {$i < $numNormals} {incr i} {
        float "x $i"
        float "y"
        float "z"
      }
    }
  }
}

intersect

