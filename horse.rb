#!/usr/bin/ruby
 
# Make sure you have these gems installed
require 'rubygems'
require 'thread'
require 'twitter'
require 'marky_markov'

CONSUMER_KEY         = 'TWITTER CONSUMER KEY'
CONSUMER_SECRET      = 'TWITTER CONSUMER SECRET KEY'
ACCESS_TOKEN         = 'TWITTER ACCESS TOKEN'
ACCESS_TOKEN_SECRET  = 'TWITTER SECRET ACCESS TOKEN'
PATH_TO_REG          = 'PATH TO TEXT FILE'

# Create a random number between 90 and 140 characters
character_count = rand(90..140)
  
# Run when you want to generate a new horse_RegE tweet
markov = MarkyMarkov::Dictionary.new('dictionary') # Saves/opens dictionary.mmd
markov.parse_file PATH_TO_REG
tweet_text = markov.generate_n_sentences(2)[0..character_count].gsub(/\s\w+$/,'')

markov.save_dictionary!
    
# Connect to your Twitter account
Twitter.configure do |config|
  config.consumer_key    = CONSUMER_KEY
  config.consumer_secret = CONSUMER_SECRET
end
twitter_client = Twitter::Client.new(:oauth_token => ACCESS_TOKEN,
                              :oauth_token_secret => ACCESS_TOKEN_SECRET)
p "#{Time.now}: #{tweet_text}"
twitter_client.update(tweet_text)