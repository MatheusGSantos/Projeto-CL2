module maquina_de_lavar(output reg bomba_agua, modo_agitar, modo_centrifugar, modo_girar,input clock, reset_n, inicio, tempo1, tempo2, tempo3, cheio, vazio, secar
	input wire [6:0] SW;
	output reg [3:0] LEDG;
	
	reg [1:0] estado_atual;
	parameter espera = 0, encher =1, agitar = 2, Tempo = 3, 
	agitar2 = 4, esvaziar = 5, centrifugar = 6;
	 

always @ (*) begin // parte combinacional
	case (estado_atual)
		espera: 
		begin
			//bomba_agua = 0; modo_agitar = 0; modo_girar = 0;modo_centrifugar = 0;
		end
		encher: 
		begin
			//bomba_agua = 1; modo_agitar = 0; modo_girar = 0;modo_centrifugar = 0;
		end
		agitar: 
		begin
			//bomba_agua = 0; modo_agitar = 1; modo_girar = 0;modo_centrifugar = 0;
		end
		tempo:
		begin
			//bomba_agua = 0; modo_agitar = 0; modo_girar = 1;modo_centrifugar = 0;
		end
		agitar2: 
		begin
			//bomba_agua = 0; modo_agitar = 1; modo_girar = 0;modo_centrifugar = 0;
		end
		esvaziar: 
		begin
			//bomba_agua = 0; modo_agitar = 0; modo_girar = 0;modo_centrifugar = 0;
		end
		centrifugar: 
		begin
			//bomba_agua = 0; modo_agitar = 0; modo_girar = 0;modo_centrifugar = 1;
		end
	endcase
end
 
always @ (posedge clock, negedge reset_n) // parte sequencial
 	if (~reset_n)
	    estado_atual <= espera;
	else
 	   case (estado_atual)
 	    espera: 
		    if (SW[0] == 1)
 		    estado_atual <= encher;

 	    encher: 
		    if (SW[1] == 1)
		    estado_atual <= agitar;

 	    agitar: 
  		    if (SW[2] == 1)
 		    estado_atual <= tempo;

	    tempo: 
		    if (SW[3] == 1)
 		    estado_atual <= agitar2;

	    agitar2: 
		    if(SW[4] == 1)
	    	    estado_atual <= esvaziar;

	    esvaziar: 
		    if(SW[5] == 1)
		    estado_atual <= centrifugar;

	    centrifugar: 
		    if(SW[6] == 1)
		    estado_atual <= espera;
		endcase
endmodule 