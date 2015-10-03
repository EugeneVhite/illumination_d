module ProductsHelper
  def to_russian_currency(value)
    number_to_currency value, unit: '₽ ', delimiter: ''
  end

  def first_two_words_of(string)
    string.split[0...2].join(' ')
  end
end
