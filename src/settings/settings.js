angular
.module('settings',  ['ui.router'])
.config(function($stateProvider) {
    console.log('Config: settings');

    $stateProvider
    .state('root.main.settings', {
        url: '/settings',
        templateUrl: 'src/settings/partials/settings.html'
    });
});
