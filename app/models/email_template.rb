class EmailTemplate < ActiveRecord::Base
  attr_accessible :name, :text, :html
  
  def html_head
    %q{
      <!DOCTYPE html>
      <html>
        <head>
          <meta content="text/html; charset=UTF-8" http-equiv="Content-Type" />
          <style type="text/css">

          </style>
        </head>
        <body>
    }
  end
  
  def html_end
    %q{
      </body>
    </html>
    }
  end
  
  def to_html
    html_head + self.html + html_end
  end
  
  def to_text
    self.text
  end
end
