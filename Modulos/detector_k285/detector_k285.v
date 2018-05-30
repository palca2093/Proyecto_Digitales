`timescale 1ns/1ps


module detector_k285(
  clk, 					//clock
  rst,					//reset
  enb,					//enb
  rx_DataE,				// array de rx_DataE de datos del canal RX
  rx_Valid,				// lo mismo que control_dk pero como salida
  k285, 				// indica que se detecto señal k28.5
  rx_Valid, 				// indica el estado del receptor:  modo rx_Valid o lectura  (1) o señal de control (0)
  rx_DataS				//array de salida con la informacion, indistinto de si es data o señal de control
);

  // Valor del simbolo K.28.5
  //   dec 188
  //   hex BC
  //   HGF EDCBA 101 11100
  //   rd -1 abcdei fghj 001111 1010
  //   rd +1 abcdei fghj 110000 0101
  //
  // 
  // Version de 8 bits de la COM va aqui 
  parameter vk285 = 8h'BC;  
  
  
  //Entradas y salidas
  input wire clk;			
  input wire rst;
  input wire enb;
  input reg [7:0] rx_DataE;		 
  output reg k285;		
  output reg rx_Valid;
  output reg rx_Valid;
  output reg rx_DataS;

  always @ (posedge clk) begin
    if (rst) begin
      k285 <= 0;			
      rx_Valid <= 0;				//deshabilita la bandera de lectura
    end else if (!rst && enb ) begin
      	rx_DataS <= rx_DataE			//Se pasa el byte de entrada a la salida.
        k285 <= (rx_DataS == vk285);		//se cambia el estado rx_Valid
        rx_Valid <= k285 ? ~rx_Valid : rx_Valid;   //Si k285==1  ~rx_Valid, si k285==0 rx_Valid
        end
    end
  end
endmodule

