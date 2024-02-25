#!/bin/bash
script_dir=$(dirname "$0")
source "$script_dir/config.sh"

# creating files for the first time
> $output_file 
> $pretty_file 
> $updated_file

# making initial request
curl --location 'https://emis.campus.edu.ge/student/card' \
--header "Authorization: $token" \
-o $output_file

cat $output_file | jq -r '.' > $pretty_file
