#####################################################################
# 文件名称： rules.mk
# 文件标识：
# 说    明： makefile所需要的通用宏的定义
# 当前版本： V1.0
# 作    者
# 完成日期：
#
# 修改记录1：
#    修改日期：2015年11月12日
######################################################################

#一般仅需要修改INCLUDEDIR、TARGET和SOURCE的定义即可
include $(DB_MAKEFILE_PATH)/compilerule.mk

#The include directory
INCLUDEDIR := $(INCLUDEDIR)\

			
DEFINES := $(DEFINES)
LIBS :=  $(LIBS)
LIBDIR := $(LIBDIR) 

#需要加入到库文件中的源代码
SOURCE := $(wildcard *.c)
SOURCE += $(wildcard *.cpp)

######################################################################
#下面的代码不需要修改
######################################################################
		
# Alter any implicit rules' variables: 
CFLAGS := $(CFLAGS) $(addprefix -I,$(INCLUDEDIR)) $(addprefix -D,$(DEFINES))
CXXFLAGS := $(CFLAGS)

OBJS := $(patsubst %.c,%.o,$(SOURCE))
OBJS += $(patsubst %.cpp,%.o,$(SOURCE)) 
OBJS := $(addprefix $(OBJDIR)/,$(OBJS))
DEPS := $(patsubst %.o,%.d,$(OBJS)) 
MISSING_DEPS := $(filter-out $(wildcard $(DEPS)),$(DEPS)) 
MISSING_DEPS_SOURCES := $(wildcard $(patsubst %.d,%.c,$(MISSING_DEPS))) 
..PHONY : deps objs
everything : $(OBJS)
deps : $(DEPS)
objs : $(OBJS)
ifneq ($(MISSING_DEPS),) 
$(MISSING_DEPS) : 
	@$(RM-F) $(patsubst %.d,%.o,$@)
endif 
-include $(DEPS)
.PHONY : everything clean rebuild 

clean : 
	@$(RM-F) $(OBJDIR)/*.o 
	@$(RM-F) $(OBJDIR)/*.d 
	@$(RM-RF) $(OBJDIR) 
	 
rebuild: clean everything 

all: $(OBJS)
 
$(OBJDIR)/%.o : %.c | $(OBJDIR)
	@echo  Compiling $< ...
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@
	
$(OBJDIR)/%.o : %.cpp | $(OBJDIR)
	@echo  Compiling $< ...
	$(CPP) -c $(CFLAGS) $(CPPFLAGS) $< -o $@
$(OBJDIR) :
	$(MKDIR) $@
