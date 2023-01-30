PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ -z $1 ]]
then 
  echo Please provide an element as an argument. #in case if user doesn't provide an argument
else

  if [[ "$1" =~ ^[0-9]+$ ]]
  then
    TEMP_ELEMENT_ATOMIC_NUMBER=$($PSQL "SELECT count(*) FROM elements WHERE atomic_number='$1'") #check if input if valid atomic number
  if [[ $TEMP_ELEMENT_ATOMIC_NUMBER -gt 0 ]]
  then 
    ELEMENT_ATOMIC_NUMBER=$1
    ELEMENT_NAME=$(echo $($PSQL "SELECT name FROM elements WHERE atomic_number=$1") | sed 's/^[ \t]*//')
    ELEMENT_SYMBOL=$(echo $($PSQL "SELECT symbol FROM elements WHERE atomic_number=$1") | sed 's/^[ \t]*//')
    ELEMENT_TYPE_ID=$(echo $($PSQL "SELECT type_id FROM properties WHERE atomic_number=$1") | sed 's/^[ \t]*//')
    ELEMENT_MASS=$(echo $($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$1") | sed 's/^[ \t]*//')
    ELEMENT_MELTING_POINT=$(echo $($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$1") | sed 's/^[ \t]*//')
    ELEMENT_BOILING_POINT=$(echo $($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$1") | sed 's/^[ \t]*//')
  if [[ $ELEMENT_TYPE_ID == 1 ]]
  then
    ELEMENT_TYPE="metal"
  elif [[ $ELEMENT_TYPE_ID == 2 ]]
  then
    ELEMENT_TYPE="metalloid"
  else
    ELEMENT_TYPE="nonmetal"
  fi

    echo "The element with atomic number $ELEMENT_ATOMIC_NUMBER is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ELEMENT_MASS amu. $ELEMENT_NAME has a melting point of $ELEMENT_MELTING_POINT celsius and a boiling point of $ELEMENT_BOILING_POINT celsius."
  fi
  elif [[ "$1" =~ ^[a-zA-Z]{1,2}$ ]]
  then
    TEMP_ELEMENT_SYMBOL=$($PSQL "SELECT count(*) FROM elements WHERE symbol='$1'") # check if input is valid element symbol
  if [[ $TEMP_ELEMENT_SYMBOL -gt 0 ]]
  then
    ELEMENT_ATOMIC_NUMBER=$(echo $($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1'") | sed 's/^[ \t]*//')
    ELEMENT_NAME=$(echo $($PSQL "SELECT name FROM elements WHERE atomic_number=$ELEMENT_ATOMIC_NUMBER") | sed 's/^[ \t]*//')
    ELEMENT_SYMBOL=$1
    ELEMENT_TYPE_ID=$(echo $($PSQL "SELECT type_id FROM properties WHERE atomic_number=$ELEMENT_ATOMIC_NUMBER") | sed 's/^[ \t]*//')
    ELEMENT_MASS=$(echo $($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ELEMENT_ATOMIC_NUMBER") | sed 's/^[ \t]*//')
    ELEMENT_MELTING_POINT=$(echo $($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ELEMENT_ATOMIC_NUMBER") | sed 's/^[ \t]*//')
    ELEMENT_BOILING_POINT=$(echo $($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ELEMENT_ATOMIC_NUMBER") | sed 's/^[ \t]*//')
  if [[ $ELEMENT_TYPE_ID == 1 ]]
  then
    ELEMENT_TYPE="metal"
  elif [[ $ELEMENT_TYPE_ID == 2 ]]
  then
    ELEMENT_TYPE="metalloid"
  else
    ELEMENT_TYPE="nonmetal"
  fi
    echo "The element with atomic number $ELEMENT_ATOMIC_NUMBER is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ELEMENT_MASS amu. $ELEMENT_NAME has a melting point of $ELEMENT_MELTING_POINT celsius and a boiling point of $ELEMENT_BOILING_POINT celsius."
  fi
  elif [[ "$1" =~ ^[a-zA-Z] ]]
  then
    TEMP_ELEMENT_NAME=$($PSQL "SELECT count(*) FROM elements WHERE name='$1'") #check if input is a valid atomic name
  if [[ $TEMP_ELEMENT_NAME -gt 0 ]]
  then
    ELEMENT_ATOMIC_NUMBER=$(echo $($PSQL "SELECT atomic_number FROM elements WHERE name='$1'") | sed 's/^[ \t]*//')
    ELEMENT_NAME=$1
    ELEMENT_SYMBOL=$(echo $($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ELEMENT_ATOMIC_NUMBER") | sed 's/^[ \t]*//')
    ELEMENT_TYPE_ID=$(echo $($PSQL "SELECT type_id FROM properties WHERE atomic_number=$ELEMENT_ATOMIC_NUMBER") | sed 's/^[ \t]*//')
    ELEMENT_MASS=$(echo $($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ELEMENT_ATOMIC_NUMBER") | sed 's/^[ \t]*//')
    ELEMENT_MELTING_POINT=$(echo $($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ELEMENT_ATOMIC_NUMBER") | sed 's/^[ \t]*//')
    ELEMENT_BOILING_POINT=$(echo $($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ELEMENT_ATOMIC_NUMBER") | sed 's/^[ \t]*//')
  if [[ $ELEMENT_TYPE_ID == 1 ]]
  then
    ELEMENT_TYPE="metal"
  elif [[ $ELEMENT_TYPE_ID == 2 ]]
  then
    ELEMENT_TYPE="metalloid"
  else
    ELEMENT_TYPE="nonmetal"
  fi
    echo "The element with atomic number $ELEMENT_ATOMIC_NUMBER is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ELEMENT_MASS amu. $ELEMENT_NAME has a melting point of $ELEMENT_MELTING_POINT celsius and a boiling point of $ELEMENT_BOILING_POINT celsius." #output the final sentence
  else
    echo "I could not find that element in the database."
  fi
  fi

fi

# I loved working on this project and I learned a lot. Thank you freecodecamp :)
