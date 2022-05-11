FROM node:lts-alpine AS react-nx-base
WORKDIR /app
COPY . .
RUN npm ci
RUN npm run build
RUN npm prune --production
# multi stash
FROM nginx:alpine AS react-nx-ui
WORKDIR /usr/share/nginx/html
COPY --from=react-nx-base /app/dist/apps/gke-demo .
# react-nx-base 是上面的 container name