//Auto-generated by RSP Compiler
//Source: list-page.rsp.html
library list_page_rsp;

import 'dart:async';
import 'dart:io';
import 'package:stream/stream.dart';
import 'package:bookshelf_server/user.dart';
import 'package:bookshelf_server/book.dart';
import 'package:bookshelf_server/year.dart';

/** Template, listPage, for rendering the view. */
Future listPage(HttpConnect connect, {List<Book>books,escapedUserID,List<Year>years,int activeYear,int activeMonth}) async { //#4
  HttpResponse response = connect.response;
  if (!Rsp.init(connect, "text/html; charset=utf-8"))
    return null;

  response.write("""<!DOCTYPE html>
<html>
<head>
    <title>"""); //#4

  response.write(Rsp.nnx(escapedUserID)); //#7


  response.write(""" さんのbookshelf</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <script>
        (function (i, s, o, g, r, a, m) {
            i['GoogleAnalyticsObject'] = r;
            i[r] = i[r] || function () {
                        (i[r].q = i[r].q || []).push(arguments)
                    }, i[r].l = 1 * new Date();
            a = s.createElement(o),
                    m = s.getElementsByTagName(o)[0];
            a.async = 1;
            a.src = g;
            m.parentNode.insertBefore(a, m)
        })(window, document, 'script', 'https://www.google-analytics.com/analytics.js', 'ga');

        ga('create', 'UA-89660523-1', 'auto');
        ga('send', 'pageview');
    </script>
</head>
<body>
<nav class="navbar navbar-default navbar-static-top">
    <div class="container">
        <ul class="nav navbar-nav">
            <li><a href="/">Top</a></li>
            <li><a href="/mypage">新規登録</a></li>
            <li class="active"><a href="#">読了リスト</a></li>
        </ul>
    </div>
</nav>
<div class="container">
    <div class="jumbotron">
        <h1>"""); //#7

  response.write(Rsp.nnx(escapedUserID)); //#38


  response.write(""" さんのbookshelf</h1>
        <p>つながりを作ろう</p>
    </div>

    <div class="calendar">
        <ul class="years nav nav-pills">
"""); //#38

  for (var year in years) { //for#44

    if (year.isActive) { //if#45

      response.write("""                <li role="presentation" class="enable active"><a href="#calendar-"""); //#46

      response.write(Rsp.nnx(year.year)); //#46


      response.write("""">"""); //#46

      response.write(Rsp.nnx(year.year)); //#46


      response.write("""年</a></li>
"""); //#46

    } else if (year.isEnable) { //else#47

      response.write("""                <li role="presentation" class="enable"><a href="#calendar-"""); //#48

      response.write(Rsp.nnx(year.year)); //#48


      response.write("""">"""); //#48

      response.write(Rsp.nnx(year.year)); //#48


      response.write("""年</a></li>
"""); //#48

    } else { //else#49

      response.write("""                <li role="presentation" class="disabled"><a href="javascript:void(0)">"""); //#50

      response.write(Rsp.nnx(year.year)); //#50


      response.write("""年</a></li>
"""); //#50
    } //if
  } //for

  response.write("""        </ul>

        <div class="tab-content">
"""); //#53

  for (var year in years) { //for#56

    response.write("""            <div role="tabpanel" class="tab-pane """); //#57

    response.write(Rsp.nnx(year.isActive ? 'active' : '')); //#57


    response.write("""" id="calendar-"""); //#57

    response.write(Rsp.nnx(year.year)); //#57


    response.write("""">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
"""); //#57

    for (var month in year.months) { //for#60

      if (month.isActive) { //if#61

        response.write("""                                <li class="active"><a href="javascript:void(0)">"""); //#62

        response.write(Rsp.nnx(month.month)); //#62


        response.write("""月</a></li>
"""); //#62

      } else if (month.isEnable) { //else#63

        response.write("""                                <li><a href="/user/"""); //#64

        response.write(Rsp.nnx(escapedUserID)); //#64


        response.write("""/"""); //#64

        response.write(Rsp.nnx(year.year)); //#64


        response.write("""/"""); //#64

        response.write(Rsp.nnx(month.month)); //#64


        response.write("""">"""); //#64

        response.write(Rsp.nnx(month.month)); //#64


        response.write("""月</a></li>
"""); //#64

      } else { //else#65

        response.write("""                                <li class="disabled"><a href="javascript:void(0)">"""); //#66

        response.write(Rsp.nnx(month.month)); //#66


        response.write("""月</a></li>
"""); //#66
      } //if
    } //for

    response.write("""                    </ul>
                </nav>
            </div>
"""); //#69
  } //for

  response.write("""        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading">
            <a
                    id="edit-button"
                    type="button"
                    class="btn btn-success pull-right hide"
                    href="/mypage/"""); //#73

  response.write(Rsp.nnx(activeYear)); //#82


  response.write("""/"""); //#82

  response.write(Rsp.nnx(activeMonth)); //#82


  response.write("""">編集する</a>
            <h2 class="panel-title">読了リスト</h2>
        </div>
            <ul class="list-group">
"""); //#82

  for (var book in books) { //for#86
var title = book.getEscapedTitle();
                var author = book.getEscapedAuthor();
                var date = book.getFormattedDateTime();

    response.write("""

                <li class="list-group-item">"""); //#91

    response.write(Rsp.nnx(title)); //#92


    response.write(""" """); //#92

    response.write(Rsp.nnx(author)); //#92


    response.write(""" """); //#92

    response.write(Rsp.nnx(date)); //#92


    response.write("""</li>
"""); //#92
  } //for

  response.write("""            </ul>
    </div>
</div>
<!-- Latest compiled and minified CSS -->
<link
        rel="stylesheet"
        href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
        integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
        crossorigin="anonymous">

<!-- Optional theme -->
<link
        rel="stylesheet"
        href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"
        integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp"
        crossorigin="anonymous">

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

<!-- Latest compiled and minified JavaScript -->
<script
        src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
        integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
        crossorigin="anonymous"></script>
<script>
    \$('.calendar .years li.enable a').click(function (e) {
        e.preventDefault();
        \$(this).tab('show');
    })
</script>
<script>
    var userName = window.location.pathname.split("/")[2];
    var myName = window.localStorage["myName"];

    if(userName == myName){
        \$("#edit-button").removeClass("hide");
    }

</script>
</body>
</html>"""); //#94

  return null;
}
