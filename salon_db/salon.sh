#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"

MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  echo -e "Welcome to My Salon, how can I help you?\n"
  DISPLAY_SERVICES
  echo -e "\nWhat would you like today?"
  read SERVICE_ID_SELECTED

  # Fetch the minimum and maximum service IDs for validation
  MIN_ID=$($PSQL "SELECT MIN(service_id) FROM services;")
  MAX_ID=$($PSQL "SELECT MAX(service_id) FROM services;")

  case $SERVICE_ID_SELECTED in
    [$MIN_ID-$MAX_ID]) BOOK_APPOINTMENT ;;
    *) MAIN_MENU "I could not find that service." ;;
  esac
}

DISPLAY_SERVICES() {
  # Display services
  SERVICES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id;")
  echo "$SERVICES" | while read -r SERVICE_ID BAR NAME
  do
    echo "$SERVICE_ID) $NAME"
  done
}

BOOK_APPOINTMENT() {
  SERVICE_EXISTENCE=$($PSQL "SELECT name FROM services WHERE service_id='$SERVICE_ID_SELECTED';" | sed -E 's/^ *| *$//g')
  
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE

  CUSTOMER_EXISTENCE=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE';" | sed -E 's/^ *| *$//g')

  if [[ -z $CUSTOMER_EXISTENCE ]]
  then
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME');")
  else
    CUSTOMER_NAME=$CUSTOMER_EXISTENCE
  fi

  echo -e "\nWhat time would you like your $SERVICE_EXISTENCE, $CUSTOMER_NAME?"
  read SERVICE_TIME

  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE';")
  INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES('$CUSTOMER_ID', '$SERVICE_ID_SELECTED', '$SERVICE_TIME');")

  echo -e "\nI have put you down for a $SERVICE_EXISTENCE at $SERVICE_TIME, $CUSTOMER_NAME.\n"
}

MAIN_MENU
