#!/bin/bash

prefix=""

if `git status | grep "master" &>/dev/null`; then
	  prefix="prod-pj"
elif `git status | grep "preview" &>/dev/null`; then
    prefix="preview-pj"
elif `git status | grep "staging" &>/dev/null`; then
    prefix="staging-pj"
else
   echo "must checkout branch release or test or staging"
   exit
fi

function my_tag() {
    git push
    git pull --tags
}

function build_tag_push() {
    local new_tag=$(echo ${prefix}-$(date +'%Y%m%d')-$(git tag -l "${prefix}-$(date +'%Y%m%d')-*" | wc -l | xargs printf '%02d'))
    echo ${new_tag}
    git tag -a ${new_tag} -m 'create new tag'
    git push origin ${new_tag}
}

my_tag;
build_tag_push;