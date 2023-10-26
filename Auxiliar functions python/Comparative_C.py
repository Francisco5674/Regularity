import csv

Record = {}
Codes = {}

with open("Outputs\Regular_intercept.csv", 'r', encoding="utf-8") as file:
  reader = csv.reader(file)
  id = 1
  next(reader)
  for line in reader:
    L = float(line[0])
    H = float(line[1])
    Tau = float(line[3])
    C = int(line[2])
    try:
      mu = float(line[4])
    except:
      mu = "."
    code = [L,H,Tau]
    if not (code in Codes.values()):
      Codes[id] = code
      Record[id] = [[C,mu]]
      id += 1
    else:
      key_list = list(Codes.keys())
      val_list = list(Codes.values())
      key = key_list[val_list.index(code)]
      Record[key].append([C,mu])

for id in Record.keys():
  Record[id] = sorted(Record[id], key = lambda x: x[0])
  print(id)

with open("Auxiliar CSV/Stat_C.csv", mode= "w", encoding= "utf-8") as file:
  for id in Record.keys():
    muintercept = [i[1] for i in Record[id]]
    parameters = Codes[id]
    data = parameters + muintercept
    data = [str(j) for j in data]
    file.write((",").join(data) + "\n")

