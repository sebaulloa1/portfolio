require 'Date'

class Stock
  def initialize(symbol)
    @symbol = symbol
    @random_value = Random.new.rand(0..100)
  end

  # Random value + day of the month
  # This would return the value saved in database or given by an API
  def price(date = Date.today)
    raise 'Invalid date' unless date.is_a?(Date)

    @random_value + date.day
  end
end

class Portfolio
  def initialize
    @stocks = []
  end

  def add_stock(stock)
    raise 'Invalid stock' unless stock.is_a?(Stock)

    @stocks << stock
  end

  # Normal profit calculation
  # def profit(date_from, date_to)
  #   raise 'Invalid date' unless date_from.is_a?(Date) && date_to.is_a?(Date)

  #   initial_sum = @stocks.sum { |stock| stock.price(date_from.to_date) }
  #   ending_sum = @stocks.sum { |stock| stock.price(date_to.to_date) }
  #   ending_sum - initial_sum
  # end

  # Annualized return calculation
  # Value returned as decimal rounded to 2 decimal places. Could be converted into a percentage or a string.
  def profit(date_from, date_to)
    raise 'Empty portfolio' if @stocks.empty?

    initial_value = @stocks.sum { |stock| stock.price(date_from.to_date) }
    ending_value = @stocks.sum { |stock| stock.price(date_to.to_date) }
    total_return = (ending_value - initial_value) / initial_value.to_f
    periods = (date_to - date_from).to_i / 365
    raise 'Invalid period' if periods.zero?

    annualized_return = ((1 + total_return) ** (1.0 / periods)) - 1
    annualized_return.round(2)
  end
end
