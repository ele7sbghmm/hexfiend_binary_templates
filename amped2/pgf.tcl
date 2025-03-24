little_endian

float "version"
hex 4 "-"

proc Headers {n} {
  for {set i 0} {$i < $n} {incr i} {
    #move 4; uint32 "$i "; move 12
    move 20
  }
}

section "PgfSizes" {
  set totalFileSize   [uint32 "TotalFileSize"]
  set totalDataSize   [uint32 "TotalDataSize"]
  set textureDataSize [uint32 "TextureDataSize"]
  set numTextures     [uint32 "NumTextures"]
  set shaderDataSize  [uint32 "ShaderDataSize"]
}

hex 4 "-"

#Headers $NumTextures
bytes [expr $numTextures * 20]
set textureBuffer [bytes $textureDataSize "TextureBuffer"]
hex 4 "-"
set shaderBuffer [bytes $shaderDataSize "ShaderBuffer"]
hex 4 "-"

section "PgfHeader" {
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

hex 4 "-"
dict set CFileManager vertexData    [bytes $vbDataSize "Vertex Data"]
set vertexHeaders [bytes [expr $numVertexBuffers * 12] "Vertex Headers"]
#set vertexHeaders a
#for {set i 0} {$i < $numVertexBuffers} {incr i} {
#  lappend vertexHeaders [uint32; uint32 ""; uint32]
#}

set indexData    [bytes $ibDataSize "Index Data"]
set indexHeaders [bytes [expr $numIndexBuffers * 12] "Index Headers"]
#for {set i 0} {$i < $numIndexBuffers} {incr i} { uint32; uint32 "ib$i"; uint32 }

hex 4 "-"
#set pushBufferData     [bytes $numPushBuffers "PushBufferData"]
set boundingVolumeData [bytes $bvDataSize "Bounding Volume Data"]
set miscData           [bytes $miscDataSize "Misc Data"]
#set influenceData      [bytes $influenceDataSize "Influence Data"]
#set limData            [bytes $limDataSize "LIM Data"]
set collisionData      [bytes $collisionDataSize "Collision Data"]
set stringTable        [bytes $stringTableSize "String Table"]
set primList           [bytes [expr $numPrimLists * 48] "Prim List"]
set vbGeomData         [bytes [expr $numVBGeomData * 48] "VB Geom Data List"]

