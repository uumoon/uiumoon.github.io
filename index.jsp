`<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isErrorPage="true"
	errorPage="/WEB-INF/views/dataMng/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 <script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery-3.3.1.js"></script>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link href="${pageContext.request.contextPath}/assets/backTemplate/css/iconfont.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/assets/layui/css/layui.css" media="all" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/assets/layui/layui.js" charset="utf-8"></script>

<title>洗车订单列表</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/backTemplate/lib/My97DatePicker/WdatePicker.js"></script>
<%@include file="/WEB-INF/view/head.jsp"%>

<object id="LODOP_OB"
	classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
	<embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0></embed>
</object>
 <style> 
 
 		#pingjia{
 				font-size: 14px;
 		
 		}
 		#pingjia span{
 				color: orange;
 		
 		}
 
 	 	#imgAll{
 			width: 55%%;
 			
 		} 
 		.right{
 		text-align: right;
 		}
 		.left{
 		text-align: left;
 		}
        .black_overlay{ 
            display: none; 
            position: absolute; 
            top: 0%; 
            left: 0%; 
            width: 100%; 
            height: 100%; 
            background-color: black; 
            -moz-opacity: 1; 
            opacity:1; 
            filter: alpha(opacity=1); 
            z-index: 250;
        } 
        .white_content { 
            display: none; 
            position: absolute; 
            top: 25%; 
            left: 25%; 
            width: 28%; 
            height: 55%; 
            padding: 0px 20px ; 
            border: 1px solid orange; 
            background-color: white; 
            overflow: auto; 
            z-index: 200;
        } 
        .showImg{
       	float: left;
       	margin: 3px;
       	
        }
     .showImg2{
       	float: right;
        margin: 3px;
        }
 
     .right{
 		 position: relative;
 		left: 80%
  }
  
    </style> 
</head>


<body>
	<nav class="breadcrumb">
		<i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span>
		洗车订单管理 <a class="btn btn-success radius r mr-20"
			style="line-height: 1.6em; margin-top: 3px"
			href="javascript:location.replace(location.href);" title="刷新"><i class="Hui-iconfont">&#xe68f;</i></a>
	</nav>
	
	
	<div class="pd-20">

			<div class="text-c" id="tops">
				请选择代理商：
				<select id="pointInfo">
						<option value="">--请选择代理商--</option>
						
				</select> &nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日期范围： <input
					type="text" name="startTime"  id="startTime" value="" autocomplete="off"
					 onclick="WdatePicker()"
					id="datemin" class="input-text Wdate" style="width: 120px;">
				 <input type="text" name="endTime" id="endTime" value="" autocomplete="off"
					 onclick="WdatePicker()"
					id="datemax" class="input-text Wdate" style="width: 120px;">
					<input type="text" class="input-text" style="width:250px" placeholder="输入车牌号" id="keyWord" name="">
				<button type="submit" class="btn btn-primary radius" id="select_info" name=""><i class="Hui-iconfont">&#xe665;</i>搜索</button>
			</div>
		<xblock>
        <button class="layui-btn layui-btn-danger" onclick="exporExcel()">导出Excel</button>
        <button class="layui-btn layui-btn-danger"  id="updateStatus">修改订单状态</button>
   		</xblock>
		 <div class="cl pd-5 bg-1 bk-gray mt-20" ><strong>
		<span>洗车订单列表</span>
		 <span class="right"> 共有数据<label id="addCount"></label></span>
		</strong></div>
		<div class="mt-20" style="margin: 0px">
			<table id="listTable"
				class="table table-border table-bordered table-bg table-hover table-sort">
				<thead>
					<tr class="text-c">
					<th width="25"><input id="selectAll"   type="checkbox" name="" value=""></th>
					<th width="220">洗车站点</th>
					<th width="220">车牌号</th>
					<th width="200">车主手机号</th>
					<th width="260">订单完成时间</th>
					<th width="100">洗车类型</th>
					<th width="150">订单状态</th>
					<th width="100">是否满意</th>
					<th width="100">问卷详情</th>
					<th width="100">图片详情</th>
					
					</tr>
				</thead>
				<tbody id="tableTbody">
					
				</tbody>
				
			</table>
		</div>
		</div>
	<script type="text/javascript">	
			$(document).ready(function(){
						var pageNows =$("#pageNows").val();	
					$.ajax({
						url:"${pageContext.request.contextPath}/dataMng/WashingOrderInfo?method=index",
						type:"POST",
						data:"",
						success:function(msg){
							var data=msg.orderInfo;
							var totalCount=msg.totalCount;
							var size=Math.ceil(totalCount/10);
							var fineCount=msg.fineCount;
			                 for(var i=0;i<data.length;i++){
			                	 if(data[i].review_status==1){
			                		 data[i].review_status='已答卷';
			                	 }else if (data[i].review_status==0) {
			                		 data[i].review_status='未答卷';
								}
			                	 if(data[i].car_wash_type==2){
			                		 data[i].car_wash_type='精洗';
			                		 
			                	 }else if (data[i].car_wash_type==1) {
			                		 data[i].car_wash_type='普洗';
								}
			                	 
			                     $("#tableTbody").html($("#tableTbody").html()
				                     +"<tr class='text-c' ><td width='25'><input id='selectAll'   type='checkbox' name='' value='"+data[i].id+"'></td>"
			                         +"<td>"+data[i].car_wash_name+"</td>"
			                         +"<td>"+data[i].number_plate+"</td>"
			                         +"<td>"+data[i].phone+"</td>"
			                         +"<td>"+data[i].complete_time+"</td>"
			                         +"<td>"+data[i].car_wash_type+"</td>"  
			                         +"<td>"+data[i].order_status+"</td>" 
									 +"<td>"+data[i].satisfied+"</td>"
			                         +"<td >"+"<button type='submit' class='btn btn-primary radius' id='seeWenjuan' value='"+data[i].id+"'>"+"查看"+"</td>"
			                         +"<td >"+"<button type='submit' class='btn btn-primary radius' id='seeImg' value='"+data[i].id+"'>"+"查看"+"</td></tr>"
			                     );
		                 }
			               $("#addCount").html($("#addCount").html()
			                       +totalCount
			                       +"条"
			                       +"（其中包含精洗"
			                       +fineCount
			                       +"条）"
			                       
			                     );
			               $("#pages").html($("#pages").html()
			            		   +" <input type='button' id='count'  value='"+'共'+size+'页'+"' class='btn btn-primary radius' addval=''>"
				                   +" <input type='button' id='thisSize' value='"+'第1页'+"' class='btn btn-primary radius' addval=''>"
			                       +" <input type='button' id='backpage' value='上一页' class='btn btn-primary radius' addval=''>"
			                       +" <input type='button' id='nextpage' value='下一页' class='btn btn-primary radius' addval=''>"
			                     );
						},error:function(){
							alert("错误");
						}
					});	
					$.ajax({
						url:"${pageContext.request.contextPath}/dataMng/WashingOrderInfo?method=selectWashPoint",
						type:"POST",
						data:"",
						success:function(msg){
							var data=msg.selectWashPoint;
							
			                 for(var i=0;i<data.length;i++){
			                     $("#pointInfo").html($("#pointInfo").html()
			                         +"<option value='"+data[i].CAR_WASH_NAME+"'  name='pointName'>"+data[i].CAR_WASH_NAME+"</option>"
			                     )
			                     }
						},error:function(){
							alert("错误");
						}
					});
					
				
					
			});
			
		
			
			
			
			
			//查询
			$(document).on("click","#select_info", function(e){
				 $("#tableTbody").empty();
				 $("#addCount").empty();
				 $("#emptys").remove();
				 $("#backpage").remove();
				 $("#nextpage").remove();
				 $("#backpageTime").remove();
				 $("#nextpageTime").remove();
				 $("#backpagekeys").remove();
				 $("#nextpagekeys").remove();
				 $("#backpagePoint").remove();
				 $("#nextpagePoint").remove();
				 $("#backpageAll").remove();
				 $("#nextpageAll").remove();
				 $("#count").remove();
				 $("#thisSize").remove();
					var pointInfo = document.getElementById("pointInfo");
					var seleIndex =pointInfo.selectedIndex;  
					var point=pointInfo.options[seleIndex].value;
					var keyWord =$("#keyWord").val();	
					var startTime =$("#startTime").val();
					var endTime =$("#endTime").val();	
					
					if(startTime!=""&&endTime==""){
						layer.confirm("请选择相应的时间段");
						return false;
					}
					if(endTime!=""&&startTime==""){
						layer.confirm("请选择相应的时间段");
						return false;
					}
					//根据关键字查
					if (keyWord!="" ) {
						$.ajax({
							url:"${pageContext.request.contextPath}/dataMng/WashingOrderInfo?method=selectByKeyWord",
							type:"POST",
							data:{"keyWord":keyWord},
							success:function(msg){
								var totalCount=msg.totalCount;
								var size=Math.ceil(totalCount/10);
								var fineCount=msg.fineCount;
								var data=msg.selectWashInfobyMsg;
				                 for(var i=0;i<data.length;i++){
				                	 if(data[i].review_status==1){
				                		 data[i].review_status='已答卷';
				                		 
				                	 }else if (data[i].review_status==0) {
				                		 data[i].review_status='未答卷';
									}
				                	 if(data[i].car_wash_type==2){
				                		 data[i].car_wash_type='精洗';
				                		 
				                	 }else if (data[i].car_wash_type==1) {
				                		 data[i].car_wash_type='普洗';
									}
				                     $("#tableTbody").html($("#tableTbody").html()
				                    	 +"<tr class='text-c' ><td width='25'><input id='selectAll'   type='checkbox' name='' value='"+data[i].id+"'></td>"
					                     +"<td>"+data[i].car_wash_name+"</td>"
				                         +"<td>"+data[i].number_plate+"</td>"
				                         +"<td>"+data[i].phone+"</td>"
				                         +"<td>"+data[i].complete_time+"</td>"
				                         +"<td>"+data[i].car_wash_type+"</td>"  
				                         +"<td>"+data[i].order_status+"</td>" 
				                         +"<td>"+data[i].satisfied+"</td>"
				                         +"<td >"+"<button type='submit' class='btn btn-primary radius' id='seeWenjuan' value='"+data[i].id+"'>"+"查看"+"</td>"
				                         +"<td >"+"<button type='submit' class='btn btn-primary radius' id='seeImg' value='"+data[i].id+"'>"+"查看"+"</td></tr>"
				                     );
			                }
				                 $("#addCount").html($("#addCount").html()
					                       +totalCount
					                       +"条"
					                       +"（其中包含精洗"
					                       +fineCount
					                       +"条）"
					                     );
				                 $("#pages").html($("#pages").html()
				                		  +" <input type='button' id='count'  value='"+'共'+size+'页'+"' class='btn btn-primary radius' addval=''>"
					                      +" <input type='button' id='thisSize' value='"+'第1页'+"' class='btn btn-primary radius' addval=''>"
					                       +" <input type='button' id='backpagekeys' value='上一页' class='btn btn-primary radius' addval=''>"
					                       +" <input type='button' id='nextpagekeys' value='下一页' class='btn btn-primary radius' addval=''>"
					                     );
							},error:function(){
								alert("错误");
							}
						});
						
						//根据时间
					}else if(startTime!=""&&point==""){
						$.ajax({
							url:"${pageContext.request.contextPath}/dataMng/WashingOrderInfo?method=selectWashInfoByTime",
							type:"POST",
							data:{"startTime":startTime,"endTime":endTime},
							success:function(msg){
								var totalCount=msg.totalCount;
								var size=Math.ceil(totalCount/10);
								var fineCount=msg.fineCount;
								var data=msg.selectWashInfobyTime;
				                 for(var i=0;i<data.length;i++){
				                	 if(data[i].review_status==1){
				                		 data[i].review_status='已答卷';
				                		 
				                	 }else if (data[i].review_status==0) {
				                		 data[i].review_status='未答卷';
									}
				                	 if(data[i].car_wash_type==2){
				                		 data[i].car_wash_type='精洗';
				                		 
				                	 }else if (data[i].car_wash_type==1) {
				                		 data[i].car_wash_type='普洗';
									}
				                     $("#tableTbody").html($("#tableTbody").html()
					                    	 +"<tr class='text-c' ><td width='25'><input id='selectAll'   type='checkbox' name='' value='"+data[i].id+"'></td>"
						                     +"<td>"+data[i].car_wash_name+"</td>"				                         +"<td>"+data[i].number_plate+"</td>"
				                         +"<td>"+data[i].phone+"</td>"
				                         +"<td>"+data[i].complete_time+"</td>"
				                         +"<td>"+data[i].car_wash_type+"</td>"  
				                         +"<td>"+data[i].order_status+"</td>" 
				                         +"<td>"+data[i].satisfied+"</td>"
				                         +"<td >"+"<button type='submit' class='btn btn-primary radius' id='seeWenjuan' value='"+data[i].id+"'>"+"查看"+"</td>"
				                         +"<td >"+"<button type='submit' class='btn btn-primary radius' id='seeImg' value='"+data[i].id+"'>"+"查看"+"</td></tr>"								
				                     );
			                }
				                 $("#addCount").html($("#addCount").html()
					                       +totalCount
					                       +"条"
					                       +"（其中包含精洗"
					                       +fineCount
					                       +"条）"
					                     );
				                 $("#pages").html($("#pages").html()
				                		  +" <input type='button' id='count'  value='"+'共'+size+'页'+"' class='btn btn-primary radius' addval=''>"
					                      +" <input type='button' id='thisSize' value='"+'第1页'+"' class='btn btn-primary radius' addval=''>"
					                       +" <input type='button' id='backpageTime' value='上一页' class='btn btn-primary radius' addval=''>"
					                       +" <input type='button' id='nextpageTime' value='下一页' class='btn btn-primary radius' addval=''>"
					                     );
							},error:function(){
								alert("错误");
							}
						});
						//根据洗车点
					}else if (point!=""&&startTime==""&&endTime=="" ) {
						$.ajax({
							url:"${pageContext.request.contextPath}/dataMng/WashingOrderInfo?method=selectWashInfoByPoint",
							type:"POST",
							data:{"point":point},
							success:function(msg){
								var totalCount=msg.totalCount;
								var size=Math.ceil(totalCount/10);
								var fineCount=msg.fineCount;
								var data=msg.selectWashInfobyPoint;
				                 for(var i=0;i<data.length;i++){
				                	 if(data[i].review_status==1){
				                		 data[i].review_status='已答卷';
				                		 
				                	 }else if (data[i].review_status==0) {
				                		 data[i].review_status='未答卷';
									}
				                	 if(data[i].car_wash_type==2){
				                		 data[i].car_wash_type='精洗';
				                		 
				                	 }else if (data[i].car_wash_type==1) {
				                		 data[i].car_wash_type='普洗';
									}
				                     $("#tableTbody").html($("#tableTbody").html()
					                    	 +"<tr class='text-c' ><td width='25'><input id='selectAll'   type='checkbox' name='' value='"+data[i].id+"'></td>"
						                     +"<td>"+data[i].car_wash_name+"</td>"				                         +"<td>"+data[i].number_plate+"</td>"
				                         +"<td>"+data[i].phone+"</td>"
				                         +"<td>"+data[i].complete_time+"</td>"
				                         +"<td>"+data[i].car_wash_type+"</td>"  
				                         +"<td>"+data[i].order_status+"</td>" 
				                         +"<td>"+data[i].satisfied+"</td>"
				                         +"<td >"+"<button type='submit' class='btn btn-primary radius' id='seeWenjuan' value='"+data[i].id+"'>"+"查看"+"</td>"
				                         +"<td >"+"<button type='submit' class='btn btn-primary radius' id='seeImg' value='"+data[i].id+"'>"+"查看"+"</td></tr>"
				                     );
			                }
				                 $("#addCount").html($("#addCount").html()
					                       +totalCount
					                       +"条"
					                       +"（其中包含精洗"
					                       +fineCount
					                       +"条）"
					                     );
				                 $("#pages").html($("#pages").html()
				                		 +" <input type='button' id='count'  value='"+'共'+size+'页'+"' class='btn btn-primary radius' addval=''>"
					                      +" <input type='button' id='thisSize' value='"+'第1页'+"' class='btn btn-primary radius' addval=''>"
					                       +" <input type='button' id='backpagePoint' value='上一页' class='btn btn-primary radius' addval=''>"
					                       +" <input type='button' id='nextpagePoint' value='下一页' class='btn btn-primary radius' addval=''>"
					                     );
							},error:function(){
								alert("错误");
							}
						});
						//根据时间和洗车点
					}else if (point!=""&&startTime!="") {
						$.ajax({
							url:"${pageContext.request.contextPath}/dataMng/WashingOrderInfo?method=selectWashInfoByPointAndTime",
							type:"POST",
							data:{"point":point,"startTime":startTime,"endTime":endTime},
							success:function(msg){
								var totalCount=msg.totalCount;
								var size=Math.ceil(totalCount/10);
								var fineCount=msg.fineCount;
								var data=msg.selectWashInfoByPointAndTime;
				                 for(var i=0;i<data.length;i++){
				                	 if(data[i].review_status==1){
				                		 data[i].review_status='已答卷';
				                		 
				                	 }else if (data[i].review_status==0) {
				                		 data[i].review_status='未答卷';
									}
				                	 if(data[i].car_wash_type==2){
				                		 data[i].car_wash_type='精洗';
				                		 
				                	 }else if (data[i].car_wash_type==1) {
				                		 data[i].car_wash_type='普洗';
									}
				                     $("#tableTbody").html($("#tableTbody").html()
					                    	 +"<tr class='text-c' ><td width='25'><input id='selectAll'   type='checkbox' name='' value='"+data[i].id+"'></td>"
						                     +"<td>"+data[i].car_wash_name+"</td>"				                         +"<td>"+data[i].number_plate+"</td>"
				                         +"<td>"+data[i].phone+"</td>"
				                         +"<td>"+data[i].complete_time+"</td>"
				                         +"<td>"+data[i].car_wash_type+"</td>"  
				                         +"<td>"+data[i].order_status+"</td>" +"<td>"+data[i].satisfied+"</td>"
				                        /* +"<td>"+data[i].review_status+"</td>" */
				                       /*  +"<td>"+data[i].reason+"</td>" */
				                         +"<td >"+"<button type='submit' class='btn btn-primary radius' id='seeWenjuan' value='"+data[i].id+"'>"+"查看"+"</td>"
				                         +"<td >"+"<button type='submit' class='btn btn-primary radius' id='seeImg' value='"+data[i].id+"'>"+"查看"+"</td></tr>"
				                     );
			                }
				                 $("#addCount").html($("#addCount").html()
					                       +totalCount
					                       +"条"
					                       +"（其中包含精洗"
					                       +fineCount
					                       +"条）"
					                     );
				                 $("#pages").html($("#pages").html()
				                		 +" <input type='button' id='count'  value='"+'共'+size+'页'+"' class='btn btn-primary radius' addval=''>"
					                      +" <input type='button' id='thisSize' value='"+'第1页'+"' class='btn btn-primary radius' addval=''>"
					                       +" <input type='button' id='backpageAll' value='上一页' class='btn btn-primary radius' addval=''>"
					                       +" <input type='button' id='nextpageAll' value='下一页' class='btn btn-primary radius' addval=''>"
					                     );
							},error:function(){
								alert("错误");
							}
						});
						
						
						
					}
			});
			
			
			$(document).on("click","#seeImg", function(e){
				document.getElementById('light').style.display='block';document.getElementById('fade').style.display='block';
				var imgId=$(this).val();
				$.ajax({
					url:"${pageContext.request.contextPath}/dataMng/WashingOrderInfo?method=findImgSrc",
					type:"POST",
					data:{"imgId":imgId},
					success:function(msg){
						var data=msg.selectImgSrc;
						  for(var i=0;i<data.length;i++){
							  $("#light").html($("#light").html()
				                        +"<div id='imgAll'><div id='imgSrc' class='showImg'>"+"<img  onload='javascript:resizeimg(this,400,300)' id='imgSize' src='http://agent.yireninfo.com/Yirencaocao1/uploadImg/"+data[i].ORDER_IMG_PATH1+"'>"+"</div>"
				                        +"<div id='imgSrc' class='showImg2'>"+"<img onload='javascript:resizeimg(this,400,300)' id='imgSize' src='http://agent.yireninfo.com/Yirencaocao1/uploadImg/"+data[i].ORDER_IMG_PATH2+"'>"+"</div></br>"
				                        +"<div id='imgSrc' class='showImg'>"+"<img onload='javascript:resizeimg(this,400,300)'  id='imgSize' src='http://agent.yireninfo.com/Yirencaocao1/uploadImg/"+data[i].ORDER_IMG_PATH3+"'>"+"</div>"
				                        +"<div id='imgSrc' class='showImg2'>"+"<img  onload='javascript:resizeimg(this,400,300)' id='imgSize' src='http://agent.yireninfo.com/Yirencaocao1/uploadImg/"+data[i].ORDER_IMG_PATH4+"'>"+"</div></div>"
				                       
							  );
							
		                }
					},error:function(){
						alert("错误");
					}
				});
			});
			
			$(document).on("click","#seeWenjuan", function(e){
				document.getElementById('lights').style.display='block';document.getElementById('review').style.display='block';
				var reviewId=$(this).val();
				$.ajax({
					url:"${pageContext.request.contextPath}/dataMng/WashingOrderInfo?method=findImgReview",
					type:"POST",
					data:{"reviewId":reviewId},
					success:function(msg){
						var data=msg.selectReviewSrc;
						  for(var i=0;i<1;i++){
							  //查问卷信息  如果问卷是满意  
							  if (data.length==0) {
								  $("#lights").html($("#lights").html()
										  +"<div id='pingjia'><div>"+"<span>服务满意度：</span>满意"+"</div>"
										  +"<div>"+"<span>清洁满意度：</span>满意"+"</div></div>"
										  
								  );
							}else{
								$("#lights").html($("#lights").html()
								+"<div id='pingjia'><div>"+"<span>不满意原因：</span>"+data[i].REASON+""+"</div>"
								+"<div>"+"<span>服务态度评分：</span>"+data[i].SERVICE_ATTITUDE+"分"+"</div>"
								+"<div>"+"<span>服务态度评价：</span>"+data[i].SERVICE_ATTITUDE_CONTENT+"</div>"
								+"<div id='pingjia'><div>"+"<span>照片详情1：</span>"+"<img  onload='javascript:resizeimg(this,400,300)' id='imgSize' src='http://agent.yireninfo.com/Yirencaocao1/uploadImg/"+data[i].SERVICE_ATTITUDE_IMG+"'>"+"</div></br>"
								+"<div id='pingjia'><div>"+"<span>照片详情2：</span>"+"<img  onload='javascript:resizeimg(this,400,300)' id='imgSize' src='http://agent.yireninfo.com/Yirencaocao1/uploadImg/"+data[i].SERVICE_ATTITUDE_IMG+"'>"+"</div></br>"
								+"<div>"+"<span>清洁度评分：</span>"+data[i].CLEANLINESS+"分"+"</div>"	
								+"<div>"+"<span>清洁度评价：</span>"+data[i].CLEANLINESS_CONTENT+""+"</div>"	
								+"<div>"+"<span>照片详情1：</span>"+"<img  onload='javascript:resizeimg(this,400,300)' id='imgSize' src='http://agent.yireninfo.com/Yirencaocao1/uploadImg/"+data[i].CLEANLINESS_IMG+"'>"+"</div></div></br>"	
								+"<div>"+"<span>照片详情2：</span>"+"<img  onload='javascript:resizeimg(this,400,300)' id='imgSize' src='http://agent.yireninfo.com/Yirencaocao1/uploadImg/"+data[i].CLEANLINESS_IMG+"'>"+"</div></div></br>"	
										  
								  );
								
							}
							
		                }
					},error:function(){
						alert("错误");
					}
				});
			});
			
			
		</script>	
	
	
		<script type="text/javascript">
		//分页查信息  将第几页信息传到servlet里面  根据 limit展示信息    每页10条    
		var pointInfo = document.getElementById("pointInfo");
			var seleIndex =pointInfo.selectedIndex;  
			var point=pointInfo.options[seleIndex].value;
			var keyWord =$("#keyWord").val();	
			var startTime =$("#startTime").val();
			var endTime =$("#endTime").val();	
			var pageNows=0;
			pageNumber=1;
			$(document).on("click","#nextpage", function(e){
				 $("#tableTbody").empty();
				 $("#backpage").remove();
				 $("#nextpage").remove();
				 $("#count").remove();
				 $("#thisSize").remove();
				pageNows+=10;
				pageNumber+=1;
				$.ajax({
					url:"${pageContext.request.contextPath}/dataMng/WashingOrderInfo?method=index",
					type:"POST",
					data:{"pageNows":pageNows},
					success:function(msg){
						var totalCount=msg.totalCount;
						var size=Math.ceil(totalCount/10);
						var data=msg.orderInfo;
						if(data==""){
							layer.alert("没有更多数据了！");
							  $("#pages").html($("#pages").html()
				                       +" <input type='button' id='backpage' value='上一页' class='btn btn-primary radius' addval=''>"
				                       +" <input type='button' id='nextpage' value='下一页' class='btn btn-primary radius' addval=''>"
				                     );
							return false;
						}
						for(var i=0;i<data.length;i++){
		                	 if(data[i].review_status==1){
		                		 data[i].review_status='已答卷';
		                		 
		                	 }else if (data[i].review_status==0) {
		                		 data[i].review_status='未答卷';
							}
		                	 if(data[i].car_wash_type==2){
		                		 data[i].car_wash_type='精洗';
		                		 
		                	 }else if (data[i].car_wash_type==1) {
		                		 data[i].car_wash_type='普洗';
							}
		                     $("#tableTbody").html($("#tableTbody").html()
			                    	 +"<tr class='text-c' ><td width='25'><input id='selectAll'   type='checkbox' name='' value='"+data[i].id+"'></td>"
				                     +"<td>"+data[i].car_wash_name+"</td>"		                         +"<td>"+data[i].number_plate+"</td>"
		                         +"<td>"+data[i].phone+"</td>"
		                         +"<td>"+data[i].complete_time+"</td>"
		                         +"<td>"+data[i].car_wash_type+"</td>"  
		                         +"<td>"+data[i].order_status+"</td>" +"<td>"+data[i].satisfied+"</td>"
		                        /* +"<td>"+data[i].review_status+"</td>" */
		                       /*  +"<td>"+data[i].reason+"</td>" */
		                         +"<td >"+"<button type='submit' class='btn btn-primary radius' id='seeWenjuan' value='"+data[i].id+"'>"+"查看"+"</td>"
		                         +"<td >"+"<button type='submit' class='btn btn-primary radius' id='seeImg' value='"+data[i].id+"'>"+"查看"+"</td></tr>"
		                     );
	                }
						  $("#pages").html($("#pages").html()
			            		  +" <input type='button' id='count'  value='"+'共'+size+'页'+"' class='btn btn-primary radius' addval=''>"
			                      +" <input type='button' id='thisSize' value='"+'第'+pageNumber+'页'+"' class='btn btn-primary radius' addval=''>"
			                       +" <input type='button' id='backpage' value='上一页' class='btn btn-primary radius' addval=''>"
			                       +" <input type='button' id='nextpage' value='下一页' class='btn btn-primary radius' addval=''>"
			                     );
					},error:function(){
						alert("错误");
					}
				});
				
			});
			$(document).on("click","#backpage", function(e){
				 $("#tableTbody").empty();
				 $("#backpage").remove();
				 $("#nextpage").remove();
				 $("#count").remove();
				 $("#thisSize").remove();
				pageNows-=10;
				pageNumber-=1;
				if(pageNows<=0){
			   		pageNows+=10;
			   	  window.location.reload();
			   		layer.alert("这已经是第一页了！");
				}
				$.ajax({
					url:"${pageContext.request.contextPath}/dataMng/WashingOrderInfo?method=index",
					type:"POST",
					data:{"pageNows":pageNows},
					success:function(msg){
						var totalCount=msg.totalCount;
						var size=Math.ceil(totalCount/10);
						var data=msg.orderInfo;
						for(var i=0;i<data.length;i++){
		                	 if(data[i].review_status==1){
		                		 data[i].review_status='已答卷';
		                		 
		                	 }else if (data[i].review_status==0) {
		                		 data[i].review_status='未答卷';
							}
		                	 if(data[i].car_wash_type==2){
		                		 data[i].car_wash_type='精洗';
		                		 
		                	 }else if (data[i].car_wash_type==1) {
		                		 data[i].car_wash_type='普洗';
							}
		                     $("#tableTbody").html($("#tableTbody").html()
			                    	 +"<tr class='text-c' ><td width='25'><input id='selectAll'   type='checkbox' name='' value='"+data[i].id+"'></td>"
				                     +"<td>"+data[i].car_wash_name+"</td>"		                         +"<td>"+data[i].number_plate+"</td>"
		                         +"<td>"+data[i].phone+"</td>"
		                         +"<td>"+data[i].complete_time+"</td>"
		                         +"<td>"+data[i].car_wash_type+"</td>"  
		                         +"<td>"+data[i].order_status+"</td>" +"<td>"+data[i].satisfied+"</td>"
		                        /* +"<td>"+data[i].review_status+"</td>" */
		                       /*  +"<td>"+data[i].reason+"</td>" */
		                         +"<td >"+"<button type='submit' class='btn btn-primary radius' id='seeWenjuan' value='"+data[i].id+"'>"+"查看"+"</td>"
		                         +"<td >"+"<button type='submit' class='btn btn-primary radius' id='seeImg' value='"+data[i].id+"'>"+"查看"+"</td></tr>"
		                     );
	                }
						  $("#pages").html($("#pages").html()
			            		  +" <input type='button' id='count'  value='"+'共'+size+'页'+"' class='btn btn-primary radius' addval=''>"
			                      +" <input type='button' id='thisSize' value='"+'第'+pageNumber+'页'+"' class='btn btn-primary radius' addval=''>"
			                       +" <input type='button' id='backpage' value='上一页' class='btn btn-primary radius' addval=''>"
			                       +" <input type='button' id='nextpage' value='下一页' class='btn btn-primary radius' addval=''>"
			                     );
					},error:function(){
						alert("错误");
					}
				});
			});
		
			
			//根据关键字分页
			$(document).on("click","#nextpagekeys", function(e){
				 $("#tableTbody").empty();
				 $("#backpagekeys").remove();
				 $("#nextpagekeys").remove();
				 $("#thisSize").remove();
				 $("#count").remove();
				pageNows+=10;
				$.ajax({
					url:"${pageContext.request.contextPath}/dataMng/WashingOrderInfo?method=selectNextByKeyWord",
					type:"POST",
					data:{"pageNows":pageNows},
					success:function(msg){
						var data=msg.selectPageWashInfobyMsg;
						var totalCount=msg.totalCount;
						var size=Math.ceil(totalCount/10);
						if(data==""){
							layer.alert("没有更多数据了！");
							$("#pages").html($("#pages").html()
				                       +" <input type='button' id='backpagekeys' value='上一页' class='btn btn-primary radius' addval=''>"
				                       +" <input type='button' id='nextpagekeys' value='下一页' class='btn btn-primary radius' addval=''>"
				                     );
							return false;
						}
						for(var i=0;i<data.length;i++){
		                	 if(data[i].review_status==1){
		                		 data[i].review_status='已答卷';
		                		 
		                	 }else if (data[i].review_status==0) {
		                		 data[i].review_status='未答卷';
							}
		                	 if(data[i].car_wash_type==2){
		                		 data[i].car_wash_type='精洗';
		                		 
		                	 }else if (data[i].car_wash_type==1) {
		                		 data[i].car_wash_type='普洗';
							}
		                     $("#tableTbody").html($("#tableTbody").html()
			                    	 +"<tr class='text-c' ><td width='25'><input id='selectAll'   type='checkbox' name='' value='"+data[i].id+"'></td>"
				                     +"<td>"+data[i].car_wash_name+"</td>"		                         +"<td>"+data[i].number_plate+"</td>"
		                         +"<td>"+data[i].phone+"</td>"
		                         +"<td>"+data[i].complete_time+"</td>"
		                         +"<td>"+data[i].order_status+"</td>" +"<td>"+data[i].satisfied+"</td>"  +"<td>"+data[i].car_wash_type+"</td>"
		                        /* +"<td>"+data[i].review_status+"</td>" */
		                       /*  +"<td>"+data[i].reason+"</td>" */
		                         +"<td >"+"<button type='submit' class='btn btn-primary radius' id='seeWenjuan' value='"+data[i].id+"'>"+"查看"+"</td>"
		                         +"<td >"+"<button type='submit' class='btn btn-primary radius' id='seeImg' value='"+data[i].id+"'>"+"查看"+"</td></tr>"
		                     );
	                }
						  $("#pages").html($("#pages").html()
		                		  +" <input type='button' id='count'  value='"+'共'+size+'页'+"' class='btn btn-primary radius' addval=''>"
			                      +" <input type='button' id='thisSize' value='"+'第'+pageNumber+'页'+"' class='btn btn-primary radius' addval=''>"
			                       +" <input type='button' id='backpagekeys' value='上一页' class='btn btn-primary radius' addval=''>"
			                       +" <input type='button' id='nextpagekeys' value='下一页' class='btn btn-primary radius' addval=''>"
			                     );
					},error:function(){
						alert("错误");
					}
				});
				
			});
			$(document).on("click","#backpagekeys", function(e){
				 $("#tableTbody").empty();
				 $("#backpagekeys").remove();
				 $("#nextpagekeys").remove();
				 $("#thisSize").remove();
				 $("#count").remove();
				pageNows-=10;
				if(pageNows<=0){
			   		pageNows+=10;
			   	  window.location.reload();
			   		layer.alert("这已经是第一页了！");
				}
				$.ajax({
					url:"${pageContext.request.contextPath}/dataMng/WashingOrderInfo?method=selectNextByKeyWord",
					type:"POST",
					data:{"pageNows":pageNows},
					success:function(msg){
						var totalCount=msg.totalCount;
						var size=Math.ceil(totalCount/10);
						var data=msg.selectPageWashInfobyMsg;
						for(var i=0;i<data.length;i++){
		                	 if(data[i].review_status==1){
		                		 data[i].review_status='已答卷';
		                		 
		                	 }else if (data[i].review_status==0) {
		                		 data[i].review_status='未答卷';
							}
		                	 if(data[i].car_wash_type==2){
		                		 data[i].car_wash_type='精洗';
		                		 
		                	 }else if (data[i].car_wash_type==1) {
		                		 data[i].car_wash_type='普洗';
							}
		                     $("#tableTbody").html($("#tableTbody").html()
			                    	 +"<tr class='text-c' ><td width='25'><input id='selectAll'   type='checkbox' name='' value='"+data[i].id+"'></td>"
				                     +"<td>"+data[i].car_wash_name+"</td>"		                         +"<td>"+data[i].number_plate+"</td>"
		                         +"<td>"+data[i].phone+"</td>"
		                         +"<td>"+data[i].complete_time+"</td>"
		                         +"<td>"+data[i].car_wash_type+"</td>"  
		                         +"<td>"+data[i].order_status+"</td>" +"<td>"+data[i].satisfied+"</td>"
		                        /* +"<td>"+data[i].review_status+"</td>" */
		                       /*  +"<td>"+data[i].reason+"</td>" */
		                         +"<td >"+"<button type='submit' class='btn btn-primary radius' id='seeWenjuan' value='"+data[i].id+"'>"+"查看"+"</td>"
		                         +"<td >"+"<button type='submit' class='btn btn-primary radius' id='seeImg' value='"+data[i].id+"'>"+"查看"+"</td></tr>"
		                     );
	                }
						  $("#pages").html($("#pages").html()
		                		  +" <input type='button' id='count'  value='"+'共'+size+'页'+"' class='btn btn-primary radius' addval=''>"
			                      +" <input type='button' id='thisSize' value='"+'第'+pageNumber+'页'+"' class='btn btn-primary radius' addval=''>"
			                       +" <input type='button' id='backpagekeys' value='上一页' class='btn btn-primary radius' addval=''>"
			                       +" <input type='button' id='nextpagekeys' value='下一页' class='btn btn-primary radius' addval=''>"
			                     );
					},error:function(){
						alert("错误");
					}
				});
			});
		
			
			//根据洗车站点分页
			$(document).on("click","#nextpagePoint", function(e){
				 $("#tableTbody").empty();
				 $("#backpagePoint").remove();
				 $("#nextpagePoint").remove();
				 $("#count").remove();
				 $("#thisSize").remove();
					pageNows+=10;
					pageNumber+=1;
				$.ajax({
					url:"${pageContext.request.contextPath}/dataMng/WashingOrderInfo?method=selectNextWashInfoByPoint",
					type:"POST",
					data:{"pageNows":pageNows,"point":point},
					success:function(msg){
						var totalCount=msg.totalCount;
						var size=Math.ceil(totalCount/10);
						var data=msg.selectWashInfobyPoint;
						if(data==""){
							layer.alert("没有更多数据了！");
							  $("#pages").html($("#pages").html()
					                       +" <input type='button' id='backpagePoint' value='上一页' class='btn btn-primary radius' addval=''>"
					                       +" <input type='button' id='nextpagePoint' value='下一页' class='btn btn-primary radius' addval=''>"
					                     );
							return false;
						}
						for(var i=0;i<data.length;i++){
		                	 if(data[i].review_status==1){
		                		 data[i].review_status='已答卷';
		                		 
		                	 }else if (data[i].review_status==0) {
		                		 data[i].review_status='未答卷';
							}
		                	 if(data[i].car_wash_type==2){
		                		 data[i].car_wash_type='精洗';
		                		 
		                	 }else if (data[i].car_wash_type==1) {
		                		 data[i].car_wash_type='普洗';
							}
		                     $("#tableTbody").html($("#tableTbody").html()
			                    	 +"<tr class='text-c' ><td width='25'><input id='selectAll'   type='checkbox' name='' value='"+data[i].id+"'></td>"
				                     +"<td>"+data[i].car_wash_name+"</td>"		                         +"<td>"+data[i].number_plate+"</td>"
		                         +"<td>"+data[i].phone+"</td>"
		                         +"<td>"+data[i].complete_time+"</td>"
		                         +"<td>"+data[i].car_wash_type+"</td>"  
		                         +"<td>"+data[i].order_status+"</td>" +"<td>"+data[i].satisfied+"</td>"
		                        /* +"<td>"+data[i].review_status+"</td>" */
		                       /*  +"<td>"+data[i].reason+"</td>" */
		                         +"<td >"+"<button type='submit' class='btn btn-primary radius' id='seeWenjuan' value='"+data[i].id+"'>"+"查看"+"</td>"
		                         +"<td >"+"<button type='submit' class='btn btn-primary radius' id='seeImg' value='"+data[i].id+"'>"+"查看"+"</td></tr>"
		                     );
	                }
						  $("#pages").html($("#pages").html()
			                		 +" <input type='button' id='count'  value='"+'共'+size+'页'+"' class='btn btn-primary radius' addval=''>"
				                      +" <input type='button' id='thisSize' value='"+'第'+pageNumber+'页'+"' class='btn btn-primary radius' addval=''>"
				                       +" <input type='button' id='backpagePoint' value='上一页' class='btn btn-primary radius' addval=''>"
				                       +" <input type='button' id='nextpagePoint' value='下一页' class='btn btn-primary radius' addval=''>"
				                     );
					},error:function(){
						alert("错误");
					}
				});
				
			});
			
			
			$(document).on("click","#backpagePoint", function(e){
				 $("#tableTbody").empty();
				 $("#backpagePoint").remove();
				 $("#nextpagePoint").remove();
				 $("#count").remove();
				 $("#thisSize").remove();
				pageNows-=10;
				pageNumber-=1;
				if(pageNows<=0){
			   		pageNows+=10;
			   	  window.location.reload();
			   		layer.alert("这已经是第一页了！");
				}
				$.ajax({
					url:"${pageContext.request.contextPath}/dataMng/WashingOrderInfo?method=selectNextWashInfoByPoint",
					type:"POST",
					data:{"pageNows":pageNows,"point":point},
					success:function(msg){
						var totalCount=msg.totalCount;
						var size=Math.ceil(totalCount/10);
						var data=msg.selectWashInfobyPoint;
						for(var i=0;i<data.length;i++){
		                	 if(data[i].review_status==1){
		                		 data[i].review_status='已答卷';
		                		 
		                	 }else if (data[i].review_status==0) {
		                		 data[i].review_status='未答卷';
							}
		                	 if(data[i].car_wash_type==2){
		                		 data[i].car_wash_type='精洗';
		                		 
		                	 }else if (data[i].car_wash_type==1) {
		                		 data[i].car_wash_type='普洗';
							}
		                     $("#tableTbody").html($("#tableTbody").html()
			                    	 +"<tr class='text-c' ><td width='25'><input id='selectAll'   type='checkbox' name='' value='"+data[i].id+"'></td>"
				                     +"<td>"+data[i].car_wash_name+"</td>"		                         +"<td>"+data[i].number_plate+"</td>"
		                         +"<td>"+data[i].phone+"</td>"
		                         +"<td>"+data[i].complete_time+"</td>"
		                         +"<td>"+data[i].car_wash_type+"</td>"  
		                         +"<td>"+data[i].order_status+"</td>" 
		                         +"<td>"+data[i].satisfied+"</td>"
		                         +"<td >"+"<button type='submit' class='btn btn-primary radius' id='seeWenjuan' value='"+data[i].id+"'>"+"查看"+"</td>"
		                         +"<td >"+"<button type='submit' class='btn btn-primary radius' id='seeImg' value='"+data[i].id+"'>"+"查看"+"</td></tr>"
		                     );
	                }
						  $("#pages").html($("#pages").html()
			                		 +" <input type='button' id='count'  value='"+'共'+size+'页'+"' class='btn btn-primary radius' addval=''>"
				                      +" <input type='button' id='thisSize' value='"+'第'+pageNumber+'页'+"' class='btn btn-primary radius' addval=''>"
				                       +" <input type='button' id='backpagePoint' value='上一页' class='btn btn-primary radius' addval=''>"
				                       +" <input type='button' id='nextpagePoint' value='下一页' class='btn btn-primary radius' addval=''>"
				                     );
					},error:function(){
						alert("错误");
					}
				});
			});
			
			
			//根据时间分页
			$(document).on("click","#nextpageTime", function(e){
				 $("#tableTbody").empty();
				 $("#backpageTime").remove();
				 $("#nextpageTime").remove();
				 $("#count").remove();
				 $("#thisSize").remove();
				pageNows+=10;
				pageNumber+=1;
				$.ajax({
					url:"${pageContext.request.contextPath}/dataMng/WashingOrderInfo?method=selectNextWashInfoByTime",
					type:"POST",
					data:{"pageNows":pageNows,"startTime":startTime,"endTime":endTime},
					success:function(msg){
						var data=msg.selectWashInfobyTime;
						var totalCount=msg.totalCount;
						var size=Math.ceil(totalCount/10);
						if(data==""){
							layer.alert("没有更多数据了！");
							$("#pages").html($("#pages").html()
				                       +" <input type='button' id='backpageTime' value='上一页' class='btn btn-primary radius' addval=''>"
				                       +" <input type='button' id='nextpageTime' value='下一页' class='btn btn-primary radius' addval=''>"
				                     );
							return false;
						}
						for(var i=0;i<data.length;i++){
		                	 if(data[i].review_status==1){
		                		 data[i].review_status='已答卷';
		                		 
		                	 }else if (data[i].review_status==0) {
		                		 data[i].review_status='未答卷';
							}
		                	 if(data[i].car_wash_type==2){
		                		 data[i].car_wash_type='精洗';
		                		 
		                	 }else if (data[i].car_wash_type==1) {
		                		 data[i].car_wash_type='普洗';
							}
		                     $("#tableTbody").html($("#tableTbody").html()
			                    	 +"<tr class='text-c' ><td width='25'><input id='selectAll'   type='checkbox' name='' value='"+data[i].id+"'></td>"
				                     +"<td>"+data[i].car_wash_name+"</td>"		                         +"<td>"+data[i].number_plate+"</td>"
		                         +"<td>"+data[i].phone+"</td>"
		                         +"<td>"+data[i].complete_time+"</td>"
		                         +"<td>"+data[i].car_wash_type+"</td>"  
		                         +"<td>"+data[i].order_status+"</td>" 
		                         +"<td>"+data[i].satisfied+"</td>"
		                         +"<td >"+"<button type='submit' class='btn btn-primary radius' id='seeWenjuan' value='"+data[i].id+"'>"+"查看"+"</td>"
		                         +"<td >"+"<button type='submit' class='btn btn-primary radius' id='seeImg' value='"+data[i].id+"'>"+"查看"+"</td></tr>"
		                     );
	                }
		        
                $("#pages").html($("#pages").html()
               		  +" <input type='button' id='count'  value='"+'共'+size+'页'+"' class='btn btn-primary radius' addval=''>"
                      +" <input type='button' id='thisSize' value='"+'第'+pageNumber+'页'+"' class='btn btn-primary radius' addval=''>"
	                       +" <input type='button' id='backpageTime' value='上一页' class='btn btn-primary radius' addval=''>"
	                       +" <input type='button' id='nextpageTime' value='下一页' class='btn btn-primary radius' addval=''>"
	                     );
					},error:function(){
						alert("错误");
					}
				});
				
			});
			$(document).on("click","#backpageTime", function(e){
				 $("#tableTbody").empty();
				 $("#backpageTime").remove();
				 $("#nextpageTime").remove();
				 $("#count").remove();
				 $("#thisSize").remove();
				pageNows-=10;
				pageNumber-=1;
				if(pageNows<=0){
			   		pageNows+=10;
			   	  window.location.reload();
			   		layer.alert("这已经是第一页了！");
				}
				$.ajax({
					url:"${pageContext.request.contextPath}/dataMng/WashingOrderInfo?method=selectNextWashInfoByTime",
					type:"POST",
					data:{"pageNows":pageNows,"startTime":startTime,"endTime":endTime},
					success:function(msg){
						var totalCount=msg.totalCount;
						var size=Math.ceil(totalCount/10);
						var data=msg.selectWashInfobyTime;
						for(var i=0;i<data.length;i++){
		                	 if(data[i].review_status==1){
		                		 data[i].review_status='已答卷';
		                		 
		                	 }else if (data[i].review_status==0) {
		                		 data[i].review_status='未答卷';
							}
		                	 if(data[i].car_wash_type==2){
		                		 data[i].car_wash_type='精洗';
		                		 
		                	 }else if (data[i].car_wash_type==1) {
		                		 data[i].car_wash_type='普洗';
							}
		                     $("#tableTbody").html($("#tableTbody").html()
			                    	 +"<tr class='text-c' ><td width='25'><input id='selectAll'   type='checkbox' name='' value='"+data[i].id+"'></td>"
				                     +"<td>"+data[i].car_wash_name+"</td>"		                         +"<td>"+data[i].number_plate+"</td>"
		                         +"<td>"+data[i].phone+"</td>"
		                         +"<td>"+data[i].complete_time+"</td>"
		                         +"<td>"+data[i].car_wash_type+"</td>"  
		                         +"<td>"+data[i].order_status+"</td>" +"<td>"+data[i].satisfied+"</td>"
		                         +"<td >"+"<button type='submit' class='btn btn-primary radius' id='seeWenjuan' value='"+data[i].id+"'>"+"查看"+"</td>"
		                         +"<td >"+"<button type='submit' class='btn btn-primary radius' id='seeImg' value='"+data[i].id+"'>"+"查看"+"</td></tr>"
		                     );
	                }  
						$("#pages").html($("#pages").html()
	                 		  +" <input type='button' id='count'  value='"+'共'+size+'页'+"' class='btn btn-primary radius' addval=''>"
		                      +" <input type='button' id='thisSize' value='"+'第'+pageNumber+'页'+"' class='btn btn-primary radius' addval=''>"
		                       +" <input type='button' id='backpageTime' value='上一页' class='btn btn-primary radius' addval=''>"
		                       +" <input type='button' id='nextpageTime' value='下一页' class='btn btn-primary radius' addval=''>"
		                     );
					},error:function(){
						alert("错误");
					}
				});
			});
			
			
			//根据站点和时间分页
			$(document).on("click","#nextpageAll", function(e){
				 $("#tableTbody").empty();
				 $("#backpageAll").remove();
				 $("#nextpageAll").remove();
				 $("#count").remove();
				 $("#thisSize").remove();
				pageNows+=10;
				pageNumber+=1;
				$.ajax({
					url:"${pageContext.request.contextPath}/dataMng/WashingOrderInfo?method=selectNextWashInfoByPointAndTime",
					type:"POST",
					data:{"pageNows":pageNows,"point":point,"startTime":startTime,"endTime":endTime},
					success:function(msg){
						var totalCount=msg.totalCount;
						var size=Math.ceil(totalCount/10);
						var data=msg.selectWashInfoByPointAndTime;
						if(data==""){
							layer.alert("没有更多数据了！");
							$("#pages").html($("#pages").html()
				                       +" <input type='button' id='backpageAll' value='上一页' class='btn btn-primary radius' addval=''>"
				                       +" <input type='button' id='nextpageAll' value='下一页' class='btn btn-primary radius' addval=''>"
				                     );
							return false;
						}
						for(var i=0;i<data.length;i++){
		                	 if(data[i].review_status==1){
		                		 data[i].review_status='已答卷';
		                		 
		                	 }else if (data[i].review_status==0) {
		                		 data[i].review_status='未答卷';
							}
		                	 if(data[i].car_wash_type==2){
		                		 data[i].car_wash_type='精洗';
		                		 
		                	 }else if (data[i].car_wash_type==1) {
		                		 data[i].car_wash_type='普洗';
							}
		                     $("#tableTbody").html($("#tableTbody").html()
			                    	 +"<tr class='text-c' ><td width='25'><input id='selectAll'   type='checkbox' name='' value='"+data[i].id+"'></td>"
				                     +"<td>"+data[i].car_wash_name+"</td>"		                         
				                     +"<td>"+data[i].number_plate+"</td>"
		                         +"<td>"+data[i].phone+"</td>"
		                         +"<td>"+data[i].complete_time+"</td>"
		                         +"<td>"+data[i].car_wash_type+"</td>" 
		                         +"<td>"+data[i].order_status+"</td>" +"<td>"+data[i].satisfied+"</td>"
		                         +"<td >"+"<button type='submit' class='btn btn-primary radius' id='seeWenjuan' value='"+data[i].id+"'>"+"查看"+"</td>"
		                         +"<td >"+"<button type='submit' class='btn btn-primary radius' id='seeImg' value='"+data[i].id+"'>"+"查看"+"</td></tr>"
		                     );
	                }   $("#pages").html($("#pages").html()
	                		 +" <input type='button' id='count'  value='"+'共'+size+'页'+"' class='btn btn-primary radius' addval=''>"
		                      +" <input type='button' id='thisSize' value='"+'第'+pageNumber+'页'+"' class='btn btn-primary radius' addval=''>"
		                       +" <input type='button' id='backpageAll' value='上一页' class='btn btn-primary radius' addval=''>"
		                       +" <input type='button' id='nextpageAll' value='下一页' class='btn btn-primary radius' addval=''>"
		                     );
					},error:function(){
						alert("错误");
					}
				});
				
			});
			$(document).on("click","#backpageAll", function(e){
				 $("#tableTbody").empty();
				 $("#backpageAll").remove();
				 $("#nextpageAll").remove();
				 $("#count").remove();
				 $("#thisSize").remove()
				pageNows-=10;
				 pageNumber-=1;
				if(pageNows<=0){
			   		pageNows+=10;
			   	  window.location.reload();
			   		layer.alert("这已经是第一页了！");
				}
				$.ajax({
					url:"${pageContext.request.contextPath}/dataMng/WashingOrderInfo?method=selectNextWashInfoByPointAndTime",
					type:"POST",
					data:{"pageNows":pageNows,"point":point,"startTime":startTime,"endTime":endTime},
					success:function(msg){
						var totalCount=msg.totalCount;
						var size=Math.ceil(totalCount/10);
						var data=msg.selectWashInfoByPointAndTime;
						for(var i=0;i<data.length;i++){
		                	 if(data[i].review_status==1){
		                		 data[i].review_status='已答卷';
		                		 
		                	 }else if (data[i].review_status==0) {
		                		 data[i].review_status='未答卷';
							}
		                	 if(data[i].car_wash_type==2){
		                		 data[i].car_wash_type='精洗';
		                		 
		                	 }else if (data[i].car_wash_type==1) {
		                		 data[i].car_wash_type='普洗';
							}
		                     $("#tableTbody").html($("#tableTbody").html()
			                     +"<tr class='text-c' ><td width='25'><input id='selectAll'   type='checkbox' name='' value='"+data[i].id+"'></td>"
				                 +"<td>"+data[i].car_wash_name+"</td>"		                         
				                 +"<td>"+data[i].number_plate+"</td>"
		                         +"<td>"+data[i].phone+"</td>"
		                         +"<td>"+data[i].complete_time+"</td>"
		                         +"<td>"+data[i].car_wash_type+"</td>"  
		                         +"<td>"+data[i].order_status+"</td>"
		                         +"<td>"+data[i].satisfied+"</td>"
		                         +"<td >"+"<button type='submit' class='btn btn-primary radius' id='seeWenjuan' value='"+data[i].id+"'>"+"查看"+"</td>"
		                         +"<td >"+"<button type='submit' class='btn btn-primary radius' id='seeImg' value='"+data[i].id+"'>"+"查看"+"</td></tr>"
		                     );
	                }   
						$("#pages").html($("#pages").html()
	                		 +" <input type='button' id='count'  value='"+'共'+size+'页'+"' class='btn btn-primary radius' addval=''>"
		                      +" <input type='button' id='thisSize' value='"+'第'+pageNumber+'页'+"' class='btn btn-primary radius' addval=''>"
		                       +" <input type='button' id='backpageAll' value='上一页' class='btn btn-primary radius' addval=''>"
		                       +" <input type='button' id='nextpageAll' value='下一页' class='btn btn-primary radius' addval=''>"
		                     );
					},error:function(){
						alert("错误");
					}
				});
			});
		
		</script>
		
		<script type="text/javascript">
		function resizeimg(ImgD,iwidth,iheight) {
		     var image=new Image();
		     image.src=ImgD.src;
		     if(image.width>0 && image.height>0){
		        if(image.width/image.height>= iwidth/iheight){
		           if(image.width>iwidth){
		               ImgD.width=iwidth;
		               ImgD.height=(image.height*iwidth)/image.width;
		           }else{
		                  ImgD.width=image.width;
		                  ImgD.height=image.height;
		                }
		               ImgD.alt=image.width+"×"+image.height;
		        }
		        else{
		                if(image.height>iheight){
		                       ImgD.height=iheight;
		                       ImgD.width=(image.width*iheight)/image.height;
		                }else{
		                        ImgD.width=image.width;
		                        ImgD.height=image.height;
		                     }
		                ImgD.alt=image.width+"×"+image.height;
		            }
		ImgD.style.cursor= "pointer"; //改变鼠标指针
		ImgD.onclick = function() { window.open(this.src);} //点击打开大图片
		if (navigator.userAgent.toLowerCase().indexOf("ie") > -1) { //判断浏览器，如果是IE
		ImgD.title = "请使用鼠标滚轮缩放图片，点击图片可在新窗口打开";
		ImgD.onmousewheel = function img_zoom() //滚轮缩放
		 {
		var zoom = parseInt(this.style.zoom, 10) || 100;
		zoom += event.wheelDelta / 12;
		if (zoom> 0)this.style.zoom = zoom + "%";
		return false;
		 }
		  } else { //如果不是IE
		     ImgD.title = "点击图片可在新窗口打开";
		   }
		    }
		}
		
		
		
		</script>
		<div id="fade" class="black_overlay">
		<div id="light" class="white_content">
		<div class="posit" style="height: 35px; width: 100%;">
		<div style="float: left;font-size: 20px;font-weight: 600px;">照片展示</div>
		<div class="" style="text-align: center; float: right;font-size: 20px;color: blue" id="back"><a href = "javascript:void(0)" onclick = "back">返回</a></div>
		</div>
		</div> 
        </div> 
        
        <div id="review" class="black_overlay">
		<div id="lights" class="white_content">
		<div class="posit" style="height: 35px; width: 100%;">
		<div style="float: left;font-size: 20px;font-weight: 600px;">问卷展示</div>
		<div class="" style="text-align: center; float: right;font-size: 20px;color: blue" id="back"><a href = "javascript:void(0)" onclick = "back">返回</a></div>
		</div>
		</div> 
        </div> 	
        
	 <div  id="pages" name="pages" class="pages" style="text-align: right;">
	
	 </div>
        <script type="text/javascript">
        function exporExcel() {
     
            window.location.href = "${pageContext.request.contextPath}/dataMng/WashingOrderInfo?method=exportReceiptReport";
        }
    	$(document).on("click","#back", function(e){
    		 $("#imgAll").remove();
    		 $("#imgAll").empty();
    		 $("#imgAll").html(''); 
    		 $("#pingjia").remove();
    		 $("#pingjia").empty();
    		 $("#pingjia").html(''); 
    		document.getElementById('light').style.display='none';
    		document.getElementById('lights').style.display='none';
    		document.getElementById('fade').style.display='none'
    		document.getElementById('review').style.display='none'
    		
    	});
    	
    	//修改订单状态   将未完成 修改成已完成
    	$(document).on("click","#updateStatus", function(e) {
    	   	var num=0;
    	   	var carOwnerIds="";
    	   	$('#tableTbody input[type="checkbox"]:checked').each(function(){
    					if ($(this).prop("checked")) {
    						num ++;
    						carOwnerIds=carOwnerIds+$(this).val()+",";
    					}
    				    
    				});
    	   	if(num == 0){
    	   		layer.alert("请选择要修改的信息！");
    	   	} else {
    	   		layer.confirm("确定修改？", function(e) {
    	    		$.ajax({
    	                url: "${pageContext.request.contextPath}/dataMng/WashingOrderInfo?method=updateStatus",
    	                type: "post",
    	                data: {"carOwnerIds": carOwnerIds},
    	                success: function(data) {
    	                	
    	                	var json=JSON.parse(data);
    	                	var da=json.del;
    	                	JSON.stringify(da)
    	                	da.message && layer.msg(da.message);
    	                      if (da.result == "1") {
    	                    	  window.location.reload();
    	                      }
    	                },
    	                error: function(data) {
    	                    layer.msg("系统异常，请重试");
    	                }
    	            });
    	    	});
    	   	}
    	});
    	
        </script>
</body>
</html>
