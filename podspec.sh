#!/bin/bash https://xaoxuu.com

# 如果目录下有一个podspec文件，直接询问版本号，然后打包验证、发布
# 如果目录下有多个podspec文件，遍历每一个podspec文件，询问版本号，然后打包验证、发布

VERSION=$1

function push(){
	# 输入版本号
	while :
	do
		if [ "$VERSION" == "" ];then
			read -p "请输入${FILENAME}版本号: " VERSION
		else
			break
		fi
	done

	# 更新podspec
	sed -i "" "s/s.version\([ ]\{1,\}\)=\([ ]\{1,\}\)\([\'|\"]\)\([^\"]\{1,\}\([\'|\"]\)\)/s.version = \"${VERSION}\"/g" ${FILENAME}
	
	# 打包验证
	git add --all
	git commit -am "update podspec" 
	git push origin
	git tag ${VERSION}
	git push --tags
	pod lib lint

	# 发布
	read -p "现在要发布${FILENAME}吗？ y/n: " pushnow
	if [ "$pushnow" == "y" ];then
		echo "> pod trunk push ${FILENAME}"
		pod trunk push ${FILENAME}
		
		# 更新脚本
		echo '> 正在更新脚本...'
		curl -O 'https://raw.githubusercontent.com/xaoxuu/podspec.sh/master/podspec.sh' -# && chmod 777 podspec.sh
		git add podspec.sh
		git commit -m "update podspec.sh" 
		git push origin
	fi


}


count=$(ls *.podspec | wc -l)

# 遍历每一个podspec文件
for FILENAME in *.podspec
do
	if [ $count -gt 1 ]; then
		read -p "检测到了${FILENAME}，是否是您要发布的podspec？ y/n: " yn
		if [ "$yn" == "y" ];then
			push
		fi
	elif [ $count == 1 ]; then
			push
	else
			echo "⚠️  没有找到podspec"
	fi
done




