# unifi_video_ir_control

Unifi Video is no longer getting updates. There will probably not be many updates for this script as the current is still working for me, but planning on replacing with another system in the future.

NOTE: While this should work, you might need some tweaks for now. Still need to update the info and confirm working with these directions from a clean install

Directions and scripts to schedule turning the IR on and off based on estimated sunset and sunrise times for Unifi Video cameras.

The "Auto" setting for my camera doesn't trigger at night due to a street light that is too bright, but doesn't light the whole area.  The IR is still wanted at night.

This relies on these two projects:

A Python Unifi Video API:
https://github.com/yuppity/unifi-video-api

A program that will caculate sunset/sunrise times based on location:
https://github.com/risacher/sunwait

Follow the steps in "SETUP" to get this setup and configured on Ubuntu 16.04.7 LTS. Other systems might need additional steps.

Requirements:
Ubuntu 16.04.7 LTS (xenial)
Unifi Video 3.10.13 (current as of 2020-10-26)
Python 3.5.2

