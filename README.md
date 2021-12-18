# COEN313--VHDL---Digital-system-II
This is all VHDL (very fast hardware desriptive language), that needed to be run on linux os. 
My coding style involves the use of entity and components relationship. For exp, the 'sum_of_minterms' entity use architecture of components 'andgate' and 'orgate', and for that, I needed to define what'andgate' and 'orgate' components made off. Hence, I also have the VHDL code for entity of component 'andgate' and 'orgate'.
The constraint file .xdc is to map what inputs, outputs to what pins on a FPGA board. Unless you wanna synthesize your code, you dont have to use it if ya just stimulate it.

COEN 313

Setup Modelsim environment:
    source /CMC/ENVIRONMENT/modelsim.env

Create work library:
    vlib work
Note: needs to be performed only once before compiling and before running any simulation

Compile VHDL source code:
    vcom name_of_VHDL_source_file 

Run commandline VHDL simulation:
    vsim -c name_of_the_entity
Note: the directory should have the same name as that of the VHDL architecture source code

Run commandline VHDL simulation:
    vsim -c -do directory_to_where_the_DO_file_resides name_of_the_entity

Format for lab report:
LAB COEN313 FM LAB# student_NO
