#!/bin/bash
set -x
# 目标Android版本
API=29
ARCH=x86_64
CPU=x86_64
TOOL_CPU_NAME=x86_64
FFMPEG_HOME=$HOME/devtools/ffmpeg
#so库输出目录
OUTPUT=$FFMPEG_HOME/android/$CPU
# NDK的路径，根据自己的NDK位置进行设置
NDK=$HOME/androidtools/androidSDK/android-sdk-macosx/ndk/21.4.7075529
# NDK=$HOME/androidtools/androidSDK/android-sdk-macosx/ndk/25.0.8775105
# 编译工具链路径
TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/darwin-x86_64
# 编译环境
SYSROOT=$TOOLCHAIN/sysroot

TOOL_PREFIX="$TOOLCHAIN/bin/$TOOL_CPU_NAME-linux-android"
 
CC="$TOOL_PREFIX$API-clang"
CXX="$TOOL_PREFIX$API-clang++"
# OPTIMIZE_CFLAGS="-march=$CPU"
function build
{
  ./configure \
  --prefix=$OUTPUT \
  --target-os=android \
  --arch=$ARCH  \
  --cpu=$CPU \
  --disable-asm \
  --enable-neon \
  --enable-cross-compile \
  --enable-static \
  --disable-shared \
  --disable-doc \
  --disable-ffplay \
  --disable-ffprobe \
  --disable-symver \
  --disable-ffmpeg \
  --cc=$CC \
  --cxx=$CXX \
  --sysroot=$SYSROOT \
  --extra-cflags="-Os -fpic $OPTIMIZE_CFLAGS" \
  --logfile="configure.log" \

  # make clean all
  # 这里是定义用几个CPU编译
  # make -j32
  # make install
}
build
