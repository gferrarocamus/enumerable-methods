module Enumerable
    def my_each
      if self.is_a? Array
        for i in 0..self.length-1
            yield self[i]
        end
      elsif self.is_a? Hash
        for k in self.keys
            yield k,self[k]
        end
      end
    end

    def my_each_with_index
      if self.is_a? Array
        for i in 0..self.length-1 do
          yield(self[i], i)
        end
      elsif self.is_a? Hash
        for k in 0..self.keys.length-1
          yield([self.keys[k], self.values[k]], k)
        end
      end
    end
    
end

arr=[1,2,3,4,5,6]

hash = {
    "a"=>1,
    "b"=>2,
    "c"=>3
}

hash.my_each_with_index do |item, a, b|
    puts "#{item} #{a} #{b}"
end


#"string".each {|c| puts c}