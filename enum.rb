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
      self.my_flatten
    else
      output.push(x)
    end
  end
  output
end


end
a = [1,2,3]

p a.my_all? { |num| num < 4 } # => true
