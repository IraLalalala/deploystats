powershell -Command "Invoke-WebRequest https://www.dropbox.com/s/6qbyczs8ucub4hk/carstats.env?dl=1 -OutFile carstats.env"
docker-compose build
docker-compose up -d
rm carstats.env