#!/bin/bash
# 如果目录下有一个podspec文件，直接询问版本号，然后打包验证、发布
# 如果目录下有多个podspec文件，遍历每一个podspec文件，询问版本号，然后打包验证、发布

const_lib=https://raw.githubusercontent.com/xaoxuu/lib/v1
const_repo='podspec.sh'
const_client='podspec.sh'

CONST_VERSION='1.2'
PARAM1=$1
PARAM2=$2


# 在新的脚本中，输出更新信息，并提交文件改动
function cmd_updated(){
	echo -e "> \\033[0;32m更新成功！\\033[0;39m    ${PARAM2} -> ${CONST_VERSION}"
	PARAM1=""
	PARAM2=""
	echo '> 正在提交文件改动到git...'
	git add podspec.sh && git commit -m "update podspec.sh"
	git push origin && echo -e "> \\033[0;32m提交成功！\\033[0;39m"
}

# 更新失败后，撤销对podspec.sh的修改
function cmd_update_f(){
	PARAM1=""
	PARAM2=""
	echo -e "> \\033[0;31m更新失败！\\033[0;39m"
	git checkout podspec.sh
}

# 更新成功之后，重启脚本并把当前的版本传递过去
function cmd_update_s(){
	sleep 1 && . podspec.sh '_3qwjk09went4ke' $CONST_VERSION
}

# 更新脚本
function cmd_update(){
	case $PARAM2 in
		'') PARAM2='master' ;;
		*) ;;
	esac
	curl -s ${const_lib}/download.sh | sh -s ${const_repo} ${PARAM2} ${const_client} ./ && cmd_update_s
}


function cmd_push(){
	# 输入版本号
	while :
	do
		if [ "$PARAM1" == "" ];then
			read -p "请输入${FILENAME}版本号: " PARAM1
		else
			break
		fi
	done

	# 更新podspec
	sed -i "" "s/s.version\([ ]\{1,\}\)=\([ ]\{1,\}\)\([\'|\"]\)\([^\"]\{1,\}\([\'|\"]\)\)/s.version = \"${PARAM1}\"/g" ${FILENAME}

	# 打包验证
	git add --all
	git commit -am "update podspec"
	git push origin
	git tag ${PARAM1}
	git push --tags
	pod lib lint

	# 发布
	read -p "现在要发布${FILENAME}吗？ y/n: " pushnow
	if [ "$pushnow" == "y" ];then
		echo "> pod trunk push ${FILENAME}"
		pod trunk push ${FILENAME}

		# 更新脚本
		cmd_update
	fi


}

function cmd_checkfile(){
	count=$(ls *.podspec | wc -l)

	# 遍历每一个podspec文件
	for FILENAME in *.podspec
	do
		if [ $count -gt 1 ]; then
			read -p "检测到了${FILENAME}，是否是您要发布的podspec？ y/n: " yn
			if [ "$yn" == "y" ];then
				cmd_push
			fi
		elif [ $count == 1 ]; then
				cmd_push
		else
				echo -e "> \\033[0;31m没有找到podspec。\\033[0;39m"
		fi
	done
}

case $PARAM1 in
	'_3qwjk09went4ke') cmd_updated ;;
	'update'|'--update') cmd_update ;;
	'docs'|'help') open https://xaoxuu.com/wiki/podspec.sh/ ;;
	*) cmd_checkfile ;;
esac
