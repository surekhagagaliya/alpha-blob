# config valid for current version and patch releases of Capistrano
lock "~> 3.17.0"

set :user, 'ubuntu'
set :application, 'alpha-blog'
set :deploy_to, '/home/ubuntu/alpha-blog'
set :repo_url, 'git@github.com:surekhagagaliya/alpha-blob.git'
set :branch, "master"
set :pty, true
set :use_sudo, false
set :deploy_via, :remote_cache
set :keep_releases, 2

set :linked_files, ['config/database.yml', 'config/credentials.yml.enc', 'config/master.key', 'config/storage.yml', 'config/credentials/production.yml.enc', 'config/credentials/production.key', 'config/unicorn.rb']
set :linked_dirs, %w[log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system]
set :stage, 'production'

set :ssh_options, forward_agent: true, user: fetch(:user), keys: %w[~/.ssh/id_ed25519.pub]

desc "Deploys the current version to the server."
namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
    invoke 'unicorn:stop'
    sleep(5)
    invoke 'unicorn:start'
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end

namespace :deploy do
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end
end

set :default_env, {
  PATH: '$HOME/.nvm/versions/node/v16.15.0/bin/:$PATH',
  NODE_ENVIRONMENT: 'production'
}