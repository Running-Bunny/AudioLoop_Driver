# AudioLoop_Driver
AudioLoop_Driver for Linux Kernel based on Tinyalsa

# 基于tinyalsa编写回传模式
从录音设备读取数据写入到播放设备中
参考Android SDK中 tinyalsa相关代码，
对应目录rockchip_android11/external/tinyalsa/
Android.bp
.git
include  //在该目录下，存在一个asoundlib.h的头文件，这个文件应该是向hal层提供一些接口。
mixer.c
MODULE_LICENSE_BSD
NOTICE
OWNERS
pcm.c    通过这个库调用到底层