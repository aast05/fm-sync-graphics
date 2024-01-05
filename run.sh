
#!/bin/bash


DIRNAME="$(dirname "$0")"

echo "$DIRNAME"

cd "$DIRNAME"

echo $(pwd)

echo "Starting sync-graphics script"

git pull

echo "Configuration : "
cat config.txt

source <(cat config.txt)
echo "source directory : $SOURCE_DIR"
echo "target directory : $TARGET_DIR" 
echo "directory to sync : $DIRS"


#mkdir -p mnt/fm24_sync
#chmod 777 mnt/fm24_sync

#echo $(pwd)/smb_credentials.txt
#mount -t cifs -o credentials=$(pwd)/smb_credentials.txt,uid=$USER,gid=10 $SOURCE_DIR mnt/fm24_sync

source <(cat smb_credentials.txt)
#rsync $SOURCE_DIR/$DIRS ./$DIRS


IFS=';' read -ra ADDR <<< "$DIRS"
for i in "${ADDR[@]}"; do
  # process "$i"
    echo "processing directory $i"
    # process "$i"
    bin/./sshpass -p "$password"  rsync -av --dry-run --update  $SOURCE_DIR/$i $TARGET_DIR/
    bin/./sshpass -p "$password"  rsync -av --update  $SOURCE_DIR/$i $TARGET_DIR/

    bin/./sshpass -p "$password"  rsync -av --dry-run --update  $TARGET_DIR/$i $SOURCE_DIR/
    bin/./sshpass -p "$password"  rsync -av --update  $TARGET_DIR/$i $SOURCE_DIR/ 
done

echo $(date) > update.txt
