Dir[File.join(__dir__, 'feeds', '*.rb')].each { |f| require(f) }

require 'blue_factory'
require 'sinatra/activerecord'

ActiveRecord::Base.connection.execute "PRAGMA journal_mode = WAL"

BlueFactory.set :publisher_did, 'did:plc:puavsdqzowvrvlhjxwondteg'
BlueFactory.set :hostname, 'feeds.andi.ishalt.so'

# uncomment to enable authentication (note: does not verify signatures)
# see Feed#get_posts(params, visitor_did) in app/feeds/feed.rb
# BlueFactory.set :enable_unsafe_auth, true

BlueFactory.add_feed 'freifunk', FreifunkFeed.new
BlueFactory.add_feed '37c3', The37c3Feed.new

