#!/bin/bash

# GUI Agent APK 构建脚本 (Linux/Mac)

echo "========================================"
echo "  GUI Agent APK 构建脚本"
echo "========================================"
echo ""

# 设置 Android SDK 路径
export ANDROID_HOME=${ANDROID_HOME:-$HOME/Android/Sdk}
export PATH=$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$PATH

# 检查 Android SDK
echo "[1/4] 检查 Android SDK..."
if [ ! -d "$ANDROID_HOME" ]; then
    echo "错误: 未找到 Android SDK！"
    echo "请先安装 Android Studio 并配置 Android SDK"
    echo "下载地址: https://developer.android.com/studio"
    exit 1
fi
echo "✓ Android SDK 已找到: $ANDROID_HOME"
echo ""

# 检查必要组件
echo "[2/4] 检查必要组件..."
if [ ! -d "$ANDROID_HOME/build-tools" ]; then
    echo "错误: 缺少 Build Tools，请在 SDK Manager 中安装"
    exit 1
fi
echo "✓ 必要组件检查通过"
echo ""

# 开始构建
echo "[3/4] 开始构建 Debug APK..."
./gradlew assembleDebug

if [ $? -ne 0 ]; then
    echo ""
    echo "✗ 构建失败！请检查上方错误信息"
    exit 1
fi

echo ""
echo "[4/4] 构建成功！"
echo ""
echo "========================================"
echo "  APK 输出位置:"
echo "  app/build/outputs/apk/debug/app-debug.apk"
echo "========================================"
echo ""
echo "您可以使用以下命令安装到手机:"
echo "adb install app/build/outputs/apk/debug/app-debug.apk"
echo ""
