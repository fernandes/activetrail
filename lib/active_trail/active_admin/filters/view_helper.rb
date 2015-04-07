ActiveAdmin::Filters::ViewHelper.class_eval do
  def except_hidden_fields
    [:q, :page, :current_user]
  end
end
