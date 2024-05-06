#!/bin/bash

# Function to generate a multiplication table
multi_table () {
    # Prompt the user to enter a number for the multiplication table
    read -p "Enter a number for the multiplication table: " num

    # Validate that the input is a positive integer
    while ! check_int "$num" || (( num <= 0 )); do
        read -p "Invalid input. Please enter a positive integer: " num
    done

    # Ask if the user wants a full or partial table
    read -p "Do you want a full table (F) or a partial table (P)? Enter 'F' for full, 'P' for partial: " fmt

    # Validate the format choice
    while [[ ! "$fmt" =~ ^[FfPp]$ ]]; do
        read -p "Invalid input. Enter 'F' for full table, 'P' for partial table: " fmt
    done

    # Call the appropriate function based on the format choice
    if [[ "$fmt" =~ ^[Ff]$ ]]; then
        full_table "$num"
    else
        partial_table "$num"
    fi
}

# Function to display a full multiplication table
full_table () {
    echo "The full multiplication table for $1:"
    for i in {1..10}; do
        echo "$1 x $i = $(($1 * $i))"
    done
}

# Function to display a partial multiplication table
partial_table () {
    # Prompt the user to enter a valid starting number (integer between 1 and 10)
    read -p "Enter the starting number (between 1 and 10): " start

    # Validate the starting number input
    while ! check_int "$start" || (( start < 1 )) || (( start > 10 )); do
        read -p "Invalid input. Please enter a valid starting number (between 1 and 10): " start
    done

    # Prompt the user to enter a valid ending number (integer between 1 and 10)
    read -p "Enter the ending number (between 1 and 10): " end

    # Validate the ending number input
    while ! check_int "$end" || (( end < 1 )) || (( end > 10 )); do
        read -p "Invalid input. Please enter a valid ending number (between 1 and 10): " end
    done

    # Ensure that the start number is less than or equal to the end number
    if (( start > end )); then
        echo "Invalid range. Showing full table instead."
        full_table "$1"
        return
    fi

    # Display the partial multiplication table for the specified range
    echo "The partial multiplication table for $1 from $start to $end:"
    for i in $(seq $start $end); do
        echo "$1 x $i = $(($1 * $i))"
    done
}

# Function to check if input is an integer
check_int() {
    local re='^[0-9]+$'  # Regular expression to match integers
    if [[ $1 =~ $re ]]; then
        return 0  # Success: input is an integer
    else
        echo "$1 is not a valid positive integer."
        return 1  # Failure: input is not an integer
    fi
}

# Initial call to the multi_table function to start the application
multi_table

# Loop to ask if the user wants to use the application again
while true; do
    read -p "Would you like to use our application again (Y/N)? " cond
    if [[ "$cond" == "Y" || "$cond" == "y" ]]; then
        multi_table  # Restart the application if user chooses 'Y' or 'y'
    else
        break  # Exit the loop and end the script if user chooses anything else
    fi
done