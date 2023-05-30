<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 제이쿼리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

<!-- 프로필 버튼 관련 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
    

<!-- 폰트어썸 cdn -->
<script src="https://kit.fontawesome.com/794ac64f16.js" crossorigin="anonymous"></script>

<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<link rel="stylesheet" href="${root}/static/css/header.css">
<meta charset="UTF-8">

<style>
.logo{
    cursor: pointer;
}
body{
margin: 0px;
padding: 0px;
}
*{
    margin: 0px;
    padding: 0px;
}
header{
    margin: 0px;
    padding: 0px;
    width: 100vw;
    height: 66px;
    display: flex;
    justify-content: space-between;
    position: fixed;
    top: 0px;
    left: 0px;
    z-index: 9999;

}

.menu {
    height: 66px;
    display: flex;
    align-items: center;
    justify-content : space-evenly;
    width : 25vw;
	background-color: white;

}
.menu > a {
    margin-right: 20px;
    text-decoration: none;
    color: black;
    font-size: 20px;
}

#profile-border {
	border-radius: 70%;
	overflow: hidden;
	margin-right:30px 
}

#profile-btn {
    background-color: white;
    width: 80px;
    border: none;
}
.menu > div:first-child {
    margin-right: 30px;
}
	.gotoChat{
	 cursor: pointer;
	}
</style>


<header>
    <div class="logo">
           <img  width="212px" height="66px" src="${root}/static/img/logo/w_logo.png" alt="" onclick="goHome()">
    </div>
    <div class="menu">
		
		<c:if test="${not empty loginMember}">
			<div class="gotoChat" onclick="goChatList()">
				
				<i class="fa-regular fa-comments fa-2xl chat-logo"style="color: #000000;"></i>
			</div>
		</c:if>
        <a href="${root}/notice/inquiry">ABOUT</a>
        <a href="${root}/notice/travelInformation">여행정보</a>
        <a href="${root}/notice/travelReview">후기</a>
        
       	<c:if test="${empty loginMember }">
	        <a href='${root}/member/login'>로그인</a>
       	</c:if>
       	<c:if test="${not empty loginMember}">
			<div class="dropdown">
				<button class="btn btn-secondary dropdown-toggle" id="profile-btn" type="button" data-bs-toggle="dropdown" aria-expanded="false">
				  <img width="60px" height="60px" id="profile-border" src="${root}/static/img/member/profile/${empty loginMember.profileImage ? 'profile_default.jpg' : loginMember.profileImage}" alt="" >
				</button>
				<ul class="dropdown-menu">
					 <li hidden>${loginMember.memberNo}</li>
					
				<li><a class="dropdown-item" href="${root}/member/myPage">MY PAGE</a></li>


				<li><a class="dropdown-item imgToProfile" onclick="goProfile(${loginMember.memberNo})">PROFILE</a></li>

				<li><a class="dropdown-item " href="${root}/member/logout">LOGOUT</a></li>
				</ul>
			  </div>
			 
       	</c:if>
    </div>
</header>
<script >

function goHome(e) {
    

  window.location.href = `${root}/home`;

};


 
function goChatList() {
	 const width = 517;
	 const height = 820;
	 const left = (window.innerWidth / 2) - (width / 2);
	 const top = 100;
 
 window.open('${root}/chat/room/list/open?page=1', '','width=' + width + ', height=' + height + ', left=' + left + ', top=' + top);


};
function goProfile(e){
   
   const width = 650;
   const height = 800;
   const left = (screen.width / 2) - (width / 2);
   const top = 0;
   window.open('${root}/click/profile?selectMemberNo='+e, '', 'width=' + width + ', height=' + height + ', left=' + left + ', top=' + top);
};
function cntNewMessage(){
	$.ajax({
				url : "${root}/chat/cnt/",
				type : "POST",
				dataType :"json",
				data : {
					loginMemberNo : "-1" ,
				},
				success: function(data){
					let cnt ="";
					cnt = JSON.parse(data);
					if(cnt >0){
						let gotoChat = document.querySelector(".gotoChat");						
						let str = "";
						str+= '<div style="text-align:center; color:red;">'+cnt+'</div>';
						gotoChat.innerHTML+=str;
						
						
					}else {
					}
				},
				error: ()=>{
					console.log("에러요 로드 실패...");
				} ,
			});
    	
};

cntNewMessage();
</script>



