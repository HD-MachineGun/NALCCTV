<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="org.jsoup.Jsoup" %>
<%@ page import="org.jsoup.nodes.Document" %>
<%@ page import="org.jsoup.nodes.Element" %>
<%@ page import="org.jsoup.select.Elements" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.io.UnsupportedEncodingException" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>NAL CCTV</title>
<link href="http://vjs.zencdn.net/7.0/video-js.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
<script src="http://vjs.zencdn.net/7.0/video.js"></script>
<style>
    body {
      background-image: url('cloud_image.jpg');
      background-repeat: no-repeat;
      background-size: cover;
    }
    p {
        font-family: "Arial Black", sans-serif;
        font-size: 36px;
        font-weight: bold;
        color: #ffffff;
      }
    span {
        font-family: "Arial Black", sans-serif;
        font-size: 36px;
        font-weight: bold;
        color: #ffffff;
      }
    div {
        font-family: "Arial Black", sans-serif;
        font-weight: bold;
        color: #ffffff;
        text-shadow: 2px 6px 2px gray;
      }
</style>
</head>
<header>
    <div class="s1" style="font-family: Impact; padding : 10px 10px; color:#FFFFFF; text-align: center; font-size: 80px;">NALLCCTV</div>
</header>
<html>
  <body>
    <article>
      <section class="visual_section">
        <div class="inner">
          <div class="left">
            <div class="CCTV">
              <div id ="wwraper">
                <div id ="wrapper">
                  <div id = "parent">
                    <div id="its">
                      <video id="itsv" class="video-js" muted playsinline autoplay>
                      <source type="application/x-mpegURL">
                      </video>
                    </div>
                  </div>
                </div>
              </div>
              <script type="text/javascript">
                var request = new Request();
                var coordx = parseFloat(request.getParameter("coordx"));
                var coordy = parseFloat(request.getParameter("coordy"));

                var itsReqURL = "http://openapi.its.go.kr:8081/api/NCCTVInfo?key=1600654851727&ReqType=2&MinX="+parseInt(coordx).toString()+"&MaxX="+(parseInt(coordx)+1).toString()
                +"&MinY="+parseInt(coordy).toString()+"&MaxY="+(parseInt(coordy)+1).toString()+"&type=its&cctvtype=1";
                var itsXML;

                function parseData(xml){
                  var cctvUrl = xml.getElementsByTagName("cctvurl");
                  var cctvName = xml.getElementsByTagName("cctvname");
                  var Coordy = xml.getElementsByTagName("coordy");

                  var request = new Request();

                  var index = 0;
                  for(var i=0;i<Coordy.length;i++)
                  {
                    if(Coordy[i].childNodes[0].nodeValue==coordy)
                    {
                      index=i; break;
                    }
                  }
                  cctvUrl = cctvUrl[index].childNodes[0].nodeValue;
                  cctvName = cctvName[index].childNodes[0].nodeValue;
                  var result = {
                    ccUrl: cctvUrl,
                    ccName: cctvName,
                  };
                  return result;
                }

                function Request(){
                  var requestParam ="";

                	this.getParameter = function(param){
                        var url = unescape(decodeURI(location.href));
                        var paramArr = (url.substring(url.indexOf("?")+1,url.length)).split("&");

                        for(var i = 0 ; i < paramArr.length ; i++){
                           var temp = paramArr[i].split("=");

                           if(temp[0].toUpperCase() == param.toUpperCase()){
                             requestParam = paramArr[i].split("=")[1];
                             break;
                           }
                        }
                        return requestParam;
                    }
                }

                function itsDisplay(itsData){
                  videoSrc(itsData.ccUrl, itsv);
                }

                function videoSrc(URL, vidId){
                  var vid = videojs(vidId, {fluid: true, aspectRatio: '3:2'});
                  fetch(URL).then(response => vid.src(response.url));
                  vid.on('click',function (){this.src(this.currentSrc());});
                  vid.on('contextmenu', function(e) {this.requestFullscreen(); e.preventDefault();});
                }

                function errMsg(vidId){document.getElementById(vidId).innerHTML += "에러 발생. 새로고침 해주세요.";}

                fetch(itsReqURL)
                .then(response=>response.text())
                .then(str => (new window.DOMParser()).parseFromString(str, "text/xml"))
                .then(data => {itsXML=data; return parseData(data);}).catch(()=>errMsg('its'))
                .then(result => itsDisplay(result));
                </script>
              </div>
            </div>
            <div class="right">
              <div class="weather">
                <%
                  Connection conn = null;
                  ResultSet rs = null;
                  int xx = 96;
                  int yy = 76;

                  String targetSigungu = request.getParameter("location");
                  targetSigungu = new String(targetSigungu.getBytes("8859_1"),"utf-8");

                  try{
                          String url = "jdbc:mysql://gugu-project-db.ck6ibzbqsisn.ap-northeast-2.rds.amazonaws.com:3306/gugudb?useUnicode=true&characterEncoding=UTF-8";
                          String id = "admin";
                          String pw = "vudrbsskdl27tkf";

                          Class.forName("com.mysql.jdbc.Driver");
                          conn=DriverManager.getConnection(url,id,pw);

                          Statement stmt = conn.createStatement();
                          String sql = "select * from nalc_map";
                          rs = stmt.executeQuery(sql);

                          while(rs.next())
                          {
                            String sigungu = rs.getString("sigungu");

                            int coordx = rs.getInt("coordx");
                            int coordy = rs.getInt("coordy");

                            if(sigungu.equals(targetSigungu))
                            {
                              xx = coordx;
                              yy = coordy;
                              break;
                            }
                          }
                          conn.close();
                  }catch(Exception e){
                          e.printStackTrace();
                          out.println("온도를 알 수 없어요.");
                  }


                  //URL에 변수 넣기
                  String URL = "https://www.weather.go.kr/weather/forecast/digital_forecast.jsp?x="+xx+"&y="+yy+"&unit=K";
                  Document doc = Jsoup.connect(URL).get();

                  //기온 가져오기
                  Elements nowTemperature = doc.select("dd[class=\"now_weather1_center temp1 MB10\"]");
                  String temp = nowTemperature.text();
                %>
                <div>
                    <p class="s1" style="font-family: 'jua'; sans-serif; font-size: 40px; text-align: center;">지금 몇 도야?</p>
                    <div>
                      <span class="s1" style="font-family: 'jua'; sans-serif; font-size: 30px; text-align: center;">
                <%
                            out.println(temp);
                            temp = temp.substring(0,2);
                %>
                      </span>
                    </div>
                </div>
                <%
                  //강수확률 가져오기
                  Elements nowRain = doc.select("td[class=\"bg_tomorrow\"]");
                  String rain = nowRain.text();
                  //그냥 출력하면 공백으로 구분되는 배열 형태로 출력됨.
                  //그래서 문자열을 잘라서 원하는 값만 출력하기. (첫번째 값 출력하면 됨.첫번째 값이 가장 최근 예보니까)
                  String[] arrayRain = rain.split(" ");
                %>
                <div>
                    <p class="s1" style="font-family: 'jua'; sans-serif; font-size: 40px; text-align: center;">비 올 확률은?</p>
                    <div>
                      <span class="s1" style="font-family: 'jua'; sans-serif; font-size: 30px; text-align: center;">
                <%
                        out.println(arrayRain[0]+"%");
                %>
                      </span>
                    </div>
                </div>
              </div>

              <style>
              article{margin : 40px auto;}/*임시!@~#~!#*/
              .visual_section{}
              .visual_section .inner{max-width : 1200px; margin : 0 auto; display: flex; justify-content: space-between;}
              .visual_section .inner .left{width : 50%;}
              .visual_section .inner .left .CCTV {text-align: center; margin-right: 30px;}
              .visual_section .inner .left .video-js{width: 530px; height: 530px;}
              .visual_section .inner .right{width : 50%;}
              .visual_section .inner .right .weather {display: flex; margin-bottom : 40px;}
              .visual_section .inner .right .weather>div{width : 50%; text-align: center;}
              .visual_section .inner .right .weather>div>p{}
              .visual_section .inner .right .weather>div>div{height: 80px;}
              .visual_section .inner .right .weather>div>div>span{}
              .visual_section .inner .right .weather>div>div>em{display:block; font-style: normal;}
              .visual_section .inner .right .cloth{}
              .visual_section .inner .right .cloth>p{}
              .visual_section .inner .right .cloth>div{height: 162px;}
              .visual_section .inner .right .cloth>div>img{}
              .visual_section .inner .right .cloth>div>span{text-align: center; display: block;}
              img{
                margin-left:80px;
              }
              </style>

              <div class="cloth">
                <p class="s1" style="font-family: 'jua'; sans-serif; font-size: 40px; text-align: center;">뭘 입는게 좋을까?</p>
                <div>
                  <%!
                  String getCloth1(int temp){
                     if(temp >= 28) return "https://ifh.cc/g/bcDiVs.png";
                     else if(temp >= 23) return "https://ifh.cc/g/aIaQie.png";
                     else if(temp >= 20) return "https://ifh.cc/g/31r2qI.png";
                     else if(temp >= 17) return "https://ifh.cc/g/XmU768.png";
                     else if(temp >= 12) return "https://ifh.cc/g/NY1fVR.png";
                     else if(temp >= 10) return "https://ifh.cc/g/IWqCdz.png";
                     else if(temp >= 6) return "https://ifh.cc/g/ziyLe8.png";
                     else return "https://ifh.cc/g/1FVIyr.png";
                  }
                  String getCloth2(int temp){
                     if(temp >= 28) return "https://ifh.cc/g/G1mc26.png";
                     else if(temp >= 23) return "https://ifh.cc/g/3mBfKz.png";
                     else if(temp >= 20) return "https://ifh.cc/g/I8SM0y.png";
                     else if(temp >= 17) return "https://ifh.cc/g/AqvLrC.png";
                     else if(temp >= 12) return "https://ifh.cc/g/8YIPAI.png";
                     else if(temp >= 10) return "https://ifh.cc/g/NY1fVR.png";
                     else if(temp >= 6) return "https://ifh.cc/g/r8zKLd.png";
                     else return "https://ifh.cc/g/g7grOx.png";
                  }
                  %>
                  <img src='<%= getCloth1(Integer.parseInt(temp))%>'>
                  <img src='<%= getCloth2(Integer.parseInt(temp))%>'>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
    </article>
  </body>
</html>
