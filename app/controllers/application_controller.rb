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


  
  # Add your ro utes here
  get "/" do
    { message: "Good luck with your project!" }.to_json
  end

  get "/projects" do
    projects = Project.all
    project.to_json
  end

  get "/project/:id" do
    project = Project.find(params[:id])
    project.to_json(only: [:name, :topic, :description, :uploaded_file])
  end

  get "/users" do
    "List all users"
  end

end
