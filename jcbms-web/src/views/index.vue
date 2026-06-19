<template>
  <div class="app-container platform-home">
    <section class="intro">
      <p class="eyebrow">JCBMS管理平台</p>
      <h1>覆盖权限、系统配置、监控运维和代码生成的一体化后台基座</h1>
      <p class="summary">
        JCBMS提供后台系统常用的用户体系、角色权限、菜单配置、日志审计、任务调度、服务监控和代码生成能力，
        帮助项目快速完成基础能力搭建，把更多时间留给实际业务开发。
      </p>
    </section>

    <section class="section">
      <h2>平台能力</h2>
      <p>
        平台内置组织、用户、角色、岗位、菜单、参数、字典和通知公告等系统管理能力，可直接支撑后台管理系统的基础配置。
      </p>
      <p>
        同时提供操作日志、登录日志、在线用户、缓存监控、服务监控、数据源监控和定时任务管理，便于日常运维、排查问题和追踪操作。
      </p>
    </section>

    <section class="section">
      <h2>功能模块</h2>
      <div class="stack-grid">
        <div v-for="item in stacks" :key="item.title" class="stack-item">
          <el-icon><component :is="item.icon" /></el-icon>
          <div>
            <h3>{{ item.title }}</h3>
            <p>{{ item.content }}</p>
          </div>
        </div>
      </div>
    </section>

    <section class="section">
      <h2>核心能力清单</h2>
      <ul class="change-list">
        <li v-for="item in changes" :key="item">{{ item }}</li>
      </ul>
    </section>

    <section class="section">
      <h2>适用场景</h2>
      <p>
        适合用于业务后台、内部管理工具、数据维护系统、任务调度平台和需要权限控制的 Web 应用。
        项目可以在现有基础能力上快速扩展业务模块，减少重复搭建账号、权限、菜单和基础 CRUD 的时间。
      </p>
    </section>
  </div>
</template>

<script setup lang="ts" name="Index">
import { Connection, MagicStick, Monitor, SetUp } from '@element-plus/icons-vue'

// 首页只展示静态说明，避免引入额外接口依赖。
const stacks = [
  {
    title: '权限与组织',
    content: '提供用户、角色、部门、岗位、菜单和按钮权限管理，支持后台系统的访问控制。',
    icon: Monitor
  },
  {
    title: '系统配置',
    content: '内置参数配置、字典管理、通知公告和菜单维护，便于统一管理系统基础数据。',
    icon: SetUp
  },
  {
    title: '监控与审计',
    content: '覆盖登录日志、操作日志、在线用户、缓存监控、服务监控和数据源监控。',
    icon: Connection
  },
  {
    title: '开发提效',
    content: '提供代码生成、表单构建和接口文档能力，帮助快速生成业务模块骨架。',
    icon: MagicStick
  }
]

// 首页功能清单，保持静态展示即可。
const changes = [
  '账号登录、验证码、Token 认证和登录状态管理。',
  '用户、角色、部门、岗位、菜单、按钮权限等后台权限体系。',
  '参数配置、字典管理、通知公告等系统基础配置。',
  '登录日志、操作日志、在线用户、服务监控、缓存监控和数据源监控。',
  '定时任务管理、任务日志查看和任务执行状态维护。',
  '代码生成、表单构建和接口文档，辅助快速开发业务模块。'
]
</script>

<style scoped lang="scss">
.platform-home {
  max-width: 1040px;
  min-height: calc(100vh - 84px);
  margin: 0 auto;
  color: var(--el-text-color-regular);

  .intro {
    padding: 34px 0 24px;
    border-bottom: 1px solid var(--el-border-color-light);

    .eyebrow {
      margin: 0 0 10px;
      font-size: 13px;
      font-weight: 600;
      color: var(--el-color-primary);
    }

    h1 {
      max-width: 760px;
      margin: 0;
      font-size: 30px;
      font-weight: 700;
      line-height: 1.35;
      letter-spacing: 0;
      color: var(--el-text-color-primary);
    }

    .summary {
      max-width: 820px;
      margin: 16px 0 0;
      font-size: 15px;
      line-height: 1.9;
      color: var(--el-text-color-regular);
    }
  }

  .section {
    padding: 24px 0;
    border-bottom: 1px solid var(--el-border-color-light);

    h2 {
      margin: 0 0 12px;
      font-size: 19px;
      font-weight: 700;
      color: var(--el-text-color-primary);
    }

    p {
      max-width: 900px;
      margin: 0 0 10px;
      font-size: 14px;
      line-height: 1.9;
      color: var(--el-text-color-regular);
    }
  }

  .stack-grid {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 14px;
  }

  .stack-item {
    display: flex;
    gap: 12px;
    min-height: 98px;
    padding: 16px;
    background: var(--el-bg-color-overlay);
    border: 1px solid var(--el-border-color-light);
    border-radius: 8px;

    .el-icon {
      flex: 0 0 34px;
      width: 34px;
      height: 34px;
      margin-top: 2px;
      font-size: 20px;
      color: var(--el-color-primary);
      background: var(--el-color-primary-light-9);
      border-radius: 8px;
    }

    h3 {
      margin: 0 0 6px;
      font-size: 15px;
      color: var(--el-text-color-primary);
    }

    p {
      margin: 0;
      font-size: 13px;
      line-height: 1.7;
      color: var(--el-text-color-secondary);
    }
  }

  .change-list {
    padding: 0;
    margin: 0;
    list-style: none;

    li {
      position: relative;
      padding-left: 18px;
      margin-bottom: 10px;
      font-size: 14px;
      line-height: 1.8;
      color: var(--el-text-color-regular);

      &::before {
        position: absolute;
        top: 11px;
        left: 0;
        width: 6px;
        height: 6px;
        content: "";
        background: var(--el-color-primary);
        border-radius: 50%;
      }
    }
  }
}

@media (max-width: 768px) {
  .platform-home {
    .intro {
      padding-top: 22px;

      h1 {
        font-size: 24px;
      }
    }

    .stack-grid {
      grid-template-columns: 1fr;
    }
  }
}
</style>
