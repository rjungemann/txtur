#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Txtur::Application.load_tasks

namespace :tags do

  desc 'reap orphaned tags'
  task :reap_orphaned => :environment do
    Tag.reap_orphaned!
  end

end

namespace :downloads do

  desc 'remove temporary files'
  task :cleanup do
    FileUtils.rm_r Dir.glob(Rails.root.join('tmp', 'download*'))
  end

end

