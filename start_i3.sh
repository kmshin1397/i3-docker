#!/bin/bash

# Renders a text based list of options that can be selected by the
# user using up, down and enter keys and returns the chosen option.
#
#   Arguments   : list of options, maximum of 256
#                 "opt1" "opt2" ...
#   Return value: selected index (0 for opt1, 1 for opt2 ...)
select_option ()
{

    # little helpers for terminal print control and key input
    ESC=$( printf "\033")

    cursor_blink_on()  { printf "$ESC[?25h"; }
    cursor_blink_off() { printf "$ESC[?25l"; }
    cursor_to()        { printf "$ESC[$1;${2:-1}H"; }
    print_option()     { printf "   $1 "; }
    print_selected()   { printf "  $ESC[7m $1 $ESC[27m"; }
    get_cursor_row()   { IFS=';' read -sdR -p $'\E[6n' ROW COL; echo ${ROW#*[}; }
    key_input()        { read -s -n3 key 2>/dev/null >&2
                         if [[ $key = $ESC[A ]]; then echo up;    fi
                         if [[ $key = $ESC[B ]]; then echo down;  fi
                         if [[ $key = ""     ]]; then echo enter; fi; }

    # initially print empty new lines (scroll down if at bottom of screen)
    for opt; do printf "\n"; done

    # determine current screen position for overwriting the options
    local lastrow=`get_cursor_row`
    local startrow=$(($lastrow - $#))

    # ensure cursor and input echoing back on upon a ctrl+c during read -s
    trap "cursor_blink_on; stty echo; printf '\n'; exit" 2
    cursor_blink_off

    local selected=0
    while true; do
        # print options by overwriting the last lines
        local idx=0
        for opt; do
            cursor_to $(($startrow + $idx))
            if [ $idx -eq $selected ]; then
                print_selected "$opt"
            else
                print_option "$opt"
            fi
            ((idx++))
        done

        # user key control
        case `key_input` in
            enter) break;;
            up)    ((selected--));
                   if [ $selected -lt 0 ]; then selected=$(($# - 1)); fi;;
            down)  ((selected++));
                   if [ $selected -ge $# ]; then selected=0; fi;;
        esac
    done

    # cursor position back to normal
    cursor_to $lastrow
    printf "\n"
    cursor_blink_on

    return $selected
}

select_opt () {
    select_option "$@" 1>&2
    local result=$?
    echo $result
    return $result
}

if $(sudo docker container ls | grep -q i3); then 
    echo "There already seems to be an I3 instance running. Please remove the existing I3 Docker container first." 
    exit; 
fi

echo
read -p 'Start I3 instance with access to files in: ' mount_path

sudo docker run -d -P --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" --mount type=bind,source="$mount_path",target="$mount_path" --name i3 --user root kmshin1397/i3:latest 

# Set up I3 user to mirror current host user
sudo docker exec --user root i3 sh -c "groupadd -g $(id -g) i3 && usermod -u $(id -u) -g $(id -g) I3"

# Open shell as I3 user
sudo docker exec -it --user I3 i3 bash

echo "Close down I3 instance?"
case `select_opt "Yes" "No"` in
    0)
        sudo docker stop i3 
        sudo docker rm i3;;
    1) 
        echo "To close down the I3 container later, run close_i3.sh"
        exit;;
esac
