# docker-handy-scripts

This repository will contain handy scripts to ease some docker issues.
I will add new scripts over time.

## docker-volume-coloner.ps1

Purpose of this script is to clone an existing docker volume easily in windows environment.
By the help this script you can create a duplicate of an existing data volume to a given
target volume name.

So this small powershell script gets two arguments. These are the name of the source volume 
and the target volume. It will copy the volume data from the source to the target
by using the alpine image.

By using the following command

<code>docker-volume-coloner.ps1 sqlserver-data sqlserver-data-backup</code>

You can copy all data that is contained in the named volume sqlserver-data to the 
sqlserver-data-backup. To do this job this script;

- Checks existance of source and target volume
- Creates target volume
- Copies all data from source volume to target volume
