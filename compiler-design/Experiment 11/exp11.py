class Variable:
    def __init__(self, name):
        self.name = name
        self.neighbors = set()
        self.color = None
        self.live_range = [float('inf'), -float('inf')]

REGISTERS = ['R1', 'R2', 'R3']
instructions = [
    "a = b + c",
    "d = a + e",
    "f = d + g",
    "h = f + i"
]

variables = {}
def get_variable(name):
    if name not in variables:
        variables[name] = Variable(name)
    return variables[name]

for idx, instr in enumerate(instructions):
    parts = instr.replace(" ", "").split("=")
    result = parts[0]
    operands = parts[1].split("+")
    
    result_var = get_variable(result)
    result_var.live_range[0] = min(result_var.live_range[0], idx)
    result_var.live_range[1] = max(result_var.live_range[1], idx)
    
    for op in operands:
        op_var = get_variable(op)
        op_var.live_range[0] = min(op_var.live_range[0], idx)
        op_var.live_range[1] = max(op_var.live_range[1], idx)

var_list = list(variables.values())
for i in range(len(var_list)):
    for j in range(i + 1, len(var_list)):
        var1 = var_list[i]
        var2 = var_list[j]
        
        if not (var1.live_range[1] < var2.live_range[0] or 
                var2.live_range[1] < var1.live_range[0]):
            var1.neighbors.add(var2)
            var2.neighbors.add(var1)

sorted_vars = sorted(variables.values(), 
                    key=lambda x: len(x.neighbors), 
                    reverse=True)

for var in sorted_vars:
    used_colors = {n.color for n in var.neighbors if n.color is not None}
    available_colors = set(range(len(REGISTERS))) - used_colors
    
    if available_colors:
        var.color = min(available_colors)
    else:
        var.color = None

current_allocation = {}
print("\nRegister Allocation by Instruction:")
for idx, instr in enumerate(instructions, 1):
    parts = instr.replace(" ", "").split("=")
    result = parts[0]
    operands = parts[1].split("+")
    
    allocation_str = []
    
    if variables[result].color is not None:
        allocation_str.append(f"{result} -> {REGISTERS[variables[result].color]}")
    
    for op in operands:
        if variables[op].color is not None:
            allocation_str.append(f"{op} -> {REGISTERS[variables[op].color]}")
    
    print(f"{idx}. {', '.join(allocation_str)}")