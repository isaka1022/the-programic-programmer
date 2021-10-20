assert result != null && result.size() > 0 : "Empty result from XYZ"

books = my_sort(find("scifi"))
assert(is_sorted?(books))

puts ("Enter 'Y' or 'N' : ")
ans = gets[0]
asset((ch == 'Y') || ( ch == 'N')) // エラーハンドリングに表明を使ってはいけない


while(iter.hasMoreElements()) {
  assert(iter.nextElement() != null); // .nextElement()の呼び出しが次に取得されるはずの要素を読み取ってしまう
  Object obj = iter.nextElement(); 
  // ...
}

while( iter.hasMoreElements()) {
  Object obj = iter.nextElement(); 
  assert(iter.nextElement() != null); // .nextElement()の呼び出しが次に取得されるはずの要素を読み取ってしまう
  // ... 
}
