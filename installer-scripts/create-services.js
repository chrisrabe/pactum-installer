if (process.argv.length < 3) {
    throw new Error("Must pass in comma delimited services");
}

const services = process.argv[2].split(',');
const serviceStr = services.map(serv => `  ${serv} = '${serv}'`).join(',\\n');
const template = `export enum ServiceNamespace {\\n${serviceStr}\\n}`;

console.log(template);