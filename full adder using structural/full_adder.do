add wave carry_in
add wave input1
add wave input2
add wave sum_out
add wave carry_out
add wave carry1
add wave carry2
add wave sum_int
force input1 0
force input2 0
force carry_in 0
run
force input1 0
force input2 0
force carry_in 1
run
force input1 0
force input2 1
force carry_in 0
run 
force input1 0
force input2 1
force carry_in 1
run
force input1 1
force input2 0
force carry_in 0
run
force input1 1
force input2 0
force carry_in 1
run
force input1 1
force input2 1
force carry_in 0
run
force input1 1
force input2 1
force carry_in 1
run
