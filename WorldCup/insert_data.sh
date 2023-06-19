#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

str=$(cat games.csv)        # Holds the data of csv file
n=${#str}                   # Size of str
b=${str:54:1}               # New Line
c=${str:4:1}                # Comma

year=""
round=""
winner=""
opponent=""
winner_goals=""
opponent_goals=""

i=0
while [[ ${str:i:1} != $b ]]; do
  ((i++))
done;
((i++))
while [ $i -lt $n ]; do
  while [[ ${str:i:1} != $b && $i -lt $n ]]; do
  # Reads each line of CSV file, each internal loop reads data of a field in file

    while [[ ${str:i:1} != $c ]]; do
      year+=${str:i:1}
      ((i++))
    done;
    ((i++))

    while [[ ${str:i:1} != $c ]]; do
      round+=${str:i:1}
      ((i++))
    done;
    ((i++))

    while [[ ${str:i:1} != $c ]]; do
      winner+=${str:i:1}
      ((i++))
    done;
    ((i++))

    while [[ ${str:i:1} != $c ]]; do
      opponent+=${str:i:1}
      ((i++))
    done;
    ((i++))

    while [[ ${str:i:1} != $c ]]; do
      winner_goals+=${str:i:1}
      ((i++))
    done;
    ((i++))

    while [[ ${str:i:1} != $b && $i -lt $n ]]; do
      opponent_goals+=${str:i:1}
      ((i++))
    done;
    ((i++))

    # Display data, Push to the table and Refresh
    # echo $year $round $winner $opponent $winner_goals $opponent_goals
    $($PSQL "insert into teams values(DEFAULT,'${winner}')")
    $($PSQL "insert into teams values(DEFAULT,'${opponent}')")
    w_id=$($PSQL "select team_id from teams where name='${winner}'")
    o_id=$($PSQL "select team_id from teams where name='${opponent}'")
    $($PSQL "insert into games values(DEFAULT,$year,$w_id,$o_id,$winner_goals,$opponent_goals,'${round}')")
    year=""
    round=""
    winner=""
    opponent=""
    winner_goals=""
    opponent_goals=""
  done;
done;
