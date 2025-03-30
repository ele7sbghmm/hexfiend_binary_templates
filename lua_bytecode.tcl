#set a [uint32_bits 31,30,29,28,27,26,25,24 "a"] # 0,1,2,3,4,5,6,7  8
#set a [uint32_bits 23,22,21,20,19,18,17,16,15 "b"] # 8,9,10,11,12,13,14,15,16  9
#set a [uint32_bits 14,13,12,11,10,9,8,7,6 "c"] # 17,18,19,20,21,22,23,24,25  9
#set a [uint32_bits 5,4,3,2,1,0 "op"] # 26,27,28,29,30,31
#uint32_bits 31,30,29,28,27,26,25,24 "a"
#move -4
#uint32_bits 23,22,21,20,19,18,17,16,15 "b"
#move -4
#uint32_bits 14,13,12,11,10,9,8,7,6 "c"
#move -4
#uint32_bits 5,4,3,2,1,0 "op"
#move -4

set Op 0; set C 0; set B 0; set A 0
proc decode {} {
  set Op [expr [uint32] >>  0 &  0x3f]; move -4
  set C  [expr [uint32] >>  6 & 0x1ff]; move -4
  set B  [expr [uint32] >> 15 & 0x1ff]; move -4
  set A  [expr [uint32] >> 24 &  0xff]
  section -collapsed "op $Op" {
    sectionvalue "$C-$B-$A"
    entry "Op" "$Op"
    entry "C" "$C"
    entry "B" "$B"
    entry "A" "$A"
  }
}
decode


#switch $i {
#  # LOADK
#  1 {
#
#  }
#  # LOADBOOL
#  2 {
#
#  }
#  # SETGLOBAL
#  7 {
#
#  }
#  # SETTABLE
#  9 {
#
#  }
#  # NEWTABLE
#  10 {
#
#  }
#  # RETURN
#  27 {
#
#  }
#  # SETLIST
#  31 {
#
#  }
#}
