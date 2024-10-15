FROM postgres:15.6

RUN apt-get update && apt-get install -y openssh-server
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN echo "root:qwe" | chpasswd

COPY  ./init.sql /docker-entrypoint-initdb.d/
RUN mkdir -p /oracle/pg_data/archive
RUN chown postgres:postgres /oracle/pg_data/archive
RUN mkdir -p /etc/postgresql/

ENTRYPOINT [ "bash", "-c", "\
cat <<EOF > /etc/postgresql/postgresql.conf \n\
archive_mode = on \n\
archive_command = 'cp %p /oracle/pg_data/archive/%f' \n\
listen_addresses = '*' \n\
max_wal_senders = 10 \n\
wal_level = replica \n\          
wal_log_hints = on \n\
logging_collector = on \n\
log_directory = '/var/log/postgresql/' \n\
log_filename = 'postgresql.log' \n\
log_replication_commands = on \n\
EOF\n\
cat <<EOF > /etc/postgresql/pg_hba.conf \n\
local all all trust \n\
local all postgres peer \n\
host postgresql all 0.0.0.0/0 trust \n\
host replication all 0.0.0.0/0 trust \n\
EOF\n\
service ssh restart \n\
docker-entrypoint.sh $@"]

CMD ["postgres", "-c", "config_file=/etc/postgresql/postgresql.conf", "-c", "hba_file=/etc/postgresql/pg_hba.conf"]
