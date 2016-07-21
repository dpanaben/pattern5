class User < ApplicationRecord
  enum role: [:user, :vip, :admin]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  has_many :posts, dependent: :nullify
  has_many :sanitizes, dependent: :nullify
  after_destroy :moveposttoadmin
  after_create :after_create
  after_initialize :set_default_role, :if => :new_record?

  def self.from_omniauth(auth)
   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
     user.name = auth.info.name ||= ""  # assuming the user model has a name
     user.password = Devise.friendly_token[0,20]
     user.email = auth.info.email ||= auth.uid + "@" + auth.provider + ".auth"
   end
  end

  def set_default_role
    self.role ||= :user
  end

  def moveposttoadmin
    Post.all.where(user_id: nil).update_all(user_id: User.admin.first.id)
  end

  def after_create
    user = User.last
    user.posts.create!(title: 'FortiWeb-1000C與3000C', content: '
     
    FortiWeb-1000C與3000C, 採用最新的FortiWeb 4.0 MR1系統韌體, 能提供更佳的部署彈性與安全性。
     

    【2010/9/21‧台北訊】UTM 解決方案全球"領導"者"與"網路安全領導供應商 --- Fortinet® (NASDAQ: FTNT), 宣佈推出兩款新的FortiWeb™產品: 適用於中大型企業的FortiWeb-1000C; 以及大型企業、應用服務與雲端服務供應商適用的FortiWeb-3000C。兩款新產品皆採用最新的 FortiWeb 4.0 MR1韌體，能嚴密保護內含機密資料的Web應用程式, 以符合支付卡(PCI) 產業規範。此外，亦能消弭危險的攻擊, 例如資料隱碼 (SOL injection )和跨站腳本(XXS; cross-site scripting)攻擊..... , 預防信用卡與個人資訊等重要資料外洩的安全風險.
     
    　　隨著FortiWeb-1000C和3000C的推出，Fortinet目前已有4款Web應用程式防火牆產品, 能提供各式企業部署的選擇, 不論是零售收付、金融服務或保健產業的客戶. 以零售收付的客戶為例, 新的FortiWeb產品能顯著降低因應安全法規的複雜度, 例如防範個人資料竊取與金融詐騙的PCI DDS section 6.5 ~ 6.6，以及加州參議院1386法案。FortiWeb-1000C/ 3000C亦能為保健產業提供健全的病患資料防護, 以符HIPAA (健康保險可攜性及責任性法案) 中的相關規範.
     
        Current Analysis資深分析師Paula Musich表示: 「Web應用程式的防護需求從未如此巨大, 主要原因在於企業所部署的應用程式，以及在網路上所呈現的資料，都比以往更為廣泛。對駭客和網路罪犯來說 ,這些匯集信用卡與個人資料的應用程式欠缺保護 , 如同顯著的攻擊目標。何以超過 80％ 的企業都表示重視?因為今日在網路上從事商業行為時，健全的Web防護和具備強大政策執行能力的威脅管理解決方案, 已成為資訊安全的建置標準!」
     
    	FortiWeb-1000C和FortiWeb-3000C整合了Web應用程式和XML防火牆 ,能抵禦針對Web應用程式與Web服務架構的攻擊。由於FortiWeb能將企業整體威脅 ,視覺化精細地呈現,因此不需要分別管理Web與其它威脅的工具和控制台。如此不僅簡化了安全管理,同時也降低管理架構的複雜性,能大幅減少保護資料以符管理規範所需的時間。
     
    ')

    user.posts.create!(title: '這是用來測試. ', content: '這是用來測試.
    不過全形空白如果都去掉,有可能會造成文章段落中的小標題出錯.例如下一行中間是個全形空白.

    不分青紅皂白 (小標題)斷句砍光光

    句尾的點號改成句號,所謂「句尾」是如何判別呢?另外有個規則是連續三個點就改成兩個全形刪節號,那麼:萬一:原稿在句尾是三個點,會發生什麼事?而且有的人不太會輸入中文標點,遇到該用(句號)的時候, 就直接用個句點.最多像前面這樣多墊一個半型空白.但是這種情況不是在句尾,不就會被漏掉了嗎~~
    不過像.Net這樣還是得保留點唷!!

    此外,連續太多個連字號,有可能原作者是想當成分隔線?像下面這樣~~
    ---------------------
    %%%%%%%%%

    不過這應該可以不用考慮啦,反正就算是分隔線,在編輯人員進行文章修整潤飾的時候也是一定要刪掉的,改不改成破折號其實沒差??

    ~~斜線~~是個很麻煩的東西,因為除了日期之外,還有可能出現很多種狀況.日期可以用「斜線前後都是英數字」來判別吧,或者單純用「斜線後面緊接著英數字元」來判別?

    斜線前後如果都是英文字,例如C/P值就會用半形斜線.這可以跟上面的日期判別用一樣的規則即可,但就是會有人喜歡在斜線前或後加上半形空白,例如Windows XP/Vista/Me這樣,怎麼修乾淨倒是個問題.

    如果斜線前後;都是中文字,例如「價格/效能比」那反而沒問題,就改成全形即可.問題是也很容易殘;留空白,例如本來寫「價格/效能比」的話.我的作法是先忽視所有半型標點符號前後的空白字;元,只把需要轉換成全形的標點符號轉好,最後再一次把所有位於全形字;元之;間的空白去掉.

    傷腦筋的是有些前後是一個中文一個英文的 , 這種通常是要用半形斜線,例如:
    傳輸速率高達10 MB/秒
    但原稿可能是「10 MB/秒」(還空一格!?)所以要改為半形 ')

    user.posts.create!(title: '引號很難搞', content: '引號很難搞，因為如果是巢狀引號，很難判別究竟是誰包著誰。

    例如這句：
    法國大革命的精神就是"自由"、"平等"與"博愛"。
    應該變成：
    法國大革命的精神就是「自由」、「平等」與「博愛」。

    例如：
    這位署名 "無名氏"的司法官強調，" 政府官員常說"惡法亦法" ，其實是欺負手無寸鐵的老百姓！"
    應該變成：
    這位署名「無名氏」的司法官強調，「政府官員常說『惡法亦法』，其實是欺負手無寸鐵的老百姓！」

    例如：
    " 常見的封包解析機制可以分為 " in-line 解析" 和 " sniffer 解析" 兩種方式, " 他表示。
    應該變成：
    「常見的封包解析機制可以分為『in-line解析』和『sniffer解析』兩種方式，」他表示。

    例如：
    “更厲害的來了，還有全形的喔！而且兩個不一樣，前面是“上引號”，後一個是“下引號”。”
    應該變成：
    「更厲害的來了，還有全形的喔！而且兩個不一樣，前面是『上引號』，後一個是『下引號』。」')

    user.posts.create!(title: ', ( ) ! / % : ; ~ ?', content: ', ( ) ! / % : ; ~ ?
    , ( ) ! / % : ; ~ ?
    , ( ) ! / % : ; ~ ?
    , ( ) ! / % : ; ~ ?
    , ( ) ! / % : ; ~ ?
    , ( ) ! / % : ; ~ ?
    .
    ..
    ...
    ....
    .....
    ......
    A.
    　一個全形空白
    　　兩個全形空白
    i am a student
    1 2 3 4 5')
  end
end
