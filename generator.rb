class Generator
  attr_accessor :max_len, :generated_password, :len, :alphabet, :nums, :special
  def initialize(len)
    @max_len = len
    @generated_password = ""
    @len = 0
    @alphabet = "abcdefghijklmnopqrstuvwxyz"
    @nums = "1234567890"
    @special = "-"
  end

  def generate_char
    @len += 1
    @len = @generated_password.length
    if @len > 0 and @len % 5 == 0 and @len != @max_len
      return @special
    end

    random = Random.new
    letter_index = random.rand(0..@alphabet.length)
    num_index = random.rand(0..@nums.length)
    type = random.rand(1..2)
    case type
    when 1
      uppercase = random.rand(1..2)
      case uppercase
      when 1
        return @alphabet[letter_index]
      when 2
        return @alphabet[letter_index].to_s.upcase
      else
        nil
      end
    when 2
      return @nums[num_index].to_s
    else
      nil
    end
  end

  def generate_password
    while @len <= @max_len
      @generated_password += generate_char.to_s
    end
    @generated_password
  end
end
