# Use the official Apache HTTP Server image from the Docker Hub
FROM httpd:latest

# Copy website files to the Apache server directory
COPY ./ /usr/local/apache2/htdocs/