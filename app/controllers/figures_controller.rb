class FiguresController < ApplicationController
  # add controller methods
  get '/figures' do
    @figures=Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    @titles=Title.all
    @landmarks=Landmark.all
    erb :'figures/new'
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])
   
    if !params[:title][:name].nil?
      title = Title.create(params[:title])
      @figure.titles << title
    end
      if !params[:landmark].nil?
      landmark = Landmark.create(params[:landmark])
      @figure.landmarks << landmark
    end
    @figure.save
    redirect "/figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'figures/show'
  end

  get "/figures/:id/edit" do
    @figure=Figure.find(params[:id])

    erb :'/figures/edit'
  end

  patch '/figures/:id' do 
    @figure=Figure.find(params[:id])
    if !params[:figure][:name].nil?
      @figure.update(params[:figure])
    end

    if !params[:title][:name].nil?
      @figure.titles << Title.create(name: params[:title][:name])
    end

    if !params[:landmark][:name].nil?
      @figure.landmarks << Landmark.create(name: params[:landmark][:name])
    end

    redirect "/figures/#{@figure.id}"
  end





end
