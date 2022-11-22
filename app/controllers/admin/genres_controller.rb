class Admin::GenresController < ApplicationController
  def index
    @genres = Genre.all
    @genre = Genre.new
  end
  
  def edit
    # 空のModelオブジェクトを生成
    @genre = Genre.new
    @genre = Genre.find(params[:id])
  end
  
  def create
    @genre = Genre.new(genre_params)
    @genre.save!
    redirect_to admin_genres_path
  end
  
  def update
    genre = Genre.find(params[:id])
    genre.update(genre_params)
    redirect_to admin_genres_path
  end
  
  def destroy
    genre = Genre.find(params[:id])
    genre.destroy
    redirect_to asmin_genres_path
  end
  
  private
  def genre_params
    params.require(:genre).permit(:genre_name )
  end
end
