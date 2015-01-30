def stock_picker(prices)
  output = []
  best_profits = 0

  prices.each_with_index do |buy_price, buy_date|
    (buy_date+1).upto(prices.count-1) do |sell_date|
      current_profit = prices[sell_date] - buy_price
      if current_profit > best_profits
        output = [buy_date, sell_date]
        best_profits = current_profit
      end
    end
  end

   return "No profits here" if best_profits == 0
   output
end
