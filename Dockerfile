FROM archlinux/base

LABEL maintainer="emanuelfontelles@hotmail.com"
RUN useradd -m -g users -G wheel user
RUN passwd -d user 
RUN mkdir /home/user/code
RUN mkdir /home/user/notebooks
RUN pacman -Sy --noconfirm base-devel python python-pip jupyter-notebook
#COPY Anaconda3-2019.03-Linux-x86_64.sh /home/user/
WORKDIR /home/user/code
COPY apache-spark /home/user/code/apache-spark
COPY sudoers /etc/sudoers
COPY mirrorlist /etc/pacman.d/mirrorlist
RUN chown -R user:users /home/user/

USER user
WORKDIR /home/user/code/apache-spark
RUN makepkg -si --noconfirm

USER root
RUN archlinux-java set java-7-openjdk

USER user
RUN rm -r /home/user/code

WORKDIR /home/user/
#RUN bash Anaconda3-2019.03-Linux-x86_64.sh -b -p $HOME/anaconda
#RUN export PATH=home/user/anaconda/bin:$PATH
#RUN rm -r /home/user/Anaconda3-2019.03-Linux-x86_64.sh

RUN export JAVA_HOME=/usr/lib/jvm/java-7-openjdk/jre
RUN export SPARK_HOME=/opt/apache-spark
#RUN export PYSPARK_PYTHON=/home/user/anaconda/bin/python
RUN export PYTHONPATH=$SPARK_HOME/python/:$PYTHONPATH
RUN export PYTHONPATH=$SPARK_HOME/python/lib/py4j-0.10.7-src.zip:$PYTHONPATH


WORKDIR /home/user/
CMD [ "echo", 'Welcome to SparkArchlinux containner fell free to contribute' ]
CMD jupyter notebook --no-browser --ip 0.0.0.0 --port 8888 notebooks