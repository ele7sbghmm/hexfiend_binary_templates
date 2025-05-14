proc cGroupNode { n } {
    set index [int16]
    move -4
    bytes 0xe "$n $index GroupNode"
    move -4
    set subNodes [uint32]
    recurse $subNodes "$n   "
}

proc cLocalFrameArray { n } {
    set index [int16]
    move -4
    bytes 0x26 "$n $index LocalFrameArray"
    move -4
    set subNodes [uint32]
    recurse $subNodes "$n   "
}

proc cVBGeomNode { n } {
    set index [uint16]
    move -4
    bytes 0xe "$n $index VBGeomNode"
    move -4
    set subNodes [uint32]
    recurse $subNodes "$n   "
}

proc cJoint { n } {
    set index [int16]
    move -4
    bytes 0x4e "$n $index Joint"
    move -4
    set subNodes [uint32]
    recurse $subNodes "$n   "
}

proc cSkinVBGeomNode { n } {
    set index [uint16]
    move -4
    bytes 0x1a "$n $index SkinVBGeomNode"
    move -4
    set subNodes [uint32]
    recurse $subNodes "$n   "
}

proc cUVAnimateNode { n } {
    set index [int16]
    move -4
    bytes 0x2a "$n $index UVAnimateNode"
    move -4
    set subNodes [uint32]
    recurse $subNodes "$n   "
}

proc get {id n} {
    switch $id {
        0x4205 { cGroupNode $n }
        0x4209 { cLocalFrameArray $n }
        0x420C { cVBGeomNode $n }
        0x4210 { cJoint $n }
        0x4211 { cSkinVBGeomNode $n }
        0x421B { cUVAnimateNode $n }
        default { entry "id" "$id"}
    }
}

proc recurse {num n} {
    for {set i 0} {$i < $num} {incr i} {
        set id [hex 2]
        get $id $n
    }
}

proc recurse_nodes {} {
    # while {![end]} {
        set id [hex 2]
        get $id ""
    # }
}

recurse_nodes
