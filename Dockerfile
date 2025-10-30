# Use a lightweight web server
FROM nginx:latest

# Copy website files to Nginx default directory
COPY . /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
