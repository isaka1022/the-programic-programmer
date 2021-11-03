puts "Enter a file name"

name = gets

system("wc -c #{name")

# 悪質なユーザーは以下のような入力を行う
# test.dat ; rm -rf /

# SAFEレベルを1にしておくことで防ぐ
