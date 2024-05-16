#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"
echo -e "\n~~~~~ Salon Services ~~~~~\n"

MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  SERVICES_LIST=$($PSQL "SELECT * FROM services")
  echo "$SERVICES_LIST" | while read SERVICE_ID BAR SERVICE
  do
    echo "$SERVICE_ID) $SERVICE"
  done

  echo -e "\nWhat service would you like?"
  read SERVICE_ID

  if [[ ! $SERVICE_ID =~ ^[0-9]+$ ]]
  then
    MAIN_MENU "That's not a number, choose again."
  fi

  SERVICE_ID_RESULT=$($PSQL "SELECT service_id FROM services WHERE service_id = $SERVICE_ID")
  if [[ -z $SERVICE_ID_RESULT ]]
  then
    MAIN_MENU "Please choose a valid service."
  fi
  fre
}

MAIN_MENU
