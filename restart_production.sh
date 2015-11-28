#!/usr/bin/env bash

export RAILS_ENV="production"
export SECRET_KEY_BASE="c4b5de8b75a6e9aec6689c703444a3be387008b7e04cd49f3f2d58a6b56961e0f7abb66c82adcbe5f088871cf33a6346f984eff682d84ffcea2bcc477cb8abfd"

echo $RAILS_ENV

echo "Assets precompile"
rake assets:precompile

echo "Restart server"
pumactl -F config/puma.rb stop
pumactl -F config/puma.rb start
