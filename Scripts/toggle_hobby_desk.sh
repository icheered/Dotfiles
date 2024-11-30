# bash
token=$(grep HA_TOKEN ~/Dotfiles/.env | cut -d'=' -f2) && curl -X POST -H 'Authorization: Bearer '$token -H 'Content-Type: application/json' http://192.168.5.145:8123/api/services/switch/toggle -d '{"entity_id": "switch.0x6cfd22fffe1a1835"}'
