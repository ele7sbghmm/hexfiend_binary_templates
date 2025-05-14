proc staticEntity {} {
  chunk

  set nameLen [uint8 "se name len"]
  set name [bytes $nameLen]

  # section -collapsed "$name" {
    uint32 "version"
    uint32 "has alpha"

    mesh 0
  # }
}

proc mesh {n} {
  chunk

  set nameLen [uint8]
  set name [bytes $nameLen "geom name"]
  # section "$n $name" {
    uint32 "version"
    uint32 "has alpha"
  # }
}

# proc primGroup

proc chunk {} { uint32; uint32; uint32 }

staticEntity

