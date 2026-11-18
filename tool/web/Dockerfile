# Serves the Flutter web build (static files) on Cloud Run. Built by
# tool/deploy_web_gcp.sh from a staging folder holding web/ + nginx.conf.
FROM nginx:1.27-alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY web/ /usr/share/nginx/html/
EXPOSE 8080
