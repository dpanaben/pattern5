class PortfoliosController < ApplicationController
  before_action :set_portfolio, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized
  after_action :verify_policy_scoped, :only => :index

  # GET /portfolios
  # GET /portfolios.json
  def index
    @portfolios = policy_scope(Portfolio)
    authorize Portfolio
  end

  # GET /portfolios/1
  # GET /portfolios/1.json
  def show
    authorize @portfolio
    @sanitizes = @portfolio.sanitizes
    @adminsanitizes = User.first.sanitizes
  end

  # GET /portfolios/new
  def new
    @portfolio = Portfolio.new
    authorize @portfolio
  end

  # GET /portfolios/1/edit
  def edit
    authorize @portfolio
  end

  # POST /portfolios
  # POST /portfolios.json
  def create
    authorize Portfolio
    @portfolio = current_user.portfolios.build(portfolio_params)

    respond_to do |format|
      if @portfolio.save
        format.html { redirect_to @portfolio, notice: 'Portfolio was successfully created.' }
        format.json { render :show, status: :created, location: @portfolio }
      else
        format.html { render :new }
        format.json { render json: @portfolio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /portfolios/1
  # PATCH/PUT /portfolios/1.json
  def update
    authorize @portfolio
    respond_to do |format|
      if @portfolio.update(portfolio_params)
        format.html { redirect_to @portfolio, notice: 'Portfolio was successfully updated.' }
        format.json { render :show, status: :ok, location: @portfolio }
      else
        format.html { render :edit }
        format.json { render json: @portfolio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /portfolios/1
  # DELETE /portfolios/1.json
  def destroy
    authorize @portfolio
    @portfolio.destroy
    respond_to do |format|
      format.html { redirect_to portfolios_url, notice: 'Portfolio was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_portfolio
      @portfolio = Portfolio.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def portfolio_params
      params.require(:portfolio).permit(:name, :description)
    end
end
