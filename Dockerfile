FROM nginx:1.27-alpine
# FROM nginx
COPY build /usr/share/nginx/html
