module porta_xor(
  input A,B,
  output Sxor
);
  assign Sxor = A ^ B;
endmodule

module porta_not(
  input X,
  output Snot
); 
  assign Snot = ~X;
endmodule

module porta_and(
  input A,B,
  output Sand
);
  assign Sand = A & B; 
endmodule

module main(
  input [1:0] A,
  input [1:0] B,
  output S
);
  logic sXor0,sXor1,sNot0,sNot1,out;
  porta_xor p_xor0(A[0],B[0],sXor0);
  porta_xor p_xor1(A[1],B[1],sXor1);
  porta_not p_not0(sXor1,sNot1);
  porta_not p_not1(sXor0,sNot0);
  porta_and p_and(sNot0,sNot1,out);
  assign S = out;
endmodule