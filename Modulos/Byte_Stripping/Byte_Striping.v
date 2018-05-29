module Byte_Striping(
  //Entradas del modulo
  input wire [7:0] tx_data,
  input wire tx_valid,
  input wire clk,
  //salidas del modulo
  output reg [7:0] lane0,
  output reg [7:0] lane1,
  output reg [7:0] lane2,
  output reg [7:0] lane3,
  output reg stripping_valid,
  //Variables internas
  output reg [1:0] counter,
  input wire init
  );

  //Primera vez que entran datos
  always @ (~init) begin
  counter <= 2'b11;
  end

  always @ (posedge clk) begin
   if (init) begin
       counter <= counter + 1;
   end else begin
     counter <= 2'b11;
   end


   //Segun sea el valor del contador, asi asigna cada uno de los bytes
   case (counter)
         2'b00: if (tx_valid) begin
           lane0 <= tx_data;
           stripping_valid <= 0;
         end
         2'b01: if (tx_valid) begin
           lane1 <= tx_data;
           stripping_valid <= 0;
         end
         2'b10: if (tx_valid) begin
           lane2 <= tx_data;
           stripping_valid <= 0;
         end
         2'b11: if (tx_valid) begin
           lane3 <= tx_data;
           stripping_valid <= 1;
         end
         default: stripping_valid <= 0;
       endcase
     end
endmodule
