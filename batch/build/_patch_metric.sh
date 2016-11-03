#!/bin/bash
# POSIX
#
#description:    add and patch files for metric
#     author:    ShijunDeng
#      email:    dengshijun1992@gmail.com
#       time:    2016-10-12
#

#lustre/
cp -rf ${MULTEXU_SOURCE_DIR}/build/metric/metric-tests lustre/
#lustre/osc/
cp ${MULTEXU_SOURCE_DIR}/build/metric/qos_rules.c lustre/osc/
#lustre/osc/
yes | cp ${MULTEXU_SOURCE_DIR}/build/metric/osc_request.c lustre/osc/
yes | cp ${MULTEXU_SOURCE_DIR}/build/metric/lproc_osc.c lustre/osc/
yes | cp ${MULTEXU_SOURCE_DIR}/build/metric/osc_cache.c lustre/osc/
#lustre/include/
yes | cp ${MULTEXU_SOURCE_DIR}/build/metric/obd.h lustre/include/
yes | cp ${MULTEXU_SOURCE_DIR}/build/metric/lprocfs_status.h lustre/include/
yes | cp ${MULTEXU_SOURCE_DIR}/build/metric/lustre_nrs_tbf.h lustre/include/
#lustre/include/lustre/
yes | cp ${MULTEXU_SOURCE_DIR}/build/metric/lustre_idl.h lustre/include/lustre/
yes | cp ${MULTEXU_SOURCE_DIR}/build/metric/lprocfs_status.h lustre/include/lustre/
#lustre/ptlrpc/
yes | cp ${MULTEXU_SOURCE_DIR}/build/metric/pack_generic.c lustre/ptlrpc/
yes | cp ${MULTEXU_SOURCE_DIR}/build/metric/nrs_tbf.c lustre/ptlrpc/
yes | cp ${MULTEXU_SOURCE_DIR}/build/metric/lproc_ptlrpc.c lustre/ptlrpc/
#lustre/obdclass/
yes | cp ${MULTEXU_SOURCE_DIR}/build/metric/genops.c lustre/obdclass/
yes | cp ${MULTEXU_SOURCE_DIR}/build/metric/lprocfs_status.c lustre/obdclass/
yes | cp ${MULTEXU_SOURCE_DIR}/build/metric/lprocfs_counters.c lustre/obdclass/

yes | cp ${MULTEXU_SOURCE_DIR}/build/metric/lustre_utils_wiretest.c lustre/utils/wiretest.c
yes | cp ${MULTEXU_SOURCE_DIR}/build/metric/lustre_ptlrpc_wiretest.c lustre/ptlrpc/wiretest.c

cp ${MULTEXU_SOURCE_DIR}/build/metric/metric.h lustre/include/

#Makefile文件
yes | cp ${MULTEXU_SOURCE_DIR}/build/metric/Makefile/lustre_include_Makefile.am lustre/include/Makefile.am
yes | cp ${MULTEXU_SOURCE_DIR}/build/metric/Makefile/lustre_include_Makefile.in lustre/include/Makefile.in
yes | cp ${MULTEXU_SOURCE_DIR}/build/metric/Makefile/lustre_osc_Makefile.in lustre/osc/Makefile.in