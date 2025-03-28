FROM node:20.19.0-alpine AS base
ARG ANGULAR_ENV="production"

# -- INSTALL -- #
FROM base AS dev-dependencies
WORKDIR /project/app
COPY ./package*.json .

WORKDIR /project/app
RUN npm install --no-fund

# -- app SRC -- #
FROM dev-dependencies AS src
WORKDIR /project/app
COPY . .

# -- BUILD -- #
FROM src AS build
WORKDIR /project/app
RUN npm run build -- --configuration ${ANGULAR_ENV}

# -- TEST -- #
FROM src AS test
WORKDIR /project/app/
RUN npm run test:report --ci

FROM nginx:stable-alpine AS production
ARG build_dir='my-angular-project'

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./entrypoint.sh /root/entrypoint.sh
RUN chmod +x /root/entrypoint.sh

COPY --from=build /project/app/dist/${build_dir}/browser/ /usr/share/nginx/html

EXPOSE 80

CMD ["/root/entrypoint.sh"]
