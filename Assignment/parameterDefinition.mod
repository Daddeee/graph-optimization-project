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