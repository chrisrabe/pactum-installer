import { mock } from 'pactum';
import { RequestMethod } from 'pactum/src/exports/mock';

export interface StubOptions {
  method?: RequestMethod;
  responseStatus?: number;
}

const defaultStubOptions: StubOptions = {
  method: 'GET',
  responseStatus: 200,
};

export const addStub = (url: string, responseBody: Record<string, any>, options = defaultStubOptions) => {
  const stubPath = url.startsWith('/') ? url : `/${url}`;
  mock.addInteraction({
    request: {
      method: options.method ?? 'GET',
      path: stubPath,
    },
    response: {
      status: options.responseStatus ?? 200,
      body: responseBody,
    },
  });
};
