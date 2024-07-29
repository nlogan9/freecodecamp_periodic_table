#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c" 

if [[ -z $1 ]]
then
  echo -e "\nPlease provide an element as an argument"
fi

NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = $1")

if [[ $NUMBER ]]
then
  ELEMENT=$($PSQL "SELECT name FROM elements WHERE atomic_number = $1")
  SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $1")
  echo -e "\nThe element with atomic number $NUMBER is $ELEMENT ($SYMBOL)"
else
  echo "new number"
fi