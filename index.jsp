<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.sql.*" %>

<!doctype html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>HTML Reference | select</title>
    <script src="//code.jquery.com/jquery.min.js"></script>
  </head>
  <body>
    <div class="selectgood selectonchange">
      <style>
          .selectonchange{text-align: center; padding : 120px 10px; margin-bottom : 30px;}
          .selectgood{text-align: center; padding : 120px 10px; margin-bottom : 30px;}
          body {
            background-image: url('cloud_image.jpg');
            background-repeat: no-repeat;
            background-size: cover;
          }
          h1 {
              font-family: "Arial Black", sans-serif;
              font-weight: bold;
              color: #ffffff;
              text-shadow: 2px 6px 2px gray;
          }
      </style>
      <div>
        <h1 style="font-family:impact; color:#FFFFFF; font-size: 80px;">NALCCTV</h1>
        <form action="result.jsp" method="get" accept-charset="utf-8">
          <select name="dosi" onchange="categoryChange(this)"  style="font-family: Verdana; width: 150px; height: 70; font-size: 20px; text-align-last: center;">
             <option>::시/도::</option>
             <option value="a">강원도</option>
             <option value="b">경기도</option>
             <option value="c">경상남도</option>
             <option value="d">경상북도</option>
             <option value="e">대구광역시</option>
             <option value="f">대전광역시</option>
             <option value="g">부산광역시</option>
             <option value="h">서울특별시</option>
             <option value="i">세종특별자치시</option>
             <option value="j">인천광역시</option>
             <option value="k">전라남도</option>
             <option value="l">전라북도</option>
             <option value="m">충청남도</option>
             <option value="n">충청북도</option>
          </select>

          <select name="sigungu" id="sigungu" onchange="locaChange(this)" style="font-family: Verdana; width: 150px; height: 700; font-size: 20px;  text-align-last: center">
            <option>::시/군/구::</option>
            <option value='13' data-local="a">강릉시</option>
            <option value='14' data-local="a">고성군</option>
            <option value='15' data-local="a">삼척시</option>
            <option value='16' data-local="a">속초시</option>
            <option value='17' data-local="a">양구군</option>
            <option value='18' data-local="a">양양군</option>
            <option value='19' data-local="a">영월군</option>
            <option value='20' data-local="a">원주시</option>
            <option value='21' data-local="a">인제군</option>
            <option value='22' data-local="a">정선군</option>
            <option value='23' data-local="a">철원군</option>
            <option value='24' data-local="a">춘천시</option>
            <option value='25' data-local="a">태백시</option>
            <option value='26' data-local="a">평창군</option>
            <option value='27' data-local="a">홍천군</option>
            <option value='28' data-local="a">화천군</option>
            <option value='29' data-local="a">횡성군</option>
            <option value='30' data-local="b">가평군</option>
            <option value='31' data-local="b">광주시</option>
            <option value='32' data-local="b">김포시</option>
            <option value='33' data-local="b">남양주시</option>
            <option value='34' data-local="b">안성시</option>
            <option value='35' data-local="b">양주시</option>
            <option value='36' data-local="b">양평시</option>
            <option value='37' data-local="b">여주시</option>
            <option value='38' data-local="b">연천군</option>
            <option value='39' data-local="b">오산시</option>
            <option value='40' data-local="b">용인시</option>
            <option value='41' data-local="b">의정부시</option>
            <option value='42' data-local="b">이천시</option>
            <option value='43' data-local="b">파주시</option>
            <option value='44' data-local="b">포천시</option>
            <option value='45' data-local="b">화성시</option>
            <option value='46' data-local="b">용인시</option>
            <option value='47' data-local="c">거창군</option>
            <option value='48' data-local="c">김해시</option>
            <option value='49' data-local="c">마산군</option>
            <option value='50' data-local="c">마산시</option>
            <option value='51' data-local="c">밀양시</option>
            <option value='52' data-local="c">양산시</option>
            <option value='53' data-local="c">의령군</option>
            <option value='54' data-local="c">진주시</option>
            <option value='55' data-local="c">창원시</option>
            <option value='56' data-local="c">함양군</option>
            <option value='57' data-local="d">경산시</option>
            <option value='58' data-local="d">경주시</option>
            <option value='59' data-local="d">고령군</option>
            <option value='60' data-local="d">구미시</option>
            <option value='61' data-local="d">군위군</option>
            <option value='62' data-local="d">김천시</option>
            <option value='63' data-local="d">영덕군</option>
            <option value='64' data-local="d">영천시</option>
            <option value='65' data-local="d">울진군</option>
            <option value='66' data-local="d">의성군</option>
            <option value='67' data-local="d">칠곡군</option>
            <option value='68' data-local="d">포항시</option>
            <option value='69' data-local="e">서구</option>
            <option value='70' data-local="f">대덕구</option>
            <option value='71' data-local="f">유성구</option>
            <option value='72' data-local="g">기장군</option>
            <option value='73' data-local="h">강서구</option>
            <option value='74' data-local="h">동자동</option>
            <option value='75' data-local="i">세종특별자치시</option>
            <option value='76' data-local="j">강화군</option>
            <option value='77' data-local="l">남원시</option>
            <option value='78' data-local="l">임실군</option>
            <option value='79' data-local="l">보성군</option>
            <option value='80' data-local="l">장수군</option>
            <option value='81' data-local="l">전주시</option>
            <option value='82' data-local="l">강진군</option>
            <option value='83' data-local="l">광양시</option>
            <option value='84' data-local="l">구례군</option>
            <option value='85' data-local="k">나주시</option>
            <option value='86' data-local="k">담양군</option>
            <option value='87' data-local="k">목포시</option>
            <option value='88' data-local="k">무안군</option>
            <option value='89' data-local="k">보성군</option>
            <option value='90' data-local="k">순천시</option>
            <option value='91' data-local="k">신안군</option>
            <option value='92' data-local="k">여수시</option>
            <option value='93' data-local="k">영광군</option>
            <option value='94' data-local="k">완도군</option>
            <option value='95' data-local="k">임실군</option>
            <option value='96' data-local="k">장성군</option>
            <option value='97' data-local="k">장흥군</option>
            <option value='98' data-local="k">진도군</option>
            <option value='99' data-local="k">함평군</option>
            <option value='100' data-local="k">화순군</option>
            <option value='101' data-local="l">군산시</option>
            <option value='102' data-local="l">김제시</option>
            <option value='103' data-local="l">남원시</option>
            <option value='104' data-local="l">무주군</option>
            <option value='105' data-local="l">부안군</option>
            <option value='106' data-local="l">완산구</option>
            <option value='107' data-local="l">완주군</option>
            <option value='108' data-local="l">익산시</option>
            <option value='109' data-local="l">장수군</option>
            <option value='110' data-local="l">전주시</option>
            <option value='111' data-local="l">정읍시</option>
            <option value='112' data-local="l">진안군</option>
            <option value='113' data-local="m">부여군</option>
            <option value='114' data-local="m">계룡시</option>
            <option value='115' data-local="m">공주시</option>
            <option value='116' data-local="m">논산시</option>
            <option value='117' data-local="m">당진시</option>
            <option value='118' data-local="m">보령시</option>
            <option value='119' data-local="m">보령시</option>
            <option value='120' data-local="m">아산시</option>
            <option value='121' data-local="m">연기군</option>
            <option value='122' data-local="m">예산군</option>
            <option value='123' data-local="m">천안시</option>
            <option value='124' data-local="n">태안시</option>
            <option value='125' data-local="n">홍성군</option>
            <option value='126' data-local="n">영동군</option>
            <option value='127' data-local="n">옥천군</option>
            <option value='128' data-local="n">음성군</option>
            <option value='129' data-local="n">증평군</option>
            <option value='130' data-local="n">진천군</option>
            <option value='131' data-local="n">청주시</option>
            <option value='132' data-local="n">충주시</option>
          </select>

          <%
          Connection conn = null;
          ResultSet rs = null;
          try{
                  String url = "jdbc:mysql://gugu-project-db.ck6ibzbqsisn.ap-northeast-2.rds.amazonaws.com:3306/gugudb?useUnicode=true&characterEncoding=UTF-8";
                  String id = "admin";
                  String pw = "vudrbsskdl27tkf";

                  Class.forName("com.mysql.jdbc.Driver");
                  conn=DriverManager.getConnection(url,id,pw);

                  Statement stmt = conn.createStatement();
                  String sql = "select * from nalcctv";
                  rs = stmt.executeQuery(sql);
                  %>
                  <select name="location" id="location" onchange="xySearch(this)" style="font-family: Verdana; width: 150px; height: 70; font-size: 20px; text-align-last: center;">
                    <option>::지역::</option>
                  <%
                  while(rs.next()){
                    String sigungu = rs.getString("sigungu");
                    String name = rs.getString("name");
                    float coordx = rs.getFloat("coordx");
                    float coordy = rs.getFloat("coordy");
                    %>
                    <option value=<%=sigungu%> value2=<%=name%> value3=<%=coordx%> value4=<%=coordy%>><%=name%></option>
                    <%
                  }
                  %>
                  </select>
                  <%
                  conn.close();
          }catch(Exception e){
                  e.printStackTrace();
                  out.println("member 테이블 호출에 실패했습니다.");
          }
          %>
          <input type="hidden" name="coordx" id="coordx"></input>
          <input type="hidden" name="coordy" id="coordy"></input>

          <input type="submit" value="Enter"></input>
      </form>
      </div>
      <script>
        function categoryChange(e) {
              var good_a = ['강릉시','고성군','삼척시','속초시','양구군','양양군','영월군','원주시','인제군','정선군','철원군','추천시','춘천시','태백시','평창군','홍천군','화천군','회성군','횡성군'];
              var good_b = ['가평군','광주시','김포시','남양주시','안성시','양주시','양평군','여주시','연천군','오산시','용인시','의정부시','이천시','파주시','포천시','화성시'];
              var good_c = ['거창군','김해시','마산군','마산시','밀양시','양산시','의령군','진주시','창원시','함양군'];
              var good_d = ['경산시','경주시','고령군','구미시','군위군','김천시','영덕군','영천시','울진군','의성군','칠곡군','포항시'];
              var good_e = ['서구'];
              var good_f = ['대덕구','유성구'];
              var good_g = ['기장군'];
              var good_h = ['강서구','동자동'];
              var good_i = ['세종특별자치시'];
              var good_j = ['남원시','대덕구','보성군','용인시','원주시','임실군','장수군','전주시'];
              var good_k = ['강화군'];
              var good_l = ['강진군','광양시','구례군','나주시','담양군','목포시','무안군','보성군','순천시','신안군','여수시','영광군','완도군','임실군','장성군','장흥군','진도군','함평군','화순군'];
              var good_m = ['군산시','김제시','남원시','무주군','부안군','완산구','완주군','익산시','인산시','장수군','전주시','정읍시','진안군'];
              var good_n = ['계룡시','공주시','논산시','당진시','보령시','서산시','아산시','연기군','예산군','천안시','태안시','홍성군'];
              var good_o = ['부여군','영동군','옥천군','음성군','증평군','진천군','청주시','충주시'];

              if (e.value == "a") sub_local = good_a;
              else if (e.value == "b") sub_local = good_b;
              else if (e.value == "c") sub_local = good_c;
              else if (e.value == "d") sub_local = good_d;
              else if (e.value == "e") sub_local = good_e;
              else if (e.value == "f") sub_local = good_f;
              else if (e.value == "g") sub_local = good_g;
              else if (e.value == "h") sub_local = good_h;
              else if (e.value == "i") sub_local = good_i;
              else if (e.value == "j") sub_local = good_j;
              else if (e.value == "k") sub_local = good_k;
              else if (e.value == "l") sub_local = good_l;
              else if (e.value == "m") sub_local = good_m;
              else if (e.value == "n") sub_local = good_n;
              else if (e.value == "o") sub_local = good_o;


              for (var i = 0; i < document.getElementById("sigungu").length; i++) {
                  var opt = document.getElementById("sigungu");

                  if (opt.options[i].getAttribute("data-local") == e.value) {
                      opt.options[i].style.display = "";
                  }
                  else {
                      opt.options[i].style.display = "none";
                  }
              }
          }
        function locaChange(e){
          for (var i = 1; i < document.getElementById("location").length; i++) {
              var opt = document.getElementById("location");
              if (opt.options[i].getAttribute("value") == $("#sigungu option:selected").text()) {
                  opt.options[i].style.display = "";
              }
              else {
                  opt.options[i].style.display = "none";
              }
          }
        }
        function xySearch(e)
        {
          var x = document.getElementById("coordx");
          var y = document.getElementById("coordy");

          x.value = $("#location option:selected").attr("value3");
          y.value = $("#location option:selected").attr("value4");
        }
      </script>
    </div>
  </body>
</html>
