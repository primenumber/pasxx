# スタックの長さを1増やす
def inc(num=1)
  puts <<"EOS"
PUSH #{num}
ADD
SWAP
PUSH #{num}
ADD
SWAP
EOS
end

# スタックの長さを1減らす
def dec(num=1)
  puts <<"EOS"
PUSH #{num}
SUB
SWAP
PUSH #{num}
SUB
SWAP
EOS
end

# 即値roll
def roll_imm(dep, rots)
  puts <<"EOS"
PUSH #{dep}
PUSH #{rots}
ROLL
EOS
end

# サイズ情報の下に値を沈める
def sink(dep=1)
  roll_imm(dep+2, dep)
end

# サイズ情報の上に値を浮かせる
def float(dep=1)
  roll_imm(dep+2, 2)
end

# 二項演算
def bin_op(op)
  float(2)
  puts op
  sink
  dec
end
