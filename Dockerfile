# Use Node.js 14 LTS as the base image
FROM node:14

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy all files from the current directory to the working directory in the container
COPY . .

# Expose port 3000 (or the port your Node.js app is running on)
EXPOSE 3000

# Command to start the Node.js application
CMD ["npm", "start"]
