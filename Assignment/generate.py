from random import randint

N 		= 50
M 		= 50
B_c 	= 1000
B_cpu 	= 1000
B_m 	= 1000

print('\nparam N:= {};'.format(N))
print('\nparam M:= {};'.format(M))
print('\nparam B_c:= {};'.format(B_c))
print('\nparam B_CPU:= {};'.format(B_cpu))
print('\nparam B_m:= {};'.format(B_m))
print("\nparam: w cpu m:= ")

for i in range(1,N+1):
	c 	= randint(1, B_c/2)
	cpu = randint(1, B_cpu/2)
	m 	= randint(1, B_m/2)
	print("{}\t{}\t{}\t{}".format(i, c, cpu, m))

print(";")
