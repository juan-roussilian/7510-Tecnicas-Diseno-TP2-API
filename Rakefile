require 'bundler/setup'

ENV['APP_ENV'] ||= 'test'

task :version do
  require './lib/version'
  puts Version.current
  exit 0
end

namespace :db do
  require 'sequel'
  require_relative 'config/configuration'
  Sequel.extension :migration
  desc 'Run migrations'
  task :migrate do |_t|
    logger = Configuration.logger
    db = Configuration.db
    db.loggers << logger
    Sequel::Migrator.run(db, 'db/migrations')
    puts '<= sq:migrate:up executed'
  end
end

require 'rubocop/rake_task'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.options = ['--display-cop-names']
end

require 'cucumber/rake/task'
Cucumber::Rake::Task.new(:cucumber) do |task|
  task.cucumber_opts = ['features', '--publish-quiet', '--tags \'not @wip\'']
end

Cucumber::Rake::Task.new(:acceptance_report) do |task|
  task.cucumber_opts = ['features', '--publish-quiet', '--tags \'not @wip\'', '--format pretty',
                        '--format html -o reports/cucumber.html']
end

Cucumber::Rake::Task.new(:acceptance_report_remote) do |task|
  task.cucumber_opts = ['features', '--publish-quiet', '--tags \'not @wip and not @local\'', '--format pretty',
                        '--format html -o reports/cucumber.html']
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |task|
  task.rspec_opts = '--color --format d'
end

RSpec::Core::RakeTask.new(:spec_report) do |t|
  t.rspec_opts = %w[--format progress --format RspecJunitFormatter --out reports/spec/rspec.xml]
end

Cucumber::Rake::Task.new(:feature_indev) do |task|
  task.cucumber_opts = ['features', '--tags \'@indev\'']
end

task ci: %i[acceptance_report spec_report rubocop]

task default: %i[cucumber spec rubocop]
