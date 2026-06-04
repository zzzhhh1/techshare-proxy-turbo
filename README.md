# 🚀 科技共享专属 - PaaS 平台双核节点部署架构 (sing-box + Argo)

本项目由 YouTube 频道 **[@科技共享](https://www.youtube.com/@kejigongxiang/)** 深度定制与开源。

专为内存及性能受限的免费云平台（如 DCDeploy、Koyeb、Hugging Face 等）设计，采用高级的 Docker 多阶段构建，在极简底座中同时运行 **sing-box（代理内核）** 与 **cloudflared（穿透内核）**。支持 `http2` 协议防封锁，纯净、轻量、稳定。

**[uuid生成器](https://99688988.xyz/uuid-generator/)**

**[海量优选域名](https://kjgx668.blogspot.com/2023/08/cloudflare-ip-cloudflare-cf.html)**

**[VLESS 智能节点裂变器](https://kjgx668.blogspot.com/2026/06/vless-body-font-family-segoe-ui-tahoma.html)**

---

## ⚠️ 部署前必读：如何正确 Fork 并自动构建镜像？

很多朋友 Fork 本仓库后，第一次构建 Docker 镜像会失败。这是因为 GitHub 默认未开启写入权限，**请务必按照以下步骤操作，否则无法成功部署！**

### 第一步：解锁 Actions 读写权限
1. 将本项目 **Fork** 到你自己的 GitHub 账号下。
2. 在你 Fork 后的仓库页面，点击顶部的 **`Settings` (设置)**。
3. 在左侧菜单栏找到并点击 **`Actions` -> `General`**。
4. 滚动到页面最底部的 **Workflow permissions** 区域。
5. 勾选 **`Read and write permissions`**。
6. 点击 **`Save` (保存)**。

### 第二步：触发自动构建 (GitHub Packages)
1. 回到仓库的 `Code` 页面，打开这个 `README.md` 文件。
2. 点击右上角的铅笔图标 ✏️ 随便修改一点内容（比如在末尾加个空格）。
3. 点击 **`Commit changes...`** 保存。
4. 点击顶部的 **`Actions`** 选项卡，你会看到一个黄色的圆圈正在转动。等待 1~2 分钟，变成绿色的 ✅ 即代表你的专属 Docker 镜像已经打包完成！

---

## ⚙️ PaaS 平台部署指南 (以 DCDeploy 为例)

当你的 GitHub 镜像构建完成后，去你的云平台进行部署。**请严格对照以下参数填写：**

### 1. 镜像地址 (Image)
**千万不要填错！必须改成你自己的路径：**
```text
ghcr.io/你的GitHub用户名/你的仓库名:latest

容器端口 (Port)
固定填写：3000

变量名 (Key),变量值示例 (Value),参数说明与获取方式
UUID = ad58bd8c-d279-48c4-aea2-06c5b63bxxxx,节点独立密码。这相当于你这台“服务器”的连接密码。请使用上方的 UUID 生成器生成一个标准的 36 位字符串填入。千万不要用示例里的 UUID！
ARGO_TOKEN = eyJhIjoiYTM...非常长的一串字母...xODk0In0=,Cloudflare 穿透密钥。你需要登录 Cloudflare Zero Trust，在 Tunnels 中新建一条隧道，选择 Cloudflared 部署方式，在官方给出的安装命令中，复制出那串极长的乱码 Token。

标准 URI 链接模板（请替换括号中的内容）：

Plaintext

vless://[填入你的UUID]@[填入你的CF域名]:443?encryption=none&security=tls&sni=[填入你的CF域名]&type=ws&host=[填入你的CF域名]&path=%2Fblog#DCDeploy-Argo%E8%8A%82%E7%82%B9

参数避坑提示：

域名：@ 后面、sni= 后面、host= 后面，这三个地方必须全部填写你绑定 Argo 隧道的那个 Cloudflare 域名。

路径转码：如果你的伪装路径是 /blog，在链接里必须转码成 %2Fblog（斜杠 / 替换为 %2F）。

🎁 终极福利：一键生成批量优选节点
如果你觉得手动替换参数太麻烦，或者想在基础节点上叠加 Cloudflare 优选 IP 来提升速度，我为你准备了专属自动化工具！

只需粘贴上面的基础节点链接，再随意粘贴一批优选 IP（无惧乱码，自动分行），工具就能一瞬间裂变出几十个属于你的极速优选节点！

👉 点击此处获取一键生成工具：科技共享专属博客
[复制链接前往] https://kjgx668.blogspot.com/2026/06/vless-body-font-family-segoe-ui-tahoma.html

## ⚖️ 许可协议与免责声明 (License & Disclaimer)

本项目包含的所有代码、脚本及教程内容，均由 **YouTube@科技共享** 原创编写或基于开源项目二次开发整理，并在 **[CC BY-NC-SA 4.0 (知识共享署名-非商业性使用-相同方式共享 4.0 国际许可协议)](https://creativecommons.org/licenses/by-nc-sa/4.0/deed.zh-hans)** 下提供。

### 你可以自由地：
* **共享** — 在任何媒介以任何形式复制、发行本作品。
* **演绎** — 修改、转换或以本作品为基础进行创作。

### 惟须遵守下列条件：
* **署名 (BY)** — 你必须给出适当的署名（标注来源为 YouTube 频道 @科技共享 及 GitHub 仓库地址），提供指向本许可协议的链接，同时标明是否对原始代码作了修改。
* **非商业性使用 (NC) 【严格禁止】** — **你不得将本项目的代码、搭建方案及衍生教程用于任何商业目的**。包括但不限于：打包售卖代理节点、将其作为付费服务的底层架构、用于任何形式的收费教学或引流获利。
* **相同方式共享 (SA)** — 如果你修改、转换或以本项目为基础进行了二次创作，你必须基于与本项目完全相同的许可协议（CC BY-NC-SA 4.0）分发你的贡献。

### 免责声明：
本项目仅供网络技术学习、研究与交流使用，旨在帮助开发者了解 Docker 容器化部署与网络穿透技术原理。
请在遵守所在国家和地区相关法律法规的前提下使用本项目。因使用者自身行为导致的任何违法违规后果，由使用者自行承担，本项目作者概不负责。
