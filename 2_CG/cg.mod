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

#number of clusters
param S default N;

#cluster composition
param s{1..N,1..S}  default 0;

#request profit for the pricing problem
#calculated as the optimal value of the dual variables of
#the current master problem
param pi{1..N} >=0 default 0;


    #####################
    #       master	    #
    #####################
    
var l{1..S}, >=0, <= 1;

minimize set_CG: 
	sum{i in 1..S} l[i];
	
subject to cover{i in 1..N}: 
	sum{j in 1..S} s[i,j]*l[j] >= 1;

	#####################
	#  PRICING PROBLEM	#
	#####################	

var u{1..N}, binary;

maximize profit:
	sum{i in 1..N} pi[i]*u[i];

subject to Traffic: 
	sum{i in 1..N} u[i]*w[i] <= B_c;
 
subject to CPU: 
	sum{i in 1..N} u[i]*cpu[i] <= B_CPU;

subject to Memory: 
	sum{i in 1..N} u[i]*m[i] <=  B_m ;
    

#PROBLEM DEFINITION

problem master: l, set_CG, cover; 

problem pricing: u, profit, Traffic, CPU, Memory;
