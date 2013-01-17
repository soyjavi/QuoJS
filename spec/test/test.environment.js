// ENVIRONMENT
var env = $$.environment();
el = $$('#box-environment');
el.append('<div>browser: ' + env.browser + '</div>');
el.append('<div>os: ' + env.os + '</div>');
el.append('<div>isMobile: ' + env.isMobile + '</div>');
el.append('<div>screen: ' + env.screen.width.toString() + 'x' + env.screen.height.toString() + '</div>');
$$('#environment').addClass('success');