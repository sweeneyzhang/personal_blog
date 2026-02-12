#!/bin/bash

# 删除旧的 public 目录
if [ -d "public" ]; then
  rm -rf public
fi

# 构建站点
hugo

# 进入 public 目录
cd public

# 初始化 git 仓库（如果不存在）
if [ ! -d ".git" ]; then
  git init
  git branch -M main
fi

# 添加所有文件
git add .

# 提交更改
git commit -m "Deploy to GitHub Pages"

# 推送到 GitHub
# 首次推送使用：
# git remote add origin https://github.com/junsheng/personal_blog.git
# git push -u origin main

# 后续推送使用：
# git push origin main

echo "部署完成！"
