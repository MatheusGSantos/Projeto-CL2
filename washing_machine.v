module washing_machine(
		output reg bomba_agua, modo_agitar, modo_centrifugar, modo_girar, 
		input CLOCK_50, SW,
		output reg [3:0] LEDG,
		input [2:0] KEY);
	
	reg [1:0] estado_atual;
	parameter espera = 0, encher =1, agitar = 2, tempo = 3, 
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
 
always @ (posedge CLOCK_50) // parte sequencial
 	if (KEY[2] == 1)
	    estado_atual <= espera;
	else
 	   case (estado_atual)
 	    espera: 
		    if (SW == 1)
 		    estado_atual <= encher;

 	    encher: 
		    if (SW == 1)
		    estado_atual <= agitar;

 	    agitar: 
  		    if (SW == 1)
 		    estado_atual <= tempo;

	    tempo: 
		    if (SW == 1)
 		    estado_atual <= agitar2;

	    agitar2: 
		    if(SW == 1)
	    	    estado_atual <= esvaziar;

	    esvaziar: 
		    if(SW == 1)
		    estado_atual <= centrifugar;

	    centrifugar: 
		    if(SW == 1)
		    estado_atual <= espera;
		endcase
endmodule 