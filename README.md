Docker container: CentOS 7 + Java 8 + Tomcat 8

## Build the image

```sh
git clone https://github.com/fabianows/centos-tomcat.git
cd centos-tomcat
docker build -t fabianows/centos-tomcat .
```

## How to use
Put your war under the `/usr/java/tomcat/webapps` directory and run the following command.

```sh
docker run -v /usr/java/tomcat/webapps:/usr/java/tomcat/webapps -v /usr/java/tomcat/logs:/usr/java/tomcat/logs -p 8080:8080 -i -t --name centos-tomcat fabianows/centos-tomcat
```

Once you run it, you can start the container with `docker start centos-tomcat` in next time and log file will be under the `/usr/java/tomcat/logs` directory.

Also, if you got some error, you can remove the container with `docker rm centos-tomcat`. Your current container list will be show with `docker ps -a`.

For Mac user, you must share the directory `/usr/java/tomcat/webapps` and `/usr/java/tomcat/logs` on Docker > Preferences > File Sharing.

## Versions
If you got error while build the docker image, please check the latest version of Java and Tomcat.

|Software|Version|Note|
|:-----------|:------------|:------------|
|CentOS|7||
|Java|8u131|[Java Release Note](http://www.oracle.com/technetwork/java/javase/8u-relnotes-2225394.html)|
|Apache Tomcat|8.5.15|[Tomcat Download Page](http://tomcat.apache.org/download-80.cgi)|

[Docker Official Image for Tomcat](https://github.com/docker-library/tomcat) is also available.
