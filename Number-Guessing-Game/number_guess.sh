#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# Read Username
echo "Enter your username:"
read USER_NAME
# Fetch the ID
USER_ID=$($PSQL "select user_id from users where name='$USER_NAME'")
GAMES_PLAYED=0
BEST_GAME=1001
if ! [[ -z $USER_ID ]]
then
  echo "Welcome back, $USER_NAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
else
  # Insert if new
  INSERT=$($PSQL "INSERT INTO users(name) VALUES('$USER_NAME')")
  echo "Welcome, $USER_NAME! It looks like this is your first time here."
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE name='$USER_NAME'")
fi

# Fetch the required data
GAMES_PLAYED=$($PSQL "select game_cnt from users where user_id=$USER_ID")
BEST_GAME=$($PSQL "select best_game from users where user_id=$USER_ID")

# Generete Random Number
echo "Guess the secret number between 1 and 1000:"
USER_GUESS=0
NUM=$(($RANDOM %1000 +1))

# Read the number and give hints until the number matches
CNT=0
while [[ $USER_GUESS -ne $NUM ]]
do
  read USER_GUESS
  if [[ $USER_GUESS =~ ^[0-9]+$ ]]
  then
    if [[ $USER_GUESS -lt $NUM ]]
    then
      echo "It's higher than that, guess again:"
    elif [[ $USER_GUESS -gt $NUM ]]
    then
      echo "It's lower than that, guess again:"
    fi
  else
    echo "That is not an integer, guess again:"
    USER_GUESS=0
  fi
  ((CNT++))
done

echo "You guessed it in $CNT tries. The secret number was $NUM. Nice job!"

# update games played and best score
UPDATE=$($PSQL "update users set game_cnt=$GAMES_PLAYED+1 where user_id=$USER_ID")

if [ $CNT -lt $BEST_GAME -o $BEST_GAME -eq 0 ]
then
  UPDATE=$($PSQL "update users set best_game=$CNT where user_id=$USER_ID")
fi
