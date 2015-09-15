# Ghost

还在用 WordPress 做你的博客站点，你就 OUT 了！速度切换到 Ghost，用 Markdown 写出最有逼格的技术博客吧。这个出自于 WordPress 前 UX 部门开发者/设计师 John O'Nolan 之手的博客系统，自 2012 年诞生之日起就被冠于类似 "WordPress Killer"，the "new direction of blogging"，"the first exciting thing to happen to blogging in years" 之类的头衔。

关于 WordPress 和 Ghost 的比较大家可以参见 [WordPress VS Ghost](http://www.elegantthemes.com/blog/resources/wordpress-vs-ghost)（英文）。

如果你动心了的话，马上用 1 分钟在 DaoCloud 上部署一个属于你的高逼格 Ghost 博客吧！

## 版本

该镜像与官方镜像同步。

## 说明

### 创建博客需要的 MySQL 数据库

![select "Services"](http://7xltjx.com1.z0.glb.clouddn.com/1.jpeg)

![select "MySQL Service"](http://7xltjx.com1.z0.glb.clouddn.com/2.jpeg)

![create "MySQL Service" instance](http://7xltjx.com1.z0.glb.clouddn.com/3.jpeg)

![specify instance's name](http://7xltjx.com1.z0.glb.clouddn.com/4.jpeg)

### 从 Ghost 镜像中创建容器

![select "Images"](http://7xltjx.com1.z0.glb.clouddn.com/5.jpeg)

![select "Ghost Image"](http://7xltjx.com1.z0.glb.clouddn.com/6.jpeg)

![deploy the latest version](http://7xltjx.com1.z0.glb.clouddn.com/7.jpeg)

![select 256M container](http://7xltjx.com1.z0.glb.clouddn.com/8.jpeg)

### 绑定 MySQL 服务

> 注意：需要设置服务别名为 `MYSQL`。

![configure "Env & Services"](http://7xltjx.com1.z0.glb.clouddn.com/9.jpeg)

### 启动容器并访问 Ghost

![run container](http://7xltjx.com1.z0.glb.clouddn.com/10.jpeg)

![access your Ghost](http://7xltjx.com1.z0.glb.clouddn.com/11.jpeg)

### 配置 Blog

您需要将环境变量 `GHOST_ROOT_URL` 的值设置为您博客的完整 URL，这样 Ghost 就能正确配置其内部的链接，例如 [http://your-ghost.daoapp.io/](http://your-ghost.daoapp.io/)。

第一次启动时，您可以通过 [http://your-ghost.daoapp.io/admin](http://your-ghost.daoapp.io/admin) 进入管理界面。

## 注意

由于上传的文件如图片等会保存在容器中，容器重新部署可能会导致上传文件的丢失，因此不建议您用 Ghost 存储重要文件。