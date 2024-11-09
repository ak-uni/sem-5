from collections import defaultdict, deque

class Operation:
    def __init__(self, id, result, operands):
        self.id = id                
        self.result = result        
        self.operands = operands    
        self.scheduled = False      
        self.dependencies = set()   
        self.dependents = set()     

instructions = [
    "t1 = a + b",
    "t2 = t1 * c",
    "t3 = d + e",
    "t4 = t3 - f",
    "t5 = t2 + t4"
]

operations = []
var_to_op = {}

for i, inst in enumerate(instructions):
    parts = inst.replace(" ", "").split("=")
    result = parts[0]
    expression = parts[1]
    operands = []
    
    for op in ['+', '-', '*', '/']:
        if op in expression:
            operands = expression.split(op)
            break
            
    op = Operation(i + 1, result, operands)
    operations.append(op)
    var_to_op[result] = op

for op in operations:
    for operand in op.operands:
        if operand in var_to_op:
            producer = var_to_op[operand]
            op.dependencies.add(producer)
            producer.dependents.add(op)

ready = deque([op for op in operations if not op.dependencies])
scheduled = []

while ready:
    current = ready.popleft()
    current.scheduled = True
    scheduled.append(current)
    
    for dependent in current.dependents:
        if all(dep.scheduled for dep in dependent.dependencies) and not dependent.scheduled:
            ready.append(dependent)

result = []
for op in scheduled:
    result.append(instructions[op.id - 1])

print("Original Instructions:")
for i, inst in enumerate(instructions, 1):
    print(f"{i}. {inst}")
    
print("\nScheduled Instructions:")
for i, inst in enumerate(result, 1):
    print(f"{i}. {inst}")