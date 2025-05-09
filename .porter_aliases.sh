# Porter aliases

export STAGING_CLUSTER=1359
export PRODUCTION_CLUSTER=1772

function ppge() {
	porter update get-env --cluster $PRODUCTION_CLUSTER --namespace $1 --app web-worker | grep $2
}

function psge() {
	porter update get-env --cluster $STAGING_CLUSTER --namespace $1 --app web-worker | grep $2
}

function ppdb() {
	porter run --cluster $PRODUCTION_CLUSTER -e netbox --namespace default --non-interactive -- psql $(ppge badger-go DATABASE_URL | cut -d'=' -f2)
}

function psdb() {
	porter run --cluster $PRODUCTION_CLUSTER -e netbox --namespace default --non-interactive -- psql $(psge go-sandbox DATABASE_URL | cut -d'=' -f2)
}
