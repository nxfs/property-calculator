levies=14.5
size=48
price=730000
rates=500
rent=7000
annual_rent_increase=8
annual_price_increase=8
rates_and_levies_increase=8
(occupation_rate=98)/100
bond_duration=240
bond_interest=9.1
initial_payment=350000
setup_costs=3500
furnitures=100000
furnitures_value_decrease=33
transfer_costs=20000

bond_debt=price-initial_payment
monthly_bond_repay=bond_debt/bond_duration
monthly_bond_interest=bond_interest/(12*100)
running_costs=levies*size+rates
initial_investment=setup_costs+furnitures+initial_payment
puts "InitialInvestment=#{initial_investment}"

benefit=0
(0..bond_duration).each do |month|
  if (month != 0) then
    income=(occupation_rate*rent)/100
    debt_interest=bond_debt*monthly_bond_interest
    monthly_bond_repay = [monthly_bond_repay, bond_debt].min
    bond_debt=bond_debt-monthly_bond_repay
    debt_reimbursement=monthly_bond_repay
    charges=debt_interest+debt_reimbursement+running_costs
    cash_flow=income-charges
    benefit=benefit+cash_flow
    if (month % 12 == 0) then
      rent=(100+annual_rent_increase)*rent/100
      price=(100+annual_price_increase)*price/100
      running_costs=(100+rates_and_levies_increase)*running_costs/100
      furnitures=(100-furnitures_value_decrease)*furnitures/100
    end
  end

  if (month % 12 == 0) then
    selling_benefit=benefit+price-transfer_costs-bond_debt-initial_investment+furnitures
    puts "YEAR #{month/12} Benefit=#{benefit.to_i} Balance=#{cash_flow.to_i} Income=#{income.to_i} Charges=#{charges.to_i} DebtInterest=#{debt_interest.to_i} DebtReimbursement=#{debt_reimbursement.to_i} RunningCosts=#{running_costs.to_i}"
    puts "Rent=#{rent.to_i} PropertyPrice=#{price.to_i} SellingBenefit=#{selling_benefit.to_i}"
  end
end
