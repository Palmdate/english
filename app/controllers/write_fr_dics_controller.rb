class WriteFrDicsController < ApplicationController
  before_action :set_write_fr_dic, only: [:show, :edit, :update, :destroy]

  # GET /write_fr_dics
  # GET /write_fr_dics.json
  # Pgae WFD in Course
  def index
    @write_fr_dics = WriteFrDic.all
    @count = params[:audio]
    if params[:status_id]
      wfd_status = Course.all.find_by_id(params[:status_id])
      wfd_status.update(:status => "In Progress")
    end
  end

  # Pgae WFD in Menu
  def public
    @write_fr_dics_result = WriteFrDic.select(:id, :result)
    @count = params[:audio]
  end

  # GET /write_fr_dics/1
  # GET /write_fr_dics/1.json
  def show
    
  end

  # GET /write_fr_dics/new
  def new
    @write_fr_dic = WriteFrDic.new
    
  end

  # GET /write_fr_dics/1/edit
  def edit
    
  end

  # POST /write_fr_dics
  # POST /write_fr_dics.json
  def create
    @write_fr_dic = WriteFrDic.new(write_fr_dic_params)
    
    respond_to do |format|
      if @write_fr_dic.save
        format.html { redirect_to @write_fr_dic, notice: 'Write fr dic was successfully created.' }
        format.json { render :show, status: :created, location: @write_fr_dic }
      else
        format.html { render :new }
        format.json { render json: @write_fr_dic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /write_fr_dics/1
  # PATCH/PUT /write_fr_dics/1.json
  def update
    respond_to do |format|
      if @write_fr_dic.update(write_fr_dic_params)
        format.html { redirect_to @write_fr_dic, notice: 'Write fr dic was successfully updated.' }
        format.json { render :show, status: :ok, location: @write_fr_dic }
      else
        format.html { render :edit }
        format.json { render json: @write_fr_dic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /write_fr_dics/1
  # DELETE /write_fr_dics/1.json
  def destroy
    @write_fr_dic.destroy
    respond_to do |format|
      format.html { redirect_to write_fr_dics_url, notice: 'Write fr dic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_write_fr_dic
      @write_fr_dic = WriteFrDic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def write_fr_dic_params
      params.require(:write_fr_dic).permit(:audio, :content)
    end
end
