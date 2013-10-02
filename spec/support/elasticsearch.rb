# encoding: UTF-8
@elasticsearch_object = '{ \"took\" : 1324, \"timed_out\" : false, \"_shards\" : { \"total\" : 5, \"successful\" : 5, \"failed\" : 0 }, \"hits\" : { \"total\" : 2, \"max_score\" : 0.11506981, \"hits\" : [ { \"_index\" : \"techniques\", \"_type\" : \"technique\", \"_id\" : \"2\", \"_score\" : 0.11506981, \"fields\" : { \"user_id\" : 1, \"description\" : \"Ura-Juji-Jime\", \"name\" : \"Ura juji jime\" } }, { \"_index\" : \"techniques\", \"_type\" : \"technique\", \"_id\" : \"1\", \"_score\" : 0.047945753, \"fields\" : { \"user_id\" : 1, \"description\" : \"Baseball choke\", \"name\" : \"Baseball Choke\" } } ] } }'

RSpec::Matchers.define :be_mapped_by do |expected|
  
  chain :with_analyzer do |analyzer|
    @analyzer = analyzer
  end
  
  chain :with_boost do |boost|
    @boost = boost
  end
  
  match do |actual|
    @result = actual.class.mapping[expected].present?
    @result = (@result && actual.class.mapping[expected][:analyzer] == @analyzer) if @analyzer.present?
    @result = (@result && actual.class.mapping[expected][:boost] == @boost) if @boost.present?
    @result
  end
  
  failure_message_for_should do |actual|
    @msg = "expected that #{actual} would be mapped by #{expected}"
    @msg ="expected that #{actual} would be mapped by #{expected} with analizer #{@analyzer}" if @analyzer.present?
    @msg ="expected that #{actual} would be mapped by #{expected} with boost #{@boost}" if @boost.present?
    @msg
  end

  failure_message_for_should_not do |actual|
    @msg = "expected that #{actual} would not be mapped by #{expected}"
    @msg ="expected that #{actual} would be mapped by #{expected} without analizer #{@analyzer}" if @analyzer.present?
    @msg ="expected that #{actual} would be mapped by #{expected} without boost #{@boost}" if @boost.present?
    @msg
  end

  description do
    @msg = "be mapped by #{expected}"
    @msg ="be mapped by #{expected} with analizer #{@analyzer}" if @analyzer.present?
    @msg ="be mapped by #{expected} with boost #{@boost}" if @boost.present?
    @msg
  end
  
end