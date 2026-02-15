import { util } from '@aws-appsync/utils';

export function request(ctx) {
    const { userId, limit = 20, nextToken } = ctx.arguments;

    return {
        operation: 'Query',
        // O GSI deve ter userId como Partition Key e timestamp como Sort Key
        index: 'userId',
        query: {
            expression: 'userId = :userId',
            expressionValues: util.dynamodb.toMapValues({ ':userId': userId }),
        },
        // Filtra os resultados após a busca pela chave
        filter: {
            expression: 'isRead = :isRead',
            expressionValues: util.dynamodb.toMapValues({ ':isRead': false }),
        },
        // scanIndexForward: false traz o timestamp mais recente primeiro (ordem decrescente)
        scanIndexForward: false,
        limit: limit,
        nextToken: nextToken,
    };
}

export function response(ctx) {
    return ctx.result;
}
