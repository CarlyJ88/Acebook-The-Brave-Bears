require 'rails_helper'

RSpec.describe ErrorsController, type: :controller do

  describe "GET #not_found" do
    it "returns http success" do
      get :not_found
      expect(response).to have_http_status(404)
    end
  end

end
