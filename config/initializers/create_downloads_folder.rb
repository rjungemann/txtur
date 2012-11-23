folder_name = File.join(Rails.root, 'tmp', 'downloads')

unless File.exists? folder_name
  Dir.mkdir folder_name
end

