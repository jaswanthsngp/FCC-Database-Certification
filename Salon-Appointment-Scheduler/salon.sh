#!/bin/bash

echo -e "\n~~~~~ MY SALON ~~~~~"
PSQL="psql --username=freecodecamp --dbname=salon --tuples-only -c"

SELECT_SERVICE () {
  # show services
  SERVICES=$($PSQL "select * from services")
  echo "$SERVICES" | while read SERVICE_ID BAR NAME
  do 
    echo "$SERVICE_ID) $NAME"
  done
  # get the required service
  read SERVICE_ID_SELECTED
  SERVICE_SELECTED=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
  # if that doesn't exist
  if [[ -z $SERVICE_SELECTED ]]
  then
    # return to main menu
    MAIN_MENU "I could not find that service. What would you like today?"
  else
    SERVICE_SELECTED=$(echo $SERVICE_SELECTED | sed -r 's/^ *| *$//g')
    # read customer phone number
    echo -e "\nWhat's your phone number?"
    read CUSTOMER_PHONE
    # get customer name
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
    # if that doesn't exist
    if [[ -z $CUSTOMER_NAME ]]
    then
      # read customer name
      echo -e "\nI don't have a record for that phone number, what's your name?"
      read CUSTOMER_NAME
      # insert to db
      CUSTOMER_ENTRY=$($PSQL "INSERT INTO customers VALUES(DEFAULT, '$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
    fi
    CUSTOMER_NAME=$(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')
    # get customer id
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
    # read service time (appointment time)
    echo -e "\nWhat time would you like your $SERVICE_SELECTED, $CUSTOMER_NAME?"
    read SERVICE_TIME
    # insert to db
    APP_ENTRY=$($PSQL "INSERT INTO appointments VALUES(DEFAULT, $CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
    echo -e "\nI have put you down for a $SERVICE_SELECTED at $SERVICE_TIME, $CUSTOMER_NAME."
  fi
}

MAIN_MENU () {
  if [[ $1 ]] 
  then
    echo -e "\n$1"
  fi
  SELECT_SERVICE
}

MAIN_MENU "Welcome to My Salon, how can I help you?\n"
