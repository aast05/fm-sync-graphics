#!/bin/bash


mkdir -p  ~/.config/systemd/user/


sed "s|\$BASE_PATH|\"$(pwd)\"|g" sync-graphics.service.template > sync-graphics.service

cat sync-graphics.service

cp sync-graphics.service ~/.config/systemd/user/sync-graphics.service


systemctl --user daemon-reload
systemctl --user restart sync-graphics.service

# verify that the service is available
systemctl --user list-unit-files sync-graphics.service

# and show his status 
systemctl --user status sync-graphics.service
