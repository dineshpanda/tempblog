class PhotosController < ApplicationController
  def index
    @photos = Photo.page(params[:page]).per(10)
    @location_hash = Gmaps4rails.build_markers(@photos.where.not(:location_latitude => nil)) do |photo, marker|
      marker.lat photo.location_latitude
      marker.lng photo.location_longitude
      marker.infowindow "<h5><a href='/photos/#{photo.id}'>#{photo.article_id}</a></h5><small>#{photo.location_formatted_address}</small>"
    end

    render("photo_templates/index.html.erb")
  end

  def show
    @photo = Photo.find(params.fetch("id_to_display"))

    render("photo_templates/show.html.erb")
  end

  def new_form
    @photo = Photo.new

    render("photo_templates/new_form.html.erb")
  end

  def create_row
    @photo = Photo.new

    @photo.article_id = params.fetch("article_id")
    @photo.name = params.fetch("name")
    @photo.image = params.fetch("image") if params.key?("image")
    @photo.location = params.fetch("location")

    if @photo.valid?
      @photo.save

      redirect_back(:fallback_location => "/photos", :notice => "Photo created successfully.")
    else
      render("photo_templates/new_form_with_errors.html.erb")
    end
  end

  def create_row_from_article
    @photo = Photo.new

    @photo.article_id = params.fetch("article_id")
    @photo.name = params.fetch("name")
    @photo.image = params.fetch("image") if params.key?("image")
    @photo.location = params.fetch("location")

    if @photo.valid?
      @photo.save

      redirect_to("/articles/#{@photo.article_id}", notice: "Photo created successfully.")
    else
      render("photo_templates/new_form_with_errors.html.erb")
    end
  end

  def edit_form
    @photo = Photo.find(params.fetch("prefill_with_id"))

    render("photo_templates/edit_form.html.erb")
  end

  def update_row
    @photo = Photo.find(params.fetch("id_to_modify"))

    @photo.article_id = params.fetch("article_id")
    @photo.name = params.fetch("name")
    @photo.image = params.fetch("image") if params.key?("image")
    @photo.location = params.fetch("location")

    if @photo.valid?
      @photo.save

      redirect_to("/photos/#{@photo.id}", :notice => "Photo updated successfully.")
    else
      render("photo_templates/edit_form_with_errors.html.erb")
    end
  end

  def destroy_row_from_article
    @photo = Photo.find(params.fetch("id_to_remove"))

    @photo.destroy

    redirect_to("/articles/#{@photo.article_id}", notice: "Photo deleted successfully.")
  end

  def destroy_row
    @photo = Photo.find(params.fetch("id_to_remove"))

    @photo.destroy

    redirect_to("/photos", :notice => "Photo deleted successfully.")
  end
end
