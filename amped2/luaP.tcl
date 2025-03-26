little_endian

proc function {index} {
  section -collapsed "function \[0\] Level $index" {
    set stringSize [uint32 "string size"]
    if {$stringSize != 0} { ascii $stringSize "" }
    uint32 "line defined"
    uint8 "num up values"
    uint8 "num params"
    uint8 "is vararg"
    uint8 "max stack size"
  }
  section -collapsed "lines" {
    set sizeOfLineInfo [uint32 "size of line info"]
    for {set i 0} {$i < $sizeOfLineInfo} {incr i} {
      uint32 "[expr $i + 1]"
    }
  }
  section -collapsed "locals" {
    uint32 "size of local vars"
    set stringSize [uint32 "string size"]
    ascii $stringSize ""
    uint32 "start pc"
    uint32 "end pc"
  }
  section -collapsed "upvalues" {
    set numUpValues [uint32 "size of up values"]
    if {$numUpValues != 0} {
      set stringSize [uint32 "string size"]
      if {$stringSize != 0} {
        ascii $stringSize ""
      }
    }

  }
  section -collapsed "constants" {
    set sizek [uint32 "num of constants"]
    for {set i 0} {$i < $sizek} {incr i} {
      section "$i" {
        set constType [uint8 "const type"]
        switch $constType {
          3 { double "double" }
          4 {
            set stringSize [uint32 "string size"]
            ascii $stringSize "string"
          }
        }
      }
    }
  }
  section -collapsed "functions" {
    set sizep [uint32 "sizep"]
    for {set i 0} {$i < $sizep} {incr i} {
      function [expr $index + 1]
    }
  }
  section -collapsed "code" {
    set sizeOfCode [uint32 "size of code"]
    bytes [expr $sizeOfCode * 4] "binary"
  }
}

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

