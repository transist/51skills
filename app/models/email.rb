# encoding: UTF-8
class Email < ActiveRecord::Base
  attr_accessible :info, :subject, :template_name, :to_address

  @queue = :send
  
  def self.build(subject, to_address, template_name, info)
    email = Email.new
    email.subject = subject
    email.to_address = to_address
    email.template_name = template_name
    email.info = info.to_s
    email
  end
  
  def self.perform(email_id)
    puts "*" * 80 + 'sending email'
    email = Email.find_by_id(email_id)
    email.send_me if email
    puts email.inspect if email
    puts "*" * 80 + 'sended'
  end
  
  def send_me
    template_html_hash = EmailTemplate.get_html_hash(template_name)
    html = Premailer.new(Document.new(File.read(Rails.root.to_s+"/app/views/email_templates/_template.html.erb")).interpolate(template_html_hash), {:with_html_string => true}).to_inline_css
    
    text = Document.new(File.read(Rails.root.to_s+"/app/views/emails/templates/#{template_name}.text.erb")).interpolate(hash_info)
    #html = Premailer.new(Document.new(File.read(Rails.root.to_s+"/app/views/emails/templates/#{template_name}.html.erb")).interpolate(hash_info), {:with_html_string => true}).to_inline_css
    params = {
     "ToAddress"=> to_address, 
     "FromName"=> '51skills', 
     "SenderAddress"=> "notifications@51skills.simpleyak.com", 
     "Headers"=> [
       {
         "Name"=> "Reply-To", 
         "Value"=>"notifications@51skills.simpleyak.com"
       }
     ], 
     "ReplyToAddress"=> "notifications@51skills.simpleyak.com", 
     "FromAddress"=> "notifications@51skills.simpleyak.com", 
     "TextBody"=> text, 
     "HtmlBody"=> html,
     "Subject"=> "51skills | " + subject
    }
    puts params.to_yaml
    EmailYak::Email.send(params)
    true
  rescue Exception => e  
    puts e.message
    puts e.backtrace.inspect  
    false
  end
  
  def hash_info
    eval info
  end
end
