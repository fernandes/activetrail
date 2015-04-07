ActiveAdmin.register Thing do
  controller do
    include ActiveTrail::Controller
    include AdminController
  end
end
