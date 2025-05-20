proc staticentity {} {
  section "StaticEntity" {
    str [uint8] "ascii" "name"
    uint32 "version"
    uint32 "has alpha"
  }

  beginChunk
}

proc mesh {} {
  section "Mesh" {
    str [uint8] "ascii" "name"
    uint32 "version"
    uint32 "has alpha"
  }

  primgroup
}

proc primgroup {} {
  uint32; uint32; uint32
  section "PrimGroup" {
    uint32 "version"
    str [uint8] "ascii" "name"
    uint32 "mPrimType"
    uint32 "mVertexFormat"
    uint32 "mVertexCount"
    uint32 "mIndexCount"
    uint32 "mMatrixCount"
  }
  # while {![end]} {
  #   beginChunk
  # }
}

proc positionlist {} {
  section -collapsed "Position List" {
    set count [uint32 "count"]
    if {$count > 0} {
      for {set i 0} {$i < $count} {incr i} {
        vec3 $i
      }
    }
  }
}
proc normallist {} {
  section -collapsed "Normal List" { }
}
proc uvlist {} {
  section -collapsed "UV Linst" {
    uint32 "count"
    uint32 "channel"
    float "u"
    float "v"
  }
}
proc colourlist {} {
  section -collapsed "Colour List" { }
}
proc striplist {} {
  section -collapsed "Strip List" { }
}
proc indexlist {} {
  section -collapsed "Index List" {
    uint32 "count"
    if {$count > 0} {
      for {set i 0} {$i < $count} {incr i} {
        uint32 "$i"
      }
    }
  }
}
proc matrixlist {} {
  section -collapsed "Matrix List" { }
}
proc weightlist {} {
  section -collapsed "Weight List" { }
}
proc multicolorlist {} {
  section -collapsed "Multi Color List" { }
}

proc vec3 {name} {
  section -collapsed "$name" {
    float "x"
    float "y"
    float "z"
  }
}

proc beginChunk {} {
  set thisPtr [pos]
  set chunkId [uint32 "chunkId"]
  set dataSize [uint32]
  set chunkSize [uint32]

  set childPtr [expr $thisPtr + $dataSize]
  set nextPtr [expr $thisPtr + $chunkSize]
  
  switch -exact $chunkId {
    66060288 { staticentity }

    65536 { mesh }
    # 65537 { skin }
    65538 {
      entry "here" ""
      primgroup
    }
    # 65539 { box }
    # 65540 { sphere }
    65541 { positionlist }
    65542 { normallist }
    65543 { uvlist }
    65544 { colourlist }
    # 65545 { striplist }
    65546 { indexlist }
    # 65547 { matrixlist }
    # 65548 { weightlist }
    # 65549 { matrixpalette }
    # 65550 { offsetlist }
    # 65551 { instanceinfo }
    # 65552 { packednormallist }
    # 65553 { vertexshader }
    # 65554 { memoryimagevertexlist }
    # 65555 { memoryimageindexlist }
    # 65556 { memoryimagevertexdescriptionlist }
    # 65557 { tangentlist }
    # 65558 { binormallist }
    # 65559 { renderstatus }
    # 65560 { expressionoffsets }
    # 65561 { shadowskin }
    # 65562 { shadowmesh }
    # 65563 { topology }
    # 65564 { multicolourlist }
  }

  goto $childPtr

  return [dict create \
    "chunkId" $chunkId \
    "chunkSize" $chunkSize \
    "dataSize" $dataSize \
    "childPtr" $childPtr \
    "nextPtr" $nextPtr \
  ]

}

beginChunk

