f = open("forecasthourly.txt", "r")

tempatureList = []
startTimeList = []

# for line in f:
#     if line.__contains__("\"temperature\""):
#         # print(line)
#         p = line.split(": ")
#         p = p[1].split(",")
#         x = p[0]
#         tempatureList.append(x)
#         # print(x)
        
for line in f:
    if line.__contains__("\"shortForecast\""):
        # print(line)
        p = line.split(": ")
        p = p[1].split(",")
        x = p[0]
        if x.__contains__("Sunny"):
            x = "Sunny"
        elif x.__contains__("Cloudy"):
            x = "Cloudy"
        elif x.__contains__("Fog"):
            x = "Fog"
        elif x.__contains__("Haze"):
            x = "Fog"
        elif x.__contains__("Mostly Clear"):
            x = "Sunny"
        elif x.__contains__("Chance Light Rain"):
            x = "Rain"
        elif x.__contains__("Light Rain"):
            x = "Rain"
        elif x.__contains__("Rain And Snow"):
            x = "Rain"
        
        
        # tempatureList.append(x)
        print(x)

# for line in f:
#     if line.__contains__("\"startTime\""):
#         # print(line)
#         p = line.split(": ")
#         p = p[1].split(",")
#         x = p[0]
#         j = x.split("T")
#         j = j[1].split("-")
#         j = j[0].split(":")
#         x = j[0]
#         tempatureList.append(x)
#         # print(x)
        
# print(len(tempatureList))