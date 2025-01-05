CICD-Terraform
GKE Cluster Creation Steps
Pre-requisites

    GCP Account and Project Creation: Ensure you have a Google Cloud Platform (GCP) account and a project set up.
    Terraform State Bucket: Create a Google Cloud Storage bucket to store the Terraform state files.

How to Use These Scripts

    Environment Setup:
        The scripts provided support both test and production environments. To add a new environment, copy any existing environment file and modify the values accordingly.

    CI/CD Configuration:
        GitHub Actions is configured to trigger automatically. Ensure the following secrets are configured in your GitHub Actions under the environment settings:
            GOOGLE_CREDENTIALS: Create a service account in GCP and add the JSON key as a GitHub Actions secret.
            project_id: Your GCP project ID.
            region: The region where the GKE cluster will be created.
            bucket_name: The name of the bucket for storing Terraform state files.
            db_password: The password for the database user.
            notification_email: The email address to receive monitoring alerts.

    GitHub Actions Deployment:
        The GitHub Actions deploy file is defaulted to the "test" environment. Adjust the configuration in the GitHub Actions workflow file as needed for different environments.

    Cloud Monitoring:
        Cloud Monitoring dashboards and alerts are set up to track the health and performance of your applications.

    Static IP and DNS Records:
        A static IP is created for the ingress. Ensure to use this IP in the ingress service configuration when deploying applications.

    PL/SQL Database:
        A PL/SQL database is created with one user.
        DB DDL scripts are included in this repository but are not automated.
        DNS Name not created for DB host