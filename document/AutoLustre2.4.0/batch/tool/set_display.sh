 #!/bin/bash
# POSIX
#
#description:    change display resolution size
#     author:    ShijunDeng
#      email:    dengshijun1992@gmail.com
#       time:    2016-08-23
#
#initialization
cd "$( dirname "${BASH_SOURCE[0]}" )" #get  a Bash script tell what directory it's stored in
if [ ! -f __init.sh ]; then
        echo "MULTEXU ERROR:multexu initialization failure:cannot find the file __init.sh... "
        exit 1
else
        source ./__init.sh
fi
function change_drsize()
{
	local drsize_x=$1 #eg 1440 
	local drsize_y=$1 #eg 900
	if [[ ! "${drsize_x} ${drsize_y}" =~ "\d{3,4} \d{3,4}" ]]; then
		print_message "MULTEXU_ERROR" "display resolution size format error..."
		exit 1
	fi
	`${PAUSE_CMD}`
	local model=${`cvt "${drsize_x} ${drsize_y}"`##"}
	sudo xrandr --newmode "${drsize_x}x${drsize_y}" ${model}
	sudo xrandr --addmode VGA-0 "${drsize_x}x${drsize_y}"
	sudo xrandr --output VGA-0 --mode "${drsize_x}x${drsize_y}"	
}

print_message "MULTEXU_INFO" "change display resolution size......"
change_drsize $@
print_message "MULTEXU_INFO" "finished to change display resolution size......"