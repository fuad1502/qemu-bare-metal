.syntax unified
.cpu cortex-m3
.thumb

.section .vector_table, "a"
.align 2
.word _stack_top
.word Reset_Handler
