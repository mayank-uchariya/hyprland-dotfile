try {
  importScripts('./firebase-messaging-sw.js', 'static/js/background.js');
} catch (e) {
  console.log(e);
}
