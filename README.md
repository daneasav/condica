# condica

subscription_id = "1ea27b67-8bb9-4189-9a99-c7fff25c2f67"
client_id       = "964c4a41-fc2f-47b6-be26-688dd6a80574"
client_secret   = "W/Hn0ztWK3v1uQmf5vhGOFCctI3mHzMeEdS1ii0133I="
tenant_id       = "88d0a5a9-d61a-4dd6-9a75-6637f3fe6bd8"

export azure_subscription_id="1ea27b67-8bb9-4189-9a99-c7fff25c2f67"
export azure_client_id="964c4a41-fc2f-47b6-be26-688dd6a80574"
export azure_client_secret="W/Hn0ztWK3v1uQmf5vhGOFCctI3mHzMeEdS1ii0133I="
export azure_tenant_id="88d0a5a9-d61a-4dd6-9a75-6637f3fe6bd8"

docker run -p 8080:8080 -p 50000:50000 --env JAVA_OPTS=-Dorg.jenkinsci.plugins.durabletask.BourneShellScript.HEARTBEAT_CHECK_INTERVAL=300 -v /Users/daneasav/workspace/settings/jenkins:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock -u root jenkinsci/blueocean:1.5.0


AccountEndpoint=https://condik-account.documents.azure.com:443/;AccountKey=kfzbmqYH7dxLT6wrvtcRfWtCifHiGmhm7OtWShwtSKic1pMGLNU8Qa6tccdC3HEuzap2y7AKrcZLwTGTIjC3Fw==;

AccountEndpoint=https://condik-account.documents.azure.com:443/;AccountKey=A3YZPEEK5TDGLb4pfW9Aoyva4DksZgC1zFAkUDLLO1lmQn5pIk0lIGsOD8zh1rJEKy5OtHpZMrLxuXc6bKAgpQ==;

AccountEndpoint=https://condik-account.documents.azure.com:443/;AccountKey=8kULGwSHyWYXI1fxSg11C6begC6bVLp6EyLzNtudYlgoJsnex9yQNSjJLpohXp82w5nLUWsUKghJOJf7m32EFQ==;