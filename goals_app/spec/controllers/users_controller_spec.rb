require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET#index" do 
    it "renders the users index" do 
      get :index
      expect(response).to render_template(:index)
    end 
  end 

  describe "GET #show" do
    it "renders the user's show page" do 
      get :show
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "brings up a form to signup a new user" do 
      get :new
      expect(response).to render_template(:new)
    end 
  end
end