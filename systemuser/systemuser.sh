#!/bin/sh

echo "Creating user $USER ($USER_ID)"
useradd -u $USER_ID -s $SHELL $USER

# Grant User Sudo Access in the Container
usermod -aG sudo $USER
echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/10-jupyter-user

sudo -E -u $USER jupyterhub-singleuser \
  --port=`expr $USER_ID + 30000` \
  --ip=127.0.0.1 \
  --user=$JPY_USER \
  --cookie-name=$JPY_COOKIE_NAME \
  --base-url=$JPY_BASE_URL \
  --hub-prefix=$JPY_HUB_PREFIX \
  --hub-api-url=$JPY_HUB_API_URL

    
