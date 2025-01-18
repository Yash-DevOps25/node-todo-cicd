# Use official Node.js image as base
FROM node:14

# Set working directory inside the container
WORKDIR /app

# Copy the app files into the container
COPY . .

# Install dependencies
RUN npm install

# Expose port 8000 (or the port your app uses)
EXPOSE 8000

# Run the app
CMD ["node", "app.js"]
