angular
.module('auth', ['ui.router'])
.config(function($stateProvider) {
    console.log('Config: auth');
    //
    // Now set up the states
    $stateProvider
    .state('auth', {
        url: '/login',
        templateUrl: 'src/auth/partials/login.html'
    });
});
