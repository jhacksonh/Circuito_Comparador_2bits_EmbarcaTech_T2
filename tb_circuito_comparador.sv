`timescale 1ns/1ns
`include "circuito_comparador.sv"

module tb_circuito_comparador;

logic [1:0] a,b;
logic x;

main UUT(
    .A(a),
    .B(b),
    .S(x)
);

initial begin
     $dumpfile("simulador.vcd");
     $dumpvars(0,tb_circuito_comparador);
     a = 10;
     b = 11;
     #10
     a = 01;
     b = 01;
     #10
     a = 10;
     b = 10;
     #10
     a = 10;
     b = 01;
     #10
     $finish;
end
endmodule