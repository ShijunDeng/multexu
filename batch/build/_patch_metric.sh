#!/bin/bash
# POSIX
#
#description:    add and patch files for metric
#     author:    ShijunDeng
#      email:    dengshijun1992@gmail.com
#       time:    2016-10-12
#

cp ${MULTEXU_SOURCE_DIR}/build/metric/qos_rules.c lustre/osc/
yes | cp ${MULTEXU_SOURCE_DIR}/build/metric/osc_request.c lustre/osc/
yes | cp ${MULTEXU_SOURCE_DIR}/build/metric/lproc_osc.c lustre/osc/

yes | cp ${MULTEXU_SOURCE_DIR}/build/metric/lustre_idl.h lustre/include/lustre/
yes | cp ${MULTEXU_SOURCE_DIR}/build/metric/obd.h lustre/include/
cp ${MULTEXU_SOURCE_DIR}/build/metric/metric.h lustre/include/
