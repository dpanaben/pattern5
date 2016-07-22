# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email


sanitize1 = user.sanitizes.create!(:match => '\s\,|\,|\,\s', :result => '，', :description => '把 , 改成全形符號')
sanitize2 = user.sanitizes.create!(:match => '\s\(|\(|\(\s', :result => '（', :description => '把 ( 改成全形符號')
sanitize3 = user.sanitizes.create!(:match => '\s\)|\)|\)\s', :result => '）', :description => '把 ) 改成全形符號')
sanitize4 = user.sanitizes.create!(:match => '\s\!|\!|\!\s', :result => '！', :description => '把 ! 改成全形符號')
sanitize5 = user.sanitizes.create!(:match => '\s\%|\%|\%\s', :result => '％', :description => '把 % 改成全形符號')
sanitize6 = user.sanitizes.create!(:match => '(?<=[\u4e00-\u9fa5]) *\:|\: *(?=[\u4e00-\u9fa5])', :result => '：', :description => '把中文字之間的 : (半形冒號)改成全形符號')
sanitize7 = user.sanitizes.create!(:match => '\s\;|\;|\;\s', :result => '；', :description => '把 ; 改成全形符號')
sanitize8 = user.sanitizes.create!(:match => '\s\~|\~|\~\s', :result => '～', :description => '把 ~ 改成全形符號')
sanitize9 = user.sanitizes.create!(:match => '\s\?|\?|\?\s', :result => '？', :description => '把 ? 改成全形符號')
sanitize10 = user.sanitizes.create!(:match => '\.{2,}', :result => '……', :description => '連續的半形句點改成連續兩組省略號…')
sanitize11 = user.sanitizes.create!(:match => '　', :result => '   ', :description => '全形空白代換成三個半形空白')
sanitize12 = user.sanitizes.create!(:match => '\.$|\.\s', :result => '。', :description => '段落尾逗點改句號')
sanitize13 = user.sanitizes.create!(:match => '(?<=\W)\s*\.\s*(?=\W)', :result => '。', :description => '半形點號若其前後皆非英數字時，取代成全形句號')
sanitize14 = user.sanitizes.create!(:match => ' (?=\/|／|[\u4e00-\u9fa5])', :result => '', :description => '處理空白--空白後面接反斜線/英數字/中文的話就把空白去掉')
