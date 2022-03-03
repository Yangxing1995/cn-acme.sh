#!/usr/bin/env sh

_exists() {
  cmd="$1"
  if [ -z "$cmd" ] ; then
    echo "Usage: _exists cmd"
    return 1
  fi
  if type command >/dev/null 2>&1 ; then
    command -v $cmd >/dev/null 2>&1
  else
    type $cmd >/dev/null 2>&1
  fi
  ret="$?"
  return $ret
}

if [ -z "$BRANCH" ]; then
  BRANCH="master"
fi

_email="$1"

if _exists curl && [ "${ACME_USE_WGET:-0}" = "0" ]; then
  curl -O https://gitcode.net/mirrors/acmesh-official/acme.sh/-/archive/master/acme.sh-master.tar.gz && \
  tar -xf acme.sh-master.tar.gz && cd acme.sh-master && ./acme.sh --install -m $_email && cd .. && \
   rm -rf acme.sh-master*
elif _exists wget ; then
  wget -O https://gitcode.net/mirrors/acmesh-official/acme.sh/-/raw/$BRANCH/acme.sh?inline=false && \
  tar -xf acme.sh-master.tar.gz && cd acme.sh-master && ./acme.sh --install -m $_email && cd .. && \
   rm -rf acme.sh-master* 
else
  echo "Sorry, you must have curl or wget installed first."
  echo "Please install either of them and try again."
fi
