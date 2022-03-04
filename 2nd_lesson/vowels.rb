#4. Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).

str = Range.new('a', 'z').to_a
vowels = ['a', 'e', 'i', 'o', 'u']
v_hash = {}
vowels.each { |vowel| v_hash[vowel] = str.index(vowel) + 1 }