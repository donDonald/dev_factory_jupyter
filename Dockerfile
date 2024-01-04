FROM ubuntu:22.04
MAINTAINER Pavel Taranov <pavel.a.taranov@gmail.com>




#To skip setting itimezonei, to set timezone: echo "Australia/Adelaide" | sudo tee /etc/timezone
ENV DEBIAN_FRONTEND=noninteractive




# Basic tools
RUN apt update \
 && apt install -y wget \
                   curl \
                   tree \
                   gawk \
                   zip \
                   lsof \
                   mc \
                   vim \
                   less \
                   git \
                   tig \
# Python3 \
                   python3 \
                   python3-pip \
                   python3-venv \
# Cleanup apt \
 && apt clean \
# Setup mc \
 && echo "regex/i/\.(md|log|txt|js|json|ejs|yml|j2|cfg|xml|sql|py|ipynb)$\n    Include=editor" | tee -a /etc/mc/mc.ext




# libgl1 - Fixing ImportError: libGL.so.1: cannot open shared object file: No such file or directory
RUN apt update \
 && apt install -y libsm6 libxext6 libxrender-dev libgl1 \
# Cleanup apt \
 && apt clean




# Create user
ENV USER_NAME=dev_factory_jupyter
RUN useradd --shell /bin/bash --create-home $USER_NAME

USER $USER_NAME

# Setup vim
RUN echo "set tabstop=4\nset shiftwidth=4\nset softtabstop=4\nset expandtab" | tee -a /home/$USER_NAME/.vimrc \
 && echo "export EDITOR=vim" | tee -a /home/$USER_NAME/.bashrc




# Setup Dockerfile shell
# https://stackoverflow.com/questions/20635472/using-the-run-instruction-in-a-dockerfile-with-source-does-not-work
# general:
SHELL ["/bin/bash", "-c"]
# for python vituralenv:
#SHELL ["/bin/bash", "-c", "source /usr/local/bin/virtualenvwrapper.sh"]




# Install jupyter
ENV JUPYTER_LOCATION=Jupyter
RUN cd /home/$USER_NAME \
 && mkdir $JUPYTER_LOCATION \
 && cd $JUPYTER_LOCATION \
 && python3 -m venv .jupyter-venv \
 && source .jupyter-venv/bin/activate\
 && pip install --upgrade pip \
 && pip3 install jupyter \
# Most common python math tools \
 && pip3 install matplotlib numpy pandas torch torchvision torchaudio opencv-python




# Stop launching browser upon jupyter startup
RUN cd /home/$USER_NAME/$JUPYTER_LOCATION \
 && source .jupyter-venv/bin/activate \
 && CFG_FILE=$(echo y | jupyter notebook --generate-config -y | awk '{print $NF}') \
 && echo "CFG_FILE:$CFG_FILE" \
 && echo "c.JupyterNotebookApp.open_browser = False" >> $CFG_FILE




# Copy entrypoint and other scripts
COPY --chown=$USER_NAME:$USER_NAME \
     files/entrypoint.sh \
     files/sysinfo.sh \
     /home/$USER_NAME/




ENTRYPOINT /home/$USER_NAME/entrypoint.sh

