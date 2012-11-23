#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Txtur::Application.load_tasks

desc 'reap orphaned tags'
task :reap_orphaned_tags => :environment do
  Tag.reap_orphaned_tags!
end
