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

    exec convert -loop 1 -delay 10 snap.*y.rgb -delay 30 snap.rgb -delay 10 snap.*x.rgb -delay 100 snap.rgb Fig_8_c.gif
    rm snap.*.rgb
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

mol new {protein_nst-ave_viewpoint_PDZ.pdb} type {pdb}

mol modcolor    0 0 ColorID 2
mol modstyle    0 0 Newcartoon
mol modmaterial 0 0 Transparent

graphics 0 color red
draw_line_between_ca_ca  335  389 0.005    1
draw_line_between_ca_ca  335  361 0.002    0
draw_line_between_ca_ca  335  359 0.009    1
draw_line_between_ca_ca  334  361 0.061    1
draw_line_between_ca_ca  334  359 0.068    0
draw_line_between_ca_ca  332  371 0.055    0
draw_line_between_ca_ca  368  399 0.002    1
draw_line_between_ca_ca  366  379 0.002    1
draw_line_between_ca_ca  366  378 0.078    0
draw_line_between_ca_ca  336  399 0.098    0
draw_line_between_ca_ca  334  374 0.139    0
draw_line_between_ca_ca  334  371 0.427    0
draw_line_between_ca_ca  333  374 0.342    0
draw_line_between_ca_ca  333  371 0.315    0
draw_line_between_ca_ca  333  370 0.269    0
draw_line_between_ca_ca  332  373 0.011    1
draw_line_between_ca_ca  332  372 0.066    0
draw_line_between_ca_ca  331  375 0.215    0
draw_line_between_ca_ca  331  371 0.157    0
draw_line_between_ca_ca  330  399 0.119    0
draw_line_between_ca_ca  330  376 0.009    1
draw_line_between_ca_ca  330  374 0.026    1
draw_line_between_ca_ca  330  373 0.070    0
draw_line_between_ca_ca  330  372 0.017    1
draw_line_between_ca_ca  330  371 0.006    0
draw_line_between_ca_ca  329  399 0.313    0
draw_line_between_ca_ca  307  353 0.251    0
draw_line_between_ca_ca  307  352 0.345    0
draw_line_between_ca_ca  307  351 0.257    1

make_rotation_animated_gif

quit
