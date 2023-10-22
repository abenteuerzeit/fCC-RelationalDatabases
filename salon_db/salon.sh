#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ Welcome to our Salon ~~~~~\n"

DISPLAY_SERVICES() {
  # Display services
  SERVICES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id;")
  echo -e "\nAvailable Services:\n"
  echo "$SERVICES" | while read -r SERVICE_ID BAR NAME
  do
    echo "$SERVICE_ID) $NAME"
  done
}

MAIN_MENU() {
  DISPLAY_SERVICES

  # Prompt for service selection
  echo -e "\nWhich service would you like to avail?"
  read SERVICE_ID_SELECTED

  # Check if service exists
  SERVICE_EXISTENCE=$($PSQL "SELECT name FROM services WHERE service_id='$SERVICE_ID_SELECTED';")
  if [[ -z $SERVICE_EXISTENCE ]]
  then
    echo -e "\nInvalid service number. Please select from the list below."
    MAIN_MENU
    return
  fi

  echo -e "\nPlease enter your phone number:"
  read CUSTOMER_PHONE

  CUSTOMER_EXISTENCE=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE';" | sed -E 's/^ *| *$//g')

  if [[ -z $CUSTOMER_EXISTENCE ]]
  then
    echo -e "\nWhat's your name?"
    read CUSTOMER_NAME
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME');")
  else
    CUSTOMER_NAME=$CUSTOMER_EXISTENCE
  fi

  echo -e "\nWhat time would you like to schedule the service?"
  read SERVICE_TIME

  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE';")

  INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES('$CUSTOMER_ID', '$SERVICE_ID_SELECTED', '$SERVICE_TIME');")

  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id='$SERVICE_ID_SELECTED';" | sed -E 's/^ *| *$//g')
    
  echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME.\n"
}

MAIN_MENU
