
SRS Application Module Rules(SRS应用模块规则)
1. Each module in its isolate home directory(一个模块一个目录).
2. There is a config file in home(目录下放一个config文件).
3. All variables in configure are available(所有的configure中的变量模块中可以使用).

The Variables in config(模块中需要定义变量，例如):
1. SRS_MODULE_NAME：The application binary name, optional. (模块名称，用来做Makefile的phony以及执行binary文件名。模块的二进制输出。为空时没有独立的二进制。)
2. SRS_MODULE_MAIN：The source file in src/main directory, optional. (模块的main函数所在的cpp文件，在src/main目录。模块在main的文件。可以为空。)
3. SRS_MODULE_APP：The source file in src/app directory, optional. (模块在src/app目录的源文件列表。模块在app的文件。可以为空。)
4. SRS_MODULE_DEFINES: The extra defined macros, optional. (模块编译时的额外宏定义。在app和main模块加入。可以为空。)

For example(下面是一个RTMFP服务器实例):
SRS_MODULE_NAME=("srs_rtmfpd")
SRS_MODULE_MAIN=("srs_main_rtmfpd")
SRS_MODULE_APP=("srs_app_rtfmpd")
SRS_MODULE_DEFINES="-DRTMFPD"

Winlin, 2015.3

