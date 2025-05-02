little_endian

proc delimiter {} {
  requires [pos] "01 00 ff 0f"
  bytes 4
  # hex 4 "-"
}

float "version"
delimiter

section -collapsed "PgfSizes" {
  uint32 "TotalFileSize"
  set totalDataSize   [uint32 "TotalDataSize"]
  set textureDataSize [uint32 "TextureDataSize"]
  set numTextures     [uint32 "NumTextures"]
  set shaderDataSize  [uint32 "ShaderDataSize"]
}
delimiter

bytes [expr $numTextures * 20]
bytes $textureDataSize "TextureBuffer"
delimiter
bytes $shaderDataSize "ShaderBuffer"
delimiter

section -collapsed "PgfHeader" {
  set vbDataSize        [uint32 "VBDataSize"]
  set ibDataSize        [uint32 "IBDataSize"]
  set pbDataSize        [uint32 "PBDataSize"]
  set bvDataSize        [uint32 "BVDataSize"]
  set miscDataSize      [uint32 "MiscDataSize"]
  set influenceDataSize [uint32 "InfluenceDataSize"]
  set limDataSize       [uint32 "LIMDataSize"]
  set collisionDataSize [uint32 "CollisionDataSize"]
  set stringTableSize   [uint32 "StringTableSize"]
  set numShaders        [uint32 "NumShaders"]
  set numVertexBuffers  [uint32 "NumVertexBuffers"]
  set numIndexBuffers   [uint32 "NumIndexBuffers"]
  set numPushBuffers    [uint32 "NumPushBuffers"]
  set numPrimLists      [uint32 "NumPrimLists"]
  set numVBGeomData     [uint32 "NumVBGeomData"]
  set numJoints         [uint32 "NumJoints"]
}

delimiter
#dict set CFileManager vertexData    [bytes $vbDataSize "Vertex Data"]
bytes $vbDataSize "vertex data"
set vertexHeaders [bytes [expr $numVertexBuffers * 12] "Vertex Headers"]
#set vertexHeaders a
#for {set i 0} {$i < $numVertexBuffers} {incr i} {
#  lappend vertexHeaders [uint32; uint32 ""; uint32]
#}

set indexData    [bytes $ibDataSize "Index Data"]
set indexHeaders [list]
section -collapsed "$numIndexBuffers index headers" {
  for {set i 0} {$i < $numIndexBuffers} {incr i} {
    uint32; lappend $indexHeaders [uint32 "$i"]; uint32
  }
}

delimiter
section -collapsed "$numPushBuffers push buffer ressources" {
  if {$numPushBuffers} {
    set pbOffset [pos]
    set pushBufferData [bytes $pbDataSize "push buffer data"]
    for {set i 0} {$i < $numPushBuffers} {incr i} {
      section -collapsed "$i" {
        hex 4 "Common"
        uint32 "Data"
        uint32 "Lock"
        uint32 "Size"
        uint32 "AllocationSize"
        entry "InterruptId" "?"
      }
    }
  }
}

if {$bvDataSize} {
  set bvOffset [pos]
  set boundingVolumeData [bytes $bvDataSize "$bvDataSize bounding volume data"]
} else {
  entry "$bvDataSize bounding volume data" ""
}
if {$miscDataSize} {
  set miscOffset [pos]
  set miscData [bytes $miscDataSize "$miscDataSize misc data"]
} else {
  entry "$miscDataSize misc data" ""
}
if {$influenceDataSize} {
  set influenceOffset [pos]
  set influenceData [bytes $influenceDataSize "$influenceDataSize influence data"]
} else {
  entry "$influenceDataSize influence data" ""
}
if {$limDataSize} {
  set limOffset [pos]
  set limData [bytes $limDataSize "$limDataSize lim data"]
} else {
  entry "$limDataSize lim data" ""
}
if {$collisionDataSize} {
  set collisionOffset [pos]
  set collisionData [bytes $collisionDataSize "$collisionDataSize collision data"]
} else {
  entry "$collisionDataSize collision data" ""
}
if {$stringTableSize} {
  set stringTableOffset [pos]
  set stringTable [bytes $stringTableSize "$stringTableSize string table data"]
} else {
  entry "$stringTableSize string table data" ""
}
if {$numPrimLists} {
  set primListOffset [pos]
  set primListData [bytes [expr $numPrimLists * 48] "$numPrimLists prim lists data"]
} else {
  entry "$numPrimLists prim lists data" ""
}
if {$numVBGeomData} {
  set vbGeomOffset [pos]
  set vbGeomData [bytes [expr $numVBGeomData * 48] "$numVBGeomData vb geom data"]
} else {
  entry "$numVBGeomData vb geoms data" ""
}

bytes [expr ([len] - 4) - [pos]] "node data"
