Na versão final entregue, os pinos visíveis no top level, visualizados no gtkwave, devem ser:
• reset;
• clock;
• estado;
• PC;
• instrução (saída do Registrador de Instrução);
• saídas do banco de registradores (valores de Reg1 e Reg2);
• saída da ULA.

Mantenha os pinos visíveis no top level como descritos no laboratório passado.
Para a entrega, o testbench e a ROM devem estar configurados para executar um programa
que faz o seguinte:

1. Carrega R3 (o registrador 3) com o valor 0
2. Carrega R4 com 0
3. Soma R3 com R4 e guarda em R4
4. Soma 1 em R3
5. Se R3<30 salta para a instrução do passo 3 *
6. Copia valor de R4 para R

        ldi r1, 1     0001 001 0000001
        ldi r2, 31    0001 010 0011111
        ldi r3, 0     0001 011 0000000
        ldi r4, 0     0001 100 0000000
        add r4, r3    0011 100 011 0000
        add r3, r1    0011 011 001 0000
        cp r2, r3     0101 010 011 0000
        brge -3       1000 1111101 000 -- 3 está em complemento de 2
        mov r5, r4    0010 101 100 0000



