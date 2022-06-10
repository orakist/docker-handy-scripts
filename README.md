# docker-handy-scripts

This repository will contain handy scripts to ease some docker issues.
I will add new scripts over time.

## docker-volume-coloner.ps1

Purpose of this script is to clone an existing docker volume easily in windows environment.
By the help of this script you can create a duplicate of an existing data volume to a given
target volume name.

This small powershell script takes two arguments. These are the name of the source volume 
and the target volume. It copys the volume data from the source to the target by using the
alpine image.

By using the following command;

<code>.\docker-volume-coloner.ps1 sqlserver-data sqlserver-data-backup</code>

you can copy all data of the volume sqlserver-data to the sqlserver-data-backup.  
To do this job, the script;

- Checks existance of source and target volume
- Creates target volume
- Copies all data from source volume to target volume

## remove-matched-containers.ps1

Purpose of this script is to stop and remove running docker containers easily in windows
environment. By the help of this script you can stop and remove any docker containers whose
name starts with a spesific query string.

This small powershell script takes one argument to query containers by name.

By using the following command;

<code>.\remove-matched-containers.ps1 container-name</code>

you can stop and remove all containers whose name starts with container-name.  
To do this job, the script;

- Queries containers whose name starts with container-name 
- Stops and removes matched containers with a nice output
