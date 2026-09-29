sudo su - postgres -c 'psql -d yiccodef -c"SELECT datname, pg_size_pretty(pg_database_size(datname)) FROM pg_database;" -t'
 postgres  | 356 MB
 yiccodef  | 8277 kB
 template1 | 7841 kB
 template0 | 7737 kB
 yisdata   | 1323 MB
