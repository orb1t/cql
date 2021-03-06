require "#{File.dirname(__FILE__)}/spec_helper"


describe 'CQL::Repository' do

  let(:clazz) { CQL::Repository }
  let(:seed_arguments) { CQL_FEATURE_FIXTURES_DIRECTORY }


  describe 'common behavior' do

    it_should_behave_like 'a queriable object'

  end


  it 'must be based on a source' do
    expect(clazz.instance_method(:initialize).arity).to eq(1)
  end

  it 'can use a file path as a source' do
    expect { clazz.new(CQL_FEATURE_FIXTURES_DIRECTORY) }.to_not raise_error
  end

  it 'can use a model as a source' do
    some_model = CukeModeler::Scenario.new

    expect { clazz.new(some_model) }.to_not raise_error
  end

  it "complains if can't be made from what it was given" do
    expect { clazz.new(:some_other_thing) }.to raise_error(ArgumentError, "Don't know how to make a repository from a Symbol")
  end

  it 'does not modify the repository during a query' do
    repo = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/simple")

    original_state = Marshal.dump(repo)

    # Just a big, messy query that does a little of everything
    repo.query do
      with { |scenario| scenario.name =~ /slurping/ }
      as thing1
      transform :self => lambda { |thing1| 1 }
      select :self
      as thing2
      with scenarios => lambda { |scenario| scenario.name =~ /3/ }
      from scenarios
      select :self
      transform :self => lambda { |thing2| 2 }
      select name
    end

    new_state = Marshal.dump(repo)

    expect(new_state).to eq(original_state)
  end

  it 'returns the same model instances as the ones being queried' do
    model_1 = CukeModeler::Scenario.new
    model_2 = CukeModeler::Step.new
    model_3 = CukeModeler::Step.new

    model_1.steps << model_2
    model_1.steps << model_3

    repo = CQL::Repository.new(model_1)

    results = repo.query do
      select :self
      from scenarios, steps
    end

    result_model_ids = results.collect { |result| result[:self].object_id }


    expect(result_model_ids).to match_array([model_1.object_id,
                                             model_2.object_id,
                                             model_3.object_id])
  end

end
