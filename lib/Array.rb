class Array
  def my_uniq
    output = []
    self.each do |el|
      output << el unless output.include?(el)
    end

    output
  end

  def two_sum
    output = []
    self.each_with_index do |el, idx|
      (idx+1).upto count-1 do |jdx|
        output << [idx, jdx] if el + self[jdx] == 0
      end
    end
    output

  end

end
