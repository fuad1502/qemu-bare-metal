extern unsigned _sidata, _sdata, _edata, _sbss, _ebss;

int main(void);

void Reset_Handler(void) {
  unsigned *src = &_sidata;
  unsigned *dst = &_sdata;
  while (dst < &_edata)
    *dst++ = *src++;
  for (dst = &_sbss; dst < &_ebss; dst++)
    *dst = 0;
  main();
  while (1)
    ;
}
