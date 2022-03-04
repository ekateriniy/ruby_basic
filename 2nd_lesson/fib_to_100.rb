#3. Заполнить массив числами фибоначчи до 100

n = 0
fib = 0
fib_arr = []

while fib < 100 do
  fib_arr << fib
  n += 1
  if n > 1
    fib = fib_arr[n - 1] + fib_arr[n - 2]
  else
    fib += 1
  end
end