#!/usr/bin/env puma

environment ENV['RAILS_ENV']
daemonize true
pidfile 'tmp/pids/puma.pid'
state_path 'tmp/pids/puma.state'
bind 'unix://tmp/sockets/puma.sock'
