#!/bin/bash

calculate_file_hash() {
    filepath="$1"
    sha512sum "$filepath"
}

erase_baseline_if_already_exists() {
    if [ -e baseline.txt ]; then
        # Delete baseline.txt if it already exists
        rm baseline.txt
    fi
}

echo ""
echo "What would you like to do?"
echo ""
echo "    A) Collect new Baseline?"
echo "    B) Begin monitoring files with saved Baseline?"
echo ""
read -p "Please enter 'A' or 'B: " response
echo ""

if [ "$response" = "A" ] || [ "$response" = "a" ]; then
    # Delete baseline.txt if it already exists
    erase_baseline_if_already_exists

    # Calculate Hash from the target files and store in baseline.txt
    # Collect all files in the target folder
    for f in Files; do
        hash=$(calculate_file_hash "$f")
        echo "$f|$hash" >> baseline.txt
    done

elif [ "$response" = "B" ] || [ "$response" = "b" ]; then
    declare -A fileHashDictionary

    # Load file|hash from baseline.txt and store them in a dictionary
    while IFS='|' read -r file hash; do
        fileHashDictionary["$file"]=$hash
    done < baseline.txt

    # Begin (continuously) monitoring files with saved Baseline
    while true; do
        sleep 1

        for f in Files; do
            hash=$(calculate_file_hash "$f")

            # Notify if a new file has been created
            if [ -z "${fileHashDictionary["$f"]}" ]; then
                # A new file has been created!
                echo "$f has been created!" # Add color codes as needed
            else
                # Notify if a new file has been changed
                if [ "${fileHashDictionary["$f"]}" = "$hash" ]; then
                    # The file has not changed
                    :
                else
                    # File file has been compromised!, notify the user
                    echo "$f has changed!!!" # Add color codes as needed
                fi
            fi
        done

        for key in "${!fileHashDictionary[@]}"; do
            if [ ! -e "$key" ]; then
                # One of the baseline files must have been deleted, notify the user
                echo "$key has been deleted!" # Add color codes as needed
            fi
        done
    done
fi
