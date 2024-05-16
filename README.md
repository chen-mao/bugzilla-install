# Bugzilla-install
Install Bugzilla by docker

## bugzilla 镜像制作
step1: 制作 perl等一些包的基础镜像
```shell
$ docker build -t hub.xdxct.com/xdxct-docker/ubuntu:bionic-perl -f Dockerfile-base .
```

step2: 切换CPAN的镜像源
```shell
$ docker run -it hub.xdxct.com/xdxct-docker/ubuntu:bionic-perl bash

# 或不使用默认配置，手动确认各个配置选项
$ perl -MCPAN -e 'mkmyconfig'

# 列出当前的镜像设置
cpan[1]> o conf urllist

# 将本站镜像加入镜像列表首位
# 注：若已在列表中则可跳过本步直接退出，修改列表不会执行自动去重
cpan[2]> o conf urllist unshift http://mirrors.aliyun.com/CPAN/

# Perl 5.36 及以上用户需要关闭 pushy_https 以使用镜像站
cpan[5]> o conf pushy_https 0

# 保存修改后的配置至 MyConfig.pm
cpan[6]> o conf commit

# 退出 cpan shell
cpan[7]> quit
```

step3: 制作镜像
```shell
docker commit <container-id> [REPOSITORY[:TAG]]
```

### Docker setup
1. To build and start the service:
```shell
$ docker-compose up -d 
```

2. To stop the service:
```shell
$ docker-compose down 
```

3. To build again and start with a fresh container:
```shell
$ docker-compose up -d --build --force-recreate 
```

### Post installation steps
1. You would have to run the checkscript.pl script to verify the installation and dependencies. This script will also prompt you to set the login user credentials.
```shell
$ docker exec -it bugzilla_web ./checkscript.pl
```

2. Now, you should be able to access the Bugzilla at https://localhost:4080/bugzilla

### FAQ
Freqently ask questions

**How should bugzilla service be restart when the server machine restarts?**

Execute as shown below:
```shell
# Close the service
$ docker-compose down

# Restart bugzilla service
$ docker-compose up -d

# Enter the container
$ docker exec -it bugzilla_web bash

# Execute script
$ ./checkscript.pl
```
