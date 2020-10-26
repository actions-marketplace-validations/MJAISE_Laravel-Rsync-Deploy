#!/bin/bash
set -eu

SSHPATH="$HOME/.ssh"
mkdir "$SSHPATH"
echo "$SSH_PRIVATE_KEY" > "$SSHPATH/key"
chmod 600 "$SSHPATH/key"
SERVER_DEPLOY_STRING="$REMOTE_USER@$REMOTE_HOST:$TARGET_DIRECTORY"

# Run Rsync synchronization
sh -c "rsync $ARGS -e 'ssh -i $SSHPATH/key -o StrictHostKeyChecking=no -p $REMOTE_HOST_PORT' . $SERVER_DEPLOY_STRING"
ssh -i $SSHPATH/key -t $REMOTE_USER@$REMOTE_HOST "sudo chown -R $REMOTE_USER:$REMOTE_USER $TARGET_DIRECTORY"
ssh -i $SSHPATH/key -t $REMOTE_USER@$REMOTE_HOST "sudo chmod 775 -R $TARGET_DIRECTORY"
ssh -i $SSHPATH/key -t $REMOTE_USER@$REMOTE_HOST "sudo chmod 777 -R $TARGET_DIRECTORY/storage"
ssh -i $SSHPATH/key -t $REMOTE_USER@$REMOTE_HOST "sudo chmod 777 -R $TARGET_DIRECTORY/public"
ssh -i $SSHPATH/key -t $REMOTE_USER@$REMOTE_HOST "cd $TARGET_DIRECTORY && php artisan migrate && php artisan modelcach:clear && php artisan cache:clear && php artisan route:cache && php artisan config:cache"
