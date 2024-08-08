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
    apiUrl: 'https://conduit-api.bondaracademy.com/api/'
  }
  if (env == 'dev') {
    config.userEmail = 'arun@conduit.com'
    config.userPassword = 'arunconduit'
  } else if (env == 'qa') {
    config.userEmail = 'arunqa@conduit.com'
    config.userPassword = 'arunconduit'
  }

  var accessToken = karate.callSingle('classpath:helpers/CreateToken.feature', config).authToken
  karate.configure('headers', {Authorization: 'Token ' + accessToken})
  return config;
}