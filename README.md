# Ghost Blog

还在用WordPress做你的博客站点，你就OUT了！速度切换到Ghost，用MarkDown写出最有逼格的技术博客吧。 这个出自于WordPress前UX部门开发者/设计师John O’Nolan之手的博客系统，自2012年诞生之日起就被冠于类似“WordPress Killer”, the “new direction of blogging”, “the first exciting thing to happen to blogging in years”之类的头衔。 

关于WordPress和Ghost的比较大家可以参见[WordPress VS Ghost(英文)](http://www.elegantthemes.com/blog/resources/wordpress-vs-ghost)

如果你动心了的话，马上用1分钟在DaoCloud上部署一个属于你的高逼格Ghost博客吧！

## 版本
0.6.0


## 创建博客需要的Mysql数据库

![select "Services"](https://dn-daoweb-resource.qbox.me/images/ghost/1-1.png)

![select "MySQL Service"](https://dn-daoweb-resource.qbox.me/images/ghost/1-2.png)

![create "MySQL Service" instance](https://dn-daoweb-resource.qbox.me/images/ghost/1-3.png)

## 从Ghost镜像中创建容器

![select "Images"](https://dn-daoweb-resource.qbox.me/images/ghost/2-1.png)

![select "Ghost Image"](https://dn-daoweb-resource.qbox.me/images/ghost/2-2.png)

![Create Container from image](https://dn-daoweb-resource.qbox.me/images/ghost/2-3.png)

## 绑定MySQL服务，并设置服务别名为'**mysql**'

![configure "Env & Services"](https://dn-daoweb-resource.qbox.me/images/ghost/3-1.png)

![bind service and set alias](https://dn-daoweb-resource.qbox.me/images/ghost/3-2.png)

## 启动容器并访问Ghost

![run container](https://dn-daoweb-resource.qbox.me/images/ghost/4-1.png)

![access Ghost](https://dn-daoweb-resource.qbox.me/images/ghost/4-2.png)

## 配置Blog

您可以设置容器环境变量 **GHOST\_ROOT\_URL** 的值为您容器的具体URL， 例如 http://your－ghost.daoapp.io。

第一次启动后，您可以访问 http://your-ghost.daoapp.io/admin 进入管理界面。
