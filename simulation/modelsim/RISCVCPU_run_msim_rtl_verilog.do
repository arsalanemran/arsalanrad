transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+E:/TEST_LAST {E:/TEST_LAST/RISCVCPU.sv}
vlog -sv -work work +incdir+E:/TEST_LAST {E:/TEST_LAST/RISCVALU.sv}
vlog -sv -work work +incdir+E:/TEST_LAST {E:/TEST_LAST/registerfile.sv}
vlog -sv -work work +incdir+E:/TEST_LAST {E:/TEST_LAST/Mult4to1.sv}
vlog -sv -work work +incdir+E:/TEST_LAST {E:/TEST_LAST/Mult2to1.sv}
vlog -sv -work work +incdir+E:/TEST_LAST {E:/TEST_LAST/flopr.sv}
vlog -sv -work work +incdir+E:/TEST_LAST {E:/TEST_LAST/flopenr.sv}
vlog -sv -work work +incdir+E:/TEST_LAST {E:/TEST_LAST/Datapath.sv}
vlog -sv -work work +incdir+E:/TEST_LAST {E:/TEST_LAST/DataMemory.sv}
vlog -sv -work work +incdir+E:/TEST_LAST {E:/TEST_LAST/Controller.sv}
vlog -sv -work work +incdir+E:/TEST_LAST {E:/TEST_LAST/ALUControl.sv}
vlog -sv -work work +incdir+E:/TEST_LAST {E:/TEST_LAST/pcreg.sv}
