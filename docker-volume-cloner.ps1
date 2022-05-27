#This is a script that can help to easily create a clone of a given data volume.
#The script is mainly useful if you are using named volumes
#Example usage: .\docker-volume-cloner.ps1 volume-data-1 volume-data-2

#Get source and destination parameters 
param( [string]$src, [string]$dest )

#First check if the user provided all needed arguments
if ( $src.length -lt 5 -or $dest.length -lt 5 )
{
	echo "Please provide valid source volume name and destination volume name!"
	exit
}

if ( $src -eq $dest )
{
	echo "Please provide different destination volume name than the source volume name!"
	exit
}
 
#Check if the source volume name does exist
docker volume inspect $src > null 2>&1
if ( !$? )
{
	echo "The source volume $src does not exist!"
	exit
}

#check if the destination volume name does not exist
docker volume inspect $dest > null 2>&1
if ( $? )
{
	echo "The destination volume $dest already exists!"
	exit
}

echo "Creating destination volume $dest ..."
docker volume create --name $dest

echo "Copying data from source volume ($src) to destination volume ($dest)..."
docker run --rm -i -t -v ${src}:/from -v ${dest}:/to alpine ash -c "cd /from ; cp -av . /to"