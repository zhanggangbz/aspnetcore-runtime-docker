FROM alpine:3.12

COPY / /

RUN chmod -R 777 /dotnet-install.sh 

RUN dotnet_version=3.1.10 \
    && wget -O dotnet.tar.gz https://download.visualstudio.microsoft.com/download/pr/3b24bc9a-17a6-40ee-83b0-039dea573293/404d2bce770f08de01c50246a47241c0/dotnet-runtime-3.1.10-linux-musl-x64.tar.gz \
    && dotnet_sha512='ee54d74e2a43f4d8ace9b1c76c215806d7580d52523b80cf4373c132e2a3e746b6561756211177bc1bdbc92344ee30e928ac5827d82bf27384972e96c72069f8' \
    && echo "$dotnet_sha512  dotnet.tar.gz" | sha512sum -c - \
    && mkdir -p /usr/share/dotnet \
    && tar -C /usr/share/dotnet -oxzf dotnet.tar.gz \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet \
    && rm dotnet.tar.gz

RUN aspnetcore_version=3.1.10 \
    && wget -O aspnetcore.tar.gz https://download.visualstudio.microsoft.com/download/pr/43727db2-e279-42cc-b733-f44edfe0b203/3ec40e0dc73278ad0c33c4283026103a/aspnetcore-runtime-3.1.10-linux-musl-x64.tar.gz \
    && aspnetcore_sha512='1a596c6f413c1f37ec6d3f0be74a19a9614d2321b5ab75290d5722ae824206dedf05e8773deac17330c4e9eff97caa56f5e59f5a6fd5d3543d3b8b4f67bbc8b3' \
    && echo "$aspnetcore_sha512  aspnetcore.tar.gz" | sha512sum -c - \
    && tar -ozxf aspnetcore.tar.gz -C /usr/share/dotnet ./shared/Microsoft.AspNetCore.App \
    && rm aspnetcore.tar.gz	
    
# RUN /dotnet-install.sh --runtime dotnet && /dotnet-install.sh --runtime aspnetcore

# 设置默认时区
ENV TZ=Asia/Shanghai

RUN apk add libgdiplus --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted

WORKDIR /app
EXPOSE 80
EXPOSE 443
