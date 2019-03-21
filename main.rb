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

    def my_select
        if self.is_a? Array
            result=[]
            self.my_each do |item| 
                result.push(item) if yield(item)
            end
            return result
        elsif self.is_a? Hash
            result=Hash.new(0)
            self.my_each do |k, v| 
                result[k]=v if yield(k,v)
            end
            return result
        end     
    end

    def my_all?(option = {})
        result=true
        if block_given?
            if self.is_a? Array         
                self.my_each do |item| 
                    result=false unless yield(item)
                end
            elsif self.is_a? Hash
                self.my_each do |k, v| 
                    result=false unless yield(k,v)
                end            
            end
        else
            if self.is_a? Array         
                self.my_each do |item| 
                    result=false unless item
                end
            elsif self.is_a? Hash
                self.my_each do |k, v| 
                    result=false unless v[k]
                end            
            end
        end
        return result
    end

    def my_any?(option = {})
      result=false
      if block_given?
          if self.is_a? Array         
              self.my_each do |item| 
                  result=true if yield(item)
              end
          elsif self.is_a? Hash
              self.my_each do |k, v| 
                  result=true if yield(k,v)
              end            
          end
      else
          if self.is_a? Array         
              self.my_each do |item| 
                  result=true if item
              end
          elsif self.is_a? Hash
              self.my_each do |k, v| 
                  result=true if v[k]
              end            
          end
      end
      return result
    end

    def my_none?(option = {})
      result=true

      if block_given?
          if self.is_a? Array         
              self.my_each do |item| 
                if yield item 
                  result=false
                  break
                end                  
              end
          elsif self.is_a? Hash
              self.my_each do |k, v| 
                if yield(k,v)
                  result=false
                  break
                end
                  
              end            
          end
      else
          if self.is_a? Array         
              self.my_each do |item| 
                if item  
                  result=false
                  break
                end
              end
          elsif self.is_a? Hash
              self.my_each do |k, v| 
                if v[k]
                  result=false
                  break
                end                  
              end            
          end
      end
      return result
    end
    
    def my_count(arg=nil)
      count = 0
      if block_given?
        if self.is_a? Array
          self.my_each do |item|
            if yield(item)
              count += 1
            end   
          end        
        elsif self.is_a? Hash
          self.my_each do |k,v|
            if yield(k,v)
              count += 1
            end   
          end
        end

      else
        if arg.nil?
          return self.length
        else
          if self.is_a? Array
            self.my_each do |item|
              if item == arg
                count += 1
              end   
            end                  
          elsif self.is_a? Hash
            self.my_each do |k,v|
              if v == arg
                count += 1
              end   
            end
          end
        end
        
        
      end
      return count
end
end


arr=[1,2,3,4,5]

hash = {
    "a"=>1,
    "b"=>2,
    "c"=>3
}

=begin
hash.my_each_with_index do |item, a, b|
    puts "#{item} #{a} #{b}"
end

test = hash.my_select{|k,v| v%2==0 }
"test123".my_each{|i| puts i}
=end

test=arr.my_count{ |x| x%2==0 }
puts test

#"string".each {|c| puts c}