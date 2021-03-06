<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="${ctx}/css/base.css" />
<link rel="stylesheet" href="${ctx}/css/info-reg.css" />
<link rel="stylesheet" href="${ctx}/css/jquery.searchableSelect.css" />
<title>移动办公自动化系统</title>
</head>

<body>
<div class="title"><h2>编辑班级信息</h2></div>
<form action="${ctx}/examClass/updClass.action" method="post" name="myform" id="myform">
    <input type="hidden" value="${examClass.id}" name="id">
<div class="main">
    <p class="short-input ue-clear">
    	<label><span style="color:red">*</span>班级名称：</label>
        <input type="text" name="className" id="className" maxlength="10" value="${examClass.className}"/>
    </p>

    <p class="short-input ue-clear">
        <label><span style="color:red">*</span>所在年级：</label>
    </p>
    <c:forEach items="${dataList}" var="o">
        <p class="short-input ue-clear">
            <label><span style= "width:100px "> &nbsp; </span></label>
            ${examClass.grade.gradeId}
            <input type="radio" name="Grade.gradeId" id="gradeId" value="${o.gradeId}"
                   <c:if test="${examClass.grade.gradeId eq o.gradeId}">checked="checked"</c:if>/>${o.gradeName}
        </p>
    </c:forEach>
    
</div>
</form>
<div class="btn ue-clear">
    <a href="javascript:;" class="confirm" onclick="updClass()">确定</a>
    <a href="${ctx}/examClass/toClassPage.action" class="clear">返回</a>
</div>
</body>
<script type="text/javascript" src="${ctx}/js/jquery.js"></script>
<script type="text/javascript" src="${ctx}/js/common.js"></script>
<script type="text/javascript" src="${ctx}/js/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.searchableSelect.js"></script>
<script type="text/javascript">
$(function(){
	$("#grade").searchableSelect();
});
$(".select-title").on("click",function(){
	$(".select-list").toggle();
	return false;
});
$(".select-list").on("click","li",function(){
	var txt = $(this).text();
	$(".select-title").find("span").text(txt);
});

//注册
function updClass(){
	$("form").submit();
}

/* //情况所有
function returnList(){
	document.myform.attributes["action"].value = "${ctx}/toTypePage.action"; 
	$("form").submit();
} */

showRemind('input[type=text], textarea','placeholder');
</script>
</html>