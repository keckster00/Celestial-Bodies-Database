#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
elif [[ $1 =~ ^[0-9]+$ ]]
then
  ATOMIC_NUMBER_RESULT=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = $1")
  if [[ -z $ATOMIC_NUMBER_RESULT ]]
  then
    echo "I could not find that element in the database."
  else
    ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $1")
    ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $1")
    ELEMENT_TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number = $1")
    ELEMENT_TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $ELEMENT_TYPE_ID")
    ELEMENT_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $1")
    ELEMENT_MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $1")
    ELEMENT_BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $1")
    echo "The element with atomic number $1 is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ELEMENT_MASS amu. $ELEMENT_NAME has a melting point of $ELEMENT_MELTING_POINT celsius and a boiling point of $ELEMENT_BOILING_POINT celsius."
  fi
else
  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$1'")
  if [[ -z $ATOMIC_NUMBER ]]
  then
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$1'")
    if [[ -z $ATOMIC_NUMBER ]]
    then
      echo "I could not find that element in the database."
    else
      ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $ATOMIC_NUMBER")
      ELEMENT_TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
      ELEMENT_TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $ELEMENT_TYPE_ID")
      ELEMENT_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
      ELEMENT_MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
      ELEMENT_BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
      echo "The element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($1). It's a $ELEMENT_TYPE, with a mass of $ELEMENT_MASS amu. $ELEMENT_NAME has a melting point of $ELEMENT_MELTING_POINT celsius and a boiling point of $ELEMENT_BOILING_POINT celsius."
    fi
  else
    ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $ATOMIC_NUMBER")
    ELEMENT_TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    ELEMENT_TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $ELEMENT_TYPE_ID")
    ELEMENT_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    ELEMENT_MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    ELEMENT_BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    echo "The element with atomic number $ATOMIC_NUMBER is $1 ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ELEMENT_MASS amu. $1 has a melting point of $ELEMENT_MELTING_POINT celsius and a boiling point of $ELEMENT_BOILING_POINT celsius."
  fi
fi
