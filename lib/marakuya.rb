require 'rdiscount'

class Marakuya
  VERSION = '0.4'

  def initialize text, opts = {}
    defaults = {:smart => true, :filter_styles => false, :filter_html => true, :fold_lines => false, :generate_toc => false}
    @rdisc   = RDiscount.new text, *defaults.collect{ |key, val| next key if opts[key] and opts.key?(key) or defaults[key] }.compact
  end

  def text; @rdisc.text; end
  def text= str; @rdisc.text = str; end

  def to_html
    str        = @rdisc.to_html
    str.gsub! %r{\s*(<|&lt;)br\s*/?>\s*\n?},  "<br />\n" # Fix line breaks
    str.gsub! %r{(\s+)(http://(?:\w|\.)*)\b}, '\1<a href="\2">\2</a>' # Extract hyperlinks
    str.gsub! %r{&lt;a([^\n]*)&lt;/a>},       '<a\1</a>' # Recover escaped hyperlinks
    
    tag_regexp  = lambda{ |tag| %r{<(#{ tag })(?:\s*([^>]*))>(\n?(?:.*\n|.*)+?)</#{ tag }>}i }
    str.gsub! tag_regexp.call(/p|li/i) do |match| # For contents of paragraph and li change newline for html break tag
      %{<#{ tag = $1 }#{ ' ' + $2 unless $2.empty? }>#{ $3.gsub /(\w)\s*\n(\s*\w)/, "\\1<br />\n\\2" }</#{ tag }>}
    end

    str
  end
end