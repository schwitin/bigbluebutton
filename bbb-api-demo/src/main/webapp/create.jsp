<!--

BigBlueButton - http://www.bigbluebutton.org

Copyright (c) 2008-2009 by respective authors (see below). All rights reserved.

BigBlueButton is free software; you can redistribute it and/or modify it under the 
terms of the GNU Lesser General Public License as published by the Free Software 
Foundation; either version 3 of the License, or (at your option) any later 
version. 

BigBlueButton is distributed in the hope that it will be useful, but WITHOUT ANY 
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A 
PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along 
with BigBlueButton; if not, If not, see <http://www.gnu.org/licenses/>.

Author: Fred Dixon <ffdixon@bigbluebutton.org>
  
-->

<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8"); 
	response.setCharacterEncoding("UTF-8"); 
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
	<link rel="icon" type="image/vnd.microsoft.icon" href="images/favicon.ico">
	<title>Create Your Own Meeting.</title>

	<script type="text/javascript"
		src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/heartbeat.js"></script>
	<script src='https://www.google.com/recaptcha/api.js'></script>


<style>

body, button, input, label, select, td, textarea {
	font-family: 'lucida grande',tahoma,verdana,arial,sans-serif;
	font-size: 1.2em;


}



input,textarea{
	border-color: #bdc7d8;
	border-radius: 5px;
	padding: 10px 8px;

    	width: 276px;
	color: #9197a3;
}

h1{
	text-align: center;
}	

textarea {
	overflow: auto;
 	width: 500px;
	height:220px;

}

input, label, button{
	margin:10px 0px;
}

.submit{
	border-radius: 5px;
	color: #fff;
	cursor: pointer;
	display: inline-block;
	letter-spacing: 1px;
	text-shadow: 0 1px 2px rgba(0, 0, 0, 0.5);

	background: linear-gradient(#67ae55, #578843) repeat scroll 0 0 #69a74e;
    	border-color: #3b6e22 #3b6e22 #2c5115;
    	box-shadow: 0 1px 1px #a4e388 inset;

    	text-align: center;
	font-weight: bold;

	text-decoration: none;
	padding: 10px 8px;

}


fieldset{
	border:none;
}

.step{
	padding: 20px;
}

.message{
	padding: 50px;
	text-align:center;
	font-size: 20px;
}

.captchaError{
	font-size:0.8em;
	color:red;
}

ul {
//   list-style-image: url('images/list-bullet.png');
list-style-type:none;
}

li {
	background: url("images/list-bullet.png") left center no-repeat;
	padding-left: 55px;
	height: 50px;
	line-height: 50px;
                                                                                    
                                                                                    
}

#content{
	width: 1024px;
	height: 768px;
	margin-left: auto ;
  	margin-right: auto ;
	//background-color: #FF1493;
}

#top{
	width: 100%;
	padding 20px;
	text-align: center;
	background-color:#f0f0f0; 
}

#middle{
	width: 710px;
	float: left;
	//background-color: #DAA520;
}

#create{
	width: 250px;
	float: left;
	//background-color: #DCDCDC;
}

#invite{
	width: 550px;
}

.centered {
    display: block;
    margin-left: auto;
    margin-right: auto 
}

</style>

</head>
<body>


<%@ include file="bbb_api.jsp"%>
<%@ page import="java.util.regex.*"%>




<%!

public boolean verifyCaptcha(HttpServletRequest request) throws Exception{

	if(request.getParameter("action") != null && request.getParameter("action").equals("create")){

		String gRecaptchaResponse = request.getParameter("g-recaptcha-response");

		URL apiUrl = new URL("https://www.google.com/recaptcha/api/siteverify");
        	Map<String,Object> params = new LinkedHashMap<String,Object>();
	        params.put("secret", "6Ld6hQMTAAAAAB9A5j14-c9yeBwHwGrB6cRHi2pt");
        	params.put("response", gRecaptchaResponse);

	        StringBuilder postData = new StringBuilder();
        	for (Map.Entry<String,Object> param : params.entrySet()) {
            	if (postData.length() != 0) postData.append('&');
            	postData.append(URLEncoder.encode(param.getKey(), "UTF-8"));
	            postData.append('=');
        	    postData.append(URLEncoder.encode(String.valueOf(param.getValue()), "UTF-8"));
	        }
	        byte[] postDataBytes = postData.toString().getBytes("UTF-8");

	        HttpURLConnection conn = (HttpURLConnection)apiUrl.openConnection();
	        conn.setRequestMethod("POST");
	        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
	        conn.setRequestProperty("Content-Length", String.valueOf(postDataBytes.length));
	        conn.setDoOutput(true);
	        conn.getOutputStream().write(postDataBytes);

	        StringBuffer answer = new StringBuffer();

	        Reader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
	        for (int c; (c = in.read()) >= 0; answer.append((char)c));

	        String googleResponse = answer.toString();

		return googleResponse.contains("true");
	}else{
		return false; // shouldn't occur
	}
}

%>




<div id="top">
	<img src="images/logo.png" alt="ukuluma" />
</div>

<div id="content">

<%
	if (request.getParameterMap().isEmpty() || false == verifyCaptcha(request)) {
		//
		// Assume we want to create a meeting
		//
		String capthcaError = request.getParameterMap().isEmpty() ? "" : "Please solve the capthca.";
%>

<div id="middle">

	<p>
	ukuluma is your free virtual meeteng room. You can use it for
	<ul>	
		<li>Talking to your firends</li>
		<li>Teaching your students</li>
		<li>Explaining your software</li>
	</ul>

	</p>
	<br/>
	<br/>
	<br/>
	<br/>
</div>

<div id="create" class="step">

	<FORM id="create_meeting" NAME="form1" METHOD="GET">
		<fieldset>
		<input id="username1" name="username1" type="text" autofocus="autofocus" required="required" placeholder="Enter Your Name" /> 
		<input name="action" type="hidden" value="create" />
		<br/>
		<div class="g-recaptcha" data-sitekey="6Ld6hQMTAAAAAPCzGpZkWbF-bj0FMtWpB4MSZ_6F"></div>
		<div class="captchaError"><%=capthcaError%></div>
		<input id="submit-button" type="submit" value="Create meeting" class="submit"/>

		</fieldset>
	</FORM>
</div>

<script>
//
// We could have asked the user for both their name and a meeting title, but we'll just use their name to create a title
// We'll use JQuery to dynamically update the button
//
//$(document).ready(function(){
//    $("input[name='username1']").keyup(function() {
//        if ($("input[name='username1']").val() == "") {
//        	$("#submit-button").attr('value',"Create meeting" );
//        } else {
//       $("#submit-button").attr('value',"Create " +$("input[name='username1']").val()+ "'s meeting" );
//        }
//    });
//});
</script>

<%
	} else if (request.getParameter("action").equals("create")) {

	

		//
		// User has requested to create a meeting
		//

		String username = request.getParameter("username1");
		String meetingID = username + "'s meeting";

		//
		// This is the URL for to join the meeting as moderator
		//
		String joinURL = getJoinURL(username, meetingID, "false", "<br>Welcome to %%CONFNAME%%.<br>", null, null);

		String url = BigBlueButtonURL.replace("bigbluebutton/","demo/");
		String inviteURL = url + "create.jsp?action=invite&meetingID=" + URLEncoder.encode(meetingID, "UTF-8");
%>
<div id="invite" class="step centered">

	<div name="message" class="message">
		<%=username%>'s meeting has been created.
	</div>

	<form name="form2" method="POST">
		Step 1. Invite others using the following text:
		<br/>
		<textarea  name="myname" wrap="off">

    Hello, 
    please join my meeting using following URL: 
    
    <%=inviteURL%>
    
    best regards 
    <%=username%>

		</textarea>
	</form>


<p>
	Step 2. Click the following button to start your meeting:
	<br/>
	<br/>
	<a href="<%=joinURL%>" class="submit">Start Meeting</a>
</p>

</div>







<%
	} else if (request.getParameter("action").equals("enter")) {
		//
		// The user is now attempting to joing the meeting
		//
		String meetingID = request.getParameter("meetingID");
		String username = request.getParameter("username");

		String url = BigBlueButtonURL.replace("bigbluebutton/","demo/");
		String enterURL = url + "create.jsp?action=join&username="
			+ URLEncoder.encode(username, "UTF-8") + "&meetingID="
			+ URLEncoder.encode(meetingID, "UTF-8");

		if (isMeetingRunning(meetingID).equals("true")) {
			//
			// The meeting has started -- bring the user into the meeting.
			//
%>
<script type="text/javascript">
	window.location = "<%=enterURL%>";
</script>
<%
	} else {
			//
			// The meeting has not yet started, so check until we get back the status that the meeting is running
			//
			String checkMeetingStatus = getURLisMeetingRunning(meetingID);
%>

<script type="text/javascript">
$(document).ready(function(){
		$.jheartbeat.set({
		   url: "<%=checkMeetingStatus%>",
		   delay: 5000
		}, function () {
			mycallback();
		});
	});


function mycallback() {
	// Not elegant, but works around a bug in IE8 
	var isMeetingRunning = ($("#HeartBeatDIV").text().search("true") > 0 );

	if (isMeetingRunning) {
		window.location = "<%=enterURL%>"; 
	}
}
</script>

<div id="waiting" class="step">

	<div name="message" class="message">
		<%=meetingID%> has not yet started.
	</div>

	<p>
	Hi <%=username%>,
	<br/>
	Now waiting for the moderator to start <%=meetingID%>.
	Your browser will automatically refresh and join the meeting when it starts.
	<br/>
	<br/>
	<br/>
	<img src="images/polling.gif" class="centered" />
	</p>

</div>

<%
}
	} else if (request.getParameter("action").equals("invite")) {
		//
		// We have an invite to an active meeting.  Ask the person for their name 
		// so they can join.
		//
		String meetingID = request.getParameter("meetingID");
%>

<div id="invite" />
	<p>
	You are about to join <%=meetingID%>.
	</p>
</div>

<form NAME="form3" METHOD="GET">
<fieldset>
	<input id="username" name="username" type="text" placeholder="Enter Your Name" /> 
	<input type="hidden" name="meetingID" value="<%=meetingID%>"> 
	<input type="hidden" name="action" value="enter">
	<br/>
	<input type="submit" value="Join" class="submit"/>
</fieldset>
</form>


<%
	} else if (request.getParameter("action").equals("join")) {
		//
		// We have an invite request to join an existing meeting and the meeting is running
		//
		// We don't need to pass a meeting descritpion as it's already been set by the first time 
		// the meeting was created.
		String joinURL = getJoinURLViewer(request.getParameter("username"), request.getParameter("meetingID"));
			
		if (joinURL.startsWith("http://")) {
%>

<script language="javascript" type="text/javascript">
  window.location.href="<%=joinURL%>";
</script>

<%
	} else { 
%>

Error: getJoinURL() failed
<p /><%=joinURL%> 

<%
 	}
 }
 %> 


</div>

</body>
</html>
