<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 제이쿼리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<!-- 프로필 버튼 관련 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">

<!-- 폰트어썸 cdn -->
<script src="https://kit.fontawesome.com/794ac64f16.js" crossorigin="anonymous"></script>





<script async
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCeCCPwGX5gzSzh6lXqgoGIy_bGEmX1S1E&callback=initMap"
    defer>
   
</script>


<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<link rel="stylesheet" href="${root}/static/css/header.css">
<!-- 헤더 -->

<meta charset="UTF-8">


<style>
	header {
		background-color: white;
	}
	#profile-btn:focus, #profile-btn:active {
		outline: none;
		box-shadow: none;
	}
</style>

<header>
    <div class="logo">
           <img width="212px" height="66px" src="${root}/static/img/logo/b_logo.png" alt="">
    </div>
    <div class="menu">
		
		<c:if test="${not empty loginMember}">
			<div id="gotoChat">
				<i class="fa-regular fa-comments fa-2xl chat-logo" style="color: #000000;"></i>
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
				  <img width="50px" height="50px" id="profile-border" src="${root}/static/img/member/profile/${loginMember.profileImage}" alt="">
				</button>
				<ul class="dropdown-menu">
				 <li hidden>${loginMember.memberNo}</li>
				  <li><a class="dropdown-item" href="${root}/member/myPage">MY PAGE</a></li>
				  <li><a class="dropdown-item imgToProfile" href="#">PROFILE</a></li>
				 <li><a class="dropdown-item" href="${root}/member/logout">LOGOUT</a></li>
				</ul>
			  </div>
			  <script>
				$('.dropdown-toggle').dropdown();
			  </script>
       	</c:if>
    </div>
</header>
<script >
let logo ;
logo = document.querySelector('.logo');
logo.addEventListener('click', ()=>{

  window.location.href = `${root}/home`;

});

let chatLogo;
chatLogo = document.querySelector('.chat-logo');
chatLogo.addEventListener('click', () => {

  // 창 옵션 설정
  const windowFeatures = `
    width=600,
    height=700,
    left=(screen.width / 2) - 275,
    top=0,
    toolbar=no,
    location=no,
    status=no,
    menubar=no,
    scrollbars=yes,
    resizable=no`;

  // 새 창 열기
  const newWindow = window.open('${root}/chat/room/list', '', windowFeatures);

  // 새 창이 로드되면 스크롤바 스타일 설정
  newWindow.addEventListener('load', () => {
    const style = document.createElement('style');
    style.textContent = `
      /* 스크롤바 스타일 설정 */
      ::-webkit-scrollbar {
        width: 10px;
        background-color: white;/* 연한 하늘색 배경색 */
      }
      ::-webkit-scrollbar-thumb {
        background-color:  #E0F2FE; /* 연한 하늘색 스크롤바 색상 */
        border-radius: 5px; /* 스크롤바를 둥글게 보이도록 설정 */
      }
      ::-webkit-scrollbar-thumb:hover {
        background-color: #64B5F6; /* 마우스 오버 시 스크롤바 색상 변경 */
      }
    `;
    newWindow.document.head.appendChild(style);
  });
});
</script>
<script>
let imgToProfile;
imgToProfile= document.querySelector('.imgToProfile');
imgToProfile.addEventListener('click', function(e) {
   const no = e.target.parentNode.parentNode.children[0].innerText; //게시글 작성자 번호
   const width = 800;
   const height = 1000;
   const left = (screen.width / 2) - (width / 2);
   const top = 0;
   window.open('${root}/click/profile?selectMemberNo='+no, '', 'width=' + width + ', height=' + height + ', left=' + left + ', top=' + top);
});
</script>