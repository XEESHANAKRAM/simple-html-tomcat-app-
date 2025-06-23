FROM tomcat:9.0
COPY target/simple-html-app.war /usr/local/tomcat/webapps/
