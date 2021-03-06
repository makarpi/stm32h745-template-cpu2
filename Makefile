##########################################################################################################################
# File automatically-generated by tool: [projectgenerator] version: [3.4.0] date: [Sat Mar 07 19:49:47 CET 2020]
##########################################################################################################################

# ------------------------------------------------
# Generic Makefile (based on gcc)
#
# ChangeLog :
#	2017-02-10 - Several enhancements + project update mode
#   2015-07-22 - first version
# ------------------------------------------------

######################################
# target
######################################
TARGET = stm32h745-template-cpu2


######################################
# building variables
######################################
# debug build?
DEBUG = 1
# optimization
OPT = -Og


#######################################
# paths
#######################################
# Build path
BUILD_DIR = out

######################################
# source
######################################
# C sources
C_SOURCES =  \
lib/STM32H7xx_HAL_Driver/Src/stm32h7xx_ll_adc.c \
lib/STM32H7xx_HAL_Driver/Src/stm32h7xx_ll_bdma.c \
lib/STM32H7xx_HAL_Driver/Src/stm32h7xx_ll_comp.c \
lib/STM32H7xx_HAL_Driver/Src/stm32h7xx_ll_crc.c \
lib/STM32H7xx_HAL_Driver/Src/stm32h7xx_ll_crs.c \
lib/STM32H7xx_HAL_Driver/Src/stm32h7xx_ll_dac.c \
lib/STM32H7xx_HAL_Driver/Src/stm32h7xx_ll_dma.c \
lib/STM32H7xx_HAL_Driver/Src/stm32h7xx_ll_exti.c \
lib/STM32H7xx_HAL_Driver/Src/stm32h7xx_ll_gpio.c \
lib/STM32H7xx_HAL_Driver/Src/stm32h7xx_ll_hrtim.c \
lib/STM32H7xx_HAL_Driver/Src/stm32h7xx_ll_i2c.c \
lib/STM32H7xx_HAL_Driver/Src/stm32h7xx_ll_lptim.c \
lib/STM32H7xx_HAL_Driver/Src/stm32h7xx_ll_lpuart.c \
lib/STM32H7xx_HAL_Driver/Src/stm32h7xx_ll_opamp.c \
lib/STM32H7xx_HAL_Driver/Src/stm32h7xx_ll_pwr.c \
lib/STM32H7xx_HAL_Driver/Src/stm32h7xx_ll_rcc.c \
lib/STM32H7xx_HAL_Driver/Src/stm32h7xx_ll_rng.c \
lib/STM32H7xx_HAL_Driver/Src/stm32h7xx_ll_rtc.c \
lib/STM32H7xx_HAL_Driver/Src/stm32h7xx_ll_spi.c \
lib/STM32H7xx_HAL_Driver/Src/stm32h7xx_ll_tim.c \
lib/STM32H7xx_HAL_Driver/Src/stm32h7xx_ll_usart.c \
lib/STM32H7xx_HAL_Driver/Src/stm32h7xx_ll_utils.c \
src/main.c \
src/stm32h7xx_it.c \
src/system_stm32h7xx_dualcore_boot_cm4_cm7.c

# ASM sources
ASM_SOURCES =  \
startup_stm32h745xx_CM4.s


#######################################
# binaries
#######################################
PREFIX = arm-none-eabi-
# The gcc compiler bin path can be either defined in make command via GCC_PATH variable (> make GCC_PATH=xxx)
# either it can be added to the PATH environment variable.
ifdef GCC_PATH
CC = $(GCC_PATH)/$(PREFIX)gcc
AS = $(GCC_PATH)/$(PREFIX)gcc -x assembler-with-cpp
CP = $(GCC_PATH)/$(PREFIX)objcopy
SZ = $(GCC_PATH)/$(PREFIX)size
else
CC = $(PREFIX)gcc
AS = $(PREFIX)gcc -x assembler-with-cpp
CP = $(PREFIX)objcopy
SZ = $(PREFIX)size
endif
HEX = $(CP) -O ihex
BIN = $(CP) -O binary -S
 
#######################################
# CFLAGS
#######################################
# cpu
CPU = -mcpu=cortex-m7

# fpu
FPU = -mfpu=fpv5-d16

# float-abi
FLOAT-ABI = -mfloat-abi=hard

# mcu
MCU = $(CPU) -mthumb $(FPU) $(FLOAT-ABI)

# macros for gcc
# AS defines
AS_DEFS = 

# C defines
C_DEFS =  \
-DCORE_CM4 \
-DSTM32H745xx \
-DUSE_FULL_LL_DRIVER


# AS includes
AS_INCLUDES = 

# C includes
C_INCLUDES =  \
-Ilib/STM32H7xx_HAL_Driver/Inc \
-Isrc \
-Ilib/CMSIS/Device/ST/STM32H7xx/Include \
-Ilib/CMSIS/Include 

# compile gcc flags
ASFLAGS = $(MCU) $(AS_DEFS) $(AS_INCLUDES) $(OPT) -Wall -fdata-sections -ffunction-sections

CFLAGS = $(MCU) $(C_DEFS) $(C_INCLUDES) $(OPT) -Wall -fdata-sections -ffunction-sections

ifeq ($(DEBUG), 1)
CFLAGS += -g -gdwarf-2
endif


# Generate dependency information
CFLAGS += -MMD -MP -MF"$(@:%.o=%.d)"


#######################################
# LDFLAGS
#######################################
# link script
LDSCRIPT = stm32h745xx_flash_CM4.ld

# libraries
LIBS = -lc -lm -lnosys 
LIBDIR = 
LDFLAGS = $(MCU) -specs=nano.specs -T$(LDSCRIPT) $(LIBDIR) $(LIBS) -Wl,-Map=$(BUILD_DIR)/$(TARGET).map,--cref -Wl,--gc-sections

# default action: build all
all: $(BUILD_DIR)/$(TARGET).elf $(BUILD_DIR)/$(TARGET).hex $(BUILD_DIR)/$(TARGET).bin


#######################################
# build the application
#######################################
# list of objects
OBJECTS = $(addprefix $(BUILD_DIR)/,$(notdir $(C_SOURCES:.c=.o)))
vpath %.c $(sort $(dir $(C_SOURCES)))
# list of ASM program objects
OBJECTS += $(addprefix $(BUILD_DIR)/,$(notdir $(ASM_SOURCES:.s=.o)))
vpath %.s $(sort $(dir $(ASM_SOURCES)))

$(BUILD_DIR)/%.o: %.c Makefile | $(BUILD_DIR) 
	$(CC) -c $(CFLAGS) -Wa,-a,-ad,-alms=$(BUILD_DIR)/$(notdir $(<:.c=.lst)) $< -o $@

$(BUILD_DIR)/%.o: %.s Makefile | $(BUILD_DIR)
	$(AS) -c $(CFLAGS) $< -o $@

$(BUILD_DIR)/$(TARGET).elf: $(OBJECTS) Makefile
	$(CC) $(OBJECTS) $(LDFLAGS) -o $@
	$(SZ) $@

$(BUILD_DIR)/%.hex: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	$(HEX) $< $@
	
$(BUILD_DIR)/%.bin: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	$(BIN) $< $@	
	
$(BUILD_DIR):
	mkdir $@		

#######################################
# clean up
#######################################
clean:
	-rm -fR $(BUILD_DIR)
  
#######################################
# dependencies
#######################################
-include $(wildcard $(BUILD_DIR)/*.d)

# *** EOF ***