#!/bin/sh

export sander=$AMBERHOME/src/sander/sander.APBS

fname=md-apbs

cat > $fname <<EOF
Example of APBS implicit solvent dynamics
&cntrl
 ntx=1, irest=0, imin=0,
 ntpr=1, ntwx=500, nscm=100, ntwr=5000,
 dt=0.001, nstlim=50,
 temp0=300, tempi=0, ntt=1, tautp=0.1,
 igb=6, cut=12.0, ntb=0,
 ntc=2, ntf=2, tol=0.000001
/
 &apbs
    apbs_debug = 0, apbs_print=0,
    geom_upd_limit = 5.d-5,
    dime = 33, 33, 33,
    cglen = 10.0, 10.0, 10.0,
    fglen = 9.0, 9.0, 9.0,
    nion=2,
    ionq  = 1.0, -1.0,
    ionc  = 0.15, 0.15,
    ionrr = 2.0, 2.0,
 &end

EOF

$sander -O -i $fname -o ${fname}.out < /dev/null
rm -f $fname