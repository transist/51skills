class EmailTemplate < ActiveRecord::Base
  attr_accessible :html, :text, :name
  
  def self.get_html_hash(template_name)
    email_template = EmailTemplate.find_by_name(template_name)
    hash = {}
    hash[:html] = email_template.html
    hash[:text] = email_template.text
    hash
  end
end
