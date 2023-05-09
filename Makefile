# 声明编译器
CC = g++

# 声明编译选项
CFLAGS = -c -Wall 
CFLAGS2 = -lpthread -L./lib -lgtest -std=c++17

# 程序名¡
TARGET = demo

# 当前项目的根目录
TOPOBJ = $(PWD)

# 编译过程的中间文件存放目录
OBJDIR = $(TOPOBJ)/obj/

# 编译的源码目录 .c
SRCDIR = $(TOPOBJ)/src/
T_SRCDIR = $(TOPOBJ)/test/

# 编译的头文件
INCDIR = $(TOPOBJ)/inc/

# 测试框架库
GTESTH = $(TOPOBJ)/lib/

# 编译生成可执行文件的目录
BINDIR = $(TOPOBJ)/bin/

# 编译生成可执行文件
BIN = $(BINDIR)$(TARGET)

# 源文件 eg: /path/a.c /path/b.c
SRCLIST = $(wildcard $(SRCDIR)*.cpp)
T_SRCLIST = $(wildcard $(T_SRCDIR)*.cpp)

# 头文件 eg: /path/a.h /path/b.h
INCLIST = $(wildcard $(SRCDIR)*.hpp)

# 源文件增加.o后缀		eg: /path/a.c -> /path/a.c.o
OBJ_ADD_O = $(addsuffix .o, $(SRCLIST))
T_OBJ_ADD_O = $(addsuffix .o, $(T_SRCLIST))

# 去除路径前面的文件夹名 eg: /path/a.o -> a.o
ERASE_PATH = $(notdir $(OBJ_ADD_O))
T_ERASE_PATH = $(notdir $(T_OBJ_ADD_O))

# 增加中间文件路径		 eg: a.o -> ./obj/a.o
SRCOBJ = $(addprefix $(OBJDIR), $(ERASE_PATH))
T_SRCOBJ = $(addprefix $(OBJDIR), $(T_ERASE_PATH))
T_DELMAIN = $(filter-out %main.cpp.o, $(SRCOBJ))

# 编译TARGET
all: check $(TARGET) test

check:
	@test -d $(BINDIR) || mkdir -p $(BINDIR)
	@test -d $(OBJDIR) || mkdir -p $(OBJDIR)

$(TARGET): $(SRCOBJ)
	$(CC) $^ -o $(BINDIR)$@

test: $(T_DELMAIN) $(T_SRCOBJ)
	$(CC) $^ -o $(BINDIR)$@ $(CFLAGS2)

$(OBJDIR)%.o: $(SRCDIR)%
	$(CC) $(CFLAGS) $(CFLAGS2) -I$(GTESTH) -I$(INCDIR) $^ -o $@

$(T_SRCOBJ): $(T_SRCLIST)
	$(CC) $(CFLAGS) $(CFLAGS2) -I$(GTESTH) -I$(INCDIR) $^ -o $@

clean: 
	rm -rf $(OBJDIR)/* $(BINDIR)/*

.PHONY: all $(TARGET) test clean 