#! /bin/bash
# What is this? --------------------------
# This bash script moves everyfile that starts with the letters <Characters> to the directory <Directory>

# Note that $1 means <Beginning Letter>
# $2 is your required directory

# for example, if you execute this command
#' ./font-move-script.sh cmu CMU/'
# then every files in you working directory will be moved into a folder called cfolder, note you need to make the destination folder first.
# How to use it? ------------------------------------

cp $1 $2
for X in *$1*; do echo mv -v \"$X\" $2; done

# prompt that asks yes or no
read -p "Are you sure you want to move the files?[y/n] " -n 1 -r

echo " moving files" # (optional) move to a new line

for X in *$1*; do mv -v "$X" $2; done

if [[ ! $REPLY =~ ^[Yy]$  ]]
then
        exit 1
fi
