# A sample Guardfile
# More info at https://github.com/guard/guard#readme

interactor :readline

case RbConfig::CONFIG['host_os'].downcase
when /linux/
  notification :libnotify
when /darwin/
  notification :growl_notify
end

guard 'bundler' do
  watch('Gemfile')
end

guard 'spork', bundler: false, wait: 120 do
  watch('Gemfile')
  watch('Gemfile.lock')
  watch('config/application.rb')
  watch('config/environment.rb')
  watch(%r{^config/environments/.*\.rb$})
  watch(%r{^config/initializers/.*\.rb$})
  watch('spec/spec_helper.rb')
end

guard 'rspec', bundler: false, all_on_start: false, all_after_pass: false, cli: '--drb --format doc' do
  # watch(%r{^spec/.+_spec\.rb$})
  # watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  # watch(%r{^app/(.*)(\.erb|\.haml)$})                 { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
  # watch(%r{^lib/(.+)\.rb$})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
  # watch('spec/spec_helper.rb')                        { 'spec' }
  # watch('config/routes.rb')                           { 'spec/routing' }

  # watch(%r{^spec/factories/(.*)\.rb})                     { 'spec/models' }
end

guard 'cucumber', bundler: false, all_on_start: false, all_after_pass: false, keep_failed: false, cli: '--profile guard' do
  # watch(%r{^features/.+\.feature$})
end

guard 'yard', stdout: 'log/yard.log', stderr: '/dev/null' do
  watch(%r{app/.+\.rb})
  watch(%r{lib/.+\.rb})
  watch(%r{ext/.+\.c})
  watch(%r{.+\.markdown})
  watch('.yardopts')
end

# vim: set ft=ruby:
