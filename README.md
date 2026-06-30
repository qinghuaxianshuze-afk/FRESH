# GUI Agent - 基于 Kimi 视觉模型的安卓自动化操作助手

## 项目简介

这是一个基于 Android Accessibility Service（无障碍服务）和 Kimi 视觉模型 API 的安卓手机 GUI Agent 应用。它可以：
- 自动截取手机屏幕
- 使用 Kimi 视觉模型理解屏幕内容
- 根据任务目标自动规划并执行点击、滑动、输入等操作
- 通过悬浮窗实时显示运行状态
- 支持用户随时中断任务

## 功能特性

1. **智能屏幕理解**：使用 Moonshot-v1 视觉模型分析屏幕截图
2. **自动操作执行**：支持点击、滑动、输入文字、返回键、Home 键等操作
3. **可视化操作**：通过 Show Touches 显示操作过程
4. **悬浮窗控制**：可拖动的悬浮窗，方便随时停止任务
5. **日志记录**：完整的操作日志，便于调试和回溯
6. **安全机制**：最大步数限制，防止死循环

## 系统要求

- Android 8.0 (API 26) 及以上
- 需要开启无障碍服务权限
- 需要悬浮窗权限（SYSTEM_ALERT_WINDOW）
- 需要网络权限（用于调用 Kimi API）

## 安装说明

### 1. 编译 APK

使用 Android Studio 打开项目后：

```bash
# 方式一：通过 Android Studio 菜单
Build > Build Bundle(s) / APK(s) > Build APK(s)

# 方式二：命令行构建
./gradlew assembleDebug
```

生成的 APK 位于：
`app/build/outputs/apk/debug/app-debug.apk`

### 2. 安装到手机

将 APK 传输到手机上安装，或使用 `adb install` 命令。

### 3. 权限配置

首次启动应用需要配置以下权限：

1. **无障碍服务**：
   - 进入 设置 > 无障碍 > 已下载的服务
   - 找到 "GUI Agent" 并开启
   
2. **悬浮窗权限**：
   - 应用会自动请求，或在 设置 > 应用 > GUI Agent > 权限 中开启

## 使用方法

### 1. 获取 Kimi API Key

访问 [Moonshot 开放平台](https://platform.moonshot.cn/) 注册账号并获取 API Key。

### 2. 启动服务

1. 打开 GUI Agent 应用
2. 输入您的 Kimi API Key
3. 点击"启动服务"按钮
4. 在系统设置中开启无障碍服务

### 3. 执行任务

1. 在任务输入框中描述您想要完成的任务，例如：
   - "帮我把微信里张三的聊天记录截图发到文件传输助手"
   - "打开淘宝搜索 iPhone 15"
   - "帮我清理相册中的重复照片"

2. 点击"执行任务"按钮
3. Agent 会自动循环执行：截屏 → 分析 → 操作 → 截屏...

4. 可随时点击"停止任务"中断操作

## 技术架构

```
┌─────────────────────────────────────┐
│           MainActivity              │
│         (用户交互界面)               │
└──────────────┬──────────────────────┘
               │
    ┌──────────▼──────────┐
    │   AgentService      │
    │ (无障碍服务核心)     │
    │                     │
    │ • takeScreenshot()  │
    │ • performClick()    │
    │ • performSwipe()    │
    │ • performInput()    │
    └──────────┬──────────┘
               │
    ┌──────────▼──────────┐
    │    KimiClient       │
    │  (API 通信模块)     │
    │                     │
    │ • analyzeScreen()   │
    │ • parseResponse()   │
    └──────────┬──────────┘
               │
    ┌──────────▼──────────┐
    │  Moonshot API       │
    │  (视觉模型)          │
    └─────────────────────┘
```

## 核心文件说明

| 文件 | 功能 |
|------|------|
| `AgentService.java` | 无障碍服务主类，负责截屏和执行操作 |
| `KimiClient.java` | Kimi API 客户端，处理 HTTP 通信 |
| `KimiAction.java` | 操作动作数据模型 |
| `MainActivity.java` | 主界面 Activity |
| `FloatingWindowService.java` | 悬浮窗服务 |

## 配置参数

可在代码中调整以下参数以优化性能：

**AgentService.java:**
- `maxSteps`: 最大操作步数（默认 50）
- 动作延迟时间：点击 800ms、滑动 1200ms、输入 600ms

**KimiClient.java:**
- `API_URL`: Kimi API 地址
- `model`: 使用的模型版本（默认 moonshot-v1-8k-vision）
- `temperature`: 模型温度（默认 0.1，越低越确定）
- 超时设置：连接 30s、读取 60s、写入 30s

## 注意事项

1. **安全使用**：本工具具有强大的自动化能力，请确保在合法合规的前提下使用
2. **API 费用**：每次截屏分析都会消耗 API 调用额度，请注意控制成本
3. **屏幕分辨率**：建议在 1080p 或更高分辨率的设备上使用以获得最佳效果
4. **网络环境**：需要稳定的网络连接以调用 Kimi API
5. **电池优化**：建议将应用加入电池优化白名单，防止后台被杀

## 故障排除

**问题：无法截屏**
- 确保 Android 版本 >= 10 (API 29)
- 检查无障碍服务是否正常启用

**问题：Kimi API 返回错误**
- 检查 API Key 是否正确
- 检查网络连接是否正常
- 确认 API 额度是否充足

**问题：操作不准确**
- 尝试降低 temperature 参数（如改为 0.05）
- 在系统提示词中增加更多约束条件
- 检查屏幕截图质量

## 开源协议

MIT License

## 作者

Marvis AI Assistant

## 更新日志

### v1.0.0 (2024)
- 初始版本发布
- 支持基本的屏幕理解和操作功能
- 实现悬浮窗控制界面
