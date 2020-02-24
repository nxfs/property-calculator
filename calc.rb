# levies=14.5
# size=59
# property_price=1250000
# rates=500
# rent=10000
# annual_rent_increase=5
# annual_property_price_increase=5
# rates_and_levies_increase=5
# occupation_rate=98
# bond_duration=240
# bond_interest=9.1
# initial_payment=730000
# setup_costs=3500
# furnitures=100000
# furnitures_value_decrease=33
# transfer_costs=20000

levies=14.5
size=48
property_price=730000
rates=500
rent=6500
annual_rent_increase=5
annual_property_price_increase=5
rates_and_levies_increase=5
occupation_rate=100
bond_duration=240
bond_interest=9.1
initial_payment=200000
setup_costs=3500
furnitures=20000
furnitures_value_decrease=33
transfer_costs=20000

initial_investment=setup_costs+furnitures+initial_payment
puts "InitialInvestment=#{initial_investment}"

bond_debt=property_price-initial_payment
monthly_bond_interest=(bond_interest/12)/100
monthly_bond_repay=bond_debt*monthly_bond_interest/(1-(1+monthly_bond_interest)**-bond_duration)
puts "MonthlyBondRepay=#{monthly_bond_repay.to_i}"

running_costs=levies*size+rates

breaking_even=nil
positive_cash_flow=nil
selling_with_benefit=nil

cash=initial_payment-initial_investment
(0..bond_duration).each do |month|
  if (month >= bond_duration)
    monthly_bond_repay = 0
  end

  income=(occupation_rate*rent)/100
  charges=monthly_bond_repay+running_costs
  cash_flow=income-charges

  if (month != 0) then
    cash=cash+cash_flow

    if (breaking_even.nil? && cash > 0) then
      breaking_even = month
    end

    if (positive_cash_flow.nil? && cash_flow > 0) then
      positive_cash_flow = month
    end

    if (month % 12 == 0) then
      rent=(100+annual_rent_increase)*rent/100
      property_price=(100+annual_property_price_increase)*property_price/100
      running_costs=(100+rates_and_levies_increase)*running_costs/100
      furnitures=(100-furnitures_value_decrease)*furnitures/100
    end
  end

  assets=property_price+furnitures
  selling_benefit=cash+assets-transfer_costs-bond_debt-initial_payment

  if (selling_with_benefit.nil? && selling_benefit>0) then
    selling_with_benefit = month
  end

  if (month % 12 == 0) then
    assets=property_price+furnitures
    selling_benefit=cash+assets-transfer_costs-bond_debt-initial_payment
    puts "YEAR #{month/12} Cash=#{cash.to_i} CashFlow=#{cash_flow.to_i} Income=#{income.to_i} Charges=#{charges.to_i} RunningCosts=#{running_costs.to_i}"
    puts "Rent=#{rent.to_i} PropertyPrice=#{property_price.to_i} SellingBenefit=#{selling_benefit.to_i}"
  end
end

puts "Breaking even after #{(breaking_even/12).to_i} years and #{(breaking_even%12).to_i} months"
puts "Positive cash flow after #{(positive_cash_flow/12).to_i} years and #{(positive_cash_flow%12).to_i} months"
puts "Selling with benefit after #{(selling_with_benefit/12).to_i} years and #{(selling_with_benefit%12).to_i} months"
