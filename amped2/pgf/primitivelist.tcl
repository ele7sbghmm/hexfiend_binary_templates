set n 0
# while {![end]} {
for {set i 0} {$i < 10} {incr i} {
  section "$n" {
    uint32 ;# unused
    uint32 "start index"
    uint32 "num of primitives"
    uint32 "primitive type"

    section -collapsed "shader ptrs" {
      sectionvalue [float]
      entry "" [float]
      entry "" [float]
    }

    section -collapsed "lod distances" {
      sectionvalue [float]
      entry "" [float]
      entry "" [float]
    }

    uint32 "push buffer ptr"
    uint32 "aux data ptr"
    incr n
  }
}
