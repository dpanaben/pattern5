class SanitizesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_portfolio


  # GET /sanitizes/new
  def new
    @sanitize = @portfolio.sanitizes.new
  end

  # GET /sanitizes/1/edit
  def edit
    @sanitize = @portfolio.sanitizes.find(params[:id])
  end

  # POST /sanitizes
  # POST /sanitizes.json
  def create
    @sanitize = @portfolio.sanitizes.build(sanitize_params)

    respond_to do |format|
      if @sanitize.save
        format.html { redirect_to @portfolio, notice: 'Sanitize was successfully created.' }
        format.json { render :show, status: :created, location: @sanitize }
      else
        format.html { render :new }
        format.json { render json: @portfolio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sanitizes/1
  # PATCH/PUT /sanitizes/1.json
  def update
    @sanitize = @portfolio.sanitizes.find(params[:id])
    respond_to do |format|
      if @sanitize.update(sanitize_params)
        format.html { redirect_to @portfolio, notice: 'Sanitize was successfully updated.' }
        format.json { render :show, status: :ok, location: @sanitize }
      else
        format.html { render :edit }
        format.json { render json: @portfolio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sanitizes/1
  # DELETE /sanitizes/1.json
  def destroy
    @sanitize = @portfolio.sanitizes.find(params[:id])
    @sanitize.destroy
    respond_to do |format|
      format.html { redirect_to @portfolio, notice: 'Sanitize was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def changestatus
    @sanitize = @portfolio.sanitizes.find(params[:id])
    @sanitize.on? ? @sanitize.off! : @sanitize.on! #如果on就off，off就on，順便save(因為有!)
    redirect_to @portfolio, notice: t("sanitize.method.changestatus.notice") + @sanitize.status.upcase + ' !!'
  end

  def takeit
    @adminsanitize = Sanitize.find(params[:id])
    @portfolio.sanitizes.create!(match: @adminsanitize.match, result: @adminsanitize.result, description: @adminsanitize.description)
    redirect_to @portfolio, notice: 'You get one rule from Admin!'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_portfolio
      @portfolio = Portfolio.find(params[:portfolio_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sanitize_params
      params.require(:sanitize).permit(:match, :result, :description, :status)
    end
end
