require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "GET /new " do
    it "responds with 200" do
      user = User.create!(first_name: 'Bob', last_name: 'Bear', email: 'bob@bear.com', password: 'bobby')
      session[:user_id] = user.to_param
      get :new
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /" do
    it "responds with 200" do
      user = User.create!(first_name: 'Bob', last_name: 'Bear', email: 'bob@bear.com', password: 'bobby')
      session[:user_id] = user.to_param
      post :create, params: { post: { message: "Hello, world!" }, user: { id: nil } }
      expect(response).to redirect_to(posts_url)
    end

    it "creates a post" do
      user = User.create!(first_name: 'Bob', last_name: 'Bear', email: 'bob@bear.com', password: 'bobby')
      session[:user_id] = user.to_param

      post :create, params: { post: { message: "Hello, world!" }, user: { id: nil } }
      expect(Post.find_by(message: "Hello, world!")).to be
    end
  end

  describe "GET /" do
    it "responds with 200" do
      user = User.create!(first_name: 'Bob', last_name: 'Bear', email: 'bob@bear.com', password: 'bobby')
      session[:user_id] = user.to_param
      get :index
      expect(response).to have_http_status(200)
    end
  end

  describe "PATCH /update" do
    it "updates a post" do
      user = User.create!(first_name: 'Bob', last_name: 'Bear', email: 'bob@bear.com', password: 'bobby')
      session[:user_id] = user.to_param
      post :create, params: { post: { message: "Hello, world!" }, user: { id: nil } }
      expect(Post.find_by(message: "Hello, world!")).to be
      @post = Post.find_by(message: "Hello, world!")
      get :edit, params: {id: @post.id}
      put :update, params: { id: @post.id, post: { message: "Bye" }, user: { id: nil } }
      expect(Post.find_by(message: "Bye")).to be
    end

    it "redirects a post" do
      user = User.create!(first_name: 'Bob', last_name: 'Bear', email: 'bob@bear.com', password: 'bobby')
      session[:user_id] = user.to_param
      post :create, params: { post: { message: "Hello, world!" }, user: { id: nil } }
      expect(Post.find_by(message: "Hello, world!")).to be
      @post = Post.find_by(message: "Hello, world!")
      get :edit, params: {id: @post.id}
      put :update, params: { id: @post.id, post: { message: "Bye" }, user: { id: nil } }
      expect(response).to redirect_to(posts_url)
    end

    it "redirects a user wall" do
      user = User.create!(first_name: 'Bob', last_name: 'Bear', email: 'bob@bear.com', password: 'bobby')
      session[:user_id] = user.to_param
      post :create, params: { post: { message: "Hello, world!" }, user: { id: user.id } }
      expect(Post.find_by(message: "Hello, world!")).to be
      @post = Post.find_by(message: "Hello, world!")
      get :edit, params: {id: @post.id}
      put :update, params: { id: @post.id, post: { message: "Bye" } }
      expect(response).to redirect_to(user_url(user.id))
    end
  end

  describe "DELETE /" do
    it "deletes a post" do
      user = User.create!(first_name: 'Bob', last_name: 'Bear', email: 'bob@bear.com', password: 'bobby')
      session[:user_id] = user.to_param
      post :create, params: { post: { message: "Hello, world!" }, user: { id: nil } }
      expect(Post.find_by(message: "Hello, world!")).to be
      @post = Post.find_by(message: "Hello, world!")

      expect{
        delete :destroy, params: {id: @post.id}
      }.to change(Post,:count).by(-1)
   end

   it "redirects to post index" do
     user = User.create!(first_name: 'Bob', last_name: 'Bear', email: 'bob@bear.com', password: 'bobby')
     session[:user_id] = user.to_param
     post :create, params: { post: { message: "Hello, world!" }, user: { id: nil } }
     expect(Post.find_by(message: "Hello, world!")).to be
     @post = Post.find_by(message: "Hello, world!")
     delete :destroy, params: {id: @post.id}

     expect(response).to redirect_to(posts_url)
   end
  end
end
