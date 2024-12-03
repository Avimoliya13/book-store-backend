# Cloud-Based E-Book Store

## Overview
The Cloud-Based E-Book Store is a scalable and feature-rich online platform for browsing, searching, and purchasing e-books. This project leverages modern web development and cloud technologies to ensure a seamless user experience and efficient administrative management.

---

## Features
- **User Interface:**
  - Modern and responsive UI developed with React.js, deployed on Vercel.
  - Secure user authentication and session management via Firebase.

- **Admin Features:**
  - View, update, and upload book details.
  - Manage book inventory and sales data.

- **Backend:**
  - Built using Express.js and Node.js.
  - Hosted on AWS EC2 with containerized deployment using Docker and AWS ECR.

- **Database:**
  - MongoDB Atlas for book inventory, transaction records, and user data.
  - AWS S3 for storing book covers and media files.

- **Infrastructure:**
  - Automated using Terraform for consistent AWS resource management.

---

## Architecture
The architecture integrates the following key components:

### 1. Frontend
- **React.js**: Responsive and interactive client-side rendering.
- **Vercel**: Deployment with CI/CD integration and optimized loading.

### 2. Backend
- **Express.js and Node.js**: API development and business logic.
- **Docker**: Streamlined containerized deployment.
- **AWS ECR**: Efficient management of Docker container images.
- **AWS EC2**: Scalable and secure backend hosting.

### 3. Database
- **MongoDB Atlas**: Flexible NoSQL database for scalable data storage.

### 4. Authentication
- **Firebase Authentication**: Secure user authentication and data management.

### 5. Infrastructure
- **AWS EC2**: Backend service hosting.
- **AWS S3**: Static asset storage (e.g., book covers).
- **Terraform**: Infrastructure as Code for provisioning AWS resources.

---

## Technologies Used
- **Frontend**: React.js, Vercel
- **Backend**: Express.js, Node.js, Docker, AWS ECR, AWS EC2
- **Database**: MongoDB Atlas
- **Authentication**: Firebase Authentication
- **Infrastructure**: AWS S3, Terraform
- **Version Control**: GitHub

---

## How to Run the Project

### Prerequisites
1. Install [Node.js](https://nodejs.org/).
2. Install [Docker](https://www.docker.com/).
3. Set up an AWS account and configure CLI access.
4. Create a MongoDB Atlas cluster and get the connection string.
5. Configure Firebase for user authentication.

### Steps to Run Locally
1. Clone the repository:
   ```bash
   git clone https://github.com/Avimoliya13/book-store-frontend.git
   cd frontend
   ```
   ```bash
   git clone https://github.com/Avimoliya13/book-store-backend.git
   cd backend
   ```
2. Set up environment variables:
   - Create a `.env` file in the root directory.
   - Add the following variables:
     ```env
     MONGO_URI=your_mongodb_connection_string
     FIREBASE_API_KEY=your_firebase_api_key
     FIREBASE_AUTH_DOMAIN=your_firebase_auth_domain
     AWS_S3_BUCKET=your_aws_s3_bucket_name
     AWS_REGION=your_aws_region
     ```
3. Install dependencies:
   ```bash
   npm install
   ```
4. Build and start the backend:
   ```bash
   npm run start:dev
   ```
5. Start the frontend:
   ```bash
   npm run dev
   ```
6. Open the application in your browser:
   - Frontend: `http://localhost:5173`
   - Backend: `http://localhost:3000`

### Deployment
Follow these steps to deploy the project:
1. Use Terraform to provision AWS resources for EC2 and ECR.
2. Push the backend Docker image to AWS ECR.
3. Deploy the frontend on Vercel.

---

