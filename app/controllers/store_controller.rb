class StoreController < ApplicationController

  include NavigationSideBar
  before_action :set_side_bar_categories

  # specific <header> rendering on main page
  def index
    @main_page = true
  end
end
