little_endian

requires 0 "58 50 52 30"
ascii 4 "magic"

uint32 "file size"
uint32 "header size"

hex 4 "common"
uint32 "offset"
uint32 "lock flags"
section "format" {
  set raw [uint32]; move -4
  entry "dma" [expr $raw >> 0 & 0xf]
  entry "dimensions" [expr $raw >> 4 & 0xf]
  entry "format" [expr $raw >> 8 & 0xff]
  set levels [expr $raw >> 16 & 0xf]
  set widthShift [expr $raw >> 20 & 0xf]
  set heightShift [expr $raw >> 24 & 0xf]
  set width [expr 1 << $widthShift]
  set height [expr 1 << $heightShift]
  entry "levels" $levels
  entry "width" $width
  entry "height" $height
  entry "depth" [expr $raw >> 28 & 0xf]
}
uint32 "size"

entry "h * w" [expr $height * $width]
section "LODs" {
  set i 1
  #for {set i 1} {$i <= $levels} {incr i} {
    bytes [expr ($height / $i) * ($width / $i)] "level $i"
  #}
}

