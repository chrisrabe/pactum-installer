// Note:
// Every service requires a namespace to address the limitation
// of clashing endpoints for multiple services with the same endpoints.
//
// e.g.
// process.env.FRANK_SERVICE_URL = `${FULL_PACTUM_URL}/frank`
//
// Make sure to modify src/pactum/stubbing.ts > ServiceNamespace when
// adding or modifying the namespace
//
const FULL_PACTUM_URL = `${process.env.PACTUM_URL}:${process.env.PACTUM_PORT}`;
