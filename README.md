# Ghost

还在用 WordPress 做你的博客站点，你就 OUT 了！速度切换到 Ghost，用 Markdown 写出最有逼格的技术博客吧。这个出自于 WordPress 前 UX 部门开发者/设计师 John O'Nolan 之手的博客系统，自 2012 年诞生之日起就被冠于类似 "WordPress Killer"，the "new direction of blogging"，"the first exciting thing to happen to blogging in years" 之类的头衔。

关于 WordPress 和 Ghost 的比较大家可以参见 [WordPress VS Ghost](http://www.elegantthemes.com/blog/resources/wordpress-vs-ghost)（英文）。

如果你动心了的话，马上用 1 分钟在 DaoCloud 上部署一个属于你的高逼格 Ghost 博客吧！

## 版本

该镜像与官方镜像同步。

## 说明

### 部署于 DaoCloud 平台

#### 创建博客需要的 MySQL 数据库

![select "Services"](http://7xltjx.com1.z0.glb.clouddn.com/1.jpeg)

![select "MySQL Service"](http://7xltjx.com1.z0.glb.clouddn.com/2.jpeg)

![create "MySQL Service" instance](http://7xltjx.com1.z0.glb.clouddn.com/3.jpeg)

![specify instance's name](http://7xltjx.com1.z0.glb.clouddn.com/4.jpeg)

#### 从 Ghost 镜像中创建容器

![select "Images"](http://7xltjx.com1.z0.glb.clouddn.com/5.jpeg)

![select "Ghost Image"](http://7xltjx.com1.z0.glb.clouddn.com/6.jpeg)

![deploy the latest version](http://7xltjx.com1.z0.glb.clouddn.com/7.jpeg)

![select 256M container](http://7xltjx.com1.z0.glb.clouddn.com/8.jpeg)

#### 绑定 MySQL 服务

> 注意：需要设置服务别名为 `MYSQL`。

![configure "Env & Services"](http://7xltjx.com1.z0.glb.clouddn.com/9.jpeg)

#### 启动容器并访问 Ghost

![run container](http://7xltjx.com1.z0.glb.clouddn.com/10.jpeg)

![access your Ghost](http://7xltjx.com1.z0.glb.clouddn.com/11.jpeg)

#### 配置 Ghost

您需要将环境变量 `GHOST_ROOT_URL` 的值设置为您博客的完整 URL，这样 Ghost 就能正确配置其内部的链接，例如 [http://your-ghost.daoapp.io](http://your-ghost.daoapp.io)。

第一次启动时，您可以通过 [http://your-ghost.daoapp.io/admin](http://your-ghost.daoapp.io/admin) 进入管理界面。

---

### 使用外部的 MySQL 数据库

**当您使用外部的 MySQL 数据库时需要设置下列所有环境变量。**

您可以通过指定下列几个环境变量的值来使用外部的 MySQL 数据库：

- `GHOST_MYSQL_HOST` 数据库主机地址
- `GHOST_MYSQL_PORT` 数据库主机端口 (不填默认为3306)
- `GHOST_MYSQL_DATABASE` 数据库名
- `GHOST_MYSQL_USER` 数据库用户名
- `GHOST_MYSQL_PASSWORD` 数据库密码

可以参考以下例子：

```console
$ docker run -d -e MYSQL_ROOT_PASSWORD=example -e MYSQL_USER=ghost -e MYSQL_PASSWORD=ghost -e MYSQL_DATABASE=ghost -p 3306:3306 --name mymysql mysql    # 启动了一个 MySQL 实例并暴露端口 3306
$ docker run -d -e GHOST_MYSQL_HOST=<mysql_host_address> -e GHOST_MYSQL_PORT=3306 -e GHOST_MYSQL_USER=ghost -e GHOST_MYSQL_PASSWORD=ghost -e GHOST_MYSQL_DATABASE=ghost -p 2368:2368 dghost    # 通过环境变量指定要使用数据库的连接方式
```

---

### 使用 Stack 功能部署 Ghost 于自有主机

您可以使用 Stack 功能将 Ghost 快速部署在您的自有主机上，您可以参考下面的 `docker-compose.yml` 文件：

**这里使用 Volume 功能挂载宿主机上的目录至容器内来做持久化储存。**

```yaml
ghost: 
  image: daocloud.io/daocloud/dao-ghost:latest 
  links: 
    - db:mysql 
  ports: 
    - "2368" 
  volumes:
    - /<path-to-your-volume>:/data
  environment:
    - GHOST_ROOT_URL=http://<your-blog-url>
  restart: always 
db: 
  image: mysql 
  environment: 
    - MYSQL_ROOT_PASSWORD=example 
    - MYSQL_DATABASE=ghost
    - MYSQL_USER=ghost
    - MYSQL_PASSWORD=ghost_db_password
  restart: always
```

## 注意

由于上传的文件如图片等会保存在容器中，容器重新部署可能会导致上传文件的丢失，因此部署于 DaoCloud 平台时，强烈建议您使用 Volume 服务来帮助 Ghost 存储重要文件，当您部署于自有主机上时可以通过 Volume 功能挂载宿主机上的目录至容器来做持久化储存。

您可以将 Volume 挂载到 `/data` 目录以管理您上传的图片与主题资源。

您需要设置 `GHOST_ROOT_URL` 变量来让 Ghost 能正确配置其内部的链接。
