# DevOps Challenge

This repository contains a simple Flask application.
It uses PostgreSQL as the database of choice.

Application has two endpoints:
- `/users` that list users
- `/health` for healthcheck

Database schema is provided in file `source/init.sql`. You can use it to create a database schema.

Dockerize the application and push it to your choice public Docker Registry.
Deploy this application along with Postgres database to a provided Kubernetes cluster.
For deployment, choose Terraform, Ansible, or both.
