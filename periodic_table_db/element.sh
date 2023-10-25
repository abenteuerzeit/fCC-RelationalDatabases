#!/bin/bash


# Exit if no argument provided
if [[ -z "$1" ]]
then
    echo "Please provide an element as an argument."
    exit
fi

# Database connection details
DB_USER="freecodecamp"
DB_NAME="periodic_table"
PSQL="psql -X --username=$DB_USER --dbname=$DB_NAME --no-align --tuples-only -c"


# Check if the argument is numeric (atomic_number), a single or two-letter string (symbol), or a longer string (name)
case $1 in
    ''|*[!0-9]*) 
        # Argument is not entirely numeric
        if [[ ${#1} -le 2 ]]; then
            QUERY_CONDITION="e.symbol = '$1'"
        else
            QUERY_CONDITION="e.name = '$1'"
        fi
        ;;
    *)  
        QUERY_CONDITION="e.atomic_number = $1"
        ;;
esac


# Fetch element details based on atomic_number, symbol, or name
ELEMENT_QUERY="SELECT e.atomic_number, e.name, e.symbol, t.type, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius 
               FROM elements AS e 
               JOIN properties AS p ON e.atomic_number = p.atomic_number 
               JOIN types AS t ON p.type_id = t.type_id 
               WHERE $QUERY_CONDITION;"
ELEMENT_DETAILS=$($PSQL "$ELEMENT_QUERY")

if [[ -z "$ELEMENT_DETAILS" ]]; then
    echo "I could not find that element in the database."
    exit
else
    IFS='|' read ATOMIC_NUMBER NAME SYMBOL ELEMENT_TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT <<< "$ELEMENT_DETAILS"
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
fi
