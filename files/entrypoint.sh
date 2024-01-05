#!/bin/bash

#cd && /bin/bash

# Start Jupyter notebook
cd /home/$USER_NAME/$JUPYTER_LOCATION \
 && source .jupyter-venv/bin/activate

jupyter notebook --no-browser

