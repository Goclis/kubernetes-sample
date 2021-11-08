#!/bin/bash

echo "Data directory: ${POD_DATA_DIR}"

# 根据环境变量创建指定的日志目录（顺带创建了数据目录）。
# 如果目录已存在，说明发生冲突，拼接当前时间并调整环境变量。
if [ -d ${POD_DATA_DIR} ]; then
    echo "Existing data directory ${POD_DATA_DIR}, concat timestamp"
    POD_DATA_DIR="${POD_DATA_DIR}-$(date +%s)"
    echo "New data directory: ${POD_DATA_DIR}"
fi
POD_LOG_DIR="${POD_DATA_DIR}/logs"
mkdir -p ${POD_LOG_DIR}

# 为了统一 logtail 采集配置中的日志路径，创建软链接。
ln -s ${POD_LOG_DIR} /share/logs

# 产生日志。
LOG_FILE_PATH=${POD_LOG_DIR}/app.log
for((i=0;i<10000000000000;i++)); do
    echo "Log ${i} to file" >> ${LOG_FILE_PATH}
    sleep 1
done
