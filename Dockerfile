# Treballarem amb la versio 20.04 Ubuntu
FROM ubuntu:20.04

# Farem un update abans d'instalar el servei DLNA
RUN apt-get update
RUN apt-get install  minidlna -y

# Crearem en el nostre contenidor un archiu on ficarem la configuracio del servei DLNA
COPY minidlna.conf /etc/minidlna.conf

# Amb aquesta comanda farem la copia del video en el nostre directori arrel
COPY video.mp4 /var/lib/minidlna/

# Donem permisos al nostre directori 
RUN chown -R minidlna:minidlna /var/lib/minidlna && chmod -R 777 /var/lib/minidlna

# Exposem els ports que utilitzarem
EXPOSE 8200
EXPOSE 554
#EXPOSE 1900

# Aquesta comanda iniciara el servei DLNA quan activem el docker-compose
CMD ["sh", "-c", "service minidlna start && tail -f /var/log/minidlna.log"]
