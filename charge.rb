require 'stripe'
require_relative 'key_reader'

Stripe.api_key = read_key('apiKeys.txt')[:sk]

# Check balance
balance = Stripe::Balance.retrieve
puts "available: #{balance.available[0].amount}, "\
"pending: #{balance.pending[0].amount}"

# Charge $20
charge = Stripe::Charge.create(
  amount: 2000,
  currency: 'usd',
  source: 'tok_visa', # obtained with Stripe.js
  description: 'Charge for quzhi1',
  capture: false
)

puts "charged: #{charge.amount}, id: #{charge.id}"

# Check balance again
balance = Stripe::Balance.retrieve
puts "available: #{balance.available[0].amount}, "\
"pending: #{balance.pending[0].amount}"

# Update a charge
charge = Stripe::Charge.update(
  charge.id,
  metadata: { order_id: '1234' }
)
puts "order_id: #{charge.metadata.order_id}"

# Capture the charge
charge = Stripe::Charge.capture(charge.id)
puts "captured: #{charge.amount}, id: #{charge.id}"

# Check balance again
balance = Stripe::Balance.retrieve
puts "available: #{balance.available[0].amount}, "\
"pending: #{balance.pending[0].amount}"
