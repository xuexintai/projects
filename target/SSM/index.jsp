<%--
  Created by IntelliJ IDEA.
  User: 薛鑫泰
  Date: 2020/6/20
  Time: 15:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
<!-- web路径：
 不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
 以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306)；需要加上项目名
         http://localhost:3306/crud
  -->
    <script type="text/javascript"
            src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
    <link
            href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
            rel="stylesheet">
    <script
            src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

<!--员工添加的模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">员工姓名</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="小明">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                    <label class="col-sm-2 control-label">gender</label>
                    <div class="col-sm-10">
                        <label class="radio-inline">
                            <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked">男
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="gender" id="gender2_add_input" value="F">女
                        </label>
                    </div>
                </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <%--部门提交部门id即可--%>
                            <select class="form-control" name="dId">

                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>
<!--员工修改的模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <p  class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked">男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F">女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-4">
                            <%--部门提交部门id即可--%>
                            <select class="form-control" name="dId">

                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">修改</button>
            </div>
        </div>
    </div>
</div>

<%--搭建显示页面--%>
<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12"></div>
        <h1>SSM-CRUD</h1>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>

    <%--显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="check_all"/>
                        </th>
                        <th>员工编号</th>
                        <th>员工姓名</th>
                        <th>员工性别</th>
                        <th>员工邮箱</th>
                        <th>部门名称</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>

                </tbody>


            </table>
        </div>
    </div>
    <%--显示分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info_area">

        </div>
        <%--分页条--%>
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>

<script type="text/javascript">
    var totalRecord,currentPage;
    //1.页面加载完成之后，直接发送Ajax请求，要到分页数据
    $(function () {
        //打开页面直接是第一页
        to_page(1);
    });
    function to_page(pn) {
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn="+pn,
            type:"GET",
            success:function (result) {
                //console.log(result);
                //1.解析并显示员工数据
                build_emps_table(result);
                //2.解析并显示分页信息
                build_page_info(result);
                //3.解析显示分页条数据
                build_page_nav(result);
            }
        });
    }
    //解析表格数据
    function build_emps_table(result) {
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps,function (index,item){
         //  alert(item.empName);
            var checkboxTd = $("<td><input type='checkbox' class='check_item'><td/>")
            var  empIdTd = $("<td></td>").append(item.empId);
            var  empNameTd = $("<td></td>").append(item.empName);
            var  genderTd = $("<td></td>").append(item.gender=='M'?"男":"女");
            var  emailTd = $("<td></td>").append(item.email);
            var  deptNameTd = $("<td></td>").append(item.department.deptName);
            /*<th>
                   <button class="btn btn-primary btn-sm">
                         <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                               编辑
                    </button>
            </th>   添加按钮*/
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                          .append("<span></span>").addClass("glyphicon glyphicon-pencil").append("编辑");
            //为编辑按钮添加一个自定义属性，来表示当前员工的id
            editBtn.attr("edit-id",item.empId);
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append("<span></span>").addClass("glyphicon glyphicon-trash").append("删除");
            //为删除按钮添加一个自定义的属性来表示删除的员工id
            delBtn.attr("del-id",item.empId);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
           //append之所以可以链式添加，是因为append方法执行完成之后还是返回之前的元素
            $("<tr></tr>").append(checkboxTd)
                          .append(empIdTd)
                          .append(empNameTd)
                          .append(genderTd)
                          .append(emailTd)
                          .append(deptNameTd)
                          .append(btnTd)
                          .appendTo("#emps_table tbody");
        });
    }
    //解析分页信息
    function build_page_info(result){
        $("#page_info_area").empty();
        $("#page_info_area").append("当前为第"+result.extend.pageInfo.pageNum+"页," +
            "总"+result.extend.pageInfo.pages+"页," +
            "总"+result.extend.pageInfo.total+"条记录");
        //将总页码赋值给totalRecord
        totalRecord = result.extend.pageInfo.total;
        //将当前页面赋值currentPage
        currentPage = result.extend.pageInfo.pageNum;
    }
    //解析分页条
    function build_page_nav(result){
      //  page_nav_area   &laquo;
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        //构建分页条元素
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi =   $("<li></li>").append($("<a></a>").append(" &laquo;"));
        //判断pageInfo是否有前一页，如果有前一页就显示，没有就不显示
        if (result.extend.pageInfo.hasPreviousPage == false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else {
            //为元素添加点击事件
            firstPageLi.click(function (){  //去首页
                to_page(1);
            });
            prePageLi.click(function (){
                to_page(result.extend.pageInfo.pageNum-1);   //后退，当前页面-1
            });
        }

        var nextPageLi =  $("<li></li>").append($("<a></a>").append(" &raquo;"));
        var lastPageLi =  $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
        //判断是否有下一页，如果有就显示并且可以进行跳转，没有就不显示
        if (result.extend.pageInfo.hasNextPage == false){   //表示没有下一页了，当前页面为末页
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else{
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum+1); //前进，当前页面+1
            });
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
        }

       //添加首页和前一页的提示
        ul.append(firstPageLi).append(prePageLi);
        //遍历给ul中添加页码提示
        $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {

            var numLi = $("<li></li>").append($("<a></a>").append(item));
            //判断是不是当前页码，如果是给他加个高亮
            if (result.extend.pageInfo.pageNum == item){
                numLi.addClass("active");
            }
            numLi.click(function () {
                    to_page(item);
            })
            ul.append(numLi);
        });
        //下一页和末页的提示
        ul.append(nextPageLi).append(lastPageLi);
        //把ul添加到nav中
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
      }
        function reset_form(ele){
            $(ele)[0].reset();
            //清空表单样式
            $(ele).find("*").removeClass("has-error has-success");
            $(ele).find(".help-block").text("");

        }
        //点击新增按钮弹出模态框
        $("#emp_add_modal_btn").click(function () {
            //表单数据重置
            reset_form("#empAddModal form");
            //发送Ajax请求，查出部门信息，显示再下拉列表中
            getDepts("#empAddModal select");
            //弹出模态框
            $("#empAddModal").modal({
                backdrop:"static"
            });
        });

    //查出所有部门信息，显示下载下拉列表中
    function getDepts(ele){
        //清空之前下拉列表的值
        $(ele).empty();
        $.ajax({
            url:"${APP_PATH}/depts",
            type: "GET",
            success:function (result) {
                // {"code":100,"msg":"处理成功！","extend":{"depts":[{"deptId":1,"deptName":"开发部"},
                // {"deptId":2,"deptName":"测试部"}]}}
                //   console.log(result);
                //显示部门信息在下拉列表中
                //$("#dept_add_select").append("")
                $.each(result.extend.depts,function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                    optionEle.appendTo(ele);
                });
            }
        });
    }

    //校验表单数据，并且显示错误信息的提示
    function validate_add_from(){
        //拿到要校验员工数据，使用曾正则表达式
      var empName = $("#empName_add_input").val();
      var regName = /(^[a-zA-Z0-9_-]{2,10}$)|(^[\u2E80-\u9FFF]{2,4})/; //校验姓名
        if (!regName.test(empName)){
           // alert("请输入正确的姓名!\n中文为2-4个汉字，字母为3-10位");
            //错误信息的提示
            //在每次校验完成之前应该清除之前的元素样式
            show_validate_msg("#empName_add_input","error","请输入正确的姓名!中文为2-4个汉字，字母为3-10位");
                       return false;
        }else{
            show_validate_msg("#empName_add_input","success","");
        }
        //校验邮箱
        var email = $("#email_add_input").val();
        var regName = /^([a-zA-Z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regName.test(email)){
           // alert("请输入正确的邮箱！");
            show_validate_msg("#email_add_input","error","请输入正确的邮箱!");
            return false;
        }else{
            show_validate_msg("#email_add_input","success","");
        }
        return  true;
    }

    //数据校验并清除元素样式
    function show_validate_msg(ele,status,msg) {
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if("success" ==status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if ("error"==status){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }


    //检查用户名是否可用
    $("#empName_add_input").change(function(){
        //发送Ajax请求校验用户名是否可用
        var empName = this.value;
        $.ajax({
            url:'${APP_PATH}/checkUser',
            data:'empName='+empName,
            type:'POST',
            success:function (result) {
                if (result.code==100){
                    show_validate_msg("#empName_add_input","success","用户名可用");
                    $("#emp_save_btn").attr("ajax-va","success");
                }else{
                    show_validate_msg("#empName_add_input","error",result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-va","error");
                }
            }
        });
    });
    //点击保存，保存员工
    $("#emp_save_btn").click(function () {
        //1.模态框中填写的表单数据提交给服务器进行保存
        //先对要提交给服务器的数据进行校验
        if (!validate_add_from()){
            return false;
        }
        //1.判断用户名校验是否成功，成功保存，不成功不保存
        if($(this).attr("ajax-va")=="error"){
            return false;
        }
        //2.发送Ajax请求保存员工
        $.ajax({
            url:"${APP_PATH}/emp",
            type:"POST",
            data: $("#empAddModal form").serialize(),
            success:function (result) {
                //alert(result.msg);
                if(result.code=="100"){
                    //1.关闭模态框
                    $("#empAddModal").modal('hide');
                    //2.来到最后一页，显示刚才的数据
                    //发送Ajax请求。显示最后一页数据
                    to_page(totalRecord);
                }else{
                    //进行后端校验，显示失败信息
                    //alert(result);
                    if(undefined!=result.extend.errors.email){
                        //显示邮箱的错误信息
                        show_validate_msg("#email_add_input","error",result.extend.errors.email);
                    }
                    if(undefined!=result.extend.errors.empName){
                        //显示名字的错误信息
                        show_validate_msg("#empName_add_input","error",result.extend.errors.empName);
                    }
                }

            }
        });
    });
    //

    //在创建编辑按钮的时候给他创建id
    $(document).on("click",".edit_btn",function (){

        //1.查出部门信息并显示部门列表
        getDepts("#empUpdateModal select");

        //2.查出员工信息，显示员工信息
        getEmp($(this).attr("edit-id"));
        //把员工idcu传递给更新按钮
        $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
        $("#empUpdateModal").modal({
            backdrop: "static"
        })
    });
    function getEmp(id){

        $.ajax({
            url:"${APP_PATH}/emp/"+id,
            type:"GET",
            success:function(result){
                var empData  = result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModal input[name=gender]").val([empData.gender]);
                $("#empUpdateModal select").val([empData.dId]);
            }
        });
    }
    //点击更新，更新员工信息
    $("#emp_update_btn").click(function (){
        //验证邮箱是否合法
        //在更新数据之前，校验邮箱信息
        var email = $("#email_update_input").val();
        var regName = /^([a-zA-Z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regName.test(email)){
            // alert("请输入正确的邮箱！");
            show_validate_msg("#email_update_input","error","请输入正确的邮箱!");
            return false;
        }else{
            show_validate_msg("#email_update_input","success","");
        }
        //2.发送Ajax请求保存更新的员工数据
        $.ajax({
            url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
            type:"PUT",
            data:$("#empUpdateModal form").serialize(),
            success:function (result) {
               // alert(result.msg);
                //1.关闭对话框
                $("#empUpdateModal").modal("hide");
                //2.回到本页面
                to_page(currentPage);
            }
        });
    });
    //单个删除
    $(document).on("click",".delete_btn",function (){
        //1.弹出是否删除对话框
      var empName = $(this).parents("tr").find("td:eq(2)").text();
      var empId = $(this).attr("del-id");
      if(confirm("确认删除【"+empName+"】吗？")){
            //确认，发送Ajax请求删除即可
          $.ajax({
              url:"${APP_PATH}/emp/"+empId,
              type:"DELETE",
              success:function(result){
                  alert(result.msg);
                  to_page(currentPage);
              }
          });

      }
    });
    //完成全选/全不选
    $("#check_all").click(function () {
       // $(this).prop("checked");
        $(".check_item").prop("checked",$(this).prop("checked"));
    });

    $(document).on("click",".check_item",function(){
        //判断当前选中的元素是不是5个
        var flag = $(".check_item:checked").length==$(".check_item").length;
        $("#check_all").prop("checked",flag);
    });

    //点击全部删除，就批量删除
    $("#emp_delete_all_btn").click(function(){
        //
        var empNames = "";
        var del_idstr = "";
        $.each($(".check_item:checked"),function(){
            alert( $(this).parents("tr").find("td:eq(3)").text());
            //this
            empNames += $(this).parents("tr").find("td:eq(3)").text()+",";
            //组装员工id字符串
           alert( del_idstr += $(this).parents("tr").find("td:eq(2)").text()+"-");
        });
        //去除empNames多余的,
        empNames = empNames.substring(0, empNames.length-1);
        //去除删除的id多余的-
        del_idstr = del_idstr.substring(0, del_idstr.length-1);
        if(confirm("确认删除【"+empNames+"】吗？")){
            //发送ajax请求删除
            $.ajax({
                url:"${APP_PATH}/emp/"+del_idstr,
                type:"DELETE",
                success:function(result){
                    alert(result.msg);
                    //回到当前页面
                    to_page(currentPage);
                }
            });
        }
    });
</script>
</body>
</html>
