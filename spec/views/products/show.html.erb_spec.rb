require 'spec_helper'

describe "products/show" do
  before(:each) do
    @product = assign(:product, stub_model(Product,
      :name => "Name",
      :description => "MyText",
      :price => "9.99",
      :article_number => "Article Number",
      :remote => false,
      :type => nil,
      :manufacturer => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
    rendered.should match(/9.99/)
    rendered.should match(/Article Number/)
    rendered.should match(/false/)
    rendered.should match(//)
    rendered.should match(//)
  end
end
