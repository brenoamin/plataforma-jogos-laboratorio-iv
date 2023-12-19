////UNIVERSIDADE FEDERAL DA BAHIA
////CÓDIGO REFERENTE A FINS AVALIATIVOS NA DISCIPLINA DE LABIV
////ALUNO: JOÃO RIOS

module comando (

input clock,
input rst,

output reg [9:0] addr,
output reg wren
);



always @(posedge clock or posedge rst) 
begin
	if(rst) begin 
	addr <= 0;
	wren <= 0;
	end
	else begin 
		if(addr == 1023) begin 
		addr <= 0;
		end
		else begin
		addr <= addr +1 ;
		end


wren <=0;
//

end 

end

endmodule 