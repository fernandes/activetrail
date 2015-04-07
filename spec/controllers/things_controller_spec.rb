require 'spec_helper'

RSpec.describe Admin::ThingsController, :type => :controller do

  before(:each) { sign_in(:user, FactoryGirl.create(:admin)) }
  describe "GET index" do
    it "assigns things" do
      thing1 = Thing.create(title: "show")
      thing2 = Thing.create(title: "hidden")
      get :index
      expect(assigns(:things)).to eq([thing1, thing2])
    end
    
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end
  
  describe "PUT update" do
    context "destroying a comment" do
      before(:each) do
        @thing = FactoryGirl.create(:thing_with_comments)
        patch :update,
          thing: {
            title: @thing.title,
            comments_attributes: {
              "0": {title: "New One", _destroy: 0, id: @thing.comments[0].id},
              "1": {title: "Destroyed", _destroy: 1, id: @thing.comments[1].id},
              "2": {title: "Last One", _destroy: 0, id: @thing.comments[2].id}
            }
          },
          id: @thing.id

      end
      it "deletes commentd#2 for thing" do
        expect(assigns(:thing).comments.count).to eq(2)
        expect(assigns(:thing).comments.pluck(:id)).to eq([1, 3])
      end

      it "assigns a thing" do
        expect(assigns(:thing)).to be_a(Thing)
      end

      it "assigns a form for thing" do
        expect(assigns(:form).model).to be_a(Thing)
      end

      it "thing has the specified title" do
        expect(assigns(:thing).title).to eq(@thing.title)
      end

      it "redirects to" do
        expect(response).to redirect_to(admin_thing_path(@thing.id))
      end

      it "has status :found" do
        expect(response).to have_http_status(:found)
      end
    end
  end
  

  
  describe "POST create" do
    context "rejecting blank field" do
      before(:each) { post :create, thing: {
          title: "My Created Thing",
          comments_attributes: {
            "0": {title: "New One"},
            "1": {title: ""}, # rejected one
            "2": {title: "Last One"}
          }
        }
      }
      
      it "creates 2 commentds for thing (rejecting blank one)" do
        expect(assigns(:thing).comments.count).to eq(2)
        expect(assigns(:thing).comments.pluck(:id)).to eq([1, 2])
      end

      it "assigns a created thing" do
        expect(assigns(:thing)).to be_a(Thing)
      end

      it "assigns a form for thing" do
        expect(assigns(:form).model).to be_a(Thing)
      end

      it "thing has the specified name" do
        expect(assigns(:thing).title).to eq("My Created Thing")
      end

      it "redirects to" do
        expect(response).to redirect_to(admin_thing_path(1))
      end

      it "has status :found" do
        expect(response).to have_http_status(:found)
      end
    end
  end
end
