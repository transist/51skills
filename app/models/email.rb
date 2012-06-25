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
    template_hash = EmailTemplate.get_html_hash(template_name)
    template_html = Document.new(File.read(Rails.root.to_s+"/app/views/email_templates/_template.html.erb")).interpolate(template_hash)
    template_text = Document.new(File.read(Rails.root.to_s+"/app/views/email_templates/_template.text.erb")).interpolate(template_hash)
    html = Premailer.new(Document.new(template_html).interpolate(hash_info), {:with_html_string => true}).to_inline_css
    text = Document.new(template_text).interpolate(hash_info)
    puts hash_info
    puts text
    puts html
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
    puts params['TextBody']
    puts params['HtmlBody']
    params['TextBody'] = params['TextBody'].encode Encoding::UTF_8
    params['HtmlBody'] = params['HtmlBody'].encode Encoding::UTF_8
    puts params['TextBody']
    puts params['HtmlBody']
    puts params.to_yaml
    EmailYak::Email.send(params)
    true
  rescue Exception => e  
    puts e.message
    puts e.backtrace.inspect  
    false
  end
  
  def hash_info
    eval info.encode
  end
  
  def self.gen_uuid
    UUID.new.generate
  end
end
