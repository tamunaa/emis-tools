# EMIS Student Card Update Notifier

This project is a set of shell scripts that interact with the EMIS (Educational Management Information System) of a campus. It fetches student card data, compares it with previously fetched data, and sends notifications if there are changes.

## Project Structure

- `config.sh`: Contains the configuration for the project, including the paths to the JSON files used for storing data.
- `emis.sh`: The main script that fetches data from the EMIS, compares it with previously fetched data, and sends notifications if there are changes.
- `initial.sh`: Sets up the environment for the project.
- `notification.sh`: A helper script that sends notifications.
- `json_files/`: A directory that contains JSON files used for storing data.

## How to Use

1. Clone the repository.
2. install `jq` and `curl` if you haven't already.
    for Ubuntu/Debian:
    ```bash 
    sudo apt-get install jq curl
    ```
    These can be installed via the package manager of your Linux distribution.
    
3. Check out config.sh and replace authorization token with you Bearer token.

    you can get the token by inspecting the network tab in the browser while opening Card Page in the EMIS.

4. Set up the environment:
    ```bash
    ./initial.sh
    ```
5. schedule taks to run the script periodically.
    for example, to run the script every 30 minutes, add the following line to your crontab:
    ```bash
    crontab -e
    ```
    in crontab file add the following line in the end:
    ```bash
    */30 * * * * PATH_TO_EMIS_SH_SCRIPT > PATH_TO_LOG_FILE 2> PATH_TO_ERROR_ERROR_LOG
    ```
    replace `PATH_TO_EMIS_SH_SCRIPT` with the path to the `emis.sh` script and `PATH_TO_LOG_FILE` with the path to the custom log file and `PATH_TO_ERROR_ERROR_LOG` with path for errors during the execution.
    
    this will run the script every 30 minutes and log the output to the log file.
    you can change the time interval and add log messages to your preference.
    
    
    

## Dependencies

- `jq`: A lightweight and flexible command-line JSON processor.
- `curl`: A command-line tool for transferring data with URLs.

## Note

This project is specifically tailored for a certain campus's EMIS and might not work with other systems without modifications.

Please replace the placeholder URL and authorization token in the `curl` commands with actual values.


## License

This project is open source and available under the [MIT License](LICENSE).