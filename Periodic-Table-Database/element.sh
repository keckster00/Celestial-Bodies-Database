#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
elif [[ $1 =~ ^[0-9]+$ ]]
then
  ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $1")
  ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $1")
  ELEMENT_TYPE=$($PSQL "SELECT type FROM properties WHERE atomic_number = $1")
  ELEMENT_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $1")
  ELEMENT_MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $1")
  ELEMENT_BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $1")
  echo -e "\nThe element with atomic number $1 is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ELEMENT_MASS amu. $ELEMENT_NAME has a melting point of $ELEMENT_MELTING_POINT celsius and a boiling point of $ELEMENT_BOILING_POINT celsius."

fi

