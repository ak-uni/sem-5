file_name = input("Enter the input file name: ")
input_file = open(file_name, "r")

rhs_dict = {}

line = input_file.readline()
while line:
    line = line.split(" = ")
    rhs = line[-1].replace("\n", "")
    optim_rhs = rhs_dict.get(rhs, rhs)
    if optim_rhs == rhs:
        rhs_dict[rhs] = line[0]
    print(line[0], "=", optim_rhs)
    line = input_file.readline()