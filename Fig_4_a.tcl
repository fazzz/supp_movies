axes location off

proc make_rotation_animated_gif {} {
    set frame 0
    for {set i 0} {$i <= 360} {incr i 10} {
	set filename snap.[format "%04d" $frame].y.rgb
	render snapshot $filename
	incr frame
	rotate y by 10
    }

    set filename snap.rgb
    render snapshot $filename

    for {set i 0} {$i < 360} {incr i 10} {
	set filename snap.[format "%04d" $frame].x.rgb
	render snapshot $filename
	incr frame
	rotate x by 10
    }

    exec convert -loop 1 -delay 10 snap.*y.rgb -delay 30 snap.rgb -delay 10 snap.*x.rgb -delay 100 snap.rgb Fig_4_a.gif
    exec rm snap.*.rgb
}

proc draw_line_between_ca_ca {resi resj radi arrow_vec} {
    set atomi [atomselect 0 "name CA and resid ${resi}"]
    set atomj [atomselect 0 "name CA and resid ${resj}"]

    set coordi [ lindex [$atomi get {x y z}] 0 ]
    set coordj [ lindex [$atomj get {x y z}] 0 ]

    set dirij [ vecsub $coordi $coordj ]
    if {! [veclength $dirij] } { return }

    set start_cone_i [ vecadd $coordj [ vecscale  0.9 $dirij ] ]
    set start_cone_j [ vecadd $coordi [ vecscale -0.9 $dirij ] ]

    draw sphere $coordi radius 0.2 resolution 20
    draw sphere $coordj radius 0.2 resolution 20

    draw cylinder $start_cone_i  $start_cone_j radius $radi resolution 20
    if { $arrow_vec == 0} {
        draw cone $start_cone_i $coordi radius [ expr $radi\*2 ] resolution 20
        draw cone $start_cone_j $coordj radius [ expr $radi\*2 ] resolution 20
    }
    if { $arrow_vec == 1} {
        draw cone $coordi $start_cone_i radius [ expr $radi\*2 ] resolution 20
        draw cone $coordj $start_cone_j radius [ expr $radi\*2 ] resolution 20
    }
}

mol new {protein_nst-ave_viewpoint.pdb} type {pdb}

mol modcolor    0 0 ColorID 2
mol modstyle    0 0 Newcartoon
mol modmaterial 0 0 Transparent

graphics 0 color red
draw_line_between_ca_ca    4   63 0.196    1
draw_line_between_ca_ca    4   62 0.169    1
draw_line_between_ca_ca    4   61 0.170    1
draw_line_between_ca_ca    4   59 0.267    1
draw_line_between_ca_ca    4   58 0.246    1
draw_line_between_ca_ca   84  113 0.019    1
draw_line_between_ca_ca   84  112 0.022    1
draw_line_between_ca_ca   84  109 0.020    1
draw_line_between_ca_ca   84  108 0.018    1
draw_line_between_ca_ca   81  112 0.027    1
draw_line_between_ca_ca   75  103 0.013    0
draw_line_between_ca_ca   74  103 0.006    0
draw_line_between_ca_ca   73  103 0.028    0
draw_line_between_ca_ca   50   64 0.038    1
draw_line_between_ca_ca   50   63 0.015    1
draw_line_between_ca_ca   26   56 0.028    1
draw_line_between_ca_ca   24   38 0.072    1
draw_line_between_ca_ca   24   37 0.068    1
draw_line_between_ca_ca   23  141 0.466    0
draw_line_between_ca_ca   23  137 0.538    0
draw_line_between_ca_ca   23   38 0.070    1
draw_line_between_ca_ca   22   38 0.079    1
draw_line_between_ca_ca   22   37 0.099    1
draw_line_between_ca_ca   20  137 0.415    0
draw_line_between_ca_ca   18   56 0.031    1
draw_line_between_ca_ca   17   56 0.024    1
draw_line_between_ca_ca    9   67 0.111    0
draw_line_between_ca_ca    8   67 0.120    0
draw_line_between_ca_ca    5   71 0.082    0
draw_line_between_ca_ca    4   71 0.115    0
draw_line_between_ca_ca    4   64 0.087    1
draw_line_between_ca_ca    1   97 0.024    0
draw_line_between_ca_ca    1   96 0.031    0

make_rotation_animated_gif

quit
