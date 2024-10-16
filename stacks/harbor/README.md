# Harbor

## 安装启动
```bash
mkdir -p ~/_docker-stacks/harbor-root;
cd ~/_docker-stacks/harbor-root;

wget https://github.com/goharbor/harbor/releases/download/v2.11.1/harbor-online-installer-v2.11.1.tgz
tar xvf harbor-online-installer-v2.11.1.tgz
cd harbor
cp harbor.yml.tmpl harbor.yml
./install.sh
# ./install.sh --with-clair --with-chartmuseum
# ./install.sh --with-notary --with-clair --with-chartmuseum 
```

## 要改的配置
```yaml
hostname: harbor.oo1.dev
http:
  port: 8880
# https: # 注释掉
external_url: https://harbor.oo1.dev
harbor_admin_password: 
database:
  password: 
data_volume: /harbor-data
```