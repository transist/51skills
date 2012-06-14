# encoding: utf-8
class Email
  @queue = :send
  
  def self.build(subject, tos, template, info)
    email = Email.new
    email
  end
  
  def self.perform(email)
    put "*" * 80 + 'sending email'
  end
  
end