{
          "log": {
            "access": "none",
            "loglevel": "none"
          },
          "inbounds": [
            {
              "port": 80,
              "protocol": "vless",
              "settings": {
                "decryption": "none",
                "clients": [
                  {
                    "id": "798204ad-2a2d-4f66-bc88-88bfe11946f8"
                  }
                ]
              },
              "streamSettings": {
                "network":"ws",
                "wsSettings": {
                  "path": "/798204ad"
                }
              }
            }
          ],
          "outbounds": [
            {
              "protocol": "freedom"
            }
          ]
        }
