import { mock } from 'pactum';

process.env.PACTUM_PORT = '3000';
process.env.PACTUM_URL = `http://localhost`;

export default function name() {
    mock.start(parseInt(process.env.PACTUM_PORT));
}
