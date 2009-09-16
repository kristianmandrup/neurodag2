require 'prawn'

# Prawn::Document.generate('basics.pdf') do
pdf.tags :h1 => { :font_size => "3em", :font_weight => :bold },
         :h2 => { :font_size => "2em", :font_style => :italic }
  
pdf.text "<h2>Talks submitted</h2>"

string = "<p><i>Alphabet soup</i> <ul><li>a</li> <li><b>b</b></li>  </ul></p> <p> <b>Numbered list</b> <ol> <li>Alpha</li> <li><i>Beta</i></li></ol> </p>"    

list = PrawnHelper::parse(string)

list.each do |item|  
  pdf.move_down(12)
  logger.debug(item)  
  pdf.text item
end

# prawnto :prawn => { :top_margin => 75 }  


