# 阶段一：从官方镜像直接提取 sing-box 核心
FROM ghcr.io/sagernet/sing-box:latest AS singbox-builder

# 阶段二：从官方镜像直接提取 cloudflared 核心
FROM cloudflare/cloudflared:latest AS cloudflared-builder

# 阶段三：构建最终运行环境 (使用具体的 bookworm-slim 标签)
FROM debian:bookworm-slim

# 安装运行环境必备工具 (包含 envsubst)
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates tzdata gettext-base \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 从前面的官方镜像中提取并植入核心程序
COPY --from=singbox-builder /usr/local/bin/sing-box /usr/local/bin/sing-box
COPY --from=cloudflared-builder /usr/local/bin/cloudflared /usr/local/bin/cloudflared

# 赋予执行权限
RUN chmod +x /usr/local/bin/sing-box /usr/local/bin/cloudflared

# 复制我们在仓库写的配置文件和启动脚本
COPY config.template.json /etc/sing-box/config.template.json
COPY start.sh /start.sh

# 赋予脚本执行权限
RUN chmod +x /start.sh

# 暴露端口给健康探针，并设定启动命令
EXPOSE 3000
CMD ["/start.sh"]
