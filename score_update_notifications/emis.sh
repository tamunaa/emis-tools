#!/bin/bash

# source ./config.sh
script_dir=$(dirname "$0")
source "$script_dir/config.sh"

export XDG_RUNTIME_DIR=/run/user/$(id -u)
export DBUS_SESSION_BUS_ADDRESS="unix:path=${XDG_RUNTIME_DIR}/bus"


curl --location 'https://emis.campus.edu.ge/student/card' \
--header "Authorization: $token" \
-o $updated_file


current_sem=$(jq '.card.semesters[0]' < $output_file) 
echo "current semster: $current_sem"

get_subjects() {
    local file_name="$1"
    local current_sem=$(jq '.card.semesters[0]' < "$file_name")
    jq --arg current_sem "$current_sem" '.card.books | map(select(.semester == ($current_sem | tonumber)))' < "$file_name"
}

current_subjects=$(get_subjects "$pretty_file")
updated_subjects=$(get_subjects "$updated_file")


num_subjects=$(echo "$current_subjects" | jq length)
echo "number of subjects: $num_subjects"

# compare the two files and send a notification if there is a change
flag=false

for ((i = 0; i < $num_subjects; i++)); do
    subject_name=$(echo "$current_subjects" | jq --argjson index "$i" -r '.[$index].name')
    old_score=$(echo "$current_subjects" | jq --argjson index "$i" -r '.[$index].score')
    new_score=$(echo "$updated_subjects" | jq --argjson index "$i" -r '.[$index].score')

    if [ "$old_score" != "$new_score" ]
    then
        message="from $old_score to $new_score"
        echo "$subject_name $message"
        $script_dir/notification.sh "from $old_score to $new_score"
        $script_dir/notification.sh "$subject_name"
        flag=true
    fi
done


if [ "$flag" = true ]
then
    #updating current output file with updated file
    cp $updated_file $output_file
    #prettify the output file just in case for us
    cat $output_file | jq -r '.' > $pretty_file
    echo "updated file"
fi


