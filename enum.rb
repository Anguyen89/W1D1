class Array

def myEach(&prc)
  self.length.times do |x|
    prc.call(self[x])
  end
  self
end


def my_select(&prc)
  output = []
  self.myEach do |x|
    output << x if prc.call(x)
  end
  output
end

def my_reject(&prc)
  output = []
  self.myEach do |x|
    output << x unless prc.call(x)
  end
  output
end


def my_any?(&prc)
  self.myEach do |x|
    return true if prc.call(x)
  end
  false
end

def my_all?(&prc)
  self.myEach do |x|
    return false unless prc.call(x)
  end
  true
end

def my_flatten
  output = []
  self.myEach do |x|
    if x.is_a?(Array)
      output += x.my_flatten
    else
      output.push(x)
    end
  end
  output
end

def my_zip(a,b)
  output = []
  arr = [self, a, b]
  (0...arr.length).each do |x|
    output.push([])
  end

  (0...arr.length).each do |row|
    (0...arr.length).each do |column|
      output[row] << arr[column][row]
    end
  end

  output
end

def my_join(item = "")
  output = ""
  self.length.times do |x|
    output += self[x]
    output += item unless x === self.length - 1
  end

  output
end

def my_reverse
  output = []
  (self.length - 1).downto(0).each do |x|
    output << self[x]
  end
  output
end

end

def factors(num)
  output = []
  (1...num).each do |int|
    if num % int == 0
      output << int
    end
  end
  output
end

# def bubblesort(array)
#   output = []
#   (0...array.length).each do |x|
#     (x + 1...array.length).each do |y|
#       if array[y] > array[y - 1] &&
#
# end

def substrings(str)
  output = []
  (0...str.length).each do |x|
    (x+1...str.length).each do |y|
      output << str[x..y]
    end
  end
  output
end

def subwords(word, dictionary)
  subs = substrings(word)
  if subs.include?(word)
    return true
  end
  false
end


a = [ "a", "b", "c", "d" ]
b = [ 7, 8, 9 ]
p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
[1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

p factors(10)

p subwords("batcabtarbrat", ["rat"])
