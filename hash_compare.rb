class HashCompare
  def initialize(hash1, hash2, mode = 'shallow')
    @hash1 = hash1
    @hash2 = hash2
    @mode = mode
  end

  def hash_compare
    return {} if @hash1 == @hash2

    compare_logic(@hash1, @hash2, @mode)
  end

  def compare_logic(hash1, hash2, mode)
    iterator_hash, comparator_hash = hash1.size >= hash2.size ? [hash1, hash2] : [hash2, hash1]
    result = {}

    iterator_hash.each do |k, v|
      
      # check existence and equality before processing
      if comparator_hash[k] != v 
        #confirm processing level and object type
        if mode == 'deep' && comparator_hash[k].is_a?(Hash) 
          #recursive call for nested value compare
          result[k] = compare_logic(v, comparator_hash[k], mode)
        else
          result[k] =  comparator_hash[k] || v 
        end
      end
    end

    # check for orphaned keys
    missing_comparator_keys =  comparator_hash.keys - result.keys - iterator_hash.keys
    missing_comparator_keys.each do |key|
      result[key] = comparator_hash[key]
    end
  
    return result
  end
end