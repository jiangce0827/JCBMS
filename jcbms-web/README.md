# JCBMS Web

JCBMS 前端项目，基于 Vue 3、TypeScript、Element Plus 和 Vite 构建。

## 开发环境

- Node.js 18+
- npm 9+

## 常用命令

```bash
npm install
npm run dev
npm run build:prod
npm run preview
```

## 环境配置

环境变量文件位于项目根目录：

- `.env.development`
- `.env.production`
- `.env.staging`

页面标题通过 `VITE_APP_TITLE = JCBMS` 配置，接口代理配置见 `vite.config.ts`。

## 目录说明

```text
jcbms-web/
├── src/
│   ├── api/                # API 接口
│   ├── assets/             # 静态资源和样式
│   ├── components/         # 公共组件
│   ├── layout/             # 布局
│   ├── store/              # Pinia 状态
│   ├── types/              # TypeScript 类型
│   ├── utils/              # 工具函数
│   └── views/              # 页面
├── vite/                   # Vite 插件配置
├── package.json
└── vite.config.ts
```

## 构建产物

生产构建输出到 `dist/`。
