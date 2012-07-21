require 'rspec'
require File.dirname(__FILE__) + "/../lib/" + "gherkin_slurper"

describe "cql" do

  describe "file parsing" do
    it 'should find the physical files' do
      gs = GQL::GherkinSlurper.new File.dirname(__FILE__) + "/../fixtures/features/simple"
      result = gs.physical_feature_files
      result[0].should =~ /simple\.feature/
      result[1].should =~ /test\.feature/
      result[2].should =~ /test2\.feature/
      result[3].should =~ /test_full\.feature/
    end
  end

  describe "tags" do
    it "retrieve tags from a scenario" do
      gs = GQL::GherkinSlurper.new File.dirname(__FILE__) + "/../fixtures/features/tags2"
      gs.tags.sort.should == ["@five", "@four", "@one", "@two"].sort
    end
  end

  describe 'features query' do
    it 'should find all feature names' do
      gs = GQL::GherkinSlurper.new File.dirname(__FILE__) + "/../fixtures/features/simple"
      gs.overview.should eql ["Simple", "Test Feature", "Test2 Feature", "Test3 Feature"]
    end

    it 'should find a scenario by feature and tag' do
      gs = GQL::GherkinSlurper.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/tags2"
      gs.get_scenario_by_feature_and_tag("Not here", "@three").should == []
    end

    it 'should retrieve a full feature' do
      gs = GQL::GherkinSlurper.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/simple"
      result = gs.find_feature "Test Feature"
      result['name'].should == "Test Feature"
      result['elements'][0]['name'].should == "Testing the slurping"
      result['elements'].should == [{"keyword"=>"Scenario", "name"=>"Testing the slurping", "line"=>3,
                                "description"=>"", "id"=>"test-feature;testing-the-slurping", "type"=>"scenario",
                                "steps"=>[{"keyword"=>"Given ", "name"=>"something happend", "line"=>4},
                                          {"keyword"=>"Then ", "name"=>"I expect something else", "line"=>5}]},
                               {"keyword"=>"Scenario", "name"=>"Testing the slurping not to be found", "line"=>7,
                                "description"=>"", "id"=>"test-feature;testing-the-slurping-not-to-be-found", "type"=>"scenario",
                                "steps"=>[{"keyword"=>"Given ", "name"=>"something happend", "line"=>8}, {"keyword"=>"Then ", "name"=>"I expect something else", "line"=>9}]}]
    end
  end

  describe 'scenario query' do
    it 'should get all scenarios as a list' do
      gs = GQL::GherkinSlurper.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/scen_outlines"
      gs.get_scenarios_from_feature("Test Feature").should == ["A Scenario"]
    end

    it 'should get a full scenario' do
      simple_path = File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/simple"
      gs = GQL::GherkinSlurper.new simple_path
      expected = {"keyword"=>"Scenario", "name"=>"Testing the slurping", "line"=>3,
                  "description"=>"", "id"=>"test-feature;testing-the-slurping", "type"=>"scenario",
                  "steps"=>[{"keyword"=>"Given ", "name"=>"something happend", "line"=>4},
                            {"keyword"=>"Then ", "name"=>"I expect something else", "line"=>5}]}
      gs.get_scenario("Test Feature", "Testing the slurping").should == expected
    end

    it 'should find scenarios by a single tag' do
      gs = GQL::GherkinSlurper.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/tags"
      gs.get_scenario_by_feature_and_tag("Simple", "@one").should == ['Next', 'Another']
      gs.get_scenario_by_feature_and_tag("Simple", "@two").should == ['Has a table', 'Blah']

      gs = GQL::GherkinSlurper.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/tags2"
      gs.get_scenario_by_feature_and_tag("Simple", "@one").should == ['Next', 'Another']
      gs.get_scenario_by_feature_and_tag("Simple", "@two").should == ['Has a table', 'Blah']
      gs.get_scenario_by_feature_and_tag("Simple 2", "@one").should == ['Next', 'Another']
      gs.get_scenario_by_feature_and_tag("Simple 2", "@two").should == ['Has a table hmmm', 'Blah']

      gs.get_scenario_by_feature_and_tag("Simple", "@three").should == []

    end

    it 'should find scenarios by multiple tags' do
      gs = GQL::GherkinSlurper.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/tags2"
      gs.get_scenario_by_feature_and_tag("Simple 2", "@two", "@four").should == ['Has a table hmmm']
    end

    it 'should retrieve the table data' do
      gs = GQL::GherkinSlurper.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/table"
      expected = {"keyword"=>"Scenario", "name"=>"Has a table", "line"=>3, "description"=>"", "id"=>"simple;has-a-table", "type"=>"scenario",
                  "steps"=>[{"keyword"=>"Given ", "name"=>"Something", "line"=>4,
                             "rows"=>[{"cells"=>["a", "a"], "line"=>5},
                                      {"cells"=>["s", "a"], "line"=>6}, {"cells"=>["s", "s"], "line"=>7}]},
                            {"keyword"=>"Then ", "name"=>"something else", "line"=>8}]}
      gs.get_scenario("Simple", "Has a table").should == expected
    end
  end

  describe 'scenario outline query' do
    it 'should get scenario outlines as a list' do
      gs = GQL::GherkinSlurper.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/scen_outlines"
      gs.get_scenarios_from_feature("Test Feature").should == ["A Scenario"]
      gs.get_scenario_outlines_from_feature("Test Feature").should == ["An Outline"]
    end
  end

end