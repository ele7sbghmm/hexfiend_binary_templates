little_endian

proc rgb565 {} {
  set r [expr [uint16] >> 11 & 0x1f]; move -2
  set g [expr [uint16] >>  5 & 0x3f]; move -2
  set b [expr [uint16] >>  0 & 0x1f]
  return [list $r $g $b]
}
proc BC1 {} { # https://en.wikipedia.org/wiki/S3_Texture_Compression#DXT1
  set c0 [rgb565]
  set c1 [rgb565]
  set alpha [uint32]
  move -8

  if {[uint16] > [uint16]} {
    move 4
    return [dict create \
      "c0" $c0 \
      "c1" $c1 \
      "c2" [list \
        [expr ([lindex $c0 0] * 2/3) + ([lindex $c1 0] * 1/3)] \
        [expr ([lindex $c0 1] * 2/3) + ([lindex $c1 1] * 1/3)] \
        [expr ([lindex $c0 2] * 2/3) + ([lindex $c1 2] * 1/3)] \
      ] \
      "c3" [list \
        [expr ([lindex $c0 0] * 1/3) + ([lindex $c1 0] * 2/3)] \
        [expr ([lindex $c0 1] * 1/3) + ([lindex $c1 1] * 2/3)] \
        [expr ([lindex $c0 2] * 1/3) + ([lindex $c1 2] * 2/3)] \
      ] \
      "alpha" $alpha \
    ]
  } else {
    move 4
    return [dict create \
      "c0" $c0 \
      "c1" $c1 \
      "c2" [list \
        [expr ([lindex $c0 0] * 1/2) + ([lindex $c1 0] * 1/2)] \
        [expr ([lindex $c0 1] * 1/2) + ([lindex $c1 1] * 1/2)] \
        [expr ([lindex $c0 2] * 1/2) + ([lindex $c1 2] * 1/2)] \
      ] \
      "c3" [list 0 0 0] \
      "alpha" $alpha \
    ]
  }
}

requires 0 "58 50 52 30"
ascii 4 "fourcc"

set fileSize   [uint32 "file size"]
set headerSize [uint32 "header size"]

section -collapsed resource {
  uint32 "common"
  uint32 ""
  uint32 ""
  uint16 "u16"
  uint16 "u16"
  uint32 ""
}

set numPixels [expr ($fileSize - $headerSize) / 8]
for {set i 0} {$i < $numPixels} {incr i} {
  section $i {
    set d [BC1]
    sectionvalue [dict get $d "c0"]
    entry "  c1" [dict get $d "c1"]
    entry "  c2" [dict get $d "c2"]
    entry "  c3" [dict get $d "c3"]
    #entry " alp" [format "%08b" [dict get $d "alpha"]]
  }
}

