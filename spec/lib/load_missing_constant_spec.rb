require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "load_missing_constant" do
  before { SuperTag::Clean.drop_tables }

  it { Tag1.should_not be_nil }

  it "should belong to a polymorphic customizable" do
    column_names = Tag1.columns.map(&:name)
    column_names.should include('customizable_id')
    column_names.should include('customizable_type')
  end

  it "should validate presence of customizable type" do
    Tag1.create.should have(1).error_on(:customizable_type)
  end

  it "should validate required fields" do
    c = Factory(:customfield, :field_name => 'one', :field_type => 'VARCHAR(255)', :required => true)   
    "Tag#{c.tag.id}".constantize.create.should have(1).error_on(:one)
  end
end

