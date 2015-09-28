require 'spec_helper'

describe "products/index" do
  before(:each) do
    assign(:products, [
      stub_model(Product,
        :name => "Name",
        :description => "MyText",
        :price => "9.99",
        :article_number => "Article Number",
        :remote_control => false,
        :type => nil,
        :manufacturer => nil
      ),
      stub_model(Product,
        :name => "Name",
        :description => "MyText",
        :price => "9.99",
        :article_number => "Article Number",
        :remote_control => false,
        :type => nil,
        :manufacturer => nil
      )
    ])
  end

  it "renders a list of products" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers

  end
end
