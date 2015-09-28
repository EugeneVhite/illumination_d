require 'spec_helper'

describe "products/edit" do
  before(:each) do
    @product = assign(:product, stub_model(Product,
      :name => "MyString",
      :description => "MyText",
      :price => "9.99",
      :article_number => "MyString",
      :remote_control => false,
      :type => nil,
      :manufacturer => nil
    ))
  end

  it "renders the edit product form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", product_path(@product), "post" do
      assert_select "input#product_name[name=?]", "product[name]"
      assert_select "textarea#product_description[name=?]", "product[description]"
      assert_select "input#product_price[name=?]", "product[price]"
      assert_select "input#product_article_number[name=?]", "product[article_number]"
      assert_select "input#product_remote[name=?]", "product[remote]"
      assert_select "input#product_type[name=?]", "product[type]"
      assert_select "input#product_manufacturer[name=?]", "product[manufacturer]"
    end
  end
end
