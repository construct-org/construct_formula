@echo off

set OLD_PATH=%PATH%
set PATH={{ env_dir }}\Scripts;%PATH%

call {{ env_dir }}\Scripts\construct %*

set PATH=%OLD_PATH%
set OLD_PATH=
