import random
from datetime import datetime
random.seed(datetime.now())
p = float(input("Enter the probability of methylation: "))
Return = ""
count = 0
N = 10
for j in range(0,N):
    Return = ""
    for i in range(0,10):
            r = random.randint(0,100)
            if r/100 < p:
                Return = Return + 'm'
            else:
                Return = Return + 'u'
            if(Return[i] == 'm'):
                count=count+1
    print(Return)

print("Average no. of methylated CGs in a sequence = {}".format(count/N))
