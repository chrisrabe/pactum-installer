import { mock } from 'pactum';
import { createStubs } from './stubs';

const PORT = 3000;

createStubs();

mock.start(PORT).then();
