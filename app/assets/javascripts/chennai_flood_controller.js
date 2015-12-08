var app = angular.module('chennai_floods', []);

app.controller("HomeController", ['$scope', function($scope){
	$scope.test = "Hello world";
}]);

/*app.config([
	'$routeProvider', function($routeProvider){
		$routeProvider.when('/',{
				templateUrl: '/templates/home.html',
				controller: 'HomeController'
		});
	}
	]);*/

