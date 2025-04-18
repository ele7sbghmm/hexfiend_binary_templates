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
section -collapsed "index headers" {
  for {set i 0} {$i < $numIndexBuffers} {incr i} {
    uint32; lappend $indexHeaders [uint32 "$i"]; uint32
  }
}

delimiter
if {$numPushBuffers} {
  set pbOffset [pos]
  set pushBufferData [bytes $pbDataSize "PushBufferData"]
}
if {$bvDataSize} {
  set bvOffset [pos]
  set boundingVolumeData [bytes $bvDataSize "Bounding Volume Data"]
}
if {$miscDataSize} {
  set miscOffset [pos]
  set miscData [bytes $miscDataSize "Misc Data"]
}
if {$influenceDataSize} {
  set influenceOffset [pos]
  set influenceData [bytes $influenceDataSize "Influence Data"]
}
if {$limDataSize} {
  set limOffset [pos]
  set limData [bytes $limDataSize "LIM Data"]
}
if {$collisionDataSize} {
  set collisionOffset [pos]
  set collisionData [bytes $collisionDataSize "Collision Data"]
}
if {$stringTableSize} {
  set stringTableOffset [pos]
  set stringTable [bytes $stringTableSize "String Table"]
}
if {$numPrimLists} {
  set primListOffset [pos]
  set primListData [bytes [expr $numPrimLists * 48] "Prim List"]
}
if {$numVBGeomData} {
  set vbGeomOffset [pos]
  set vbGeomData [bytes [expr $numVBGeomData * 48] "vb geom data list"]
}

