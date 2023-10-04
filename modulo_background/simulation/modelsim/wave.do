onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /VGA_Interface_tb/clk
add wave -noupdate /VGA_Interface_tb/rst
add wave -noupdate /VGA_Interface_tb/R_in
add wave -noupdate /VGA_Interface_tb/G_in
add wave -noupdate /VGA_Interface_tb/B_in
add wave -noupdate /VGA_Interface_tb/R
add wave -noupdate /VGA_Interface_tb/G
add wave -noupdate /VGA_Interface_tb/B
add wave -noupdate /VGA_Interface_tb/HS
add wave -noupdate /VGA_Interface_tb/VS
add wave -noupdate /VGA_Interface_tb/BLANK
add wave -noupdate /VGA_Interface_tb/VGA_SYNC
add wave -noupdate /VGA_Interface_tb/VGA_CLK
add wave -noupdate /VGA_Interface_tb/h_pos
add wave -noupdate /VGA_Interface_tb/v_pos
add wave -noupdate /VGA_Interface_tb/oAddress
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {564 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {2084 ps}
