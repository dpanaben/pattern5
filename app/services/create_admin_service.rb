class CreateAdminService
  def call
    user = User.find_or_create_by!(email: Rails.application.secrets.admin_email) do |user|
        user.password = Rails.application.secrets.admin_password
        user.password_confirmation = Rails.application.secrets.admin_password
        user.name = Rails.application.secrets.admin_name
        user.provider = "System"
        user.admin!
        portfolio1 = user.portfolios.create!(name: 'First Portfolio', description: "First Portfolio")
        sanitize1 = portfolio1.sanitizes.create!(:match => '\s\,|\,|\,\s', :result => '，', :description => '把 , 改成全形符號')
        sanitize2 = portfolio1.sanitizes.create!(:match => '\s\(|\(|\(\s', :result => '（', :description => '把 ( 改成全形符號')
        sanitize3 = portfolio1.sanitizes.create!(:match => '\s\)|\)|\)\s', :result => '）', :description => '把 ) 改成全形符號')
        sanitize4 = portfolio1.sanitizes.create!(:match => '\s\!|\!|\!\s', :result => '！', :description => '把 ! 改成全形符號')
        sanitize5 = portfolio1.sanitizes.create!(:match => '\s\%|\%|\%\s', :result => '％', :description => '把 % 改成全形符號')
        sanitize6 = portfolio1.sanitizes.create!(:match => '(?<=[\u4e00-\u9fa5]) *\:|\: *(?=[\u4e00-\u9fa5])', :result => '：', :description => '把中文字之間的 : (半形冒號)改成全形符號')
        sanitize7 = portfolio1.sanitizes.create!(:match => '\s\;|\;|\;\s', :result => '；', :description => '把 ; 改成全形符號')
        sanitize8 = portfolio1.sanitizes.create!(:match => '\s\~|\~|\~\s', :result => '～', :description => '把 ~ 改成全形符號')
        sanitize9 = portfolio1.sanitizes.create!(:match => '\s\?|\?|\?\s', :result => '？', :description => '把 ? 改成全形符號')
        sanitize10 = portfolio1.sanitizes.create!(:match => '\.{2,}', :result => '……', :description => '連續的半形句點改成連續兩組省略號…')
        sanitize11 = portfolio1.sanitizes.create!(:match => '　', :result => '   ', :description => '全形空白代換成三個半形空白')
        sanitize12 = portfolio1.sanitizes.create!(:match => '\.$|\.\s', :result => '。', :description => '段落尾逗點改句號')
        sanitize13 = portfolio1.sanitizes.create!(:match => '(?<=\W)\s*\.\s*(?=\W)', :result => '。', :description => '半形點號若其前後皆非英數字時，取代成全形句號')
        sanitize14 = portfolio1.sanitizes.create!(:match => ' (?=\/|／|[\u4e00-\u9fa5])', :result => '', :description => '處理空白--空白後面接反斜線/英數字/中文的話就把空白去掉')
      end
  end
end
