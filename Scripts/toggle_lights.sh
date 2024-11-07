# bash
token=$(grep HA_TOKEN ~/Dotfiles/.env | cut -d'=' -f2) && curl -X POST -H 'Authorization: Bearer '$token -H 'Content-Type: application/json' http://192.168.5.145:8123/api/services/light/toggle -d '{"entity_id": "light.light1"}'
