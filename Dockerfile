# Use a lightweight base image (like node if you still need node, or nginx for static HTML)
FROM node:18   # or FROM nginx:alpine for pure static HTML

# Set working directory inside container
WORKDIR /app

# Copy everything from your project into the container
COPY . .

# If it's a Node app, you can skip npm install
# If it's static HTML, no build needed
# Expose port (for Node server)
EXPOSE 3000

# Start your app
# For Node.js app (replace app.js with your entry point)
CMD ["node", "app.js"]

# For static HTML with nginx, it would be:
# COPY . /usr/share/nginx/html
# CMD ["nginx", "-g", "daemon off;"]
