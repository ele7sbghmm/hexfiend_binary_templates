little_endian

proc func {index} {
  section -collapsed "function \[0\] Level $index" {
    set stringSize [uint32 "string size"]
    if {$stringSize != 0} { ascii $stringSize "" }
    uint32 "line defined"
    uint8 "num up values"
    uint8 "num params"
    uint8 "is vararg"
    global maxStackSize 
    set maxStackSize [uint8 "max stack size"]
  }
}
proc lines {} {
  section -collapsed "lines" {
    set sizeOfLineInfo [uint32 "size of line info"]
    section -collapsed "line defined" {
      for {set i 0} {$i < $sizeOfLineInfo} {incr i} {
        uint32 "[expr $i + 1]"
      }
    }
  }
}
proc locals {} {
  section -collapsed "locals" {
    uint32 "size of local vars"
    set stringSize [uint32 "string size"]
    ascii $stringSize ""
    uint32 "start pc"
    uint32 "end pc"
  }
}
proc upvalues {} {
  section -collapsed "upvalues" {
    set numUpValues [uint32 "size of up values"]
    if {$numUpValues != 0} {
      set stringSize [uint32 "string size"]
    #  puts "[pos] $stringSize upval stringsize"
      if {$stringSize != 0} {
        ascii $stringSize ""
      }
    }
  }
}
proc constants {} {
  global consts

  section -collapsed "constants" {
    set sizek [uint32 "num of constants"]
    for {set i 0} {$i < $sizek} {incr i} {
      set constType [uint8]
      set val [switch $constType {
          3 { double }
          4 { ascii [uint32] }
          9 { uint16 [uint32] }
      }]
      lappend consts $val
      entry "$constType" "$val"
    }
  }
}
proc functions {} {
  section -collapsed "functions" {
    set sizep [uint32 "sizep"]
    for {set i 0} {$i < $sizep} {incr i} {
      function [expr $index + 1]
    }
  }
}

proc decode {} {
  global Op C B A Bx
  set Op -1; set C -1; set B -1; set A -1; set Bx -1
  set Op [expr [uint32] >>  0 &  0x3f]; move -4
  set C  [expr [uint32] >>  6 & 0x1ff]; move -4
  set B  [expr [uint32] >> 15 & 0x1ff]; move -4
  set A  [expr [uint32] >> 24 &  0xff]; move -4
  set Bx [expr [uint32] >>  6 & 0x3ffff]
  #section -collapsed "decode" {
  #  sectionvalue "$Op-$C-$B-$A"
  #  entry "Op" "$Op"
  #  entry "C" "$C"
  #  entry "B" "$B"
  #  entry "A" "$A"
  #  entry "Bx" "$Bx"
  #}
}
proc code {} {
  global globals reg consts Op C B A Bx

  section -collapsed "code" {
    set sizeOfCode [uint32 "size of code"]

    for {set i 0} {$i < $sizeOfCode} {incr i} {
      decode
      #puts "- $Op ---------------------------------------------------- Op$Op-C$C-B$B-A$C-Bx$Bx --- "
      switch $Op {
        # LOADK
        1 {
          #puts " LOADK reg\[A$A\] = consts\[Bx$Bx\]"
          set constsBx [lindex $consts $Bx]
          set reg [lset reg $A $constsBx]
          #puts "   [lindex $reg $A]"
        }
        # LOADBOOL
        2 {
          #puts " LOADBOOL reg\[A$A\] = TRUE/FALSE"
          if {$C > -1} {
            set reg [lset reg $A [
              switch { 0 { "FALSE" }; 1 { "TRUE" } }
            ]]
          }
          #puts "          [lindex $reg $A]"
        }
        # SETGLOBAL
        7 {
          #puts " SET GLOBAL\[consts\[A$A\]\] = reg\[Bx$Bx\]"
          dict set globals [lindex $consts $A] [lindex $reg $Bx]
          #puts "        \[[lindex $consts $A]\]"
        }
        # SETTABLE
        9 {
          set d [lindex $reg $A]
          if {$B <  250 && $C <  250} {
            #puts " SETTABLE 0  B$B <  250 && C$C <  250"
            #puts "   [lindex $reg $B]  [lindex $reg $C]"
            dict set d [lindex $reg $B] [lindex $reg $C]
          }
          if {$B <  250 && $C >= 250} {
            #puts " SETTABLE 1  B$B <  250 && C$C >= 250"
            #puts "   [lindex $reg $B] [lindex $consts [expr $C % 250]]"
            dict set d [lindex $reg $B] [lindex $consts [expr $C % 250]]
          }
          if {$B >= 250 && $C <  250} {
            #puts " SETTABLE 2  B$B >= 250 && C$C <  250"
            #puts "   [lindex $consts [expr $B % 250]] [lindex $reg $C]"
            dict set d [lindex $consts [expr $B % 250]] [lindex $reg $C]
          }
          if {$B >= 250 && $C >= 250} {
            #puts " SETTABLE 3  B$B >= 250 && C$C >= 250"
            #puts "   [lindex $consts [expr $B % 250]] [lindex $consts [expr $C % 250]"
            dict set d [lindex $consts [expr $B % 250]] [lindex $consts [expr $C % 250]]
          }
          set reg [lset reg $A $d]
        }
        # NEWTABLE
        10 {
          #puts " NEW TABLE  reg\[A$A\] = {} "
          set reg [lset reg $A [dict create]]
        }
        # RETURN
        27 {
          #puts " RETURN"
          #puts " Globals: $globals"
        }
        # SETLIST
        31 {
          #puts " SET LIST  x%32"
          set start [expr $A + $Bx - $Bx % 32 + 1]
          set end [expr $start + $Bx % 32 + 1]
          set reg [lset reg $A [lrange $reg $start $end]]
        }
      }
    }
  }
  foreach {item dic} [lindex $reg 0] {
    puts "$item $dic"
    entry $item [format "%.2f" [lindex $dic 0]]
    entry "" [format "%.2f" [lindex $dic 1]]
    entry "" [format "%.2f" [lindex $dic 2]]
  }
}
proc function {index} {
  func index
  uint32
  lines
  #locals
  #upvalues
  constants
  functions
  code
}

set consts [list]
set reg [lrepeat 5 0]
set globals {}

requires 0 "1b 4c 75 61 50"
section -collapsed "global header" {
  bytes 1
  ascii 3 "fourCC"

  uint8 -hex "version"
  uint8 "endianness"
  uint8 "sizeOfInt"
  uint8 "sizeOfSize_t"
  uint8 "sizeOfInstruction"
  uint8 "sizeOfOper"
  uint8 "sizeOfB"
  uint8 "sizeOfBb"
  uint8 "sizeOfCb"
  uint8 "sizeOfNumber"
  bytes 8 "sample"
}
function 1

