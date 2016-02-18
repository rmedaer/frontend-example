angular
.module('app',  ['ui.router', 'auth', 'settings'])
.config(function($stateProvider, $urlRouterProvider) {
    console.log('Config: app');

    $urlRouterProvider.otherwise('/home');

    $stateProvider
    .state('root', {
        url: '',
        templateUrl: 'src/app/partials/root.html',
        abstract: true,
    })
    .state('root.main', {
        url: '',
        views: {
            content: {
                templateUrl: 'src/app/partials/wrapper.html'
            },
            menu: {
                templateUrl: 'src/app/partials/menu.html'
            }
        },
        abstract: true,
    })
    .state('root.main.home', {
        url: '/home',
        templateUrl: 'src/app/partials/home.html',
    });
});
