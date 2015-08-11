require_relative 'sub_commands'

def push_impl(op)
  puts op
  sink
  inc
end

def push(n)
  push_impl("PUSH #{n}")
end

def pop(op)
  float
  puts op
  dec
end

def not_op
  float
  puts "NOT"
  sink
end

def dup
  float
  puts "DUP"
  sink(2)
  inc
end

def roll
  float
  puts "DUP"
  roll_imm(4, 1)
  puts <<"EOS"
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
  puts "HALT"
end

def label(word)
  puts "LABEL #{word}"
end

def jez(word)
  dec
  float
  puts "JEZ #{word}"
end

def jmp(word)
  puts "JMP #{word}"
end

def swap
  float(2)
  puts "SWAP"
  sink(2)
end

def toggle
  puts "SWAP"
  puts "DUP"
  roll_imm(3, 2)
  puts "DUP"
  roll_imm(3, 1)
  puts <<"EOS"
PUSH 3
ADD
PUSH 1
ROLL
PUSH 1
ADD
SWAP
DUP
EOS
  roll_imm(3, 1)
  puts <<"EOS"
PUSH 1
ADD
ROLL
EOS
end

def size
  puts <<"EOS"
SWAP
DUP
EOS
  sink
  puts "SWAP"
  inc
end

def new_stack
  puts <<"EOS"
PUSH 0
SWAP
PUSH 1
ADD
EOS
end
