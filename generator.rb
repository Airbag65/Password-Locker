class Generator
  attr_accessor :max_len, :generated_password, :len, :alphabet, :nums, :special
  def initialize(len)
    self.max_len = len
    self.generated_password = ""
    self.len = 0
    self.alphabet = "abcdefghijklmnopqrstuvwxyz"
    self.nums = "1234567890"
    self.special = "-"
  end

  def generate_char
    self.len += 1
    self.len = self.generated_password.length
    if self.len > 0 and self.len % 5 == 0 and self.len != self.max_len
      return self.special
    end

    random = Random.new
    letter_index = random.rand(0..self.alphabet.length)
    num_index = random.rand(0..self.nums.length)
    type = random.rand(1..2)
    case type
    when 1
      uppercase = random.rand(1..2)
      case uppercase
      when 1
        return self.alphabet[letter_index]
      when 2
        return self.alphabet[letter_index].to_s.upcase
      else
        nil
      end
    when 2
      return self.nums[num_index].to_s
    else
      nil
    end
  end

  def generate_password
    while self.len <= self.max_len
      self.generated_password += generate_char.to_s
    end
    self.generated_password
  end
end
