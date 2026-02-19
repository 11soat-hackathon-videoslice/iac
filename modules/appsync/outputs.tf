output "api_id" {
  value       = aws_appsync_graphql_api.this.id
  description = "AppSync API ID"
}

output "api_arn" {
  value       = aws_appsync_graphql_api.this.arn
  description = "AppSync API ARN"
}

output "graphql_url" {
  value       = aws_appsync_graphql_api.this.uris["GRAPHQL"]
  description = "GraphQL endpoint URL"
}

output "realtime_url" {
  value       = aws_appsync_graphql_api.this.uris["REALTIME"]
  description = "Realtime endpoint URL"
}
