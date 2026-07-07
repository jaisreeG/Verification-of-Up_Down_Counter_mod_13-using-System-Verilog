# Makefile for MiniProject - Regression Testing - Mod - 13 Up_Down Loadable Counter

# SIMULATOR = Questa for Mentor's Questasim
# SIMULATOR = VCS for Synopsys's VCS

SIMULATOR = Questa
FSDB_PATH = /home/cad/eda/SYNOPSYS/VERDI_2022/verdi/T-2022.06-SP1/share/PLI/VCS/LINUX64
RTL = ../rtl/up_down_counter_mod13.v
work = work #library name
SVTB1 = ../env_lib/counter_if.sv
INC = +incdir+../env +incdir+../env_lib +incdir+../test
SVTB2 = ../test/counter_pkg.sv ../test/top.sv
COVOP = -coveropt 3 +cover=bcft
VSIMOPT= -vopt -voptargs=+acc
VSIMCOV= -coverage -sva
VSIMBATCH1= -c -do  " log -r /* ;coverage save -onexit mem_cov1;run -all; exit"
VSIMBATCH2= -c -do  " log -r /* ;coverage save -onexit mem_cov2;run -all; exit"
VSIMBATCH3= -c -do  " log -r /* ;coverage save -onexit mem_cov3;run -all; exit"
VSIMBATCH4= -c -do  " log -r /* ;coverage save -onexit mem_cov4;run -all; exit"

help:
        @echo ===========================================================================================================
        @echo " USAGE          =>  make target"
        @echo " clean          =>  clean the earlier log and intermediate files"
        @echo " sv_cmp         =>  Create library and compile the code"
        @echo " TC1            =>  Compile and run testcase1 in batch mode"
        @echo " report_1       =>  Merge coverage reports and generate html"
        @echo " covhtml        =>  View coverage report in firefox"
        @echo " covtxt         =>  View coverage report in text editor [VCS only]"
        @echo " cov_verdi      =>  View coverage report in verdi [VCS only]"
        @echo " wave           =>  Open waveform (wave_file1.wlf)"
        @echo ===========================================================================================================


clean : clean_$(SIMULATOR)
sv_cmp : sv_cmp_$(SIMULATOR)
TC1 : TC1_$(SIMULATOR)
report_1 : report_1_$(SIMULATOR)
view_wave : view_wave_$(SIMULATOR)
covhtml : covhtml_$(SIMULATOR)
covtxt: covtxt_$(SIMULATOR)
cov_verdi: cov_verdi_$(SIMULATOR)
wave: wave_$(SIMULATOR)

# ---- Start of Definitions for Mentor's Questa Specific Targets -----#

sv_cmp_Questa:
        vlib $(work)
        vmap work $(work)
        vlog -work $(work) $(RTL) $(INC) $(SVTB2) $(SVTB1) $(COVOP)

TC1_Questa:sv_cmp_Questa
        vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH1)  -wlf wave_file1.wlf -l test1.log  -sv_seed 362739486 work.top +TEST1
        vcover report  -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov1

report_1_Questa:
        vcover merge mem_cov mem_cov1
        vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov


covhtml_Questa:
         firefox covhtmlreport/index.html&

clean_Questa:
        rm -rf transcript* *log* fcover* covhtml* mem_cov* *.wlf modelsim.ini work
        clear

wave_Questa:
        vsim -view wave_file1.wlf

# ---- End of Definitions for Mentor's Questa Specific Targets -----#
