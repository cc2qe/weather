#!/bin/bash

ZIP=22903

curl --silent "http://xml.weather.yahoo.com/forecastrss?p="${ZIP}"&u=c" | grep -E '(<title>Conditions|Current Conditions:|C<BR)' | sed -e 's/Current Conditions://' -e 's/<br \/>//' -e 's/<b>//' -e 's/<\/b>//' -e 's/<BR \/>//' -e 's/<description>//' -e 's/<\/description>//' -e 's/<title>//' -e 's/<\/title>//' | awk '{ if ($1 != "") print }'

echo ''

curl --silent "http://xml.weather.yahoo.com/forecastrss?p="${ZIP}"&u=c" | grep 'Forecast:' -A 2 | sed -e 's/<br \/>//' -e 's/<b>//' -e 's/<\/b>//' | sed -e 's/<BR \/>//' | sed -e 's/<BR \/>//'

CURRENT=`curl --silent "http://xml.weather.yahoo.com/forecastrss?p="${ZIP}"&u=c" | grep -E '(C<BR)' | sed 's/,.*//g'`
ICON=`cat ./icon_key.txt | awk "{ if (\\$1==\"$CURRENT\") print }" FS="\t" | awk '{ print $2 }' FS="\t" `

cp ./yahoo_weather_icons/HD_Yahoo_Icons/$ICON ./current.png

# curl --silent "http://weather.yahoo.com/united-states/virginia/charlottesville-12767090/" | grep "current-weather" | sed "s/.*background\:url(\'\(.*\)\')\ no-repeat.*/\1/" | xargs curl --silent -o /tmp/weather.png

# below is the old command, which no longer works
#curl --silent "http://weather.yahoo.com/united-states/virginia/charlottesville-12767090/" | grep "forecast-icon" | sed "s/.*background\:url(\'\(.*\)\')\;\ _background.*/\1/" | xargs curl --silent -o /tmp/weather.png
