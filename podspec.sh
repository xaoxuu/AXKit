#!/bin/bash https://xaoxuu.com

# 如果目录下有一个podspec文件，直接询问版本号，然后打包验证、发布
# 如果目录下有多个podspec文件，遍历每一个podspec文件，询问版本号，然后打包验证、发布

function push(){
	# 输入版本号
	while :
	do
		read -p "请输入${FILENAME}版本号: " VERSION
		if [ "$VERSION" == "" ];then
		    continue
		else
			break
			VERSION=$1
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




