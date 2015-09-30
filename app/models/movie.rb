class Movie < ActiveRecord::Base

  has_many :reviews

  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  validates :poster_image_url,
    presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_future

  def review_average
    reviews.size ? reviews.sum(:rating_out_of_ten)/reviews.size : "-"
  end

  class << self

    def search(params)
      @movies = Movie.all
      @movies = @movies.where("title like ?", "%#{params[:title]}%") if params[:title].present?
      @movies = @movies.where("director like ?", "%#{params[:director]}%") if params[:director].present?
      @movies = @movies.where("runtime_in_minutes < ?", 90) if params[:duration] == "2"
      @movies = @movies.where("runtime_in_minutes BETWEEN ? AND ?", 90, 120) if params[:duration] == "3"
      @movies = @movies.where("runtime_in_minutes > ?", 120) if params[:duration] == "4"
      @movies
    end

  end

  protected

  def release_date_is_in_the_future
    if release_date.present?
      errors.add(:release_date, "should probably be in the future") if release_date < Date.today
    end
  end

  mount_uploader :poster_image_url, MoviePosterUploader

end
