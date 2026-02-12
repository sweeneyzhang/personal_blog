# 个人博客

基于 Hugo + GitHub Pages 搭建的个人博客。

## 本地开发

```bash
# 安装 Hugo (macOS)
brew install hugo

# 启动本地服务器
hugo server --buildDrafts

# 访问博客
# http://localhost:1313/
```

## 创建新文章

```bash
hugo new content posts/your-post-title.md
```

## 部署到 GitHub Pages

### 方法一：手动部署

```bash
# 构建静态站点
hugo

# 将 public 目录部署到 GitHub Pages 的 gh-pages 分支或单独仓库
```

### 方法二：使用部署脚本

```bash
chmod +x deploy.sh
./deploy.sh
```

### 方法三：使用 GitHub Actions (推荐)

在 `.github/workflows/hugo.yml` 中配置自动部署：

```yaml
name: Deploy Hugo site to Pages

on:
  push:
    branches: ["main"]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: false

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
        with:
          submodules: recursive
          fetch-depth: 0

      - name: Setup Hugo
        uses: peaceiris/actions-hugo@v3
        with:
          hugo-version: "latest"
          extended: true

      - name: Build
        run: hugo --minify

      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: ./public

  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

## GitHub Pages 设置

1. 在 GitHub 创建仓库 `username.github.io`
2. 或创建仓库后在 Settings > Pages 中设置 Source
3. 博客将部署到：`https://junsheng.github.io/personal_blog/`

## 自定义配置

编辑 `hugo.toml` 文件来自定义博客配置：

```toml
baseURL = 'https://junsheng.github.io/personal_blog/'
languageCode = 'zh-CN'
title = '个人博客'
theme = 'ananke'
```

## 主题

当前使用 [Ananke](https://github.com/theNewDynamic/gohugo-theme-ananke) 主题。

更多主题：https://themes.gohugo.io/

## 项目结构

```
.
├── archetypes/    # 内容模板
├── assets/        # 资源文件
├── content/       # 博客内容
│   └── posts/     # 文章目录
├── data/          # 数据文件
├── layouts/       # 布局文件
├── static/        # 静态文件
├── themes/        # 主题
├── hugo.toml      # 配置文件
└── public/        # 构建输出（部署到 GitHub Pages）
```
