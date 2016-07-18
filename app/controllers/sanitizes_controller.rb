class SanitizesController < ApplicationController
  before_action :set_sanitize, except: [:index, :new, :create]
  after_action :verify_authorized

  # GET /sanitizes
  # GET /sanitizes.json
  def index
    @sanitizes = policy_scope(Sanitize)
    authorize Sanitize
  end

  # GET /sanitizes/1
  # GET /sanitizes/1.json
  def show
    authorize @sanitize
  end

  # GET /sanitizes/new
  def new
    @sanitize = Sanitize.new
    authorize @sanitize
  end

  # GET /sanitizes/1/edit
  def edit
    authorize @sanitize
  end

  # POST /sanitizes
  # POST /sanitizes.json
  def create
    authorize Sanitize
    @sanitize = Sanitize.new(sanitize_params)

    respond_to do |format|
      if @sanitize.save
        format.html { redirect_to @sanitize, notice: 'Sanitize was successfully created.' }
        format.json { render :show, status: :created, location: @sanitize }
      else
        format.html { render :new }
        format.json { render json: @sanitize.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sanitizes/1
  # PATCH/PUT /sanitizes/1.json
  def update
    authorize @sanitize
    respond_to do |format|
      if @sanitize.update(sanitize_params)
        format.html { redirect_to @sanitize, notice: 'Sanitize was successfully updated.' }
        format.json { render :show, status: :ok, location: @sanitize }
      else
        format.html { render :edit }
        format.json { render json: @sanitize.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sanitizes/1
  # DELETE /sanitizes/1.json
  def destroy
    authorize @sanitize
    @sanitize.destroy
    respond_to do |format|
      format.html { redirect_to sanitizes_url, notice: 'Sanitize was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def changestatus
    authorize @sanitize
    @sanitize.on? ? @sanitize.off! : @sanitize.on! #如果on就off，off就on，順便save(因為有!)
    redirect_to sanitizes_url, notice: 'The rule has been turned ' + @sanitize.status.upcase + ' !!'
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_sanitize
      # @sanitize = Sanitize.find(params[:id])
      @sanitize = Sanitize.find_by(id: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sanitize_params
      params.require(:sanitize).permit(:match, :result, :description, :status)
    end
end
