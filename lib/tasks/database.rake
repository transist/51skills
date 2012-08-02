namespace :db do
  task :seed do
    system "psql -d #{ActiveRecord::Base.connection_config[:database]} < #{Rails.root.join('db/seeds.sql')}"
  end
end
