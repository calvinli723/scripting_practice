# scripting_practice

## These scripts were written and tested for Ubuntu Linux 22.04 (Jammy Jellyfish)

`example_logs`
Contains example log files for use with scripts such as `show-attackers.sh`.


`add-local-user.sh`


- Enforces that it be executed with superuser (root) privileges. If the script is not executed with superuser privileges it will not attempt to create a user and returns an exit status of 1.

- Prompts the person who executed the script to enter the username (login), the name for person who will be using the account, and the initial password for the account.

- Creates a new user on the local system with the input provided by the user.

- Informs the user if the account was not able to be created for some reason. If the account is not created, the script is to return an exit status of 1.

- Displays the username, password, and host where the account was created. This way the help desk staff can copy the output of the script in order to easily deliver the information to the new account holder.


`disable-local-user.sh`

* Enforces that it be executed with superuser (root) privileges. If the script is not executed with superuser privileges it will not attempt to create a user and returns an exit status of 1. All messages associated with this event will be displayed on standard error.

* Provides a usage statement much like you would find in a man page if the user does not supply an account name on the command line and returns an exit status of 1. All messages associated with this event will be displayed on standard error.

* Disables (expires/locks) accounts by default.

* Allows the user to specify the following options:

    + -d Deletes accounts instead of disabling them.

    + -r Removes the home directory associated with the account(s).

    + -a Creates an archive of the home directory associated with the accounts(s) and stores the archive in the /archives directory. (NOTE: /archives is not a directory that exists by default on a Linux system. The script will need to create this directory if it does not exist.)

* Any other option will cause the script to display a usage statement and exit with an exit status of 1.

* **TODO**: Accepts a list of usernames as arguments. At least one username is required or the script will display a usage statement much like you would find in a man page and return an exit status of 1. All messages associated with this event will be displayed on standard error.

* **TODO**: Refuses to disable or delete any accounts that have a UID less than 1,000.

* **TODO**: Only system accounts should be modified by system administrators. Only allow the help desk team to change user accounts.

* **TODO**: Informs the user if the account was not able to be disabled, deleted, or archived for some reason.

* Displays the username and any actions performed against the account.


`show-attackers.sh`

- Use `example_logs/syslog` as example input; Designed to read from `/var/log/auth.log` (contains sshd logs).

- Requires that a file is provided as an argument.  If a file is not provided or it cannot be read, then the script will display an error message and exit with a status of 1.

- Counts the number of failed login attempts by IP address.  If there are any IP addresses with more than 10 failed login attempts, the number of attempts made, the IP address from which those attempts were made, and the location of the IP address will be displayed.

- **TODO**: Produces output in CSV (comma-separated values) format with a header of "Count,IP,Location".
