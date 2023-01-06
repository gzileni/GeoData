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
	docker run --network geodata --env-file .env -e PGHOST=db gzileni/geodata-import python3 shape.py --file CentriStorici --schema gis
	docker run --network geodata --env-file .env -e PGHOST=db gzileni/geodata-import python3 shape.py --file EdificatoAnte1945 --schema gis
	docker run --network geodata --env-file .env -e PGHOST=db gzileni/geodata-import python3 shape.py --file HPH_Mosaicatura_ISPRA_2020_pericolosita_idraulica_elevata --schema gis
	docker run --network geodata --env-file .env -e PGHOST=db gzileni/geodata-import python3 shape.py --file LPH_Mosaicatura_ISPRA_2020_pericolosita_idraulica_bassa --schema gis
	docker run --network geodata --env-file .env -e PGHOST=db gzileni/geodata-import python3 shape.py --file LPH_Mosaicatura_ISPRA_2020_pericolosita_idraulica_bassa --schema gis
	docker run --network geodata --env-file .env -e PGHOST=db gzileni/geodata-import python3 shape.py --file Mosaicatura_ISPRA_2020_2021_aree_pericolosita_frana_PAI --schema gis
	docker run --network geodata --env-file .env -e PGHOST=db gzileni/geodata-import python3 shape.py --file MPH_Mosaicatura_ISPRA_2020_pericolosita_idraulica_media --schema gis
	@echo --- publish data finished ---

