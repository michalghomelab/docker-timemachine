FROM alpine:3.24

RUN apk add --no-cache --upgrade \
    avahi \
    samba \
    samba-client \
    supervisor \
    && rm -f /etc/avahi/services/*

COPY samba/samba.service /etc/avahi/services/samba.service
COPY samba/smb.conf /etc/samba/smb.conf
COPY samba/supervisord.conf /etc/supervisord.conf
COPY setup.sh samba/template_quota /tmp/

VOLUME ["/timemachine"]

EXPOSE 445

ENTRYPOINT ["/tmp/setup.sh"]

HEALTHCHECK --interval=5m --timeout=3s \
  CMD avahi-daemon -c && smbclient -L localhost -U '%' -m SMB3 >/dev/null 2>&1 || exit 1

CMD ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]
