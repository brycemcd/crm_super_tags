require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "common/_super_tags.html.haml" do
  before(:each) do
    login_and_assign(:admin => true)

    @customfield = Factory(:customfield, :field_name => 'test', :form_field_type => 'short_answer')
    @tag = @customfield.tag
    assign(:opportunity, @opportunity = Factory(:opportunity, :account => Factory(:account), :tag_list => @tag.name))
  end

  it "should render [edit super tag] form" do

    view.fields_for @opportunity do |f|
      view.stub(:f) { f }
      render
    end

    view.should render_template(:partial => "/common/_super_tag_section")

    rendered.should have_tag("input[id=opportunity_tag1_attributes_test]")
  end
end
