function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);

  karate.configure('ssl', true);
  // Otherwise we get this exception org.opentest4j.AssertionFailedError: 
  // http call failed after 1531 milliseconds for url: 
  // javax.net.ssl.SSLHandshakeException: PKIX path building 
  // failed: sun.security.provider.certpath.SunCertPathBuilderException: 
  // unable to find valid certification path to requested target

  if (!env) {
    env = 'dev';
  }
  var config = {
    env: env,
    myVarName: 'someValue'
  }
  if (env == 'dev') {
    // customize
    // e.g. config.foo = 'bar';
  } else if (env == 'e2e') {
    // customize
  }
  return config;
}