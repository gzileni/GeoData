build-production:
	@echo Building and tagging IMPORT
	docker build -t gzileni/geodata-import ./import
	@echo --- build-production finished ---

publish-stack:
	@echo Publishing
	docker-compose -f ./docker-compose.yml --env-file .env down
	docker-compose -f ./docker-compose.yml --env-file .env rm
	docker-compose -f ./docker-compose.yml --env-file .env build
	docker-compose -f ./docker-compose.yml --env-file .env up -d --remove-orphans
	@echo --- publish stack finished ---
	
publish-production: publish-stack
	docker run --network geodata --env-file .env -e PGHOST=db --cpus=".75" --memory=4g gzileni/geodata-import python3 shape.py --file oldtown --schema gis
	docker run --network geodata --env-file .env -e PGHOST=db --cpus=".75" --memory=4g gzileni/geodata-import python3 shape.py --file build45 --schema gis
	docker run --network geodata --env-file .env -e PGHOST=db --cpus=".75" --memory=4g gzileni/geodata-import python3 shape.py --file idro_h --schema gis
	docker run --network geodata --env-file .env -e PGHOST=db --cpus=".75" --memory=4g gzileni/geodata-import python3 shape.py --file idro_l --schema gis
	docker run --network geodata --env-file .env -e PGHOST=db --cpus=".75" --memory=5g gzileni/geodata-import python3 shape.py --file idro_m --schema gis
	docker run --network geodata --env-file .env -e PGHOST=db --cpus=".75" --memory=6g gzileni/geodata-import python3 shape.py --file landsli --schema gis
	@echo --- publish data finished ---

