class TracksController < ApplicationController
  before_action :authenticate!
  before_action :set_track, only: %i[ edit update destroy ]
  before_action :set_album, only: %i[ new edit destroy ]

  # GET /tracks or /tracks.json
  def index
    @tracks = filtered_tracks
    @genres = Genre.all
  end

  # GET /tracks/new
  def new
    @track = Track.new
  end

  # GET /albums/1/edit
  def edit
  end

  # POST /tracks or /tracks.json
  def create
    @track = Track.new(track_params)

    respond_to do |format|
      if @track.save
        format.html { redirect_to album_path(id: track_params[:album_id]), notice: "Faixa criada com sucesso" }
        format.json { render :show, status: :created, location: @track }
      else
        format.html { redirect_to new_track_path(album: track_params[:album_id]), status: :unprocessable_entity, notice: "Erro ao criar a faixa" }
        format.json { render json: @track.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tracks/1 or /tracks/1.json
  def update
    respond_to do |format|
      if @track.update(track_params)
        format.html { redirect_to album_path(id: track_params[:album_id]), notice: "Faixa atualizada com sucesso" }
        format.json { render :show, status: :created, location: @track }
      else
        format.html { redirect_to new_track_path(album: track_params[:album_id]), status: :unprocessable_entity, notice: "Erro ao atualizar a faixa" }
        format.json { render json: @track.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @track.destroy!

    respond_to do |format|
      format.html { redirect_to album_path(@album), status: :see_other, notice: "Faixa deletada com sucesso" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:album])
    end

    def set_track
      @track = Track.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def track_params
      params.require(:track).permit(:name, :link, :album_id)
    end

    def filtered_tracks
      query = params[:query]
      genres_by_comma = params[:genres]
    
      genre_ids = genres_by_comma&.split(",")&.map(&:to_i)
    
      if query.present? && genre_ids.present?
        Track
          .joins(album: { album_genres: :genre })
          .where("tracks.name ILIKE ?", "%#{query}%")
          .where(genres: { id: genre_ids })
          .distinct
      elsif query.present?
        Track.where("tracks.name ILIKE ?", "%#{query}%")
      elsif genre_ids.present?
        Track
          .joins(album: { album_genres: :genre })
          .where(genres: { id: genre_ids })
          .distinct
      else
        Track.all
      end
    end   
end
