# Installation

## Server bootstrap

```shell
cd /tmp
git clone git@github.com:pachkovsky/cookbooks.git
cd cookbooks
sudo ./bootstrap
```

## Deploy with Capistrano

```shell
cap <server> deploy:setup
cap <server> deploy:check
create config files in shared folder (see symlink_configs task)
cap <server> deploy:update (to test if everything is ok)
cap <server> deploy:cold
cap <server> deploy
```