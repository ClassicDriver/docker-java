##########################################################################################
# ClassicDriver Base Docker image with Java installed (Server JRE)
##########################################################################################
FROM classicdriver/base

MAINTAINER Team Nitrous <nitrous@classicdriver.com>

#############################################
# Java installation
#############################################
ENV APP_INSTALL_DIR /opt/jdk
ENV APP_MAJOR_VERSION 8
ENV APP_MINOR_VERSION 60
ENV APP_BUILD_VERSION b27
ENV APP_ARCHIVE server-jre-${APP_MAJOR_VERSION}u${APP_MINOR_VERSION}-linux-x64.tar.gz
ENV APP_RELATIVE_URL ${APP_MAJOR_VERSION}u${APP_MINOR_VERSION}-${APP_BUILD_VERSION}/${APP_ARCHIVE}
ENV APP_FULL_INSTALL_PATH ${APP_INSTALL_DIR}/jdk1.${APP_MAJOR_VERSION}.0_${APP_MINOR_VERSION}

# Move into the tmp directory
# WORKDIR /tmp

# Create installation directory
# Download java from Oracle (for example http://download.oracle.com/otn-pub/java/jdk/8u60-b27/server-jre-8u60-linux-x64.tar.gz)
# Extract the downloaded tar file into the installation directory:
RUN	mkdir -p ${APP_INSTALL_DIR}                       \
    && wget --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/${APP_RELATIVE_URL} \
    && tar -zxf ${APP_ARCHIVE} -C ${APP_INSTALL_DIR}  \
    && rm -rf ${APP_ARCHIVE}.tar.gz

# Set $JAVA_HOME environment variable
ENV JAVA_HOME ${APP_FULL_INSTALL_PATH}

# Add the ${JAVA_HOME}/bin directory to the $PATH environment variable
ENV PATH $PATH:${APP_FULL_INSTALL_PATH}/bin

# Set as the default JVM
RUN	update-alternatives --install /usr/bin/java java ${APP_FULL_INSTALL_PATH}/bin/java 100 \
    && update-alternatives --install /usr/bin/javac javac ${APP_FULL_INSTALL_PATH}/bin/javac 100

# Move into the home directory
WORKDIR /
