#!/bin/bash
script/aw_fastcgi.pl --listen 127.0.0.1:55900 --nproc 5 --keeperr 2>>log/error.log &
