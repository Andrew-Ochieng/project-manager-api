class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  use Rack::Session::Pool, :expire_after => 259200000000
  
  # To enable cross origin requests for all routes:
  set :bind, '0.0.0.0'
  configure do
    enable :cross_origin
  end
  before do
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Headers'] = '*'
    response.headers["Access-Control-Allow-Methods"] = "GET, POST, OPTIONS, PUT, DELETE"
  end
  
  # routes...
  options "*" do
    response.headers["Allow"] = "GET, PUT, POST, DELETE, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
    response.headers["Access-Control-Allow-Origin"] = "*"
    200
  end

  # GET ---------------------------------------------------------------------------# Add your ro utes here
  def authorized
    User.find(session[:user_id])
  end

  get "/" do
    authorized
    { message: "Good luck with your project!" }.to_json
  end

  get "/projects" do
    authorized
    projects = Project.all
    projects.to_json
  end

  get "/projects/:id" do
    authorized
    project = Project.find(params[:id])
    project.to_json(only: [:name, :topic, :description, :uploaded_file])
  end

  get "/users" do
    authorized
    Project.all.to_json
  end

  get "user/:id" do
    authorized
    project = Project.find(params[:id])
    project.to_json(only: [:name, :topic, :details])
  end


  # POST ---------------------------------------------------------------------------
  post "/login" do
    user = User.where(["username=? and password=?", params[:username], params[:password]])[0]

    if (user.nil?)
      {error: "Wrong email or password"}.to_json
    else
      session[:user_id] = user.id
      user.to_json
    end
  end

  post "/signup" do
    user = User.create(
      username: "user",
      email: "user@user.com",
      password: "password"
    )
    
    if (user.nil?)
      {error: "Wrong email or password"}.to_json
    else
      session[:user_id] = user.id
      user.to_json
    end
  end


  post "/projects" do
    authorized
    project = Project.create(project_params)
    project.to_json
  end

  # PATCH ---------------------------------------------------------------------------
  patch "/projects/:id" do
    authorized
    project = Project.find_by(id: params[:id])
    project.update()
    project.to_json
  end

  # DELETE ---------------------------------------------------------------------------
  delete "/projects/:id" do
    authorized
    project = Project.find(params[:id])
    project.destroy
    project.to_json
  end

  delete "/logout" do
    session.delete user_id
  end


  # private
  # def project_params
    
  # end
  



end
