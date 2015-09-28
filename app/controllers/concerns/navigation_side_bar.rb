# should be included in all controllers with "render layout: true" (almost everywhere)

module NavigationSideBar
  extend ActiveSupport::Concern

  private

  def set_side_bar_categories
    @types = Type.all
    @manufacturers = Manufacturer.all
  end

end