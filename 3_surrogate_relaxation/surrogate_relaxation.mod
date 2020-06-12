#PARAMETERS

#number of requests
param N;

#number of virtual machine
param M;

#request traffic
param w{1..N};

#request CPU requirement
param cpu{1..N} default 1;

#request memory requirement
param m{1..N} default 1;

#VM capacity
param B_c;
#VM max CPU
param B_CPU default N;
#VM max memory
param B_m default N;

# surrogate relaxation multipliers
param m1{1..M} default 1;
param m2{1..M} default 1;
param m3{1..M} default 1;

# step for updating multipliers
param t default 1;
param max_iter default 1000;
param max_iter_without_improvement default 200;

#---------------------------------
# Integer Linear Programming model
#---------------------------------

var x{1..N,1..M} binary;

var y{1..M} binary;

minimize Installed_VMs:
	sum{j in 1..M} y[j];

subject to Assignment {i in 1..N}:
	sum{j in 1..M} x[i,j] = 1;

#---------------------------------
# Surrogate Relaxation constraint
#---------------------------------

#surrogate relaxation constraint
subject to SurrogateCapacity{j in 1..M}:
	sum{i in 1..N} m1[j] * w[i] * x[i,j] + 
	sum{i in 1..N} m2[j] * cpu[i] * x[i,j] + 
	sum{i in 1..N} m3[j] * m[i] * x[i,j] 
	<= (m1[j] * B_c + m2[j] * B_CPU + m3[j] * B_m) * y[j];
