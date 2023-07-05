#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

STEP_THREE () {
  # get number, symbol, name, mass, melting point, boiling point and type id
  # echo $1 $2 $3 $4 $5 $6 $7
  # get type from type id
  TYPE=$($PSQL "select type from types where type_id=$7")
  # echo $TYPE
  # print to the output
  echo "The element with atomic number $1 is $3 ($2). It's a $TYPE, with a mass of $4 amu. $3 has a melting point of $5 celsius and a boiling point of $6 celsius."
}

STEP_TWO () {
  # gets number, name and symbol
  # echo $1 $2 $3
  # fetch properties through number
  DATA=$($PSQL "select * from properties where atomic_number=$1")
  echo "$DATA" | sed 's/|/ /g' | while read NUMBER MASS MP BP TYPE
  do
    # forward for printing
    STEP_THREE $1 $2 $3 $MASS $MP $BP $TYPE
  done
}

# if the argument is not given
if ! [[ $1 ]]
then
  # Prompt for it
  echo "Please provide an element as an argument."
# if number is given
elif [[ $1 =~ ^[0-9]+$ ]]
then
  # fetch basic data
  DATA=$($PSQL "select * from elements where atomic_number=$1")
  # echo $DATA
  if ! [[ -z $DATA ]]
  then
    # process it
    echo "$DATA" | sed 's/|/ /g' | while read NUMBER SYMBOL NAME
    do
      # forward for advanced processing
      STEP_TWO $NUMBER $SYMBOL $NAME
    done
  else
    echo "I could not find that element in the database."
  fi
# if Symbol is given
elif [[ ${#1} -le 2 ]]
then
  # fetch, process and forward
  DATA=$($PSQL "select * from elements where symbol='$1'")
  # echo $DATA
  if ! [[ -z $DATA ]]
  then
    echo "$DATA" | sed 's/|/ /g' | while read NUMBER SYMBOL NAME
    do
      STEP_TWO $NUMBER $SYMBOL $NAME
    done
  else
    echo "I could not find that element in the database"
  fi
# if name is given
else
  # fetch, process and forward
  DATA=$($PSQL "select * from elements where name='$1'")
  # echo $DATA
  if ! [[ -z $DATA ]]
  then
    echo "$DATA" | sed 's/|/ /g' | while read NUMBER SYMBOL NAME
    do
      STEP_TWO $NUMBER $SYMBOL $NAME
    done
  else
    echo "I could not find that element in the database."
  fi
fi
