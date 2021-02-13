# request-broadcast

![CI](https://github.com/aleixmorgadas/request-broadcaster/workflows/CI/badge.svg)

An AWS Component to broadcast HTTP requests to N subscribers.

## How it works

![request-broadcaster image](./docs/assets/request-broadcaster.png)

0. A device that wants to start receiving the requests needs to register into the DynamoDB.
1. Expose an API Gateway to receive the external webhooks
2. Lambda receives the HTTP Call.
3. Lambda fetches all registered devices from DynamoDB
4. Replies the HTTP Call to all registered devices (fire and forget)

## Warnings

:warning: This components might incur in your AWS Bill. It shouldn't be a lot, but depends on the traffic you have.