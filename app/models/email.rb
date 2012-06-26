# encoding: UTF-8
class Email < ActiveRecord::Base
  attr_accessible :info, :subject, :template_name, :to_address, :code

  @queue = :send
  
  def self.build(subject, to_address, template_name, info, gen)
    email = Email.new
    email.subject = subject
    email.to_address = to_address.downcase
    email.template_name = template_name
    if gen  
      email.code = (gen ? gen_uuid : nil)
      url_hash = {:url => "http://51skills.com/subscribe_confirm?code=#{email.code}"}
      email.info = info.merge(url_hash).to_s
    else
      email.info = info.to_s
    end
    
    email
  end
  
  def self.perform(email_id)
    email = Email.find_by_id(email_id)
    email.send_me if email
  end
  
  def send_me
    template = EmailTemplate.find_by_name(template_name)
    text = Document.new(template.to_text).interpolate(hash_info)
    html = Document.new(template.to_html).interpolate(hash_info)
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
  
  def self.gen_uuid
    UUID.new.generate
  end
end
