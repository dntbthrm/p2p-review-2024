FROM node:21-alpine3.19 AS builder

WORKDIR /app_frontend

COPY frontend/package*.json ./  
COPY frontend/yarn.lock ./       

RUN npm install --legacy-peer-deps  

COPY frontend/ ./

ENV REACT_APP_API_BASE_URL=http://localhost:8080

RUN npm run build   


FROM nginx:alpine
COPY dockerfiles/default.conf /etc/nginx/conf.d/default.conf

COPY --from=builder /app_frontend/build /usr/share/nginx/html

# порт для nginx
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
