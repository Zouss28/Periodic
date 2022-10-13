#!/bin/bash
PSQL="psql  --username=freecodecamp --dbname=periodic_table --no-align --tuples-only -c" 
#get the input
nan(){
    echo I could not find that element in the database.
}
#if number
if [[ -z $1 ]]
then
    echo Please provide an element as an argument.
elif [[ $1 =~ ^[1-9]+ ]]
then 
    echo $($PSQL "SELECT atomic_number,symbol,name,atomic_mass,melting_point_celsius,boiling_point_celsius,type FROM elements INNER JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE atomic_number=$1") | while IFS='|' read AT_NUM SYMBOL NAME AT_MASS MEL_P BL_P TYPE
        do 
            if [[ -z $NAME ]]
            then
                nan
            else
                echo "The element with atomic number $AT_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $AT_MASS amu. $NAME has a melting point of $MEL_P celsius and a boiling point of $BL_P celsius."
            fi
        done
#if symbol
elif [[ $1 =~ ^([A-Z]([a-z])?$) ]]
then
    echo $($PSQL "SELECT atomic_number,symbol,name,atomic_mass,melting_point_celsius,boiling_point_celsius,type FROM elements INNER JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE symbol='$1'") | while IFS='|' read AT_NUM SYMBOL NAME AT_MASS MEL_P BL_P TYPE
        do
            if [[ -z $NAME ]]
            then
            nan
            else 
                echo "The element with atomic number $AT_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $AT_MASS amu. $NAME has a melting point of $MEL_P celsius and a boiling point of $BL_P celsius."
            fi
        done
# if name
elif [[ $1 =~ [A-Za-z]+ ]]
then
    echo $($PSQL "SELECT atomic_number,symbol,name,atomic_mass,melting_point_celsius,boiling_point_celsius,type FROM elements INNER JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE name='$1'") | while IFS='|' read AT_NUM SYMBOL NAME AT_MASS MEL_P BL_P TYPE
        do
            if [[ -z $NAME ]]
            then
            nan
            else 
                echo "The element with atomic number $AT_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $AT_MASS amu. $NAME has a melting point of $MEL_P celsius and a boiling point of $BL_P celsius."
            fi
        done
fi