require_relative 'sub_commands'

def push_impl(op)
  op + "\n" +
  sink +
  inc
end

def push(n)
  push_impl("PUSH #{n}")
end

def pop(op)
  float +
  op + "\n" +
  dec
end

def not_op
  float +
  "NOT\n" +
  sink
end

def dup
  float +
  "DUP\n" +
  sink(2) +
  inc
end

def roll
  float +
  "DUP\n" +
  roll_imm(4, 1) +
  <<"EOS" +
PUSH 4
ADD
PUSH 2
ROLL
SWAP
PUSH 2
ADD
SWAP
ROLL
EOS
  dec(2)
end

def halt
  "HALT\n"
end

def label(word)
  "LABEL #{word}\n"
end

def jez(word)
  dec +
  float +
  "JEZ #{word}\n"
end

def jmp(word)
  "JMP #{word}\n"
end

def swap
  float(2) +
  "SWAP\n" +
  sink(2)
end

def toggle
  "SWAP\n" +
  "DUP\n" +
  roll_imm(3, 2) +
  "DUP\n" +
  roll_imm(3, 1) +
  <<"EOS" +
PUSH 3
ADD
PUSH 1
ROLL
PUSH 1
ADD
SWAP
DUP
EOS
  roll_imm(3, 1) +
  <<"EOS"
PUSH 1
ADD
ROLL
EOS
end

def size
  <<"EOS" +
SWAP
DUP
EOS
  sink +
  "SWAP\n" +
  inc
end

def new_stack
  <<"EOS"
PUSH 0
SWAP
PUSH 1
ADD
EOS
end
