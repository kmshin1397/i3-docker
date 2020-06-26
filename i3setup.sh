#!/bin/bash
#
# i3setup.sh  version 2.1  common setup
#

[ $# -lt 1 -o $# -gt 3 ] && { echo "usage: $( basename $0 ) defs [[oldcycle] newcycle]" >&2; exit 1; }

set -e

# set parameters

export MAPS="$(pwd)/${1}/maps"

export SETS="$(pwd)/${1}/sets"

[ -e ${MAPS} ] || { echo "$( basename $0 ): defs/maps not found" >&2; exit 1; }

[ -e ${SETS} ] || { echo "$( basename $0 ): defs/sets not found" >&2; exit 1; }

[ -r ${I3PARAM:=i3param.sh} ] || { echo "$( basename $0 ): could not read default parameter file ${I3PARAM}" >&2; exit 1; }

. ${I3PARAM}

# setup software packages

[ -d ${I3ROOT} ] || { echo "$( basename $0 ): i3 is not setup properly" >&2; exit 1; }

# KS 2020: Removed from Docker container as we know the environment variables are set up, and these keep replacing vital paths like /usr/local/lib
# . ${I3ROOT}/setup.sh 

PATH="${I3LEGACY}/run:${PATH}"

[ ${I3SCRIPTS} ] && PATH="${I3SCRIPTS}:${PATH}"

if [ x${USEIMAGIC} = xtrue ]; then

  [ ${IMAGIC_ROOT} ] || { echo "$( basename $0 ): Imagic is not setup properly" >&2; exit 1; }

fi

if [ "${2}" ]; then

# define environment variables for current cycle

  export CYC=$( printf "%03u" ${3:-${2}} )

  export PRFX="${CYCPRFX}${CYC}"

  export I3D="${PRFX}.i3d"

  export SET="${PRFX}"

  export DIR="${DIRPRFX}${CYC}"

  export SEL="${PRFX}-sel"

  export CLS="${PRFX}-class"

  export DIM=$( echo ${MOTIFSIZE} | awk '{ print NF }' )

# previous cycle

  if [ ${3} ]; then

    export OLD=$( printf "%03u" ${2} )

    export OLDPRFX="${CYCPRFX}${OLD}" 

    export OLDSET="${OLDPRFX}-ali"

    export OLDDIR="${DIRPRFX}${OLD}"

  fi

fi

# data set definitions and file paths relative to sub-directory

export I3FILEPATH="."$( while read dir map tlt; do echo -n ":${dir}"; done <${MAPS} )
