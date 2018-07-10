#!/bin/bash

#远程执行命令

server_ip=(root@192.168.11.72 root@192.168.11.73)
server_pwd=(root root)
image_sourcedir=/root/temp/partner/image/

mycount=0

echo "准备开始..."

for cur_ip in ${server_ip[@]}
	do
		#2.开始循环1
		
		cur_pwd=${server_pwd[mycount]}
		
		echo "第$mycount个服务器 $cur_ip,密码:$cur_pwd"
		
		/usr/bin/expect <<-EOF
		
		set timeout 1800
		
		#拷贝镜像到远程服务器的指定目录，只能拷贝目录级
		
		#spawn scp -Cpr "/root/temp/partner/image/*.*" $cur_ip:/root/temp/test/
		
		#采用同步
		spawn rsync -avz $image_sourcedir $cur_ip:/root/temp/test/
		
		expect {
			"*yes/no*" {
          send "yes\n"
					exp_continue                
        }
			"*assword:" {
   				send "$cur_pwd\n"
					#exp_continue   		
   			}   			
		}
		
		#interact
		
		expect eof
		EOF
		
		
		mycount=$(($mycount+1))
	done


	
echo "脚本执行完毕"	
