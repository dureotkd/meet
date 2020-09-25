<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>Document</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<style>
@import
	url("https://fonts.googleapis.com/css?family=DM+Sans:400,500,700|Source+Sans+Pro:300,400,600,700&display=swap")
	;

* {
	outline: none;
	box-sizing: border-box;
}

html {
	box-sizing: border-box;
	-webkit-font-smoothing: antialiased;
}

body {
	font-family: "Source Sans Pro", sans-serif;
	background-color: #373e57;
	color: #ccc8db;
}

.container {
	background-color: #151728;
	display: flex;
	max-width: 1600px;
	height: 100vh;
	overflow: hidden;
	margin: 0 auto;
}

.left-side {
	width: 260px;
	border-right: 1px solid #272a3a;
	display: flex;
	flex-direction: column;
	transition: 0.3s;
	background-color: #151728;
	overflow: auto;
	flex-shrink: 0;
}

@media screen and (max-width: 930px) {
	.left-side.active {
		z-index: 4;
	}
	.left-side
	.active
	>
	*
	:not
	 
	(
	.logo
	 
	)
	{
	opacity
	:
	 
	1;
	transition
	:
	 
	0
	.3s
	 
	0
	.2s
	;
	
	
}

.left-side.active .left-side-button svg:first-child {
	opacity: 0;
}

.left-side.active .left-side-button svg:last-child {
	transform: translate(-50%, -50%);
	opacity: 1;
}

.left-side
:not
 
(
.active
 
)
{
width
:
 
56
px
;

		
overflow
:
 
hidden
;

	
}
.left-side
:not
 
(
.active
 
)
>
*
:not
 
(
.logo
 
)
:not
 
(
.left-side-button
 
)
{
opacity
:
 
0;
}
.left-side:not (.active ) .logo {
	writing-mode: vertical-lr;
	transform: rotate(180deg);
	transform-origin: bottom;
	display: flex;
	align-items: center;
	margin-top: -10px;
}

}
.main {
	flex-grow: 1;
	display: flex;
	flex-direction: column;
	background-color: #181d2f;
}

.logo {
	font-family: "DM Sans", sans-serif;
	font-size: 15px;
	color: #fff;
	font-weight: 600;
	text-align: center;
	height: 68px;
	line-height: 68px;
	letter-spacing: 4px;
	position: sticky;
	top: 0;
	background: linear-gradient(to bottom, #151728 0%, #151728 76%, rgba(21, 23, 40, 0)
		100%);
}

.side-title {
	font-family: "DM Sans", sans-serif;
	color: #5c5e6e;
	font-size: 15px;
	font-weight: 600;
	margin-bottom: 20px;
}

.side-wrapper {
	padding: 30px;
}

.side-menu {
	display: flex;
	flex-direction: column;
	font-size: 15px;
	white-space: nowrap;
}

.side-menu svg {
	margin-right: 16px;
	width: 16px;
}

.side-menu a {
	text-decoration: none;
	color: #9c9cab;
	display: flex;
	align-items: center;
}

.side-menu a:hover {
	color: #fff;
}

.side-menu
 
a
:not
 
(
:last-child
 
)
{
margin-bottom
:
 
20
px
;


}
.follow-me {
	text-decoration: none;
	font-size: 14px;
	display: flex;
	align-items: center;
	margin-top: auto;
	overflow: hidden;
	color: #9c9cab;
	padding: 0 20px;
	height: 52px;
	flex-shrink: 0;
	border-top: 1px solid #272a3a;
	position: relative;
}

.follow-me svg {
	width: 16px;
	height: 16px;
	margin-right: 8px;
}

.follow-text {
	display: flex;
	align-items: center;
	transition: 0.3s;
}

.follow-me:hover .follow-text {
	transform: translateY(100%);
}

.follow-me:hover .developer {
	top: 0;
}

.developer {
	position: absolute;
	color: #fff;
	left: 0;
	top: -100%;
	display: flex;
	transition: 0.3s;
	padding: 0 20px;
	align-items: center;
	background-color: #272a3a;
	width: 100%;
	height: 100%;
}

.developer img {
	border-radius: 50%;
	width: 26px;
	height: 26px;
	object-fit: cover;
	margin-right: 10px;
}

.search-bar {
	height: 60px;
	background-color: #151728;
	z-index: 3;
	position: relative;
}

.search-bar input {
	height: 100%;
	width: 100%;
	display: block;
	background-color: transparent;
	border: none;
	padding: 0 54px;
	background-image:
		url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' width='512' height='512'%3e%3cpath d='M508.9 478.7L360 330a201.6 201.6 0 0045.2-127.3C405.3 90.9 314.4 0 202.7 0S0 91 0 202.7s91 202.6 202.7 202.6c48.2 0 92.4-17 127.3-45.2L478.7 509c4.2 4.1 11 4.1 15 0l15.2-15.1c4.1-4.2 4.1-11 0-15zm-306.2-116c-88.3 0-160-71.8-160-160s71.7-160 160-160 160 71.7 160 160-71.8 160-160 160z' data-original='%23000000' class='active-path' data-old_color='%23000000' fill='%235C5D71'/%3e%3c/svg%3e");
	background-repeat: no-repeat;
	background-size: 16px;
	background-position: 25px 50%;
	color: #fff;
	font-family: "Source Sans Pro", sans-serif;
	font-weight: 600;
}

.search-bar input::placeholder {
	color: #5c5d71;
}

.main-container {
	padding: 20px;
	flex-grow: 1;
	overflow: auto;
	background-color: #24273b;
}

.profile {
	position: relative;
	height: 40vh;
	min-height: 250px;
	max-height: 350px;
	z-index: 1;
}

.profile-cover {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	object-fit: cover;
	object-position: center;
	border-radius: 4px;
}

.profile:before {
	content: "";
	width: 100%;
	height: 100%;
	position: absolute;
	z-index: -1;
	left: 0;
	top: 0;
	background-image:
		url("https://images.unsplash.com/photo-1508247967583-7d982ea01526?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2250&q=80");
	background-repeat: no-repeat;
	background-size: cover;
	background-position: center;
	filter: blur(50px);
	opacity: 0.7;
}

.profile-menu {
	position: absolute;
	bottom: 0;
	padding-left: 200px;
	background: #151728;
	width: 100%;
	display: flex;
	border-radius: 0 0 4px 4px;
}

.profile-menu-link {
	padding: 20px 16px;
	color: #5c5e6e;
	transition: 0.3s;
	cursor: pointer;
}

.profile-menu-link.active, .profile-menu-link:hover {
	color: #fff;
	background-color: #1b1d2e;
	border-bottom: 3px solid #1488fa;
}

.profile-avatar {
	position: absolute;
	align-items: center;
	display: flex;
	z-index: 1;
	bottom: 16px;
	left: 24px;
	width: 150px;
	height: 150px;
	border-radius: 50%;
}

.profile-img {
	height: 100%;
	width: 100%;
	border-radius: 50%;
	object-fit: cover;
	border: 3px solid #151728;
}

.profile-name {
	margin-left: 24px;
	margin-bottom: 24px;
	font-size: 22px;
	color: #fff;
	font-weight: 600;
	font-family: "DM Sans", sans-serif;
	position: absolute;
	right: -60%;
}

.timeline {
	display: flex;
	padding-top: 20px;
	position: relative;
	z-index: 2;
}

.timeline-left {
	width: 310px;
	flex-shrink: 0;
}

.timeline-right {
	flex-grow: 1;
	padding-left: 20px;
}

@media screen and (max-width: 768px) {
	.timeline {
		flex-wrap: wrap;
		flex-direction: column-reverse;
	}
	.timeline-right {
		padding-left: 0;
		margin-bottom: 20px;
	}
	.timeline-left {
		width: 100%;
	}
}

.box {
	background-color: #151728;
	border-radius: 4px;
}

.intro {
	padding: 20px;
}

.intro-title {
	font-family: "DM Sans", sans-serif;
	color: #5c5e6e;
	font-weight: 600;
	font-size: 18px;
	display: flex;
	align-items: center;
	margin-bottom: 20px;
}

.intro-menu {
	background-color: #8f98a9;
	box-shadow: -8px 0 0 0 #8f98a9, 8px 0 0 0 #8f98a9;
	width: 5px;
	height: 5px;
	border: 0;
	padding: 0;
	border-radius: 50%;
	margin-left: auto;
	margin-right: 8px;
}

.info {
	font-size: 15px;
}

.info-item {
	display: flex;
	color: #c3c5d5;
}

.info-item+.info-item {
	margin-top: 14px;
}

.info-item a {
	margin-left: 6px;
	color: #1771d6;
	text-decoration: none;
}

.info-item svg {
	width: 16px;
	margin-right: 10px;
}

.event {
	position: relative;
	margin-top: 20px;
	padding: 10px;
}

.event-wrapper {
	position: relative;
}

.event-img {
	max-width: 100%;
	display: block;
	padding-bottom: 12px;
}

.event-date {
	position: absolute;
	left: 20px;
	top: 15px;
}

.event-month {
	background-color: #1687fa;
	padding: 7px 20px;
	font-weight: 600;
	font-family: "DM Sans", sans-serif;
	color: #fff;
	text-align: center;
	border-radius: 4px 4px 0 0;
}

.event-day {
	width: 100%;
	backdrop-filter: blur(4px);
	color: #fff;
	font-size: 22px;
	font-weight: 600;
	font-family: "DM Sans", sans-serif;
	background-color: rgba(0, 0, 0, 0.4);
	padding: 6px 0;
	text-align: center;
}

.event-title {
	color: #c3c5d5;
	margin-bottom: 5px;
	font-family: "DM Sans", sans-serif;
	font-weight: 600;
	padding: 0 14px;
}

.event-subtitle {
	color: #5c5e6e;
	font-family: "DM Sans", sans-serif;
	font-size: 13px;
	font-weight: 500;
	padding: 0 14px;
}

.pages {
	margin-top: 20px;
	padding: 20px;
}

.user {
	display: flex;
	align-items: center;
	cursor: pointer;
}

.user+.user {
	margin-top: 18px;
}

.user-img {
	border-radius: 50%;
	width: 45px;
	height: 45px;
	margin-right: 15px;
	object-fit: cover;
	object-position: center;
}

.username {
	font-size: 15px;
	font-family: "DM Sans", sans-serif;
}

.status-menu {
	padding: 20px;
	display: flex;
	align-items: center;
}

.status-menu-item {
	text-decoration: none;
	color: #ccc8db;
	padding: 10px 14px;
	line-height: 0.7;
	font-family: "DM Sans", sans-serif;
	font-weight: 500;
	border-radius: 20px;
}

.status-menu-item.active, .status-menu-item:hover {
	background-color: #2e2e40;
	color: #fff;
}

.status-menu-item+.status-menu-item {
	margin-left: 10px;
}

@media screen and (max-width: 500px) {
	.status-menu {
		font-size: 14px;
	}
	.status-menu-item+.status-menu-item {
		margin-left: 0;
	}
}

.status-img {
	width: 50px;
	height: 50px;
	object-fit: cover;
	border-radius: 50%;
	margin-right: 20px;
}

.status-main {
	padding: 0 20px;
	display: flex;
	align-items: center;
	border-bottom: 1px solid #272a3a;
	padding-bottom: 20px;
	flex-wrap: wrap;
}

.status-textarea {
	flex-grow: 1;
	background-color: transparent;
	border: none;
	resize: none;
	margin-top: 15px;
	color: #fff;
	max-width: calc(100% - 70px);
}

.status-textarea::placeholder {
	color: #5c5d71;
}

.status-actions {
	display: flex;
	padding: 10px 20px;
}

.status-action {
	text-decoration: none;
	color: #ccc8db;
	margin-right: 20px;
	display: flex;
	align-items: center;
}

.status-action svg {
	width: 16px;
	flex-shrink: 0;
	margin-right: 8px;
}

@media screen and (max-width: 1320px) {
	.status-action {
		width: 16px;
		overflow: hidden;
		color: transparent;
		white-space: nowrap;
	}
}

.status-share {
	background-color: #1b86f9;
	border: none;
	color: #fff;
	border-radius: 4px;
	padding: 10px 20px;
	margin-left: auto;
	cursor: pointer; <!--
	box-shadow: 0 0 20px #1b86f9;
	-->
}

.album {
	padding-top: 20px;
	margin-top: 20px;
}

.album .status-main {
	border: none;
	display: flex;
}

.album .intro-menu {
	margin-bottom: auto;
	margin-top: 5px;
}

.album-detail {
	width: calc(100% - 110px);
}

.album-title span {
	color: #1771d6;
	cursor: pointer;
}

.album-date {
	font-size: 15px;
	color: #595c6c;
	margin-top: 4px;
}

.album-content {
	padding: 0 20px 20px;
}

.album-photo {
	width: 100%;
	object-fit: cover;
	object-position: center;
	border-radius: 4px;
	margin-top: 10px;
}

.album-photos {
	display: flex;
	margin-top: 20px;
	max-height: 30vh;
}

.album-photos>.album-photo {
	width: 50%;
}

.album-right {
	width: 50%;
	margin-left: 10px;
	line-height: 0;
	display: flex;
	flex-direction: column;
}

.album-right .album-photo {
	height: calc(50% - 10px);
}

.album-actions {
	padding: 0 20px 20px;
}

.album-action {
	margin-right: 20px;
	text-decoration: none;
	color: #a2a4b4;
	display: inline-flex;
	align-items: center;
	font-weight: 600;
}

.album-action:hover {
	color: #fff;
}

.album-action svg {
	width: 16px;
	margin-right: 6px;
}

.account-button {
	border: 0;
	background: 0;
	color: #64677a;
	padding: 0;
	cursor: pointer;
	position: relative;
}

.account-button svg {
	width: 20px;
}

.account-button:not (.right-side-button ) +.account-button:before {
	position: absolute;
	right: 0px;
	top: -2px;
	background-color: #1b86f8;
	width: 8px;
	height: 8px;
	border-radius: 50%;
	content: "";
	border: 2px solid #151728;
}

.account-profile {
	width: 28px;
	height: 28px;
	border-radius: 50%;
	margin: 0 10px;
}

.account-user {
	display: inline-flex;
	align-items: center;
	color: #64677a;
	font-weight: 600;
}

.account-user span {
	font-size: 10px;
	font-weight: normal;
}

.account {
	height: 60px;
	display: flex;
	justify-content: space-evenly;
	align-items: center;
	position: sticky;
	top: 0;
	background-color: #151728;
	z-index: 3;
	flex-shrink: 0;
}

.stories {
	border-bottom: 1px solid #272a3a;
}

.stories .user-img {
	border: 2px solid #e2b96c;
}

.stories .album-date {
	font-family: "Source Sans Pro", sans-serif;
}

.user-status {
	background-color: #7fd222;
	width: 8px;
	height: 8px;
	border-radius: 50%;
	margin-left: auto;
}

.user-status.offline {
	background-color: #606a8d;
}

.user-status.idle {
	background-color: #dd1c20;
}

.contacts .username {
	display: flex;
	flex: 1;
	align-items: center;
}

.right-search svg {
	width: 16px;
	height: 16px;
}

.right-search {
	padding-right: 10px;
	display: flex;
	align-items: center;
	border-top: 1px solid #272a3a;
	position: sticky;
	bottom: 0;
	margin-top: auto;
}

.right-search input {
	padding-right: 10px;
}

.search-bar-svgs {
	color: #656679;
	display: flex;
}

.search-bar-svgs svg {
	margin-right: 16px;
}

.overlay {
	width: 100%;
	height: 100%;
	position: fixed;
	top: 0;
	left: 0;
	background-color: rgba(36, 39, 59, 0.8);
	opacity: 0;
	visibility: hidden;
	pointer-events: none;
	transition: 0.3s;
}

@media screen and (max-width: 1210px) {
	.overlay.active {
		z-index: 3;
		opacity: 1;
		visibility: visible;
		pointer-events: all;
	}
}

@media screen and (max-width: 1210px) {
	.right-side-button {
		display: block;
	}
}

.left-side-button {
	display: none;
}

@media screen and (max-width: 930px) {
	.left-side-button {
		display: flex;
		flex-shrink: 0;
		align-items: center;
		justify-content: center;
		position: relative;
		cursor: pointer;
		height: 60px;
		background-color: rgba(39, 42, 58, 0.5);
		border: 0;
		padding: 0;
		line-height: 0;
		color: #fff;
		border-bottom: 1px solid #272a3a;
	}
	.left-side-button svg {
		transition: 0.2s;
		width: 24px;
	}
	.left-side-button svg:last-child {
		position: absolute;
		left: 50%;
		transform: translate(100%, -50%);
		top: 50%;
		opacity: 0;
	}
}

@media screen and (max-width: 700px) {
	.profile-avatar {
		top: -25px;
		left: 50%;
		transform: translatex(-50%);
		align-items: center;
		flex-direction: column;
		justify-content: center;
	}
	.profile-img {
		height: 100px;
		width: 100px;
	}
	.profile-name {
		margin: 5px 0;
	}
	.profile-menu {
		padding-left: 0;
		width: 100%;
		overflow: auto;
		justify-content: center;
	}
	.profile-menu-link {
		padding: 16px;
		font-size: 15px;
	}
}

@media screen and (max-width: 480px) {
	.profile-menu-link:nth-last-child(1), .profile-menu-link:nth-last-child(2)
		{
		display: none;
	}
}

::-webkit-scrollbar {
	width: 10px;
	border-radius: 10px;
}

/* Track */
::-webkit-scrollbar-track {
	background: rgba(255, 255, 255, 0.01);
}

/* Handle */
::-webkit-scrollbar-thumb {
	background: rgba(255, 255, 255, 0.11);
	border-radius: 10px;
}

/* Handle on hover */
::-webkit-scrollbar-thumb:hover {
	background: rgba(255, 255, 255, 0.1);
}

.modal_wrap{
        display: none;
        width: 500px;
        height: 500px;
        position: absolute;
        top:50%;
        left: 50%;
        margin: -250px 0 0 -250px;
        background:#eee;
        z-index: 2;
    }
    .black_bg{
        display: none;
        position: absolute;
        content: "";
        width: 100%;
        height: 100%;
        background-color:rgba(0, 0,0, 0.5);
        top:0;
        left: 0;
        z-index: 1;
    }
    .modal_close{
        width: 26px;
        height: 26px;
        position: absolute;
        top: -30px;
        right: 0;
    }
    .modal_close> a{
        display: block;
        width: 100%;
        height: 100%;
        background:url(https://img.icons8.com/metro/26/000000/close-window.png);
        text-indent: -9999px;
    }
</style>


<script>
window.onload = function() {
	 
    function onClick() {
        document.querySelector('.modal_wrap').style.display ='block';
        document.querySelector('.black_bg').style.display ='block';
    }   
    function offClick() {
        document.querySelector('.modal_wrap').style.display ='none';
        document.querySelector('.black_bg').style.display ='none';
      
    }
    
 
    document.getElementById('modal_btn').addEventListener('click', onClick);
    document.querySelector('.black_bg').addEventListener('click', offClick);
    
};

</script>

</head>
<body>


<button type='button' id="modal_btn">모달창아 나와랏</button>
<div class="black_bg"></div>
<div class="modal_wrap">
    <div>
        모달창 내용
    </div>
<div>


</body>
</html>