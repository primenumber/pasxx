require_relative 'pasxx'

if ARGV.size < 1 then
  puts "usage: #{$prog_name} [FILENAME]"
  exit
end

def process_command(args, macros)
  return macros[args[0]] if macros[args[0]] != nil
  case args[0]
  when "ADD","SUB","MUL","DIV","MOD","GREATER"
    bin_op(args[0])
  when "PUSH"
    push(args[1].to_i)
  when "POP","OUTN","OUTC"
    pop(args[0])
  when "NOT"
    not_op
  when "DUP"
    dup
  when "ROLL"
    if args.size == 3 then
      push(args[1].to_i)
      push(args[2].to_i)
    end
    roll
  when "INN","INC"
    push_impl(args[0])
  when "HALT"
    halt
  when "LABEL"
    label(args[1])
  when "JEZ"
    jez(args[1])
  when "JMP"
    jmp(args[1])
  when "SWAP"
    swap
  when "TOGGLE"
    toggle
  when "SIZE"
    size
  when "NEW"
    new_stack
  end
end

def define_macro(file, name, macros)
  str = ""
  while line = f.gets
    line.chomp!
    break if line == "end"
    str += process_command(line.split(" "), macros)
  end
  macros[name] = str
end

File.open(ARGV[0]) {|f|
  macros = {}
  puts <<"EOS"
PUSH 0
PUSH 0
PUSH 2
EOS
  while line = f.gets
    line.chomp!
    next nil if line == "" or line[0] == "#"
    args = line.split(" ")
    if args[0] == "def" then
      define_macro(f, args[1], macros)
    else
      puts process_command(args, macros)
    end
  end
}
