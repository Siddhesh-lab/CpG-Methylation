import random
from datetime import datetime
random.seed(datetime.now())
p = float(input("Enter the probability of methylation: "))
print()
print("Seq. No.      Methy  Unmethy")
Return = ""
count = 0
countm = 0
N = 1000
for j in range(0,N):
    Return = ""
    #print("  {}".format(j))
    countm = 0
    for i in range(0,10):
            r = random.randint(0,100)
            if r/100 < p:
                Return = Return + 'm'
            else:
                Return = Return + 'u'
            if(Return[i] == 'm'):
                count=count+1
                countm = countm + 1

    print("   {}\t\t{}\t{}".format(j+1,countm,10-countm))
    #print("     {}".format(10 - countm))
    #print(Return)

print()
print("Average no. of methylated CGs in a sequence = {}".format(count/N))
