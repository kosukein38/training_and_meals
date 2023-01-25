desc "This task is called by the Heroku scheduler add-on"
task :test_scheduler => :environment do
  puts 'scheduler test'
  puts 'it works.'
end

task :create_sitemaps => :environment do
  rake 'sitemap:refresh'
end
