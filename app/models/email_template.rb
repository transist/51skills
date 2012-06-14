class EmailTemplate < ActiveRecord::Base
  attr_accessible :html, :name
  
  def self.get_html_hash(template_name)
    email_template = EmailTemplate.find_by_name(template_name)
    hash = {}
    hash[:template] = email_template.html
    hash
  end
end
