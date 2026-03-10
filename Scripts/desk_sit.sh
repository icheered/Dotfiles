# bash
token=$(grep HA_TOKEN ~/Dotfiles/.env | cut -d'=' -f2) && curl -X POST -H 'Authorization: Bearer '$token -H 'Content-Type: application/json' http://192.168.5.145:8123/api/services/script/turn_on -d '{"entity_id": "script.desk_sitting"}'
