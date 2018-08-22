<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all" />
<script type="text/javascript" src="${pageContext.request.contextPath}/layui/layui.js"></script>



	<script type="text/javascript">
			layui.use(['form', 'layer', 'jquery', 'laypage', 'laydate',], function() {
				var layer = layui.layer,
					laypage = layui.laypage,
					$ = layui.jquery,
					laydate = layui.laydate;
				
				
				  laydate.render({
					    elem: '#publishTime'
					  });		
				

				// 添加显示窗口
				$("#addBtn").click(function() {
					$('#addForm')[0].reset();
					$("#id").prop("value", "");

					layer.open({
						type: 1,
						title: '添加书籍',
						area: ['350px', '460px'],
						shadeClose: true, //点击遮罩关闭
						content: $("#addBook")
					});

				});

				//删除书籍
								function delBook() {
									$("tbody").on("click", "#delBtn", function() {
										var id = $(this).parent().parent().find("td").first().text();
										layer.confirm('确认要删除吗？', {
											btn: ['确认', '取消'] //可以无限个按钮
										}, function() {
											$.ajax({
												type: "get",
												url: "${pageContext.request.contextPath}/books/del",
												async: true,
												data: "id=" + id,
												success: function(data) {
													if(data=="ok"){
														layer.msg("删除成功！",{icon: 1});
													bookList();
													}else{
														layer.msg("删除失败！",{icon: 2});
													}
												}
											});
										}, function() {
				
										});
									});
								}

				//加载数据
				function bookList(pageNum) {

					$.ajax({
						type: "post",
						url: "${pageContext.request.contextPath}/books/list",
						data: {
							"pageNum": pageNum || 1,
						},
						async: true,
						success: function(data) {
							var dataHtml = "";
							if(data.list!= null&&data.list.length!=0) {
								$.each(data.list, function(i, book) {

									dataHtml += '<tr>';
									dataHtml += "<td style='display: none;'>" + book.id + "</td>";
									dataHtml += '<td >' + ((data.pageNum-1)*5+i+1) + '</td>';
									dataHtml += '<td>' + book.title + '</td>';
									dataHtml += '<td >' + book.author + '</td>';
									dataHtml += '<td >' + book.pages + '</td>';
									dataHtml += '<td >' + book.publisher + '</td>';
									dataHtml += '<td >' + book.publishTime+ '</td>';
									dataHtml += '<td>';
									dataHtml += '<a class="layui-btn layui-btn-mini news_edit" id="updateBtn"><i class="layui-icon">&#xe62a;</i>修改</a>';
									dataHtml += '<a class="layui-btn layui-btn-danger layui-btn-mini news_del" id="delBtn"><i class="layui-icon">&#xe640;</i> 删除</a>';
						
									dataHtml += '</td>';
									dataHtml += '</tr>';
								});
							} else {
								dataHtml = '<tr><td colspan="7">暂无数据</td></tr>';
							}
							$("#tbodyData").html(dataHtml);
							// 显示分页
							laypage.render({
								elem: 'page', //注意，这里的 test1 是 ID，不用加 # 号
								curr: data.pageNum, //获取起始页
								count: data.total, //数据总数，从服务端得到
								limit: data.pageSize, //每页显示的条数，laypage将会借助 count 和 limit 计算出分页数
								layout: ['count', 'prev', 'page', 'next', 'skip'],
								//可选值有：count（总条目输区域）、prev（上一页区域）、page（分页区域）、next（下一页区域）、limit（条目选项区域）、 skip（快捷跳页区域）
								theme: '#FFB800', //自定义主题。支持传入：颜色值，或任意普通字符
								jump: function(obj, first) {
									//首次不执行
									if(!first) {
										//do something
										bookList(obj.curr);
									}
								}
							});	
							

						}
					});
				}

				//保存书籍
								function save() {
									$("#addForm button:first").click(function() {
									 var	title = $("input[name='title']").val();
									 var	author = $("input[name='author']").val();
									 var	pages = $("input[name='pages']").val();
									 var	publisher = $("input[name='publisher']").val();
									 var	publishTime = $("input[name='publishTime']").val();
										if(title==null||title==""){
											layer.alert("书名不能为空！",{icon:2});
											return false;
										}else if(author==null||author==""){
											layer.alert("作者不能为空！",{icon:2});
											return false;											
										}	else if(pages==null||pages==""){
											layer.alert("页数不能为空！",{icon:2});
											return false;											
										}	else if(publisher==null||publisher==""){
											layer.alert("出版社不能为空！",{icon:2});
											return false;											
										}	else if(publishTime==null||publishTime==""){
											layer.alert("出版日期不能为空！",{icon:2});
											return false;											
										}									 
					
										var submitdata = $("#addForm").serialize();
				
										$.ajax({
											type: "post",
											url: "${pageContext.request.contextPath}/books/save",
											async: true,
											data: submitdata,
											success: function(data) {
												if(data=="ok"){
													bookList();
													layer.msg("保存成功！",{icon: 1});
												}else{
													layer.msg("保存失败！",{icon: 2});
												}
											}
										});
										layer.closeAll();
				
									});
								}
				
								//修改书籍
								function updateBook(){
								$("tbody").on("click","#updateBtn",function(){
								var trs = $(this).parent().parent();
								var id = trs.find("td").first().text();	
								var title = trs.find("td").eq(2).text();
								var author=trs.find("td").eq(3).text();
								var pages = trs.find("td").eq(4).text();
								var publisher = trs.find("td").eq(5).text();
								var publishTime = trs.find("td").eq(6).text();


										$("#id").prop("value",id);	
										$("input[name='title']").prop("value",title);
										$("input[name='author']").prop("value",author);
										$("input[name='pages']").prop("value",pages);
										$("input[name='publisher']").prop("value",publisher);
										$("input[name='publishTime']").prop("value",publishTime);										


									layer.open({
										  type: 1,
										  title:'修改书籍',
										  area: ['450px', '500px'],
										  shadeClose: true, //点击遮罩关闭
										  content: $("#addBook")
										 });		
								})	;
							}
						

				//显示书籍列表
				bookList();
				//保存
				save();
				//删除书籍
				delBook();
				//修改书籍
				updateBook();
			})
		</script>
</head>
<body style="text-align: center;">
<h1>书籍列表</h1><br/>
<p style="text-align: left;"><a class="layui-btn layui-btn-mini news_edit" id="addBtn"><i class="layui-icon">&#xe654;</i>添加</a></p>
<table class="layui-table">

	<thead>
		<tr>
			<th>编号</th>
			<th>书名</th>
			<th>作者</th>
			<th>页数</th>
			<th>出版社</th>
			<th>出版日期</th>
			<th>操作</th>
		</tr>
	</thead>
	<tbody id="tbodyData">
	
	
	
	</tbody>

</table>
<div id="page" style="text-align: right;"></div>



<!-- 添加 -->
		<div id="addBook" style="display: none;">
			<form class="layui-form" id="addForm">
			<input type="hidden" name="id"  id="id">
			<label class="layui-form-label"></label>
				<div class="layui-form-item">
					<label class="layui-form-label">书名:</label>
					<div class="layui-input-inline">
						<input type="text" name="title" placeholder="请输入书名" autocomplete="off" class="layui-input">
					</div>
				</div>
				

				<div class="layui-form-item">
					<label class="layui-form-label">作者:</label>
					<div class="layui-input-inline">
						<input type="text" name="author" placeholder="请输入作者" autocomplete="off" class="layui-input">
					</div>
				</div>
				
				<div class="layui-form-item">
					<label class="layui-form-label">页数:</label>
					<div class="layui-input-inline">
						<input type="text" name="pages" placeholder="请输入页数" autocomplete="off" class="layui-input">
					</div>
				</div>

				<div class="layui-form-item">
					<label class="layui-form-label">出版社:</label>
					<div class="layui-input-inline">
						<input type="text" name="publisher" placeholder="请输入出版社" autocomplete="off" class="layui-input">
					</div>
				</div>

				<div class="layui-form-item">
					<label class="layui-form-label">出版日期:</label>
					<div class="layui-input-inline">
						<input type="text" name="publishTime" id="publishTime" placeholder="请输入出版日期" autocomplete="off" class="layui-input" placeholder="yyyy-MM-dd">
					</div>
				</div>

				<div class="layui-form-item">
					<div class="layui-input-block">
						<button type="button" class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
						<button type="reset" class="layui-btn layui-btn-primary">重置</button>
					</div>
				</div>
			</form>	
	</div>
</body>
</html>