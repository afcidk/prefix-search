TESTS = \
    test_cpy \
    test_ref

CFLAGS = -Wall -Werror -g

# Control the build verbosity                                                   
ifeq ("$(VERBOSE)","1")
    Q :=
    VECHO = @true
else
    Q := @
    VECHO = @printf
endif

GIT_HOOKS := .git/hooks/applied

.PHONY: all clean

all: $(GIT_HOOKS) $(TESTS)

$(GIT_HOOKS):
	@scripts/install-git-hooks
	@echo

OBJS_LIB = \
	tst.o

OBJS := \
    $(OBJS_LIB) \
    test_cpy.o \
    test_ref.o

deps := $(OBJS:%.o=.%.o.d)

test_%: test_%.o $(OBJS_LIB)
	$(VECHO) "  LD\t$@\n"
	$(Q)$(CC) $(LDFLAGS) -o $@ $^

%.o: %.c
	@astyle --style=kr --indent=spaces=4 --suffix=none $*.c
	$(VECHO) "  CC\t$@\n"
	$(Q)$(CC) -o $@ $(CFLAGS) -c -MMD -MF .$@.d $<

tinput.txt:
	scripts/gen.py

clean:
	$(RM) $(TESTS) $(OBJS)
	$(RM) $(deps)
	$(RM) ref_bench.txt cpy_bench.txt runtime.png tinput.txt runtime.png

plot: bench
	gnuplot scripts/runtime.gp

bench: $(TESTS) tinput.txt
	./test_cpy --bench
	./test_ref --bench


-include $(deps)
