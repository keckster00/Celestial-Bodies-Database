#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"
#generate random number
#user has to guess
RAND_NUM=$(( RANDOM % 1000 + 1 ))
echo $RAND_NUM

#Prompt for username
echo "Enter your username: "
read USERNAME

USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")
if [[ -z $USER_ID ]]
then
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  USER_INSERT_RESULT=$($PSQL "INSERT INTO users(username, num_games, best_game) VALUES('$USERNAME', 0, 0)")
else
  GAMES_PLAYED=$($PSQL "SELECT num_games FROM users WHERE user_id = $USER_ID")
  BEST_GAME=$($PSQL "SELECT best_game FROM users WHERE user_id = $USER_ID")
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

echo "Guess the secret number between 1 and 1000: "
NUM_GUESS=1
read GUESS

while [[ $GUESS != $RAND_NUM ]]
do
  if [[ ! $GUESS =~ ^[0-9]+$ ]]
  then
    echo "That is not an integer, guess again: "
  else
    if [[ $GUESS -gt $RAND_NUM ]]
    then
      echo "It's lower than that, guess again: "
    else
      echo "It's higher than that, guess again: "
    fi
    NUM_GUESS=$(( $NUM_GUESS + 1 ))
  fi
  read GUESS
done

echo "You guessed it in $NUM_GUESS tries. The secret number was $RAND_NUM. Nice job!"

USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")
BEST_GAME=$($PSQL "SELECT best_game FROM users WHERE user_id = $USER_ID")
if [[ $NUM_GUESS < $BEST_GAME  || $BEST_GAME = 0 ]] 
then
  UPDATE_BEST_RESULT=$($PSQL "UPDATE users SET best_game = $NUM_GUESS WHERE user_id = $USER_ID")
fi

GAMES_PLAYED=$($PSQL "SELECT num_games FROM users WHERE user_id = $USER_ID")
NEW_NUM=$(( $GAMES_PLAYED + 1 ))
UPDATE_NUM_RESULT=$($PSQL "UPDATE users SET num_games = $NEW_NUM WHERE user_id = $USER_ID")

