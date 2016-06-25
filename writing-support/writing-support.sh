#!/bin/sh
#
# [required]
# * Docker Toolbox (Docker, Docker Machine)
#
# [run]
# writing-support/writing-support.sh
#
# [run with cron]
# crontab -e
# 0 5 * * * $HOME/writing-support/writing-support.sh

DOCKER_MACHINE_NAME=${1:-default}
CHAPTER_COUNT=2

# retry ( http://blog.rakugakibox.net/entry/2015/04/28/shell-function-retryable )
function retryable() {
    for i in {1..3}; do
        MSG=$("$@" 2>&1) && break
    done

    if [ $? -eq 0 ]; then
      return 0
    else
      echo $MSG 1>&2
      return 1
    fi
}

# setup
export PATH=/usr/local/bin:$PATH
export LANG=ja_JP.UTF-8
eval "$(docker-machine env $DOCKER_MACHINE_NAME)"
docker-machine ssh $DOCKER_MACHINE_NAME "sudo udhcpc" > /dev/null
cd "$(dirname $0)/.."

# docker build
docker build -t writing writing-support > /dev/null

# docker run - md2pdf
retryable docker run --rm -v $PWD:/root/writing writing bash -c \
  "pandoc -N --toc --latex-engine=lualatex -H writing-support/header.tex \
    -V documentclass=ltjarticle -V linkcolor=black -V monofont=Inconsolata \
    -o book.pdf chapter*/*.md"

# docker run - wordcount
docker run --rm -v $PWD:/root/writing writing bash -c \
  "for i in \$(seq 1 $CHAPTER_COUNT); do
    WC_COUNT=\$(nkf chapter\$i/*\.md 2> /dev/null | wc -m | tail -n1);
    WC_DATE=\$(date +'%Y/%m/%d');
    echo \$WC_DATE,\$WC_COUNT >> writing-support/count_chapter\$i.dat;
  done"
docker run --rm -v $PWD:/root/writing writing bash -c "gnuplot writing-support/count.plt"
