# GUI Agent 项目结构

```
GuiAgent/
├── app/
│   ├── build.gradle                          # App 模块构建配置
│   ├── proguard-rules.pro                    # ProGuard 混淆规则
│   └── src/
│       ├── main/
│       │   ├── AndroidManifest.xml           # 应用清单（权限、服务声明）
│       │   ├── java/com/marvis/guiagent/     # Java 源代码
│       │   │   ├── AgentService.java         # ★ 核心无障碍服务
│       │   │   ├── KimiClient.java           # ★ Kimi API 客户端
│       │   │   ├── KimiAction.java           # 操作动作数据模型
│       │   │   ├── MainActivity.java         # 主界面 Activity
│       │   │   └── FloatingWindowService.java # 悬浮窗服务
│       │   └── res/
│       │       ├── layout/
│       │       │   ├── activity_main.xml     # 主界面布局
│       │       │   └── floating_window.xml   # 悬浮窗布局
│       │       ├── values/
│       │       │   ├── strings.xml           # 字符串资源
│       │       │   └── themes.xml            # 主题样式
│       │       └── xml/
│       │           └── accessibility_service_config.xml  # 无障碍服务配置
│       └── test/
│           └── java/com/marvis/guiagent/
│               └── ExampleUnitTest.java      # 单元测试示例
├── build.gradle                              # 项目级构建配置
├── settings.gradle                           # 项目设置
├── gradle.properties                         # Gradle 属性
├── gradle/wrapper/
│   └── gradle-wrapper.properties             # Gradle Wrapper 配置
├── build_apk.bat                             # Windows 构建脚本
├── build_apk.sh                              # Linux/Mac 构建脚本
└── README.md                                 # 项目文档
```

## 文件功能说明

### 核心源码文件 (★)

1. **AgentService.java** - 无障碍服务核心类
   - 继承 AccessibilityService
   - 负责截屏（takeScreenshot）
   - 执行点击操作（performClick）
   - 执行滑动操作（performSwipe）
   - 执行文字输入（performInput）
   - 任务主循环：截屏→分析→执行→再截屏
   - 最大步数限制防止死循环

2. **KimiClient.java** - API 通信模块
   - 使用 OkHttp 发送 HTTP 请求
   - 将屏幕截图转为 Base64 发送给 Kimi API
   - 解析返回的 JSON 操作指令
   - 包含完整的系统提示词（System Prompt）

3. **KimiAction.java** - 数据模型
   - 定义操作动作的数据结构
   - 支持 click/swipe/input/back/home/wait/finish 等动作类型
   - 包含坐标、持续时间、输入文本等字段

4. **MainActivity.java** - 用户界面
   - API Key 输入框
   - 任务目标输入框
   - 状态显示和日志输出
   - 启动/停止服务按钮
   - 执行/停止任务按钮

5. **FloatingWindowService.java** - 悬浮窗服务
   - 可拖动的悬浮窗口
   - 显示当前运行状态
   - 提供快速停止任务按钮
   - 支持关闭悬浮窗

### 配置文件

- **AndroidManifest.xml**: 声明权限、Activity、Service
- **accessibility_service_config.xml**: 无障碍服务详细配置
- **build.gradle (app)**: 依赖管理（OkHttp, Gson, Material Design）

## 构建要求

- Android Studio Hedgehog (2023.1.1) 或更高版本
- Android SDK 34 (Android 14)
- Gradle 8.2+
- JDK 17+

## 快速开始

1. 用 Android Studio 打开 GuiAgent 目录
2. 等待 Gradle 同步完成
3. 连接手机或启动模拟器
4. 点击 Run 或执行 `./gradlew assembleDebug`
5. 安装生成的 APK 并授予必要权限
