import random
from datetime import datetime
import numpy as np
from matplotlib import pyplot as plt
random.seed(datetime.now())
p1 = float(input("Enter the probability of methylation for list 1: "))
p2 = float(input("Enter the probability of methylation for list 2: "))
Return1 = ""
Return2 = ""
count1 = 0
count2 = 0
N = 100000
list1 = []
list2 = []
for j in range(0,N):
    Return1 = ""
    Return2 = ""
    for i in range(0,10):
            r1 = random.randint(0,101)
            r2 = random.randint(0,101)
            if r1/100 < p1:
                Return1 = Return1 + 'm'
            else:
                Return1 = Return1 + 'u'
            if(Return1[i] == 'm'):
                count1=count1+1
            if r2/100 < p2:
                Return2 = Return2 + 'm'
            else:
                Return2 = Return2 + 'u'
            if(Return2[i] == 'm'):
                count2=count2+1
    list1.append(Return1)
    list2.append(Return2)
#print(list1)
#print(list2)
print("Average no. of methylated CGs in sequence 1 = {}".format(count1/N))
print("Average no. of methylated CGs in sequence 2 = {}".format(count2/N))

list = list1 + list2
random.shuffle(list)
#print(list)
count = 0
list_count=[]
for i in list:
    count = 0
    for j in i:
        if j=='m':
            count=count+1
    list_count.append(count)

plt.subplots(figsize=(7,5))
plt.hist(list_count, 10)
plt.ylabel('Frequency of Methylated CGs')
plt.xlabel('No of Methylated CGs')
plt.tight_layout()
plt.show()
