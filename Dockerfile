FROM alpine:3.12

COPY / /

RUN /dotnet-install.sh --runtime dotnet && /dotnet-install.sh --runtime aspnetcore

# 设置默认时区
ENV TZ=Asia/Shanghai

RUN apt-get update && apt-get install -y apt-utils libgdiplus libc6-dev

WORKDIR /app
EXPOSE 80
EXPOSE 443
