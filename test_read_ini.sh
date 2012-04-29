#!/bin/bash

. read_ini.sh

read_ini config.cfg

echo ${INI__config__smtp_host}
