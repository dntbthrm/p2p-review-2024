FROM node:21-alpine3.19 AS builder

WORKDIR /app_frontend

COPY frontend/package*.json ./  
COPY frontend/yarn.lock ./       

RUN npm install --legacy-peer-deps  

COPY frontend/ ./

RUN npm run build   


FROM nginx:alpine

COPY --from=builder /app_frontend/build /usr/share/nginx/html

# порт для nginx
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
