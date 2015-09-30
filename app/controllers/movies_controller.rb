class MoviesController < ApplicationController

  def index
    @movies = Movie.where(nil)
    @movies = @movies.with_title(params[:title]) if params[:title].present?
    @movies = @movies.with_director(params[:director]) if params[:director].present?
    @movies = @movies.under_x_min(90) if params[:duration] == "2"
    @movies = @movies.over_x_min(90).under_x_min(120) if params[:duration] == "3"
    @movies = @movies.over_x_min(120) if params[:duration] == "4"
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :description
    )
  end

end
