def my_transpose(matrix)
  output = []

  matrix.count.times do |i|
    new_array = []
    matrix.each do |row|
      next if row[i].nil?
      new_array << row[i]
    end
    output << new_array.dup
  end

  output
end
