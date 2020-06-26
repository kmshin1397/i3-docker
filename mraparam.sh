#!/bin/sh
#
# mraparam.sh  version 2.2  define parameters
#

#
# General parameters
#
# prefix of directory names of alignment cycles
export DIRPRFX="cycle-"

#* change based on the project 
# prefix of output file names
export CYCPRFX="t4ss-"

#* constant 
# directory with initial alignment parameters (relative to top directory)
export TRFDIR="trf"

#* change based on the project
# size of subvolumes
export MOTIFSIZE="64 64 64"

#* Initially I was using bin1, but this was slow and not big of a difference. Liu lab is using bin 2 or 4.
# sampling factor
export SAMPFACT="2 2 2"

#* I recomend it to be always true, but tlt files are needed.
# missing wedge compensation
export WDGCOMP="true"


#
# Parameters for raw motif alignment
#
#* Almost always I'm using structure from previous cycle. 
# reference image or image stack (leave blank to use the global average
# or set to string "sel" to use selected class averages of previous cycle)
export REFIMG=
#change this

#* most of the time same between the cycles. If you prepare reference in e2proc3d.py you don't need that. 
#* preparing reference in eman is actually better, but there is no eman on dione so it is annoyting to keep transfering data. 
# mask applied to reference
# -mw for rectangular window, -md for ellipsoidal mask
# -ms is the mask apodization, -mc the mask center
export REFMSKOPT1="-md 45 45 0 -ms 0 0 0 -mc 0 0 -13"
export REFMSKOPT2="-mw 45 45 25 -ms 0 0 0 -mc 0 0 -13"

#* This settings are fine most of the time, but if reference has poor contrast it is good to try different options. 
# Fourier space filters applied to reference
# REFLOWPASS: diameter of low-pass filter mask
# REFLOWAPO:  low-pass apodization
export REFLOWPASS="0.45 0.45 0.45"
export REFLOWAPO="0.05 0.05 0.05"
# REFHIPASS:  diameter of high-pass filter mask
# REFHIAPO:   high-pass apodization
export REFHIPASS="0.055 0.055 0.055"
export REFHIAPO="0.007 0.007 0.007"

#* Never used that 
# additional filter stored in an image file (leave blank to skip)
# image size must be the corresponding transform size of MOTIFSIZE
export REFFILT=

#* Keep as it is 
# montages (true or false)
export REFMONT="true"
# number of columns in montage
#export REFMONTCOL="10"

#* I think it is useless. I keep 0 most of the time 
# multireference alignment mask, applied to raw motifs
# -mw for rectangular window, -md for ellipsoidal mask
# -ms is the mask apodization, -mc the mask center
export MRAMSK="-md 0 0 0 -mc 0 0 0"
#add another line

#* Keep default 
# cross-correlation mode: xcf mcf pcf dbl (leave blank for xcf)
export MRACC="xcf"

#* I never changed that 
# peak search radius
export MRAPKR="5 5 5"

#* I never changed that
# radius for center of mass calculation
# export MRACMR="2 2 2"

#* Has to be modified between cycles
# grid search
# for translational alignment only, use "0 0 0 0"
# for rotational alignment, use "<nut> <nstep> <spin> <sstep>"
# search direction of rotation axis in concentric cones with 
# maximum half-angle <nut> (nutation angle), and angular step <nstep>
# search rotation about the above axis from -<spin> to +<spin>
# (spin angle) with step size <sstep>
# rotational alignment about z-axis only: "0 0 <spin> <sstep>"
# angular ranges: 0 <= <spin> <= 180;  0 <= <nut> <= 180
export MRASRCH="2 0.5 10 0.5"

# execution options
# use "nohup <n>" to run on <n> processors
export MRAOPT="nohup 40"


#
# MSA parameters
#
#* It make no sense for me why it could be different than above 
# size of extracted subvolumes for MSA
export MSAIMGSIZE="64 64 64"

# sampling factor for subvolume extraction
export MSAIMGSMP="${SAMPFACT}"

#* I was mainly using mask options below, but this one is acctually better. The problem is that you need mask prepared in eman or relion, which are not on dione so it is annoying. 
# file name of MSA mask, path name is relative to DIRPRFX,
# size must be defined above with MSAIMGSIZE
# (leave blank to use mask creation options below)
export MSAMASK=

#* most of the time same between the cycles
# MSA mask creation options
# -mw for rectangular window, -md for ellipsoidal mask
# -mc is the mask center
export MSAMASKOPT1="-md 45 45 0 -ms 0 0 0 -mc 0 0 -13"
export MSAMASKOPT2="-mw 45 45 25 -ms 0 0 0 -mc 0 0 -13"
export MSAMASKOPT3=

# file name of image to superimpose mask (leave blank to skip)
export MSAMASKSUPERPOS=

# create averages of raw stack
export MSAIMGAVG="true"

#* I think is useless
# image mask applied to extracted motifs
# -mw for rectangular window, -md for ellipsoidal mask
# -ms is the mask apodization, -mc the mask center
export MSAIMGMSK="-md 0 0 0 -mc 0 0 0"

#* doesn't relly need changing
# Fourier space filters
# MSALOWPASS: diameter of low-pass filter mask
# MSALOWAPO:  low-pass apodization
export MSALOWPASS="0.35 0.35 0.35"
export MSALOWAPO="0.05 0.05 0.05"
# MSAHIPASS:  diameter of high-pass filter mask
# MSAHIAPO:   high-pass apodization
export MSAHIPASS="0.010 0.010 0.010"
export MSAHIAPO="0.002 0.002 0.002"
# additional filter stored in an image file (leave blank to skip)
# image size must be the corresponding transform size of MSAIMGSIZE
export MSAFILT=

# Maximal number of factors
export MSAFACT=40

# montage of eigenimages (true or false)
export MSAMONT="true"
# number of columns in montage
#export MSAMONTCOL="10"


#
# Classification parameters
#
#* I would keep classification parameter as thay are 
# number of classes to generate
export CLASSES="1 2 3 4"

# min/max number and increment of classes stored in the class-file
# the settings below store 2 4 6 8 classes
export CLSMIN="1"
export CLSMAX="4"
export CLSINC="1"
# factors used in classification
export CLSFACT="1-4"

# low-pass filter for montaged class averages (leave blank to skip montage)
export CLSMONT="0.45"
# number of columns in montage
#export CLSMONTCOL="10"

# fraction of ignored high-variance outliers
export CLSHVO="0.1"

# fraction of ignored high-variance class members
export CLSHVM="0.1"


#
# Parameters for class average alignment
#
# set specific reference image
# (leave blank for automatic evaluation of optimal reference)
export SELREFIMG=

# real space masks (maximum 3, applied sequentially)
# (leave blank for no mask)
export SELMSKOPT1=
export SELMSKOPT2=
export SELMSKOPT3=


# Fourier space filters
# SELLOWPASS: diameter of low-pass filter mask
# SELLOWAPO:  low-pass apodization
export SELLOWPASS="0.40 0.40 0.40"
export SELLOWAPO="0.05 0.05 0.05"
# SELHIPASS:  diameter of high-pass filter mask
# SELHIAPO:   high-pass apodization
export SELHIPASS="0.010 0.010 0.010"
export SELHIAPO="0.002 0.002 0.002"
# additional filter stored in an image file (leave blank to skip)
# image size must be the corresponding transform size of MOTIFSIZE
export SELFILT=

# cross-correlation mode: xcf mcf pcf dbl (leave blank for xcf)
export SELCC="xcf"

# montages (true or false)
export SELMONT="true"
# number of columns in montage
#export SELMONTCOL="10"

# peak search radius
export SELPKR="5 5 5"

# radius for center of mass calculation
# export SELCMR="2 2 2"


#* need to be modified between cycles, but could be same as above. In fact I always use same settings
# grid search (3D)
# for translational alignment only, use "0 0 0 0"
# for rotational alignment, use "<nut> <nstep> <spin> <sstep>"
# search direction of rotation axis in concentric cones with tation angle), and angular step <nstep>
# search rotation about the above axis from -<spin> to +<spin>
# (spin angle) with step size <sstep>
# rotational alignment about z-axis only: "0 0 <spin> <sstep>"
# angular ranges: 0 <= <spin> <= 180;  0 <= <nut> <= 180
# grid search (2D)
# rotational alignment: "<rot> <step>"
# angular range: 0 <= <rot> <= 180
export SELSRCH="2 0.5 10 0.5"

# execution options
# use "nohup" to run on a single processor
# use "nohup <n>" to run on <n> processors
export SELOPT="nohup 40"

# selected classification to apply transformations to raw motifs
# must be one defined with CLASSES above, or leave blank to skip
export SELCLS="4"

#
# miscellaneous parameters
#
# produce global average
export GLBLAVG="true"

# produce side views of averages
export YPERM="true"

# uncomment to keep large image stacks (default is delete)
# export MSAIMGKEEP="true"

# uncomment to use custom temporary file directory
# export I3TMPDIR="/tmp"

# uncomment to use custom scripts in specified directory
# export I3SCRIPTS="scripts"
