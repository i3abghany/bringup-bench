.section .text
.global _start

_start:
  .option push
  .option norelax
  la gp, __global_pointer$
  .option pop

  la sp, _stack_start

  la t0, _bss_start
  la t1, _bss_end
  bgeu t0, t1, clear_bss_done

clear_bss:
  sw zero, 0(t0)
  addi t0, t0, 4
  bltu t0, t1, clear_bss

clear_bss_done:
  addi a0, zero, 0
  addi a1, zero, 0
  jal ra, main

  addi a0, zero, 0
  jal ra, libtarg_success

halt_loop:
  jal zero, halt_loop
