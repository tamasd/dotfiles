#!/bin/sh

for i in $(dbus-send --print-reply --dest=org.gnome.SessionManager /org/gnome/SessionManager org.gnome.SessionManager.GetInhibitors | grep -Po 'Inhibitor\d+'); do
	dbus-send --print-reply --dest=org.gnome.SessionManager /org/gnome/SessionManager/$i org.gnome.SessionManager.Inhibitor.GetAppId
done
