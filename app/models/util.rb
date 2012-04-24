class Util
  class << self
    def js_strlen(str)
      len=0
      i=0
      while i<str.length
        if str[i].ord>255
          len+=2
        else
          len+=1
        end
        i+=1
      end
      return len
    end
    
    def js_chinese(str)
      ret=0
      i=0
      while i<str.length
        if str[i].ord>255
          ret+=1
        end
        i+=1
      end
      return ret
    end
     
  end
end
