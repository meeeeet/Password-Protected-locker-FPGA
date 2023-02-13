onerror {quit -f}
vlib work
vlog -work work lock.vo
vlog -work work lock.vt
vsim -novopt -c -t 1ps -L cycloneiii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.and1_vlg_vec_tst
vcd file -direction lock.msim.vcd
vcd add -internal and1_vlg_vec_tst/*
vcd add -internal and1_vlg_vec_tst/i1/*
add wave /*
run -all
