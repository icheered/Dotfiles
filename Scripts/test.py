l1 = 7
o1 = 0
l2 = 8
o2 = 6

i = 0
while True:
    i -= 1
    if i % l1 == o1 and i % l2 == o2:
        print(i)
        break
