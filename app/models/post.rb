class Post < ApplicationRecord
  enum publish: [:no, :yes]
  has_paper_trail
  validates :title, presence: true
  #before_update :replacesomething

  belongs_to :author, class_name: "User", foreign_key: :user_id
  belongs_to :portfolio

  def replacesomething(sanitizes)
    content = self.content
    patterns = sanitizes.select(:match, :result)

    patterns.each do |pattern|
      content = content.gsub( Regexp.new(pattern.match), pattern.result )
    end
    self.content = content
  end







#以下拿來測試用的
  def sanitize_not
    p = self.content
    #p = p.gsub('　', '    ') #全形空白代換成三個半形空白

    #p = p.gsub(/(\w) (?=\w)/, '\1 ') #處理空白--兩個英數字中間的空白會留著
    #p = p.gsub(/(\W) (?=\w)/, '\1') #處理空白--前面不是英數字，中間的空白刪掉

    p = p.gsub(/ (?=\/|／|[\u4e00-\u9fa5])/, '') #處理空白--空白後面接反斜線/英數字/中文的話就把空白去掉
    #p = p.gsub(/\/(?!\w)/, "／") #處理反斜線--斜線後面不接英文與數字的改成全形
    p = p.gsub(/／(?=\w)/, "/") #處理反斜線--全形斜線後面是英文字的再改回半形
    p = p.gsub(/([a-zA-Z])／/, '\1/') #處理反斜線--全形斜線前面是英文字的再改回半形


    p = p.gsub(/\"|“|”/, "〝")

    p = p.gsub(/ (?=[\u4e00-\u9fa5])| (?=／)/, '') #把中文字前面的空白去掉
    self.content = p
  end

  def placeholder
    p.each do |a|
      if a[/[\u4e00-\u9fa5]|\w/] != nil #段落內如果沒有中文英文字就省略
        b = Paragraph.new
        b.context_id = c.id
        a = a.strip #段落去頭尾空白
        a = a.gsub(/-{2,}/, "\u2014\u2014") #-- 改成破折號

        a = a.gsub(/\"(.*)\"/, '「\1」')
        a = a.gsub(/\"(.*)\"/, '『\1』')

        #a = a.gsub(/ /, '█')
        b.section = a
        b.save
      end
    end
  end

end
