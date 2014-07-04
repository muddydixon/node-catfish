# Catfish: server process monitoring and notification tool

Catfish is server process monitoring and notification agent.

## Install

```
$ npm install catfish
```

## Usage

Write json:

```json
{
    "interval": 5000,
    "specs": [
        {
            "name": "mysql (dummy)",
            "type": "ps",
            "value": "mysqld"
        },
        {
            "name": "redis (dummy)",
            "type": "ps",
            "value": "redis-server"
        }
    ],
    "notifications": [
        {
            "name": "slack",
            "type": "slack",
            "token": "<my token>",
            "domain": "<my domain>",
            "channel": "<my channel>",
            "username": "catfish"
        }
    ]
}
```

Exec this: (WIP)
```bash
./bin/catfish
```

## Plugins

### Specs

* process

### Notifications

* slack
