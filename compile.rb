require_relative 'pasxx'

if ARGV.size < 1 then
  puts "usage: #{$prog_name} [FILENAME]"
  exit
end

File.open(ARGV[0]) {|f|
  puts <<"EOS"
PUSH 0
PUSH 0
PUSH 2
EOS
  while line = f.gets
    line.chomp!
    next if line == "" or line[0] == "#"
    args = line.split(" ")
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
        roll_imm(args[1].to_i, args[2].to_i)
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
}
