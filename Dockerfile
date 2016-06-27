FROM ubuntu:16.04
MAINTAINER Beau Cronin, beau.cronin@gmail.com

ENV NUM_PROCS 8

RUN apt-get update && apt-get install -y \
	m4 \
	wget \
	gfortran \
	git \
	csh \
	libxml-libxml-perl \
    cmake \
    libopenmpi-dev \
    openmpi-bin \
    awscli \
	libncurses5-dev \
	tk8.5-dev \
	tcl \
	psmisc \
	autoconf \
	libswitch-perl \
	vim

# hdf5 - need to build from source
# ADD http://www.hdfgroup.org/ftp/HDF5/current/src/hdf5-1.8.17.tar.gz /
RUN wget -q http://www.hdfgroup.org/ftp/HDF5/current/src/hdf5-1.8.17.tar.gz
RUN tar xzvf hdf5-1.8.17.tar.gz
RUN cd hdf5-1.8.17 \
	&& ./configure --prefix=/usr \
	&& make \
	&& make install

# netcdf - need to build both C and Fortran versions from source, pointed at HDF5
# ADD https://github.com/Unidata/netcdf-c/archive/v4.4.0.tar.gz /netcdf-c-4.4.0.tar.gz
RUN wget -q https://github.com/Unidata/netcdf-c/archive/v4.4.0.tar.gz -O netcdf-c-4.4.0.tar.gz
RUN tar xzvf netcdf-c-4.4.0.tar.gz
RUN cd netcdf-c-4.4.0 \
	&& ./configure --prefix=/usr --libdir=/usr \
	&& make \
	&& make install

# ADD https://github.com/Unidata/netcdf-fortran/archive/v4.4.4.tar.gz /netcdf-fortran-4.4.4.tar.gz
RUN wget -q https://github.com/Unidata/netcdf-fortran/archive/v4.4.4.tar.gz -O netcdf-fortran-4.4.4.tar.gz
RUN tar xzvf netcdf-fortran-4.4.4.tar.gz
RUN cd netcdf-fortran-4.4.4 \
	&& ./configure --prefix=/usr --libdir=/usr \
	&& make \
	&& make install

# confd
RUN wget -q https://github.com/kelseyhightower/confd/releases/download/v0.12.0-alpha3/confd-0.12.0-alpha3-linux-amd64 -O confd
RUN chmod u+x confd

# openlava
RUN wget -q https://github.com/openlava/openlava/archive/3.3.2.tar.gz -O openlava-3.3.2.tar.gz
RUN tar xzvf openlava-3.3.2.tar.gz
RUN cd openlava-3.3.2 \
    && ./bootstrap.sh \
    && ./configure --prefix=/opt/openlava \
    && make \
    && make install
ADD ./conf/openlava/* /opt/openlava/etc/
RUN useradd -r openlava
#RUN chown -R openlava:openlava /opt/openlava
RUN cp /opt/openlava/etc/openlava /etc/init.d
RUN chmod +x /etc/init.d/openlava
RUN cp /opt/openlava/etc/openlava.* /etc/profile.d

# cesm 1.2.2
RUN git clone https://github.com/beaucronin/cesm-1_2_2.git  

ADD conf/confd /etc/confd
ADD conf/cesm/confd /etc/cesm
ADD conf/cesm/Macros /
ADD conf/cesm/case1.run /
ADD scripts/boot.sh /
CMD /boot.sh