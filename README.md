1. docker-compose build --build-arg SSH_PRIVATE_KEY="`echo "$(cat ~/.ssh/id_rsa)"`"
2. docker-compose build --build-arg SSH_PRIVATE_KEY="`echo "$(cat ~/.ssh/id_rsa)"`" --build-arg POSTGRES_PASSWORD=<your password>
