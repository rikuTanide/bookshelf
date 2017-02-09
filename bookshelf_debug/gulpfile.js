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
                    source: '/static/',
                    target: 'http://localhost:63342/'
                },
                {
                    source: '/mypage/angular/',
                    target: 'http://localhost:63342/bookshelf/bookshell_client/web/mypage/angular/'
                },
                {
                    source: '/',
                    target: 'http://localhost:8080/'
                }
            ]
        }));
});