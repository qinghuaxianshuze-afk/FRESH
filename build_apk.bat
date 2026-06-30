@echo off
chcp 65001 >nul
echo ========================================
echo   GUI Agent APK 构建脚本
echo ========================================
echo.

REM 设置 Android SDK 路径（请根据实际情况修改）
set ANDROID_HOME=C:\Users\%USERNAME%\AppData\Local\Android\Sdk
set PATH=%ANDROID_HOME%\platform-tools;%ANDROID_HOME%\tools;%PATH%

echo [1/4] 检查 Android SDK...
if not exist "%ANDROID_HOME%" (
    echo 错误: 未找到 Android SDK！
    echo 请先安装 Android Studio 并配置 Android SDK
    echo 下载地址: https://developer.android.com/studio
    pause
    exit /b 1
)
echo ✓ Android SDK 已找到: %ANDROID_HOME%
echo.

echo [2/4] 检查必要组件...
if not exist "%ANDROID_HOME%\build-tools" (
    echo 错误: 缺少 Build Tools，请在 SDK Manager 中安装
    pause
    exit /b 1
)
if not exist "%ANDROID_HOME%\platforms\android-34" (
    echo 警告: 未找到 API 34 平台，尝试使用其他版本...
)
echo ✓ 必要组件检查通过
echo.

echo [3/4] 开始构建 Debug APK...
call gradlew.bat assembleDebug

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ✗ 构建失败！请检查上方错误信息
    pause
    exit /b 1
)

echo.
echo [4/4] 构建成功！
echo.
echo ========================================
echo   APK 输出位置:
echo   app\build\outputs\apk\debug\app-debug.apk
echo ========================================
echo.
echo 您可以使用以下命令安装到手机:
echo adb install app\build\outputs\apk\debug\app-debug.apk
echo.

pause
