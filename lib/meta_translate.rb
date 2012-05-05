module MetaTranslate
  def translation_for(*objects)
    objects.each do |object|
      define_method("#{object}") do |locale|
        if locale.to_s == 'zh'
          self.send("#{object}_zh")
        else
          self.send("#{object}_en")
        end
      end
    end
  end
end
ActiveRecord::Base.extend MetaTranslate