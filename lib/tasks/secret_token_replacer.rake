#
# Rake Task for replacing the secret-token in config/initializers/secret_token.rb
#
namespace :secret do
  desc 'Replace the secure secret key in your secret_token.rb'
  task :replace do
    pattern  = /(\.secret_token *= *')\w+(')/
    secret   = SecureRandom.hex(64)
    filepath = "#{Rails.root}/config/initializers/secret_token.rb"
    content  = File.read(filepath)
    
    unless pattern
      STDERR.puts "no secret token found in #{filepath}"
      exit 1
    end
    
    # replace the secret token
    content.gsub!(pattern,"\\1#{secret}\\2")
    
    # write the new configuration
    File.open(filepath, 'w') {|f| f.write(content) }
    
    puts "Secret token succesfully replaced"
  end
end
