
## Set correct sequesnce value
```sql
SELECT
   setval(pg_get_serial_sequence('small_lotto_txs', 'id'), max("id"))
FROM
   "small_lotto_txs";
```

## postgresql CLI
```bash
sudo -u postgres psql
```


## postgresql backup
To back up a PostgreSQL database using the command line interface (CLI), you can use the `pg_dump` utility.

### **Basic Command Syntax**:
The basic command to back up a PostgreSQL database is:

```bash
pg_dump -U username -W -F c -b -v -f /path/to/backupfile.dump database_name
```

### Explanation of the options:
- `-U username`: Specifies the PostgreSQL username to connect with.
- `-W`: Prompt for the password of the specified user.
- `-F c`: Specifies the format of the backup. `c` stands for custom format (useful for restoring).
- `-b`: Include large objects (blobs) in the backup.
- `-v`: Verbose mode, which provides detailed output during the backup process.
- `-f /path/to/backupfile.dump`: Specifies the file path where the backup will be saved.
- `database_name`: The name of the database to back up.

### Example:
```bash
sudo su - postgres

# docker compose exec db pg_dump -U dev_user -W -b -f /usr/app/data/pg_data/db_dump.sql dev_db
pg_dump -U postgres -W -b -f /var/lib/postgresql/db_dump.sql leslie_db
exit
sudo cp /var/lib/postgresql/db_dump.sql db_dump.sql

# pg_dump -U leslie_admin -W -F d -b -f /var/lib/postgresql/db_dump leslie_db
# sudo chown www:www db_dump
# sudo find . -name "*.gz" -exec gunzip {} \;
# sudo find . -name "*.dat" -exec sh -c 'mv "$1" "${1%.dat}.sql"' _ {} \;
```




## restore database

format like this:
```sql
TRUNCATE TABLE player_lotto_txs;


COPY public.player_lotto_txs (id, wallet_from, wallet_to, txid, "timestamp", symbol, quantity) FROM stdin;
1	0xf37a22e8bf0514787c5dd2796ae7382578a6f72d	0xc6dad0643fb91eba46b20d1248ac575fc2352b60	0x993e405937465c721289d3d1e4c05dffe4c01b6dd68ac3e115f2f92aaaa5557a	1725665327	ETH	0.01
71	0x17d2836e7948f87837d5bb32c0eee1e81d0dd090	0xc6dad0643fb91eba46b20d1248ac575fc2352b60	0xb8d733eb3d73643c1e94fae71d6230a1ee2608d0a742dc8639512df8e37b0ff4	1737065459	ETH	0.01
\.

SELECT setval(pg_get_serial_sequence('player_lotto_txs', 'id'), max("id")) FROM "player_lotto_txs";

```

```bash
# Get-Content db_dump.sql | ForEach-Object { $_ -replace '^\d+\t', '' } | Set-Content db_dump.sql
sed 's/^\d\+\t//g' db_dump.sql > db_dump.sql

```

execute command
```bash
# docker compose exec db psql -U dev_user dev_db -f /usr/app/data/pg_data/db_dump.sql
sudo cp db_dump.sql /var/lib/postgresql/db_dump.sql
sudo su - postgres
psql -U postgres -d leslie_db -f ./db_dump.sql
```



```SQL
SELECT setval(pg_get_serial_sequence('django_admin_log', 'id'), max("id")) FROM "django_admin_log";
```