Na versão final entregue, os pinos visíveis no top level, visualizados no gtkwave, devem ser:
• reset;
• clock;
• estado;
• PC;
• instrução (saída do Registrador de Instrução);
• saídas do banco de registradores (valores de Reg1 e Reg2);
• saída da ULA.

Pode usar outros pinos durante a implementação e a fase de debug, mas retire-os para a
entrega.
Também espero que você teste vários programas durante o desenvolvimento mas, para a
entrega, o testbench e a ROM devem estar configurados para executar um programa que faz o
seguinte:

1. Carrega R3 (o registrador 3) com o valor 5
2. Carrega R4 com 8
3. Soma R3 com R4 e guarda em R5
4. Subtrai 1 de R5
5. Salta para o endereço 20
6. No endereço 20, copia R5 para R3
7. Salta para a terceira instrução desta lista (R5 <= R3+R4)

0   nop
1   ldi r3, 5       0001 011 0000101
2   ldi r4, 8       0001 100 0001000
3   ldi r5, 0       0001 101 0000000
4   add r5, r3      0011 101 011 0000
5   add r5, r4      0011 101 100 0000
6   ldi r1, 1       0001 001 0000001
7   sub r5, r1      0100 101 001 0000
8   jmp 20 ; 0x14   1111 0000010100

(...)

20  mov r3, r5      0010 011 101 0000
21  jmp 3           1111 0000000011
