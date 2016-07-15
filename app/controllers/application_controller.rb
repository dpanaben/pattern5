class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_locale
  protect_from_forgery with: :exception
  before_action :set_paper_trail_whodunnit

  private
  # def set_locale
  #   I18n.locale = params[:locale] || I18n.default_locale
  # end
  def set_locale
    # 可以將 ["en", "zh-TW"] 設定為 VALID_LANG 放到 config/environment.rb 中
    if params[:locale] && I18n.available_locales.include?( params[:locale].to_sym )
      session[:locale] = params[:locale]
    end

    I18n.locale = session[:locale] || I18n.default_locale
  end

end
