#!/bin/bash
set -e
declare -A ARGS;
ARGS=(
    ["HTTP_PORT"]="${HTTP_PORT:-4567}"
    ['CORP_ID']="${CORP_ID:-}"
    ['AGENT_ID']="${AGENT_ID:-}"
    ['SECRET']="${SECRET:-}"
    ['ENCODING_AES_KEY']="${ENCODING_AES_KEY:-}"
 )

configure() {
    for key in ${!ARGS[*]}
    do  
        search="%%${key}%%"
        replace=${ARGS["$key"]}
        #echo "$search = $replace"
        sysname=$(uname)
        if [ "$sysname" == "Darwin" ] ; then
            # Note the "" and -e  after -i, needed in OS X
            find ./config.tpl -type f -exec sed -i .tpl -e "s#${search}#${replace}#g" {} \;
        else
            find ./config.tpl -type f -exec sed -i "s#${search}#${replace}#g" {} \;
        fi        
    done
    cp -f config.tpl bin/config.conf
}
# replace config file with environment arguments。 
configure

exec "$@"
