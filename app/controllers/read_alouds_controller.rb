class ReadAloudsController < ApplicationController
  before_action :set_read_aloud, only: [:show, :edit, :update, :destroy]

  # GET /read_alouds
  # GET /read_alouds.json
  def chart
    if current_user         
      last_result = ReadAloudChart.where(user_id:current_user.id).order('updated_at DESC').first
      if last_result != nil && last_result.sentence.to_s == params[:sentence]
        return last_result.update(:rate => params[:rate])
      else
        unless params[:rate] == nil
          result = ReadAloudChart.new(:user_id => current_user.id, :rate => params[:rate], :sentence => params[:sentence])
          result.save!
        end
      end
    else
      redirect_to login_path
    end
  end
  
  def index
    if current_user
      @read_alouds = params[:audio].to_i
    else
      redirect_to login_path
    end
   
  end

  # GET /read_alouds/1
  # GET /read_alouds/1.json
  def show
  end

  # GET /read_alouds/new
  def new
    @read_aloud = ReadAloud.new
  end

  # GET /read_alouds/1/edit
  def edit
  end

  # POST /read_alouds
  # POST /read_alouds.json
  def create
    @read_aloud = ReadAloud.new(read_aloud_params)

    respond_to do |format|
      if @read_aloud.save
        format.html { redirect_to @read_aloud, notice: 'Read aloud was successfully created.' }
        format.json { render :show, status: :created, location: @read_aloud }
      else
        format.html { render :new }
        format.json { render json: @read_aloud.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /read_alouds/1
  # PATCH/PUT /read_alouds/1.json
  def update
    respond_to do |format|
      if @read_aloud.update(read_aloud_params)
        format.html { redirect_to @read_aloud, notice: 'Read aloud was successfully updated.' }
        format.json { render :show, status: :ok, location: @read_aloud }
      else
        format.html { render :edit }
        format.json { render json: @read_aloud.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /read_alouds/1
  # DELETE /read_alouds/1.json
  def destroy
    @read_aloud.destroy
    respond_to do |format|
      format.html { redirect_to read_alouds_url, notice: 'Read aloud was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_read_aloud
      @read_aloud = ReadAloud.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def read_aloud_params
      params.fetch(:read_aloud, {})
    end
end
