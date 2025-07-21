# Use the official NGINX image
FROM nginx:alpine

# Remove the default nginx page
RUN rm -rf /usr/share/nginx/html/*

# Copy your own HTML file
COPY index.html /usr/share/nginx/html/

# Expose port 80
EXPOSE 80
