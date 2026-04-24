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
  # Build a minimal argv on stack so code that reads argv[1] does not fault.
  addi sp, sp, -8
  sw zero, 0(sp)
  sw zero, 4(sp)

  addi a0, zero, 0
  addi a1, sp, 0
  jal ra, main

  addi a0, zero, 0
  jal ra, libtarg_success

halt_loop:
  jal zero, halt_loop
