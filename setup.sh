#!/bin/sh

#defaults
TM_USER="${TM_USER:-timemachine}"
TM_PW="${TM_PW:-timemachine}"
TM_ID="${TM_ID:-1000}"
TM_SIZE="${TM_SIZE:-250}"
#Add smb user
    grep -q "^${TM_USER}:" /etc/passwd ||
        adduser -D -H ${TM_GROUP:+-G $TM_GROUP} ${TM_ID:+-u $TM_ID} "${TM_USER}"
    echo -e "${TM_PW}\n${TM_PW}" | smbpasswd -s -a "${TM_USER}"

## timemachine location
if [ ! -d "/timemachine" ]; then
    mkdir "/timemachine"
fi


chown -R ${TM_USER} "/timemachine"
TM_SIZE=$(($TM_SIZE * 1000000000))
sed "s#REPLACE_TM_SIZE#${TM_SIZE}#" /tmp/template_quota > /timemachine/.com.apple.TimeMachine.quota.plist

INTERFACE="${INTERFACE:-enp1s0}"

# Configure Avahi
cat > /etc/avahi/avahi-daemon.conf <<EOF
[server]
use-ipv4=yes
use-ipv6=no
enable-dbus=no
allow-interfaces=${INTERFACE}
deny-interfaces=veth,br-,docker0

[wide-area]
enable-wide-area=yes

[publish]
publish-addresses=yes
publish-hinfo=yes
publish-workstation=yes
publish-domain=yes

[reflector]
enable-reflector=no
EOF

echo "INFO: Avahi configured to use ${INTERFACE} interface"

# run CMD
exec "${@}"
