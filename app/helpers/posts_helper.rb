module PostsHelper
  def myhighlight(text)
    # Based on ActionView::Helpers::TextHelper#highlight
    if @sanitizes != nil
      @sanitizes.each do |sanitize|
        if sanitize.result.length > 0
          #抓出符合規則的部份上色
          text = text.gsub(Regexp.new(sanitize.match), '<span class="expect">\&</span>')
        end
      end
    end
    return text
  end

  def myhighlight_result(text)
    # Based on ActionView::Helpers::TextHelper#highlight
    if @sanitizes != nil
      @sanitizes.each do |sanitize|
        if sanitize.result.length > 0
          #抓出符合結果的部份上色
          text = text.gsub(sanitize.result, '<span class="result">\&</span>')
        end
      end
    end
    return text
  end
end
