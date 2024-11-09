from collections import deque, namedtuple
from typing import NamedTuple

EPSILON = "Ɛ"
END_MARKER = "$"

LRItem = NamedTuple('LRItem', [('head', str), ('body', str), ('lookahead', frozenset), ('pos', int)])
Action = namedtuple('Action', ['action', 'num', 'head', 'body'])

def compute_first(var: str) -> set[str]:
    if not var.isupper() or var == EPSILON:
        return {var}
    if var in first:
        return first[var]
    
    first_var = set()
    body = productions.get(var, [var])
    
    for production in body:
        for symbol in production:
            first_sym = compute_first(symbol)
            first_var |= first_sym - {EPSILON}
            if EPSILON not in first_sym:
                break
        else:
            first_var.add(EPSILON)
    return first_var

class CLR:
    def __init__(self):
        self._start_symbol = next(iter(productions))
        self._lr_items = []
        self._action_map = {}
        self._parsing_table = {}
        self._augmented_start = "START"
        self._compute_lr1_items()
        self._compute_parsing_table()

    def _lookahead(self, beta: str, alpha: frozenset) -> frozenset:
        lookahead = compute_first(beta) if beta else set()
        return frozenset(lookahead | alpha)

    def _closure(self, item: LRItem) -> list:
        items = [item]
        if item.pos == len(item.body):
            return items
            
        cur_sym = item.body[item.pos]
        if cur_sym.isupper() and cur_sym != EPSILON:
            for rule in productions[cur_sym]:
                items.extend(self._closure(LRItem(cur_sym, rule, 
                    self._lookahead(item.body[item.pos + 1:], item.lookahead), 0)))
        return items

    def _compute_lr1_items(self):
        i0 = self._closure(LRItem(self._augmented_start, self._start_symbol, 
            frozenset({END_MARKER}), 0))
        self._lr_items.append(i0)
        q = deque(i0)

        while q:
            item = q.popleft()
            if item in self._action_map:
                continue
            if item.pos >= len(item.body):
                continue
                
            new_items = self._closure(LRItem(item.head, item.body, item.lookahead, item.pos + 1))
            if new_items:
                self._action_map[item] = len(self._lr_items)
                self._lr_items.append(new_items)
                q.extend(new_items)

    def _compute_parsing_table(self):
        for i, items in enumerate(self._lr_items):
            for item in items:
                if item.pos == len(item.body):
                    for sym in item.lookahead:
                        self._parsing_table[i, sym] = Action('reduce', 0, item.head, item.body)
                else:
                    cur_sym = item.body[item.pos]
                    self._parsing_table[i, cur_sym] = Action(
                        'goto' if cur_sym.isupper() else 'shift',
                        self._action_map[item], item.head, item.body)

    def parse(self, word: str):
        stack = deque([0])
        word = f'{word}{END_MARKER}'
        buf = iter(word)
        pointer = next(buf)
        loc = 0

        while stack:
            state = stack[-1]
            action = self._parsing_table[state, pointer]
            
            if action.action == 'shift':
                stack.extend([pointer, action.num])
                pointer = next(buf)
                loc += 1
            elif action.action == 'reduce':
                stack = deque(list(stack)[:-len(action.body) * 2])
                if action.head != self._augmented_start:
                    goto_action = self._parsing_table[stack[-1], action.head]
                    stack.extend([action.head, goto_action.num])
                else:
                    break
            else:
                stack.pop()
                stack.append(action.num)

productions = {
    'S': ['CC'],
    'C': ['aC', 'b'],
}
first = {
    'S': {'a', 'b'},
    'C': {'a', 'b'},
}

parser = CLR()
