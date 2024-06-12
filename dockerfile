FROM nginx:alpine

COPY ./dist/gifs usr/share/nginx/html

EXPOSE 80


CMD ["nginx", "-g", "daemon off;" ]