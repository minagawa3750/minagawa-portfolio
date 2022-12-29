require "rails_helper"

RSpec.describe SkiResortsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/ski_resorts").to route_to("ski_resorts#index")
    end

    it "routes to #new" do
      expect(get: "/ski_resorts/new").to route_to("ski_resorts#new")
    end

    it "routes to #show" do
      expect(get: "/ski_resorts/1").to route_to("ski_resorts#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/ski_resorts/1/edit").to route_to("ski_resorts#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/ski_resorts").to route_to("ski_resorts#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/ski_resorts/1").to route_to("ski_resorts#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/ski_resorts/1").to route_to("ski_resorts#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/ski_resorts/1").to route_to("ski_resorts#destroy", id: "1")
    end
  end
end
