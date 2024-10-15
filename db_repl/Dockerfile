FROM postgres:15.6

USER postgres

CMD ["bash", "-c", "until pg_basebackup --pgdata=/var/lib/postgresql/data -R --host=postgres_primary --port=5432; do echo 'Waiting for primary to connect...'; sleep 1s; done; echo 'Backup done, starting replica...'; chmod 0700 /var/lib/postgresql/data; exec postgres"]
