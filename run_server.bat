cd /d %~dp0

docker run -it -p 80:80 -p 22123:22 ^
-v "%cd%\ssh-key\authorized_keys":/root/.ssh/authorized_keys:ro ^
-v "%cd%\beets-data":/radio-stream/data ^
-v "%cd%\scripts\bundled":/radio-stream/scripts/bundled ^
-v "%cd%\scripts\user":/radio-stream/scripts/user ^
-v "%userprofile%\Music\beets-music":/radio-stream/music ^
vitalybe/radio-stream %*