const buildEnv = () => {
  // ts-hackaround
  const someFoo = (window as any)['env']['FOO'];
  return {
    someFoo,
  };
};

export const environment = buildEnv();
