class ReadAloudsController < ApplicationController
  before_action :set_read_aloud, only: [:show, :edit, :update, :destroy]
  before_action :check_user
  
  # GET /read_alouds
  # GET /read_alouds.json
  def chart
    last_result = ReadAloudChart.where(user_id:current_user.id).order('updated_at DESC').first
    if last_result != nil && last_result.sentence.to_s == params[:sentence]
      return last_result.update(:rate => params[:rate])
    else
      unless params[:rate] == nil
        result = ReadAloudChart.new(:user_id => current_user.id, :rate => params[:rate], :sentence => params[:sentence])
        result.save!
      end
    end
    
  end
  
  def index
    @read_alouds = params[:audio].to_i
    if params[:status_id]
      @status_id = params[:status_id]
      read_status = Course.all.find_by_id(params[:status_id])
      read_status.update(:status => "In Progress")
    end
  end
  
  # Report to admin 
  def report
    last_report = ReadAloudReport.where(user_id:current_user.id).order('updated_at DESC').first
    if params[:rate].to_i >= 60
      
      if last_report != nil && last_report.sentence.to_s == params[:sentence]
        last_report.update(:percent => params[:rate])
        render json: { status: 'update', message: "Your result updated successful." }
      else
        report = ReadAloudReport.new(:user_id => current_user.id,
                                     :sentence => params[:sentence],
                                     :percent => params[:rate],
                                     :result => params[:result])
        if report.save!
          render json: { status: 'success', message: "Saved" }
        else
          render json: { status: 'errors', message: "Occured errors!" }
        end
        
      end
      
    else
      render json: { status: 'error', message: "Your accuracy need larger than 60% " }
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
