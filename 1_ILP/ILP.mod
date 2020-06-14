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

#---------------------------------
# Integer Linear Programming model
#---------------------------------

var x{1..N,1..M} >= 0, <= 1; #binary;

var y{1..M} >= 0, <= 1; #binary;

minimize Installed_VMs:
	sum{j in 1..M} y[j];

subject to Assignment {i in 1..N}:
	sum{j in 1..M} x[i,j] = 1;

subject to Traffic {j in 1..M}:
	sum{i in 1..N} w[i]*x[i,j] <= B_c * y[j];

subject to Cpu{j in 1..M}:
	sum{i in 1..N} cpu[i]*x[i,j] <= B_CPU * y[j];

subject to Memory{j in 1..M}:
	sum{i in 1..N} m[i]*x[i,j] <= B_m * y[j];