#Jonathan Hornung
#2019-07-18
#Unifi API IR Control
#Version 1.0

from unifi_video import UnifiVideoAPI
import os
import sys
import socket

unifi_hostname = socket.getfqdn()
api_key = os.environ["unifi_api"]
camera_name = os.environ["unifi_camera_name"]
control_option = sys.argv[1]

# Default kwargs: addr = 'localhost', port = 7080, schema = http
#uva = UnifiVideoAPI(username='username', password='password', addr='10.3.2.1')

# Use API key (can be set per user in Unifi NVR user settings)
#uva = UnifiVideoAPI(api_key, addr='10.10.11.91')

# Use HTTPS and skip cert verification
#uva = UnifiVideoAPI(api_key, addr=unifi_hostname,
#  port=7443, schema='https', verify_cert=False)

#Use HTTPS
uva = UnifiVideoAPI(api_key, addr=unifi_hostname,
  port=7443, schema='https')

# Set IR leds to mode passed to script
print ("Seting to %s" % control_option)
uva.get_camera(camera_name).ir_leds(control_option)

