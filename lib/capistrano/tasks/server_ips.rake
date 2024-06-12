namespace :server do
  desc "Outputs the server IPs for the current stage"
  task :ips do
    on roles(:all) do |host|
      puts host.hostname
    end
  end
end
