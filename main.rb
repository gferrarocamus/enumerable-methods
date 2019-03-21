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

    def my_all?(*arg)
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
        elsif arg.empty?        
            if self.is_a? Array         
                self.my_each do |item| 
                    result=false unless item
                end
            elsif self.is_a? Hash
                self.my_each do |k, v| 
                    result=false unless v[k]
                end            
            end
        else
            arg.my_each do |a|
                if self.is_a? Array         
                    self.my_each do |item| 
                        result=false unless item==a
                    end
                elsif self.is_a? Hash
                    self.my_each do |k, v| 
                        result=false unless v[k]==a
                    end            
                end
            end
        end
        return result
    end

    def my_any?(*arg)
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
      elsif arg.empty?
          if self.is_a? Array         
              self.my_each do |item| 
                  result=true if item
              end
          elsif self.is_a? Hash
              self.my_each do |k, v| 
                  result=true if v[k]
              end            
          end
      else
        arg.my_each do |a|
            if self.is_a? Array         
                self.my_each do |item| 
                    result=true if item==a
                end
            elsif self.is_a? Hash
                self.my_each do |k, v| 
                    result=true if v[k]==a
                end            
            end
      end
      end
      return result
    end

    def my_none?(*arg)
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
        elsif arg.empty?
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
      else
        arg.my_each do |a|
            if self.is_a? Array         
                self.my_each do |item| 
                    if item == a 
                        result=false
                        break
                    end
                end
            elsif self.is_a? Hash
                self.my_each do |k, v| 
                    if v[k] == a
                        result=false
                        break
                    end                  
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

    def my_map
        return to_enum(:my_map) unless block_given?
        result=[]
        if self.is_a? Range
            arr = self.to_a 
            arr.my_each do |item| 
                result.push(yield(item)) 
            end
        elsif self.is_a? Array
            self.my_each do |item| 
                result.push(yield(item)) 
            end
        elsif self.is_a? Hash
            self.my_each do |k, v| 
                result.push(yield(k,v))
            end
        end
        return result
    end
end