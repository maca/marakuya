require 'rdiscount'
require 'evil_spambots'

module Marakuya
  extend self
  VERSION      = '0.4.4'
  EMAIL_REGEXP = %r{[a-z0-9!\#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!\#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?}
  URL_REGEXP   = %r{
    \b
    (?:
      (?:http)://[-\w]+(?:\.\w[-\w]*)+
    |
      (?i: [a-z0-9] (?:[-a-z0-9]*[a-z0-9])? \. )+
      (?-i: com\b
          | edu\b
          | biz\b
          | gov\b
          | in(?:t|fo)\b
          | mil\b
          | net\b
          | org\b
          | [a-z][a-z]\.[a-z][a-z]\b
      )
    )
    ( : \d+ )?
    (?:
      /
      [^.!,?;"\'<>()\[\]\{\}\s\x7F-\xFF]*
      (?:
        [.!,?]+ [^.!,?;"\'<>()\[\]\{\}\s\x7F-\xFF]+
      )*
    )?
  }ix
  
  private
  DEFAULTS    = {:smart => true, :filter_styles => false, :filter_html => true, :fold_lines => false, :generate_toc => false} #Just Rdiscont defaults
  
  public
  
  # Convert markdown encoded text into html using Rdiscount and in addition it applies some changes:
  # 
  # * Explicit BR tags are kept.
  # * New lines inside p and li tags are converted to BR tags.
  # * URLs will be auto converted to links.
  # * Email addresses will be auto converted to mailto links and obfuscated using javascript (http://hivelogic.com/enkoder/form).
  # * Emails will be obfuscated if passing the obfuscate option as true
  # 
  # Options:
  # 
  # * obfuscate: +boolean+
  #   when it will obfuscate the email addresses to protectect them from spambot harvesting
  # * smart: +boolean+
  #   whether or not to use smart quoutation marks (auto closing), defaults to true
  # * filter_html +boolean+
  #   whether or not it will escape existing html, defaults to true
  # * fold_lines
  # * generate_toc
  # 
  def markdown_to_html text, opts = {}
    obfuscate = opts.delete(:obfuscate)
    rdisc     = RDiscount.new text, *DEFAULTS.collect{ |key, val| next key if opts[key] and opts.key?(key) or DEFAULTS[key] }.compact
    str       = rdisc.to_html
    
    str.gsub! %r{\s*(<|&lt;)br\s*/?>\s*\n?},  "<br />\n"          # Fix line breaks
    
    str.gsub! /(\s)(#{ URL_REGEXP })/, '\1<a href="\2">\2</a>'    # Extract hyperlinks
    
    str.gsub! %r{&lt;a([^\n]*)&lt;/a>}, '<a\1</a>'                # Recover escaped hyperlinks
    
    str.gsub! EMAIL_REGEXP do |email|                          
      obfuscate ? EvilSpambots.obfuscate_email(email) : %{<a href="mailto:#{ $~ }">#{ $~ }</a>}
    end
    
    str.gsub! tag_content_regexp(/p|li/i) do |match| # For contents of paragraph and li change newline for html break tag
      %{<#{ tag = $1 }#{ ' ' + $2 unless $2.empty? }>#{ $3.gsub /(\w)\s*\n(\s*\w)/, "\\1<br />\n\\2" }</#{ tag }>}
    end
    
    str
  end
  alias :to_html  :markdown_to_html
  alias :mk       :markdown_to_html
  
  def tag_content_regexp tag
    %r{<(#{ tag })(?:\s*([^>]*))>(\n?(?:.*\n|.*)+?)</#{ tag }>}i
  end
end

ActionView::Helpers::TextHelper.send(:include, Marakuya) rescue nil

