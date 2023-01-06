build-osm:
	@echo Building and tagging NOMINATIM
	docker build -t teamsviluppo/wharp-nominatim ./nominatim

build-production: build-osm
	@echo Building and tagging IMPORT
	docker build -t teamsviluppo/wharp-import ./import
	@echo Building and tagging BACKEND
	docker build -t teamsviluppo/wharp-backend ./backend
	@echo Building and tagging FRONTEND
	docker build -t teamsviluppo/wharp-frontend ./frontend
	@echo --- build-production finished ---

publish-stack:
	@echo Publishing
	docker-compose -f ./docker-compose.yml --env-file .env down
	docker-compose -f ./docker-compose.yml --env-file .env rm
	docker-compose -f ./docker-compose.yml --env-file .env build
	docker-compose -f ./docker-compose.yml --env-file .env up -d --remove-orphans
	@echo --- publish stack finished ---
	
publish-production: publish-stack
	docker run --network wharp --env-file .env -e PGHOST=db teamsviluppo/wharp-import python3 shape.py --file AK_VdA_elem_noti_lineare --schema gis
	docker run --network wharp --env-file .env -e PGHOST=db teamsviluppo/wharp-import python3 shape.py --file Archeo_VdA_puntuale --schema gis
	docker run --network wharp --env-file .env -e PGHOST=db teamsviluppo/wharp-import python3 shape.py --file Vincoli_Archeo_VdA_PRG_poligonale --schema gis
	docker run --network wharp --env-file .env -e PGHOST=db teamsviluppo/wharp-import python3 shape.py --file AK_VdA_elab_lineare --schema gis
	docker run --network wharp --env-file .env -e PGHOST=db teamsviluppo/wharp-import python3 shape.py --file Archeo_VdA_poligonale --schema gis
	docker run --network wharp --env-file .env -e PGHOST=db teamsviluppo/wharp-import python3 shape.py --file Archeo_VdA_lineare --schema gis
	docker run --network wharp --env-file .env -e PGHOST=db teamsviluppo/wharp-import python3 shape.py --file AK_VdA_elem_noti_poligonale --schema gis
	@echo --- publish geographical data finished ---
	docker run --network wharp --env-file .env -e PGHOST=db teamsviluppo/wharp-import python3 excel.py --file Anagrafica --schema administration
	docker run --network wharp --env-file .env -e PGHOST=db teamsviluppo/wharp-import python3 excel.py --file Bibliografia --schema administration
	docker run --network wharp --env-file .env -e PGHOST=db teamsviluppo/wharp-import python3 excel.py --file Cartografia --schema administration
	docker run --network wharp --env-file .env -e PGHOST=db teamsviluppo/wharp-import python3 excel.py --file Doc_Fotografica --schema administration
	docker run --network wharp --env-file .env -e PGHOST=db teamsviluppo/wharp-import python3 excel.py --file Epoca_Tipologia --schema administration
	docker run --network wharp --env-file .env -e PGHOST=db teamsviluppo/wharp-import python3 excel.py --file Sitografia --schema administration
	docker run --network wharp --env-file .env -e PGHOST=db teamsviluppo/wharp-import python3 excel.py --file Voc_Bibliografia --schema administration
	docker run --network wharp --env-file .env -e PGHOST=db teamsviluppo/wharp-import python3 excel.py --file Voc_Cartografia --schema administration
	docker run --network wharp --env-file .env -e PGHOST=db teamsviluppo/wharp-import python3 excel.py --file Voc_Epoca --schema administration
	docker run --network wharp --env-file .env -e PGHOST=db teamsviluppo/wharp-import python3 excel.py --file Voc_Info_Dato --schema administration
	docker run --network wharp --env-file .env -e PGHOST=db teamsviluppo/wharp-import python3 excel.py --file Voc_Posizionamento --schema administration
	docker run --network wharp --env-file .env -e PGHOST=db teamsviluppo/wharp-import python3 excel.py --file Voc_Tipologia --schema administration
	docker run --network wharp --env-file .env -e PGHOST=db teamsviluppo/wharp-import python3 excel.py --file Voc_Volumi --schema administration
	@echo --- publish data finished ---

