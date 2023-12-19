transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/Processa_Sprite {C:/intelFPGA_lite/18.1/Processa_Sprite/TesteMemoria4.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/Processa_Sprite {C:/intelFPGA_lite/18.1/Processa_Sprite/Processa_Sprite.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/Processa_Sprite {C:/intelFPGA_lite/18.1/Processa_Sprite/merge_sprites.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/Processa_Sprite {C:/intelFPGA_lite/18.1/Processa_Sprite/comando.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/Processa_Sprite {C:/intelFPGA_lite/18.1/Processa_Sprite/prepara_dados.v}
vcom -93 -work work {C:/intelFPGA_lite/18.1/Processa_Sprite/RAM2.vhd}
vcom -93 -work work {C:/intelFPGA_lite/18.1/Processa_Sprite/RAM3.vhd}

vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/Processa_Sprite {C:/intelFPGA_lite/18.1/Processa_Sprite/TB_Sprites.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  TB_Sprites

add wave *
view structure
view signals
run 14 sec
