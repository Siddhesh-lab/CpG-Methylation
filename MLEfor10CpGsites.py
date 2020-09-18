import random
from datetime import datetime
import numpy as np
from matplotlib import pyplot as plt
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

sims = 100000
percent_list = [i/100 for i in range(100)]
prob_of_p = []

for t in percent_list:
    trials = [np.random.binomial(10, t) for i in range(sims)]
    prob_of_p.append(float(sum([1 for i in trials if i==10*p]))/len(trials))
plt.subplots(figsize=(7,5))
plt.plot(prob_of_p)
plt.xlabel('Percentage Methylated')
plt.ylabel('Probability of p mythylated and p-1 unmethylated')
plt.tight_layout()
plt.show()
plt.savefig('prob_of_9', dpi=150)
