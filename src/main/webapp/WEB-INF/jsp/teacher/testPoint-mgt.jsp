<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="${ctx}/css/base.css" />
<link rel="stylesheet" href="${ctx}/css/info-mgt.css" />
<link rel="stylesheet" href="${ctx}/css/WdatePicker.css" />
<title>移动办公自动化系统</title>
</head>
<body>
<div class="title"><h2>考点管理</h2></div>
<form action="${ctx}/testPoint/deleteTestPoint.action" method="post" name="myform" id="myform">
<div class="table-operate ue-clear">
    <a href="#" class="add" onclick="addTestPoint()">添加</a>
    <a href="javascript:;" class="del" onclick="deleteUser()">删除</a>
    <select id="course.courseId" name="courseId" class="query">
        <option value=0>--请选择科目--</option>
        <c:forEach items="${course}" var="obj">
            <option value="${obj.courseId}">${obj.courseName}</option>
        </c:forEach>
    </select>
    <select id="grade.gradeId" name="gradeId" class="query">
        <option value=0>--请选择年级--</option>
        <c:forEach items="${grade}" var="obj">
            <option value="${obj.gradeId}">${obj.gradeName}</option>
        </c:forEach>
    </select>
    <a href="#" class="count" onclick="queryByGradeAndCourse()">搜查</a>
</div>
<div class="table-box" id="myDiv">
    <table border="1" cellspacing="1" id="myTable">
        <thead>
        <th class="num"></th>
        <th class='name'>编号</th><th class="process">所属科目</th><th class="process">所属年级</th><th class="process">难度</th>
        <th class="name">第一层考点</th><th class="process">细分考点</th><th class="process">更细分考点</th><th class="operate">操作</th>
        </thead>
    </table>
</div>
    <div id="specDiv">
<div class="pagination ue-clear"></div></div>
</form>
</body>
<script type="text/javascript" src="${ctx}/js/jquery.js"></script>
<script type="text/javascript" src="${ctx}/js/common.js"></script>
<script type="text/javascript" src="${ctx}/js/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.pagination.js"></script>
<script type="text/javascript">
$(".select-title").on("click",function(){
	$(".select-list").hide();
	$(this).siblings($(".select-list")).show();
	return false;
})
$(".select-list").on("click","li",function(){
	var txt = $(this).text();
	$(this).parent($(".select-list")).siblings($(".select-title")).find("span").text(txt);
})
$(function () {
    InitTable2(0);
	InitPage2('${pageInfo.total}');
});
function queryByGradeAndCourse()
{
    var gradeId = $("select[name=gradeId]").val();
    var courseId = $("select[name=courseId]").val();
    var data0 = {
        page:1,
        gradeId:gradeId,
        courseId:courseId
    };
    $.ajax({
        url:"${ctx}/testPoint/qryPageInfoByCourseAndGrade.action",
        type:"post",
        contentType:"application/json",
        dataType:"json",
        data:JSON.stringify(data0),
        success:function(data){
            var total = data.total;
            $("tbody [align=center]").remove();
            InitTable2(0);
            InitPage2(total);
        }
    });
}
function InitPage2(total)
{
    $('.pagination').pagination(total,{
        callback: InitTable2,
        display_msg: true,
        setPageNo: false
    });
}
function InitTable2(page)
{
    var gradeId = $("select[name=gradeId]").val();
    var courseId = $("select[name=courseId]").val();
    var data0={
        "page":page+1,
       "gradeId":gradeId,
        "courseId":courseId
    };
    $.ajax({
        url:"${ctx}/testPoint/qryTestPointByCourseAndGrade.action",
        type:'post',
        dataType:'json',
        contentType:'application/json',
        data:JSON.stringify(data0),
        success: function(data){
            var html = "";
            html += "<tbody align='center'>";
            for(dataList in data){
                html += "<tr align='center'>";
                html += "<td><input type='checkbox' name='testPointId' value='"+data[dataList].id+"'/></td>";
                html += "<td>"+data[dataList].id+"</td>";
                html += "<td>"+data[dataList].course.courseName+"</td>";
                html += "<td>"+data[dataList].grade.gradeName+"</td>";
                html += "<td>"+data[dataList].difficulty+"</td>";
                html += "<td>"+data[dataList].firstTestPoint+"</td>";
                if(data[dataList].secondTestPoint == null)
                {
                    html += "<td>无</td>";
                }else
                {
                    html += "<td>"+data[dataList].secondTestPoint+"</td>";
                }
                if(data[dataList].thirdTestPoint == null)
                {
                    html += "<td>无</td>";
                }else
                {
                    html += "<td>"+data[dataList].thirdTestPoint+"</td>";
                }
                html += "<td class='operate'><a href='${ctx}/testPoint/delTestPoint.action?testPointId="+data[dataList].id+"' class='del'>删除</a>&nbsp;";
                html += "<a href='${ctx}/testPoint/toUpdTestPoint.action?testPointId="+data[dataList].id+"' class='del'>编辑</a>&nbsp;";
                html += "</tr>";
            }
            html += "</tbody>";
            $("tbody [align=center]").remove();
            $("#myTable").append(html);
        }
    });
}

function deleteUser(){
	var ids = "";
	$("input:checkbox[name='testPointId']:checked").each(function() {
		ids += $(this).val() + ",";
    });
	//判断最后一个字符是否为逗号，若是截取
	var id = ids.substring(ids.length -1, ids.length);
	if(id == ","){
		ids = ids.substring(0, ids.length-1);
	}
	if(ids == ""){
		alert("请选择要删除的记录！");
		return;
	}
	$("form").submit();
}

function addTestPoint(){
	document.myform.attributes["action"].value = "${ctx}/testPoint/toAddTestPoint.action";
	$("form").submit();
}

$("tbody").find("tr:odd").css("backgroundColor","#eff6fa");

showRemind('input[type=text], textarea','placeholder');
</script>
</html>