#!/bin/bash

# 清屏，让终端界面干净好看
# clear

# 输出纯字符Banner
echo -e "\n\033[1;36m=========================================\n          Hynphi网络（香港）\n=========================================\033[0m\n"
echo -e "正在为您按顺序检测 s-ui/3x-ui Reality 伪装网站延迟...\n"

# 域名列表
domains=(
    "www.hku.hk" "www.cuhk.edu.hk" "www.ust.hk" "www.polyu.edu.hk"
    "www.cityu.edu.hk" "www.hkbu.edu.hk" "www.mtr.com.hk" "www.clp.com.hk"
    "www.hkelectric.com" "www.cathaypacific.com" "www.hkex.com.hk" "www.bochk.com"
    "www.hsbc.com.hk" "www.hangseng.com" "www.hkt.com" "www.pccw.com"
    "www.hongkongpost.hk" "www.gov.hk" "www.hkstp.org" "www.cyberport.hk"
)

# 循环测试延迟（经典顺序排队模式，单个网站硬性死等 1.5 秒）
for d in "${domains[@]}"; do
    # 挨个测试，上一个测完才会测下一个
    r=$(curl -s -o /dev/null -m 1.5 -w "%{time_appconnect}" "https://$d")
    
    awk -v d="$d" -v r="$r" 'BEGIN {
        if (r>0) 
            printf "%-24s : \033[1;32m%.0f ms\033[0m\n", d, r*1000; 
        else 
            printf "%-24s : \033[1;31mtimeout\033[0m\n", d
    }'
done

echo -e "\n\033[1;36m=========================================\033[0m"
echo -e "检测完成！请选择绿色且延迟较低的域名写入 s-ui/3x-ui。\n"
