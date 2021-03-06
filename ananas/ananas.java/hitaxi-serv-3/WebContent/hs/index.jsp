<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" errorPage=""%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- TemplateBeginEditable name="doctitle" -->
<title>HiTaxi手持模式</title>
<!-- TemplateEndEditable -->
<!-- TemplateBeginEditable name="head" -->
<!-- TemplateEndEditable -->
<!--[if IE]>
	<style type="text/css" media="all">.borderitem {border-style: solid;}</style>
	<![endif]-->
<link rel="stylesheet" type="text/css" href="../hitaxi1.css" media="all" />
<script src='../js/ws-js-api.js'></script>
<script type="text/javascript">
	function show(jid) {
		try {
			var xmlhttp;
			if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
				xmlhttp = new XMLHttpRequest();
			} else {// code for IE6, IE5
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			xmlhttp.onreadystatechange = State_Change;
			xmlhttp.open("GET", "../GetCarDetail", true);
			xmlhttp.setRequestHeader("jid", jid);
			xmlhttp.send();
			function State_Change() {
				if (xmlhttp.readyState == 4) {
					if (xmlhttp.status == 200) {
						var result = xmlhttp.responseText;
						eval("var cardetail = " + result);

						var table = "<table width='200' border='0' >";

						{
							var car = cardetail;
							car.jid;
							car.nickname;
							car.phone;
							car.plate;
							var row = "<tr><td>昵称：</td><td>"
									+ car.nickname
									+ "</td></tr><tr><td>车牌：</td><td>"
									+ car.plate
									+ "</td></tr><tr><td>电话：</td><td><a href=tel:"+car.phone+">"
									+ car.phone + "</a></td></tr>"+"<br><br><br>如需订该车请点击电话号码即可！";
							table = table + row;
						}
						table = table + "</table>";
						document.getElementById("report").innerHTML = table;

					} else {
						window.location = "../error/404.jsp";// 服务器维护中！
					}
				}
			}
		} catch (err) {
		}
	}

	function Call_UserStatusHS() {// 今后在javascript中对servlet的调用一律采用call_加servlet名的格式
		try {
			document.getElementById("showdo").innerHTML = "正在搜车中……";
			document.getElementById("showpic").src = "../images/wait.gif";
			var jsapi = getJSAPI();
			var MyJid = jsapi.getJabberID();//获取登录jid
			var MyPosAll = jsapi.getPos();//获取全部GPS数据
			var MyLat = MyPosAll.getLatitude();//获取纬度
			var MyLon = MyPosAll.getLongitude();//获取经度
			var MyAlt = MyPosAll.getAltitude();//获取海拔
			var MyAcc = MyPosAll.getAccuracy();//获取精度
			var MyTim = MyPosAll.getTimeStamp();//获取当前时间戳
			var MySou = MyPosAll.getSource();//获取GPS设备源
			var MyJid = jsapi.getJabberID();//获取登录jid
			var MyisGPS = jsapi.isGPSEnable();//获取gps工作状态
			var xmlhttp;
			if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
				xmlhttp = new XMLHttpRequest();
			} else {// code for IE6, IE5
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			xmlhttp.onreadystatechange = State_Change;
			xmlhttp.open("GET", "./UserStatusByHS", true);
			xmlhttp.setRequestHeader("geo-pos", MyLon + "," + MyLat);
			xmlhttp.setRequestHeader("MyAlt", MyAlt);
			xmlhttp.setRequestHeader("MyAcc", MyAcc);
			xmlhttp.setRequestHeader("geo-time", MyTim);
			xmlhttp.setRequestHeader("MySou", MySou);
			xmlhttp.setRequestHeader("jid", MyJid);
			xmlhttp.setRequestHeader("MyisGPS", MyisGPS);
			xmlhttp.send();
			function State_Change() {
				if (xmlhttp.readyState == 4) {
					if (xmlhttp.status == 200) {
						var result = xmlhttp.responseText;
						eval("var carList = " + result);

						var table = "<table width='200' border='1' >";

						for ( var i = 0; i < carList.length; i++) {
							var car = carList[i];
							car.jid;
							car.nickname;
							car.distance;
							var row = "<tr> <td>" + car.nickname + "</td><td>"
									+ car.distance
									+ "</td><td><p onclick='show(&quot;"
									+ car.jid + "&quot;)'>详细</p></td> </tr>";
							table = table + row;
						}
						table = table + "</table>";
						document.getElementById("report").innerHTML = table;

					} else {
						window.location = "../error/404.jsp";// 服务器维护中！
					}
				}
			}
		} catch (err) {
		}
	}
</script>
</head>
<body>
	<div id="main">
		<img src="../images/base_map_1.png" id="base_map_1" alt="" />
		<div class="clearFloat"></div>
		<div id="report">
			<p>&nbsp;</p>
			<p>
				<img id="showpic" src="../images/findcar.png"
					onclick="Call_UserStatusHS()" />
			</p>
			<p id="showdo">点击“搜车”图标开始操作！</p>
			<a href="../main/index.jsp" /> <input type="button"
				class="hitexi_button" id="back" value="返回" /> </a>
		</div>
		<img src="../images/base_map_9.png" id="base_map_9" alt="" /> <img
			src="../images/mid_map_1.png" id="mid_map_1" alt="" /><img
			src="../images/base_map_2.png" id="base_map_2" alt="" />
		<div class="clearFloat"></div>
		<img src="../images/base_map_8.png" id="base_map_8" alt="" /> <img
			src="../images/mid_map_5.png" id="mid_map_5" alt="" /> <img
			src="../images/top_map_1.png" id="top_map_1" alt="" /> <img
			src="../images/mid_map_2.png" id="mid_map_2" alt="" /> <img
			src="../images/base_map_3.png" id="base_map_3" alt="" />
		<div class="clearFloat"></div>
		<img src="../images/base_map_7.png" id="base_map_7" alt="" />
		<div id="colwrap1">
			<img src="../images/mid_map_4.png" id="mid_map_4" alt="" /> <img
				src="../images/top_map_2.png" id="top_map_2" alt="" /> <img
				src="../images/mid_map_3.png" id="mid_map_3" alt="" />
			<div class="clearFloat"></div>
			<img src="../images/base_map_6.png" id="base_map_6" alt="" />
			<div class="clearFloat"></div>
		</div>
		<img src="../images/base_map_4.png" id="base_map_4" alt="" />
		<div class="clearFloat"></div>
	</div>
</body>
</html>
