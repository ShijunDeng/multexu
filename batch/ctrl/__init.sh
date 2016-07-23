#!/bin/sh
# POSIX
#
#description:    define configuration variables
#     author:    ShijunDeng
#      email:    dengshijun1992@gmail.com
#	time:    2016-07-19
#
function __init()
{
	export MULTEXU_BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../../ && pwd )"
	export MULTEXU_SOURCE_DIR="${MULTEXU_BASE_DIR}/source"
	export MULTEXU_BATCH_DIR="${MULTEXU_BASE_DIR}/batch"

	export MULTEXU_BATCH_AUTHORIZE_DIR="${MULTEXU_BATCH_DIR}/authorize"
	export MULTEXU_BATCH_CONFIG_DIR="${MULTEXU_BATCH_DIR}/config"
	export MULTEXU_BATCH_BUILD_DIR="${MULTEXU_BATCH_DIR}/build"
	export MULTEXU_BATCH_CRTL_DIR="${MULTEXU_BATCH_DIR}/ctrl"
	
	export PAUSE_CMD="sleep 3s"

}

##################

__init
