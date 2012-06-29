require 'resque/tasks'

desc "Migrate People Data so sperate person model and provider model"
task :migrate_people_data => :environment do
  people =  Person.where('provider is not null')
  people.each do |person|
    unless Provider.find_by_uid_and_provider(person.uid, person.provider)
      provider = Provider.new
      provider.uid = person.uid
      provider.username = person.username
      provider.token = person.token
      provider.secret = person.secret
      provider.provider = person.provider
      provider.profile_attributes = person.profile_attributes
      provider.email = person.email_address
      provider.person_id = person.id
      provider.save
    end
    person.email = person.email_address if person.email.blank?
    person.save
  end
end