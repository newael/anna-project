<%@ page language="java" pageEncoding="UTF-8"%>

<script>
function hover(element) {
	  element.setAttribute('src', '<%=request.getContextPath()%>/images/icon_top.png');
	}

	function unhover(element) {
	  element.setAttribute('src', '<%=request.getContextPath()%>/images/icon_plus.png');
	}
</script>


<dvi>
<ul id="quickmenu" class="mfb-component--br mfb-zoomin" data-mfb-toggle="hover">
				<li class="mfb-component__wrap" ><a href="" class="mfb-component__button--main">
				<div id="menu_plus" class="menu_plus" onClick="javascript:window.scrollTo(0,0)">
				<img src="<%=request.getContextPath()%>/images/icon_plus.png" width="25px" height="25px;" he style="margin-left: 16px; margin-top: 16px;"
				onmouseover="hover(this);" onmouseout="unhover(this);" >
				</div>
				
				</a>
					<ul class="mfb-component__list">
					<c:if test="${ not empty uidx }">
						<li>
							<a href="<%=request.getContextPath()%>/boarditem/itemwrite.do" data-mfb-label="글쓰기" class="mfb-component__button--child">
								<img src="<%=request.getContextPath()%>/images/icon_write.png" width="20px" height="20px;" he style="margin-left: 19px; margin-top: 18px;">
							</a>
						</li>
						</c:if>
						<li>
						<c:if test="${ chkSellNewMessage ne 0}">
								<div style="display:inline-block; width:18px; height:18px; font-size:0.8rem; position:absolute; padding: 0px 0px 0px 5px; right:1px; top:0; background:red; margin-left: 10px;
   										 margin-top: 10px; border-radius:10px; color:#fff; z-index:1;">${ chkSellNewMessage }</div>
							</c:if>
							<a href="<%=request.getContextPath()%>/user/chatList.do" data-mfb-label="채팅" class="mfb-component__button--child">
								<img src="<%=request.getContextPath()%>/images/icon_qc.png" width="23px" height="23px;" he style="margin-left: 17px; margin-top: 16px;">
							</a>
						</li>
						<li>
						<c:if test="${ chkAlarm ne 0}">
								<div style="display:inline-block; width:18px; height:18px; font-size:0.8rem; position:absolute; padding: 0px 0px 0px 5px; right:1px; top:0; background:red; margin-left: 10px;
   										 margin-top: 10px; border-radius:10px; color:#fff; z-index:1;">${ chkAlarm }</div>
							</c:if>
							<a href="<%=request.getContextPath()%>/user/alarmView.do" data-mfb-label="알림" class="mfb-component__button--child">
								<img src="<%=request.getContextPath()%>/images/icon_push.png" width="20px" height="20px;" he style="margin-left: 18px; margin-top: 18px;">
							</a>
						</li>
				</ul>
			</li>
			</ul>
			</dvi>