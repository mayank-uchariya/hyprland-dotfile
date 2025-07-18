/* eslint-disable no-undef */

self.addEventListener('notificationclick', function (event) {
  console.log('notificationclick', event);
  event.notification.close();
});

self.addEventListener('notificationclose', function (event) {
  console.log('Notification closed', event);
});

// Scripts for firebase and firebase messaging
importScripts('./firebase-app-compat.js');
importScripts('./firebase-messaging-compat.js');

// Initialize the Firebase app in the service worker by passing the generated config
const firebaseConfig = {
  apiKey: 'AIzaSyC-0rAgbpW6y_BubS2MVgEo0NsDWvYqr0s',
  authDomain: 'martian-notifications-dev.firebaseapp.com',
  projectId: 'martian-notifications-dev',
  storageBucket: 'martian-notifications-dev.appspot.com',
  messagingSenderId: '682018367222',
  appId: '1:682018367222:web:93ccd1a367e04c14b2aed7',
  measurementId: 'G-VZSYDC8TDJ'
};
firebase.initializeApp(firebaseConfig);

// Retrieve firebase messaging
const messaging = firebase.messaging();

messaging.onBackgroundMessage(function (payload) {
  console.log('Received background message ', payload);
});
