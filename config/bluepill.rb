# -*- encoding : utf-8 -*-
ENV['RAILS_ENV'] = 'production'

# Whenever this file is updated, make sure to update bluepill-initscript.sh!

Bluepill.application('rletters') do |app|

  app.uid = app.gid = 'rletters_deploy'

  app.process('unicorn') do |proc|
    proc.start_command = 'bundle exec unicorn -c /opt/rletters/root/config/unicorn.rb -E production -D'
    proc.stop_command = 'kill -QUIT {{PID}}'
    proc.restart_command = 'kill -USR2 {{PID}}'

    proc.pid_file = '/opt/rletters/root/tmp/pids/unicorn.pid'
    proc.working_dir = '/opt/rletters/root'

    proc.start_grace_time = 60
    proc.stop_grace_time = 60
    proc.restart_grace_time = 180

    proc.monitor_children do |child_process|
      child_process.stop_command = 'kill -QUIT {{PID}}'

      child_process.checks :mem_usage, every: 3.minutes, below: 200.megabytes, times: [3,4], fires: :stop
      child_process.checks :cpu_usage, every: 3.minutes, below: 40, times: [3,4], fires: :stop
    end
  end

  app.process('clockwork') do |proc|
    clockwork_args = '--pid-dir=/opt/rletters/root/tmp/pids --log-dir=/opt/rletters/root/log --log -i 0 --clock=/opt/rletters/root/config/clock.rb'

    proc.start_command = "bundle exec clockworkd #{clockwork_args} start"
    proc.stop_command = "bundle exec clockworkd #{clockwork_args} stop"
    proc.restart_command = "bundle exec clockworkd #{clockwork_args} restart"

    proc.pid_file = '/opt/rletters/root/tmp/pids/clockworkd.0.pid'
    proc.working_dir = '/opt/rletters/root'

    proc.start_grace_time = 60
    proc.stop_grace_time = 60
    proc.restart_grace_time = 60
  end

  app.process('resque-pool') do |proc|
    proc.start_command = 'bundle exec resque-pool --daemon --environment production'
    proc.stop_command = 'kill -QUIT {{PID}}'
    proc.restart_command = 'kill -HUP {{PID}}'

    proc.pid_file = '/opt/rletters/root/tmp/pids/resque-pool.pid'
    proc.working_dir = '/opt/rletters/root'

    proc.start_grace_time = 60
    proc.stop_grace_time = 60
    proc.restart_grace_time = 180
  end

end