module Enumerable
    def my_each
      if self.is_a? Array
        for i in self
            yield self[i]
        end
      elsif self.is_a? Hash
        for k in self.keys
            yield k,self[k]
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

hash.my_each do |item, v|
    puts "#{item}, #{v}"
end

"string".each {|c| puts c}