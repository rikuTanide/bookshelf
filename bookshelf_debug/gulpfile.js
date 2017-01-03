var gulp = require("gulp");
var webserver = require("gulp-webserver");
gulp.task('webserver', function () {
    gulp.src('web')
        .pipe(webserver({
            host: 'localhost',
            port: 8000,
            livereload: true,
            proxies: [
                {
                    source: '/mypage/packages',
                    target: 'http://localhost:63342/bookshelf/bookshell_client/web/mypage/packages'
                },
                {
                    source: '/mypage/main.dart.js',
                    target: 'http://localhost:63342/bookshelf/bookshell_client/web/mypage/main.dart.js'
                },
                {
                    source: '/mypage',
                    target: 'http://localhost:8080/mypage'
                },
                {
                    source: '/static/',
                    target: 'http://localhost:63342/'
                },
                {
                    source: '/',
                    target: 'http://localhost:8080/'
                }
            ]
        }));
});