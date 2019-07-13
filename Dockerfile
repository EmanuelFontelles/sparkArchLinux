FROM archlinux/base

LABEL maintainer="emanuelfontelles@hotmail.com"

RUN pacman -Sy --noconfirm base-devel python python-pip jupyter-notebook
RUN useradd -m -g users -G wheel user
RUN passwd -d user 
RUN mkdir /home/user/code
RUN mkdir /home/user/notebooks
WORKDIR /home/user/code
COPY apache-spark /home/user/code/apache-spark
COPY sudoers /etc/sudoers
COPY mirrorlist /etc/pacman.d/mirrorlist
RUN chown -R user:users /home/user/
USER user
WORKDIR /home/user/code/apache-spark
RUN makepkg -si --noconfirm
WORKDIR /home/user/notebooks
CMD jupyter notebook --no-browser --ip 0.0.0.0 --port 8888 /notebooks



#CMD ["cd", "/home/user/code/apache-spark"]
#CMD ["ls", "/home/user/code/apache-spark"]
#CMD ["makepkg", "-si"]



#RUN chown -R $USER:$USER /home/user/
#RUN 
#RUN pacman -Suy --noconfirm base-devel

#RUN mkdir /notebooks
