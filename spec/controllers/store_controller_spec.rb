require 'spec_helper'

describe StoreController, type: :controller do

  describe "GET 'index'" do
    it "renders the :index view" do
      get :index
      response.should render_template :index
    end

    it 'populates array of articles' do

    end
  end

end
