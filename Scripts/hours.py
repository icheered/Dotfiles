import sys

hoursstring = sys.argv[1]
splitstring = hoursstring.split("\n")

hourlist = [splitstring[i] for i in range(2, len(splitstring), 4)]

hours = sum([float((time.split(' ')[0]).replace(",", ".")) for time in hourlist])

hourlyrate = 30 

print(f"Hours: {hours}")
print(f"Total: {hours * hourlyrate}")
