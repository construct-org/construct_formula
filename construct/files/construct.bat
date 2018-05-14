@echo off

set OLD_PATH=%PATH%
set PATH={{ latest_dir }}\Scripts;%PATH%

call {{ latest_dir }}\Scripts\construct %*

set PATH=%OLD_PATH%
set OLD_PATH=
