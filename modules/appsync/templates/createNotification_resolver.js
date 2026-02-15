import { util } from '@aws-appsync/utils';

export function request(ctx) {
    const { input } = ctx.arguments;
    // O util.dynamodb.putItem gera automaticamente o formato { "M": {...} } do DynamoDB
    return {
        operation: 'PutItem',
        key: util.dynamodb.toMapValues({
            id: input.id,
            timestamp: input.timestamp
        }),
        attributeValues: util.dynamodb.toMapValues(input),
    };
}

export function response(ctx) {
    return ctx.result;
}