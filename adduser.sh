#!/bin/bash
adduser deploy
usermod -aG sudo deploy
rsync --archive --chown=deploy:deploy ~/.ssh /home/deploy


chmod -R g+w /var/www/folder


export SECRET_KEY_BASE=<rake secret>
ruby -e 'p ENV["SECRET_KEY_BASE"]'


sudo chown -R deploy "/var/www/folder"

ssh-keygen -t rsa
cd .ssh
touch authorized_keys
chmod 600 authorized_keys


Server tasks:
  mina deploy             # Deploy to the server.
  mina rails[arguments]   # Execute a Rails command in the current deploy.
  mina rake[arguments]    # Execute a Rake command in the current deploy.
  mina run[command]       # Runs a command in the server.
  mina setup              # Sets up a site.

More tasks:
  mina bundle:install                  # Install gem dependencies using Bundler.
  mina deploy:cleanup                  # Clean up old releases.
  mina deploy:force_unlock             # Forces a deploy unlock.
  mina deploy:link_shared_paths        # Links paths set in :shared_paths.
  mina git:clone                       # Clones the Git repository to the release path.
  mina nginx:restart                   # Restarts Nginx.
  mina rails:assets_precompile         # Precompiles assets (skips if nothing has changed since the last release).
  mina rails:assets_precompile:force   # Precompiles assets.
  mina rails:db_migrate
