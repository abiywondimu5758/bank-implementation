postgres:
	docker run --name postgres17 -p 5432:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=root -d postgres:17.4-alpine3.21

createdb:
	docker exec -it postgres17 createdb --username=postgres --owner=postgres simple_bank

dropdb:
	docker exec -it postgres17 dropdb -U postgres simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://postgres:root@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://postgres:root@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

.PHONY: postgres createdb dropdb migrateup migratedown sqlc test
