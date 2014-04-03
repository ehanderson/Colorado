module ApplicationHelper
  def zurb_menu(items, options = {})
    presenter = Refinery::Pages::ZurbMenuPresenter.new(items, self)
    %w(menu_tag dom_id css list_dropdown_css list_item_dropdown_css list_tag_css selected_css).map(&:to_sym).each do |k|
      presenter.send("#{k}=", options[k]) if options.has_key?(k)
    end
    presenter
  end
end
