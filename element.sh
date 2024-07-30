#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c" 

if [[ -z $1 ]]
then
  echo -e "\nPlease provide an element as an argument"
fi

NUMBER=$(echo $($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = $1") | sed -E 's/^ *| *$//g')

if [[ $NUMBER ]]
then
  ELEMENT=$(echo $($PSQL "SELECT name FROM elements WHERE atomic_number = $1") | sed -E 's/^ *| *$//g')
  SYMBOL=$(echo $($PSQL "SELECT symbol FROM elements WHERE atomic_number = $1") | sed -E 's/^ *| *$//g')
  TYPE=$(echo $($PSQL "SELECT type FROM types INNER JOIN properties USING(type_id) WHERE atomic_number = $NUMBER") | sed -E 's/^ *| *$//g')
  echo -e "\nThe element with atomic number $NUMBER is $ELEMENT ($SYMBOL). It's a $TYPE"
else
  echo "new number"
fi
