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
      get :show, params: {id: User.last.id}
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "brings up a form to signup a new user" do 
      get :new
      expect(response).to render_template(:new)
    end 
  end

  describe "POST #create" do
    context 'with valid params' do 
      before(:each) do 
          post :create, params: { user: {username: 'Harry Potter5', password: "password"}}
      end 

      it 'creates the user' do 
          expect(User.last.username).to eq('Harry Potter5')
      end 

      it 'redirects to user show page' do 
          expect(response).to redirect_to(user_url(User.last))
      end    
    end 

    context 'with invalid params' do 
      before(:each) do 
          post :create, params: { user: {not_an_attribute: ''}}
      end 

      it 'renders the new template' do 
          expect(response).to render_template(:new)
          expect(response).to have_http_status(422)
      end 

      it 'adds errors to flash' do 
          expect(flash[:errors]).to be_present
      end 
    end
  end
end