require 'nokogiri'
require 'prawn'

module PrawnHelper
  
  def self.parse(html)
    
    doc = Nokogiri::HTML.parse(html)
    
    result = html
    doc.css('ul').each do |ul|
      puts "parsing ul"      
      res = "<br/>"
      ul.css('li').each_with_index do |li, index|      
        res << "- #{li.inner_html} <br/>"
      end
      result.sub!(/<ul>.*?<\/ul>/, res)
    end

    doc.css('ol').each do |ul|
      puts "parsing ol"
      res = "<br/>"
      ul.css('li').each_with_index do |li, index|
        res << "#{index+1}. #{li.inner_html} <br/>"
      end
      result.sub!(/<ol>.*?<\/ol>/, res)      
    end

    result.gsub!(/<p>/, '#BREAK#')
    result.gsub!(/<\/p>/, '')
                
    # puts result
    res_list = result.split(/#BREAK#/)
    
    res_list
  end
  
  # "<p><ul><li>a</li><li>b</li></ul></p> <p><ol><li>Alpha</li><li>Beta</li></ol> </p>"
  def self.do_pdf(str)
    
    Prawn::Document.generate('basics.pdf') do
      tags :h1 => { :font_size => "3em", :font_weight => :bold },
           :h2 => { :font_size => "2em", :font_style => :italic }
      
      text "<h2>Talks submitted</h2>"      

      list = PrawnHelper::parse(str)

      list.each do |item|
        move_down(12)
        text item
      end
    end    
  end

end