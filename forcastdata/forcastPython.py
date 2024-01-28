f = open("forecasthourly.txt", "r")

tempatureList = []
startTimeList = []

for line in f:
    if line.__contains__("\"temperature\""):
        # print(line)
        p = line.split(": ")
        p = p[1].split(",")
        x = p[0]
        tempatureList.append(x)
        print(x)
        
for line in f:
    if line.__contains__("\"temperature\""):
        # print(line)
        p = line.split(": ")
        p = p[1].split(",")
        x = p[0]
        tempatureList.append(x)
        print(x)

for line in f:
    if line.__contains__("\"startTime\""):
        # print(line)
        p = line.split(": ")
        p = p[1].split(",")
        x = p[0]
        j = x.split("T")
        j = j[1].split("-")
        j = j[0].split(":")
        x = j[0]
        tempatureList.append(x)
        print(x)
        
print(len(tempatureList))
        
# for i in tempatureList:
#     temp = i.split(",")
#     print(temp)
#     print(i)
    # elif line.__contains__("\"startTime\""):
    #     print(line)
    #     startTimeList.__add__(line)