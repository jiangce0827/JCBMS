# JCBMS Server

JCBMS 后端项目，基于 Spring Boot 3、Spring Security、MyBatis-Plus、Druid、Quartz 和 Redis 构建。

## 开发环境

- JDK 17+
- Maven 3.8+
- MySQL 8+
- Redis 6+

## 模块说明

```text
jcbms-server/
├── jcbms-admin/        # 启动模块
├── jcbms-common/       # 公共能力
├── jcbms-framework/    # 框架配置、安全、拦截器
├── jcbms-system/       # 系统管理
├── jcbms-quartz/       # 定时任务
├── jcbms-generator/    # 代码生成
├── sql/                # 初始化脚本
└── pom.xml
```

Maven 坐标使用 `com.jiangce.jcbms`，模块 artifactId 统一使用 `jcbms-*`。

## 常用命令

```bash
mvn clean package "-Dmaven.test.skip=true"
```

PowerShell 中需要给 `-Dmaven.test.skip=true` 加引号，避免参数被解析成 Maven lifecycle。

## 数据库初始化

默认数据库名为 `jcbms`：

```bash
mysql -u root -p -e "CREATE DATABASE jcbms DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;"
mysql -u root -p jcbms < sql/jcbms_20260417.sql
```

默认连接配置位于 `jcbms-admin/src/main/resources/application-druid.yml`。

## 启动

构建完成后可运行：

```bash
java -jar jcbms-admin/target/jcbms-admin.jar
```

启动脚本位于 `bin/run.bat`。
