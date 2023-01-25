desc 'This task is called by the Heroku scheduler add-on'
task test_scheduler: :environment do
  puts 'scheduler test'
  puts 'it works.'
end
