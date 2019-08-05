# frozen_string_literal: true

require 'stripe'
require_relative 'key_reader'

Stripe.api_key = read_key('apiKeys.txt')[:sk]

# Check balance for each thread
threads = []
800.times do
  threads << Thread.new do
    begin
      Stripe::Charge.create(
        amount: 50,
        currency: 'usd',
        source: 'tok_visa', # obtained with Stripe.js
        description: 'Charge for quzhi1',
        capture: false
      )
    rescue StandardError => e
      puts e.inspect
      break
    end
  end
end

threads.each(&:join)
