remove-docker-error:
	sudo chown -R ${USER}:root .docker
	sudo chmod -R 755 .docker

restart-supabase:
	cd .docker && docker compose up -d --force-recreate
