class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
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
  get "/" do
    { message: "Good luck with your project!" }.to_json
  end

  get "/projects" do
    projects = Project.all
    project.to_json
  end

  get "/projects/:id" do
    project = Project.find(params[:id])
    project.to_json(only: [:name, :topic, :description, :uploaded_file])
  end

  get "/users" do
    Project.all.to_json
  end

  get "user/:id" do
    project = Project.find(params[:id])
    project.to_json(only: [:name, :topic, :details])
  end


  # POST ---------------------------------------------------------------------------
  post "/projects" do
    project = Project.create(project_params)
    project.to_json
  end




  # PATCH ---------------------------------------------------------------------------
  patch "/projects/:id" do
    project = Project.find_by(id: params[:id])
    project.update()
    project.to_json
  end





  # DELETE ---------------------------------------------------------------------------
  delete "/projects/:id" do
    project = Project.find(params[:id])
    project.destroy
    project.to_json
  end


  # private
  # def project_params
    
  # end
  



end
