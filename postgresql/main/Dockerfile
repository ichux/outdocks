FROM postgres:12
USER postgres

RUN echo "listen_addresses='*'" >> /etc/postgresql/postgresql.conf
RUN echo "max_connections=100" >> /etc/postgresql/postgresql.conf
RUN echo "shared_preload_libraries='pg_stat_statements'" >> /etc/postgresql/postgresql.conf

EXPOSE 5432

VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]
CMD ["-c", "config_file=/etc/postgresql/postgresql.conf"]
