class Array
  def my_uniq
    results = []
    self.each do |el|
      results << el unless results.include?(el)
    end

    results
  end

  def two_sum
    results = []
    hash = {}
    self.each_with_index do |el, idx|
      if hash[-el]
        hash[-el].each { |idx2| results << [idx2, idx] }
      end

      hash[el] = (hash[el] || []) << idx
    end

    results.sort
  end

  def my_transpose
    results = Array.new(self.first.length){[]}
    self.each_with_index do |row, r_idx|
      row.each_with_index do |el, c_idx|
        results[c_idx][r_idx] = el
      end
    end
    results
  end

  def stock_picker
    return [] if self.uniq.length == 1
    lowest_so_far = [0, self.first]
    highest_so_far = [-1, 0]
    best_case = [lowest_so_far, highest_so_far]

    each_with_index do |el, idx|
      if el <= lowest_so_far[1]
        if highest_so_far[1] - lowest_so_far[1] > best_case[1][1] - best_case[0][1]
          best_case = [lowest_so_far, highest_so_far]
        end
        lowest_so_far = [idx, el]
        highest_so_far = [-1, 0]
      elsif el > highest_so_far[1]
        highest_so_far = [idx, el]
      end
    end

    if highest_so_far[1] - lowest_so_far[1] > best_case[1][1] - best_case[0][1]
      best_case = [lowest_so_far, highest_so_far]
    end
    [best_case[0][0], best_case[1][0]]
  end
end
