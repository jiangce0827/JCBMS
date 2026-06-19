# jcbms AI Agent 开发指南

> AI Agent 在此项目中进行二次开发时的操作规范

## 项目概述

**JCBMS快速开发平台** — 面向后台管理系统的快速开发基座，提供权限控制、系统管理、监控运维、任务调度和代码生成等基础能力。

### 技术栈

| 层级 | 技术 | 版本 |
|------|------|------|
| 前端框架 | Vue 3 + TypeScript | 3.5.26 |
| UI 组件库 | Element Plus | 2.13.1 |
| 构建工具 | Vite | 6.4.1 |
| 状态管理 | Pinia | 3.0.4 |
| 后端框架 | Spring Boot | 3.5.11 |
| 持久层 | MyBatis-Plus | 3.5.7 |
| Java 版本 | JDK | 17 |

### 项目结构

```
jcbms/
├── jcbms-web/          # 前端项目
│   ├── src/
│   │   ├── api/                # API 接口
│   │   ├── assets/styles/      # 样式文件
│   │   ├── components/         # 公共组件
│   │   ├── layout/             # 布局组件
│   │   ├── store/              # 状态管理
│   │   ├── types/              # 类型定义
│   │   ├── utils/              # 工具函数
│   │   └── views/              # 页面视图
│   └── package.json
│
└── jcbms-server/       # 后端项目
    ├── jcbms-admin/          # 启动模块
    ├── jcbms-common/         # 公共模块
    ├── jcbms-framework/      # 框架核心
    ├── jcbms-generator/      # 代码生成器
    ├── jcbms-quartz/         # 定时任务
    └── jcbms-system/         # 系统管理
```

---

## 操作规范

### 1. 修改前必读

- **先读后改**：任何文件修改前必须先 Read 原文件
- **最小修改**：只改任务要求的部分，不做无关重构
- **理解上下文**：了解修改对其他模块的影响
- **中文注释**：生成或修改代码、SQL、配置、脚本等内容时，必须为关键业务规则、复杂逻辑、重要参数和非显而易见的实现添加必要的中文注释说明；避免对简单直观代码重复注释

### 2. 前端开发规范

#### 文件操作

| 操作 | 工具 | 说明 |
|------|------|------|
| 读取文件 | Read | 修改前必须先读取 |
| 编辑文件 | Edit | 优先使用 Edit 而非 Write |
| 新建文件 | Write | 仅在必要时创建新文件 |
| 搜索文件 | Glob | 按文件名模式搜索 |
| 搜索内容 | Grep | 按内容搜索 |

#### Vue 组件

```vue
<template>
  <!-- 模板内容 -->
</template>

<script setup lang="ts" name="ComponentName">
// 组件逻辑
</script>

<style scoped lang="scss">
/* 样式 */
</style>
```

**必须遵守：**
- 使用 `<script setup lang="ts">` 语法
- 指定 `name` 属性
- 样式使用 `scoped`
- 文件不超过 300 行

#### 样式规范（重要）

**禁止硬编码颜色，必须使用 CSS 变量：**

```scss
// 文字颜色
color: var(--el-text-color-primary);    // 主要文字
color: var(--el-text-color-regular);    // 常规文字
color: var(--el-text-color-secondary);  // 次要文字

// 背景颜色
background: var(--el-bg-color);          // 页面背景
background: var(--el-bg-color-overlay);  // 卡片/弹窗背景

// 边框颜色
border-color: var(--el-border-color);
border-color: var(--el-border-color-light);

// 主题色
color: var(--el-color-primary);
background: var(--el-color-primary-light-9);
```

**样式文件位置：**
- `src/assets/styles/variables.module.scss` — 变量定义
- `src/assets/styles/sidebar.scss` — 侧边栏
- `src/assets/styles/element-ui.scss` — Element Plus 覆盖
- `src/assets/styles/jcbms.scss` — 自定义样式

#### API 接口

```typescript
// api/system/user.ts
import request from '@/utils/request'

export function listUser(query: UserQuery) {
  return request({
    url: '/system/user/list',
    method: 'get',
    params: query
  })
}
```

**命名规范：**
- `listXxx` — 列表查询
- `getXxx` — 详情查询
- `addXxx` — 新增
- `updateXxx` — 修改
- `delXxx` — 删除

#### 类型定义

```typescript
// types/api/system/user.ts
export interface UserQuery {
  username?: string
  pageNum?: number
  pageSize?: number
}

export interface UserInfo {
  id: number
  username: string
}
```

#### 状态管理

```typescript
// store/modules/user.ts
import { defineStore } from 'pinia'

export const useUserStore = defineStore('user', () => {
  const token = ref<string>('')

  async function login(form: LoginForm) {
    // 登录逻辑
  }

  return { token, login }
})
```

---

### 3. 后端开发规范

#### 包结构

```
com.jiangce.jcbms
├── common          # 公共模块
├── framework       # 框架核心
├── system          # 系统管理
├── generator       # 代码生成器
└── quartz          # 定时任务
```

#### 注释规范

- 后端新增或修改的 Controller、Service、Mapper 等方法必须添加方法级中文 JavaDoc 注释，说明方法用途、关键参数和返回值
- 实体类字段必须添加中文字段注释，说明字段业务含义；数据库字段、校验注解和填充策略等非显而易见配置应补充说明
- 注释应解释业务意图和约束，避免对 getter/setter、简单赋值等直观逻辑重复注释

#### 分层规范

**Controller：**
```java
@RestController
@RequestMapping("/system/user")
public class SysUserController {

    @Autowired
    private ISysUserService userService;

    @GetMapping("/list")
    public TableDataInfo list(SysUser user) {
        startPage();
        List<SysUser> list = userService.selectUserList(user);
        return getDataTable(list);
    }
}
```

**Service：**
```java
public interface ISysUserService extends IService<SysUser> {
    List<SysUser> selectUserList(SysUser user);
}

@Service
public class SysUserServiceImpl extends ServiceImpl<SysUserMapper, SysUser>
        implements ISysUserService {

    @Override
    public List<SysUser> selectUserList(SysUser user) {
        return baseMapper.selectUserList(user);
    }
}
```

**Mapper：**
```java
@Mapper
public interface SysUserMapper extends BaseMapper<SysUser> {
    List<SysUser> selectUserList(SysUser user);
}
```

#### MyBatis-Plus 使用

**简单 CRUD — 使用内置方法：**
```java
getById(id)           // 查询单个
list(queryWrapper)    // 查询列表
save(entity)          // 新增
updateById(entity)    // 修改
removeById(id)        // 删除
```

**复杂查询 — 保留 XML：**
```xml
<select id="selectUserList" resultType="SysUser">
    SELECT * FROM sys_user
    <where>
        <if test="username != null">
            AND username LIKE CONCAT('%', #{username}, '%')
        </if>
    </where>
</select>
```

#### 实体类

```java
@Data
@TableName("sys_user")
public class SysUser extends BaseEntity {

    /** 用户ID */
    @TableId(type = IdType.AUTO)
    private Long userId;

    /** 用户名 */
    @NotBlank(message = "用户名不能为空")
    private String username;

    /** 创建时间，由 MyBatis-Plus 新增时自动填充 */
    @TableField(fill = FieldFill.INSERT)
    private Date createTime;
}
```

---

### 4. 数据库规范

#### 表结构

```sql
CREATE TABLE biz_order (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
    order_no VARCHAR(64) NOT NULL COMMENT '订单号',
    user_id BIGINT NOT NULL COMMENT '用户ID',
    amount DECIMAL(10,2) DEFAULT 0 COMMENT '金额',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time DATETIME DEFAULT NULL COMMENT '创建时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME DEFAULT NULL COMMENT '更新时间'
) COMMENT '订单表';
```

**必备字段：** `id`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`

#### SQL 脚本管理

数据库变更必须同步更新 SQL 脚本，添加日期注释：

```sql
-- 2026-05-17 新增订单表
CREATE TABLE biz_order (...);

-- 2026-05-17 给订单表新增状态字段
ALTER TABLE biz_order ADD COLUMN status INT DEFAULT 0 COMMENT '订单状态';
```

#### 菜单配置

新增业务模块后，必须在 `sys_menu` 表中配置菜单，否则用户无法访问。

**菜单类型：**
- `M` — 目录（可包含子菜单）
- `C` — 菜单（对应页面）
- `F` — 按钮（页面内操作权限）

**sys_menu 核心字段：**

| 字段 | 说明 | 示例值 |
|------|------|--------|
| `menu_name` | 菜单名称 | 订单管理 |
| `parent_id` | 父菜单ID | 0（顶级） |
| `order_num` | 显示顺序 | 10 |
| `path` | 路由地址 | order |
| `component` | 组件路径 | system/order/index |
| `menu_type` | 类型 | M / C / F |
| `perms` | 权限字符串 | system:order:list |
| `icon` | 菜单图标 | shopping |

**配置方式：**

1. **通过后台界面**（推荐）：系统管理 → 菜单管理 → 新增
2. **通过 SQL 脚本**：

```sql
-- 新增订单管理目录
INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, menu_type, perms, icon, visible, status)
VALUES ('订单管理', 0, 10, 'order', NULL, 'M', '', 'shopping', '0', '0');

-- 新增订单列表菜单（假设父目录 menu_id 为 1000）
INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, menu_type, perms, icon, visible, status)
VALUES ('订单列表', 1000, 1, 'list', 'system/order/index', 'C', 'system:order:list', 'list', '0', '0');
```

**权限关联：** 添加菜单后，需在 `sys_role_menu` 表中关联角色，用户才能看到并访问该菜单。

---

### 5. Git 提交规范

#### 格式

```
<type>(<scope>): <subject>
```

#### Type 类型

| type | 说明 | 示例 |
|------|------|------|
| feat | 新功能 | `feat(order): 新增订单管理模块` |
| fix | 修复 Bug | `fix(login): 修复登录超时问题` |
| refactor | 重构 | `refactor(user): 优化用户查询逻辑` |
| style | 样式调整 | `style(header): 调整导航栏高度` |
| docs | 文档更新 | `docs: 更新 README` |
| test | 测试 | `test(user): 新增用户服务单元测试` |
| chore | 构建/依赖 | `chore: 升级 Element Plus 版本` |
| perf | 性能优化 | `perf(query): 优化列表查询性能` |

#### Scope 范围

`user` `role` `menu` `system` `monitor` `tool` `login` `layout`

---

### 6. 安全规范

**禁止事项：**
- 硬编码密码、密钥、Token
- 提交 `.env` 文件
- 日志中记录敏感信息

**必须遵守：**
- SQL 使用参数化查询或 MyBatis-Plus 条件构造器
- 用户输入必须校验
- 敏感接口添加权限注解 `@PreAuthorize`

---

### 7. 常用命令

```bash
# 前端
cd jcbms-web
npm install          # 安装依赖
npm run dev          # 启动开发服务器
npm run build:prod   # 生产构建

# 后端
cd jcbms-server
mvn clean package -Dmaven.test.skip=true  # 打包
```

---

**最后更新：2026-05-17**
