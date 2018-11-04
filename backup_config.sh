#!/bin/bash

#This script is used to take backup of configuration file before changing

function usage() {
echo ""
echo "usage: backup_config [-h | --help] -N OPT_number -f filename -M Issue_description"
echo ""
}

export -f usage

if [[ "$1" = "--help" || "$1" = "-h" ]]; then                   #show help
  usage
  exit 1
elif [[ $# < 6 ]]; then						#check if all arguemnts are passed
  echo "Invalid number of arguments"
  usage	
  exit 1
fi

while getopts ":N:f:M:" option; do
  case $option in
    N)
	opt_number=$OPTARG
      ;;

    f)
        filename=$OPTARG
	if [ ! -f $filename ]; then
         echo "File not found"
         echo "Please give correct file name"
         exit 1
	fi
      ;;

    M)
       issue=$OPTARG
      ;;

    \?)
      echo "Invalid option: -$OPTARG"
      exit 1
      ;;

    :)
      echo "-$OPTARG requires an argument."
      exit 1
      ;;
  esac
done

mkdir -p /ts/.backup_config$(pwd) && cp $filename /ts/.backup_config$(pwd)/    #create same directory structure and backup the file

echo "$opt_number  $(date +"%d.%m.%y")  '$issue' " >> /ts/.backup_config/change_tracker    #single line issue description

echo "File backed up successfully"	
