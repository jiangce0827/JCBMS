# JCBMS 快速开发平台

JCBMS 是一套前后端分离的后台管理系统快速开发平台，提供用户、角色、菜单、权限、参数配置、日志审计、系统监控、任务调度和代码生成等基础能力，适合快速搭建业务后台、内部管理工具和数据维护系统。

## 功能能力

- 系统管理：用户管理、角色管理、菜单管理、部门管理、岗位管理、字典管理和参数配置。
- 权限控制：登录认证、菜单权限、按钮权限、数据权限和在线用户管理。
- 运维监控：操作日志、登录日志、服务监控、缓存监控和访问控制。
- 任务调度：定时任务配置、执行日志和任务状态管理。
- 开发工具：代码生成、接口文档和常用后台页面结构。

## 技术栈

| 端 | 技术 |
|---|------|
| 前端 | Vue 3 + TypeScript + Element Plus + Vite |
| 后端 | Spring Boot 3.5 + MyBatis-Plus 3.5 + Druid |
| 数据库 | MySQL 8 + Redis |

## 项目结构

```
jcbms/
├── jcbms-web/          # 前端项目
│   ├── src/                    # 源码
│   ├── package.json            # 依赖配置
│   └── vite.config.ts          # Vite 配置
├── jcbms-server/       # 后端项目
│   ├── jcbms-admin/          # 启动模块（主入口）
│   ├── jcbms-common/         # 公共模块（工具类、常量）
│   ├── jcbms-framework/      # 框架模块（安全、配置）
│   ├── jcbms-system/         # 系统模块（用户、角色、菜单）
│   ├── jcbms-quartz/         # 定时任务模块
│   ├── jcbms-generator/      # 代码生成模块
│   ├── sql/                    # 数据库脚本
│   └── pom.xml                 # Maven 配置
├── AGENTS.md                   # AI Agent 开发规范
└── CLAUDE.md                   # Claude Code 规范入口
```

## 环境要求

- **JDK**: 17+
- **Maven**: 3.8+
- **Node.js**: 18+
- **MySQL**: 8.0+
- **Redis**: 6.0+

## 快速启动

### 1. 数据库初始化

```bash
# 创建数据库
mysql -u root -p -e "CREATE DATABASE jcbms DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;"

# 导入数据
mysql -u root -p jcbms < jcbms-server/sql/jcbms_20260417.sql
```

### 2. 启动 Redis

```bash
# Windows
redis-server

# Linux/Mac
sudo systemctl start redis
```

### 3. 配置后端环境

后端只保留两个 Spring 配置文件：

- `application.yml`：主配置结构，默认只激活 `druid` profile。
- `application-druid.yml`：Druid 数据源和连接池结构。

环境差异通过进程环境变量提供。仓库提交 `jcbms-server/.env.example` 作为模板，真实 `jcbms-server/.env` 不提交到 Git。

```bash
cd jcbms-server
copy .env.example .env
```

修改 `.env` 中的数据库、Redis、JWT 密钥、上传目录和 Swagger 开关等值。生产环境必须使用独立数据库账号、强密码和随机 JWT 密钥，不要复用本地开发默认值。

### 4. 启动后端

```bash
cd jcbms-server

# 编译打包
mvn clean package -Dmaven.test.skip=true

# run.bat 会读取 jcbms-server/.env 并启动 jcbms-admin.jar
bin\run.bat
```

后端启动后访问：`http://localhost:8080`

也可以使用 Maven 启动：

```bash
cd jcbms-server/jcbms-admin
mvn spring-boot:run
```

`mvn spring-boot:run` 不会自动读取 `jcbms-server/.env`。使用这种方式时，需要先在终端加载环境变量，或在 IDE 中手动配置环境变量 / 使用支持 `.env` 的插件。

### 5. 启动前端

```bash
cd jcbms-web

# 安装依赖
npm install

# 启动开发服务器
npm run dev
```

前端启动后访问：`http://localhost:80`（默认端口，见 vite.config.ts）

## 初始化账号

初始化 SQL 包含本地演示账号。首次登录后必须立即修改管理员密码，并按部署环境调整 `sys_config` 中的账号初始密码策略。

## 常用命令

```bash
# 后端
mvn clean package -Dmaven.test.skip=true    # 编译打包
bin\run.bat                              # 读取 .env 并启动 jar
mvn spring-boot:run                      # Maven 启动，不自动读取 .env

# 前端
npm run dev                      # 开发环境启动
npm run build:prod               # 生产环境打包
npm run preview                  # 预览打包结果
```

## 数据库配置

数据库配置结构位于 `jcbms-server/jcbms-admin/src/main/resources/application-druid.yml`，具体环境值来自进程环境变量，`bin/run.bat` 会从 `jcbms-server/.env` 注入：

```yaml
master:
  url: ${JCBMS_DB_URL:jdbc:mysql://localhost:3306/jcbms?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8}
  username: ${JCBMS_DB_USERNAME:root}
  password: ${JCBMS_DB_PASSWORD:}
```

`.env.example` 列出了可配置项和本地默认值，部署时复制为 `.env` 后按目标环境修改。
