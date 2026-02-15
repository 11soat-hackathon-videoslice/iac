import { util } from '@aws-appsync/utils';

export function request(ctx) {
    const { id, timestamp } = ctx.arguments;
    return {
        operation: 'UpdateItem',
        key: util.dynamodb.toMapValues({ id, timestamp }), // Garante que o ID mapeado é o da PK
        update: {
            // Usamos nomes de atributos para evitar conflito com palavras reservadas
            expression: 'SET #isRead = :true',
            expressionNames: { '#isRead': 'isRead' },
            expressionValues: util.dynamodb.toMapValues({ ':true': true }),
        },
    };
}

export function response(ctx) {
    if (ctx.error) {
        util.error(ctx.error.message, ctx.error.type);
    }
    return ctx.result;
}