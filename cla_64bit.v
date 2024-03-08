`timescale 1ns / 1ps

module cla_64bit(a,b, cin, sum,cout);
  input [63:0] a, b;
  input cin;
  output [63:0] sum;
  output cout;
  wire [15:0] c1, c2, c3, c4;

  cla_16bit cla1 (.a(a[15:0]), .b(b[15:0]), .cin(cin), .sum(sum[15:0]), .cout(c1));
  cla_16bit cla2 (.a(a[31:16]), .b(b[31:16]), .cin(c1), .sum(sum[31:16]), .cout(c2));
  cla_16bit cla3 (.a(a[47:32]), .b(b[47:32]), .cin(c2), .sum(sum[47:32]), .cout(c3));
  cla_16bit cla4 (.a(a[63:48]), .b(b[63:48]), .cin(c3), .sum(sum[63:48]), .cout(cout));

endmodule


module cla_16bit(a,b, cin, sum,cout);
  input [15:0] a,b;
  input cin;
  output [15:0] sum;
  output cout;
  wire c1,c2,c3;
   
  cla_4bit cla1 (.a(a[3:0]), .b(b[3:0]), .cin(cin), .sum(sum[3:0]), .cout(c1));
  cla_4bit cla2 (.a(a[7:4]), .b(b[7:4]), .cin(c1), .sum(sum[7:4]), .cout(c2));
  cla_4bit cla3(.a(a[11:8]), .b(b[11:8]), .cin(c2), .sum(sum[11:8]), .cout(c3));
  cla_4bit cla4(.a(a[15:12]), .b(b[15:12]), .cin(c3), .sum(sum[15:12]), .cout(cout));
 
endmodule


module cla_4bit(a,b, cin, sum,cout);
  input [3:0] a,b;
  input cin;
  output [3:0] sum;
  output cout;
   
  wire [3:0] p,g,c;
   
  assign p=a^b;//propagate
  assign g=a&b; //generate
   
  assign c[0]=cin;
  assign c[1]= g[0]|(p[0]&c[0]);
  assign c[2]= g[1] | (p[1]&g[0]) | p[1]&p[0]&c[0];
  assign c[3]= g[2] | (p[2]&g[1]) | p[2]&p[1]&g[0] | p[2]&p[1]&p[0]&c[0];
  assign cout= g[3] | (p[3]&g[2]) | p[3]&p[2]&g[1] | p[3]&p[2]&p[1]&p[0]&c[0];
  assign sum=p^c;
 
endmodule
