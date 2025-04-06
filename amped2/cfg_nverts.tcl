little_endian

uint32 "unk"
for {set i 0} {$i < 64} {incr i} {
    section $i {
        set "x" [float]
        set "y" [float]
        set "z" [float]
        sectionvalue [format "%f" $x]
        entry "" [format "%f" $y]
        entry "" [format "%f" $z]
    }
}
