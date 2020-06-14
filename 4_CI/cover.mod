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


# Current total number of cover inequalities
param nc default 0;
# Set of indices for the cover inequalities
set C := 1..nc;
# Set of items composing each cover
set CI{C} within 1..N;

#-------------------------------------------------
#                Linear Relaxation
#-------------------------------------------------

# different (but equivalent) formulation w.r.t 1_ILP.
# here we use a separated consistency constraint instead of multiplying
# the right part of capacity inequalities by y[j].

var x{1..N, 1..M} >= 0, <= 1;

var y{1..M} >= 0, <= 1;

minimize Installed_VMs:
	sum{j in 1..M} y[j];

subject to Assignment {i in 1..N}:
	sum{j in 1..M} x[i,j] >= 1;

subject to Traffic {j in 1..M}:
	sum{i in 1..N} w[i]*x[i,j] <= B_c*y[j];

subject to Cpu{j in 1..M}:
	sum{i in 1..N} cpu[i]*x[i,j] <= B_CPU*y[j];

subject to Memory{j in 1..M}:
	sum{i in 1..N} m[i]*x[i,j] <= B_m*y[j];
    
subject to Cover {c in C, j in 1..M}:
	sum {i in CI[c]} x[i,j] <= y[j]*(card(CI[c])-1);

#--------------------------------------------------
#                 Separation problem
#--------------------------------------------------

# solution of the relaxation
param x_star{1..N}; #>= 0, <= 1;

# weights of the constraint we are considering (could be equal to c, cpu or m)
param a{1..N} default 1;

# right hand side of the constraint we are considering
param B default N;

# It's 1 if the variable is in the cover
var u{1..N} binary;

minimize Violation: 
	sum {i in 1..N} (1 - x_star[i])*u[i];

subject to CoverConditionTraffic:
    sum{i in 1..N} w[i]*u[i] >= B_c + 1;

subject to CoverConditionCpu:
    sum{i in 1..N} cpu[i]*u[i] >= B_CPU + 1;

subject to CoverConditionMemory:
    sum{i in 1..N} m[i]*u[i] >= B_m + 1;