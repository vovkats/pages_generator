class PageDecorator < Draper::Decorator
  delegate_all

  def processed_content
    content = bold(self.content)
    content = italic(content)
    content = link(content)
    content = br(content)
    content.html_safe
  end

  private

  def bold(content)
    content.gsub(/\*\*\[(([[:alnum:]]|\W)+?)\]\*\*/, '<b>\1</b>')
  end

  def italic(content)
    content.gsub(/\\\[(([[:alnum:]]|\W)+?)\]\\/, '<i>\1</i>').gsub(/\\/, '')
  end

  def link(content)
    content.gsub(/\(\((([[:alnum:]]\/?)+)\W?(\[([[:alnum:]]|\W+)+?\])\)\)/, '<a href="/\1">\3</a>')
      .gsub(/\[/, '')
      .gsub(/\]/, '')
  end

  def br(content)
    content.gsub(/\n/, '<br>')
  end
end
