ActiveAdmin.register Book do
  # everything happens here :D
  controller do
    include ActiveTrail::Controller
  end
  
  collection_action :baz, method: :get do
    render text: params.has_key?(:current_user)
  end
end
