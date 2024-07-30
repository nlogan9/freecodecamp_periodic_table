#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c" 

if [[ -z $1 ]]
then
  echo -e "\nPlease provide an element as an argument"
fi

if [[ $($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = $1") ]]
then
  NUMBER=$(echo $($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = $1") | sed -E 's/^ *| *$//g')
elif [[ $($PSQL "SELECT symbol FROM elements WHERE symbol = '$1'") ]]
then
  NUMBER=$(echo $($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$1'") | sed -E 's/^ *| *$//g')
elif [[ $($PSQL "SELECT name FROM elements WHERE name = '$1'") ]]
then
  NUMBER=$(echo $($PSQL "SELECT atomic_number FROM elements WHERE name = '$1'") | sed -E 's/^ *| *$//g')
else
  echo "new number"
fi

  ELEMENT=$(echo $($PSQL "SELECT name FROM elements WHERE atomic_number = $NUMBER") | sed -E 's/^ *| *$//g')
  SYMBOL=$(echo $($PSQL "SELECT symbol FROM elements WHERE atomic_number = $NUMBER") | sed -E 's/^ *| *$//g')
  TYPE=$(echo $($PSQL "SELECT type FROM types INNER JOIN properties USING(type_id) WHERE atomic_number = $NUMBER") | sed -E 's/^ *| *$//g')
  MASS=$(echo $($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $NUMBER") | sed -E 's/^ *| *$//g')
  MELT=$(echo $($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $NUMBER") | sed -E 's/^ *| *$//g')
  BOIL=$(echo $($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $NUMBER") | sed -E 's/^ *| *$//g')
  echo -e "\nThe element with atomic number $NUMBER is $ELEMENT ($SYMBOL). It's a $TYPE, with a mass of $MASS amu.\
 $ELEMENT has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
