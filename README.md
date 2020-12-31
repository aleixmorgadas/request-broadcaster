# request-broadcast

An AWS Component to boradcast HTTP requests to N subscribers.

## How it works

![request-broadcaster image](./docs/assets/request-broadcaster.png)

0. A device that wants to start receiving the requests needs to register into the DynamoDB.
1. Expose an API Gateway to receive the external webhooks
2. Lambda receives the HTTP Call.
3. Lambda fetches all registered devices from DynamoDB
4. Replies the HTTP Call to all registered devices (fire and forget)

